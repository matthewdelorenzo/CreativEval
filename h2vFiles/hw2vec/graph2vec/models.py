#!/usr/bin/env python
#title           :models.py
#description     :This file includes the models of hw2vec.
#author          :Shih-Yuan Yu
#date            :2021/03/05
#version         :0.2
#notes           :
#python_version  :3.6
#==============================================================================
import json
from pathlib import Path
import torch
import torch.nn as nn
import torch.nn.functional as F

from collections import OrderedDict
from torch.nn import Linear, ReLU
from torch_geometric.nn import GCNConv, GINConv, SAGPooling, TopKPooling
from torch_geometric.nn import global_add_pool, global_mean_pool, global_max_pool

#Use to solve issues with missing keys (occurs due to changes in PyTorch which were implemented in PyG2.0)
def cfgUpdater(ordered_dict, key_dict):
    # update keys and values while preserving dict order using a placeholder dict
    new_ordered_dict = OrderedDict()
    for key in ordered_dict:
        if key in key_dict:
            # rename the key and, if key is lin weight related, transpose it
            if "lin.weight" in key_dict[key]:
                new_ordered_dict[key_dict[key]] = ordered_dict[key].t()
            else:
                new_ordered_dict[key_dict[key]] = ordered_dict[key]
        else:
            new_ordered_dict[key] = ordered_dict[key]
    # update the original OrderedDict
    ordered_dict.clear()
    ordered_dict.update(new_ordered_dict)


""" def cfgUpdater(ordered_dict, new_key, old_key):
    # Check if the old key exists in the OrderedDict
    if old_key in ordered_dict:
        # Create a new OrderedDict with the new order
        new_ordered_dict = OrderedDict()
        for key, value in ordered_dict.items():
            if key == old_key:
                if "pool" not in key:
                    new_ordered_dict[new_key] = value.t()
                else:
                    new_ordered_dict[new_key] = value
            else:
                new_ordered_dict[key] = value
            
        # Update the original OrderedDict
        ordered_dict.clear()
        ordered_dict.update(new_ordered_dict)
 """

class GRAPH_CONV(nn.Module):
    def __init__(self, type, in_channels, out_channels):
        super(GRAPH_CONV, self).__init__()
        self.type = type
        self.in_channels = in_channels
        self.out_channels = out_channels
        if type == "gcn":
            self.graph_conv = GCNConv(in_channels, out_channels)
            self.graph_conv.node_dim= 0

    def forward(self, x, edge_index):
        """ print("Edge index in Forward $$$#$#:" + str(edge_index)) """
        return self.graph_conv(x, edge_index)

class GRAPH_POOL(nn.Module):
    def __init__(self, type, in_channels, poolratio):
        super(GRAPH_POOL, self).__init__()
        self.type = type
        self.in_channels = in_channels
        self.poolratio = poolratio
        if self.type == "sagpool":
            self.graph_pool = SAGPooling(in_channels, ratio=poolratio)
        elif self.type == "topkpool":
            self.graph_pool = TopKPooling(in_channels, ratio=poolratio)
    
    def forward(self, x, edge_index, batch):
        return self.graph_pool(x, edge_index, batch=batch)

class GRAPH_READOUT(nn.Module):
    def __init__(self, type):
        super(GRAPH_READOUT, self).__init__()
        self.type = type
    
    def forward(self, x, batch):
        if self.type == "max":
            return global_max_pool(x, batch)
        elif self.type == "mean":
            return global_mean_pool(x, batch)
        elif self.type == "add":
            return global_add_pool(x, batch)


class GRAPH2VEC(nn.Module):
    
    ''' 
        For users who want to develop their own network architecture, 
        you may use this graph2vec class as template and implement your architecture.
    '''

    def __init__(self, config):
        super(GRAPH2VEC, self).__init__()
        self.config = config

    def forward(self, x):
        # ModuleList can act as an iterable, or be indexed using ints
        # Doesn't work
        for i, l in enumerate(self.layers):
            print(self.layers[i])
            self.layers[i // 2](x['x'], x['edge_index']) + l(x['x'], x['edge_index'])
        return x


    def save_model(self, model_config_path, model_weight_path):
        Path(model_config_path).parent.mkdir(parents=True, exist_ok=True)
        Path(model_weight_path).parent.mkdir(parents=True, exist_ok=True)
        model_configurations = {}

        convs = [] 
        for layer in self.layers:
            convs.append((layer.type, layer.in_channels, layer.out_channels))
        model_configurations['convs'] = convs

        model_configurations['pool'] = (self.pool1.type, self.pool1.in_channels, self.pool1.poolratio)
        model_configurations['readout'] = self.graph_readout.type
        model_configurations['fc'] = (self.fc.in_features, self.fc.out_features)
        with open(model_config_path, 'w') as f:
            json.dump(model_configurations, f)
        torch.save(self.state_dict(), model_weight_path)

    def load_model(self, model_config_path, model_weight_path):
        with open(model_config_path) as f:
            model_configuration = json.load(f)
        
        convs = [] 
        for setting in model_configuration['convs']:
            graph_conv_type, in_channels, out_channels = setting
            convs.append(GRAPH_CONV(graph_conv_type, int(in_channels), int(out_channels)))

        self.set_graph_conv(convs)
        pool_type, pool_in_channels, pool_ratio = model_configuration['pool']
        self.set_graph_pool(GRAPH_POOL(pool_type, pool_in_channels, pool_ratio))

        self.set_graph_readout(GRAPH_READOUT(model_configuration['readout']))
        fc_in_channel, fc_out_channel = model_configuration['fc']
        self.set_output_layer(nn.Linear(fc_in_channel, fc_out_channel))

        model = torch.load(model_weight_path, map_location='cpu')
        

        #Update the data format
        keyUpdates = dict()
        keyUpdates['layers.0.graph_conv.weight' ] = 'layers.0.graph_conv.lin.weight'
        keyUpdates['layers.1.graph_conv.weight'] ='layers.1.graph_conv.lin.weight'
        keyUpdates['pool1.graph_pool.gnn.lin_l.weight'] ='pool1.graph_pool.gnn.lin_rel.weight'
        keyUpdates['pool1.graph_pool.gnn.lin_l.bias'] ='pool1.graph_pool.gnn.lin_rel.bias'
        keyUpdates['pool1.graph_pool.gnn.lin_r.weight'] = 'pool1.graph_pool.gnn.lin_root.weight'
        cfgUpdater(model, keyUpdates)

        """ cfgUpdater(model, 'layers.0.graph_conv.lin.weight', 'layers.0.graph_conv.weight')
        cfgUpdater(model, 'layers.1.graph_conv.lin.weight', 'layers.1.graph_conv.weight')
        cfgUpdater(model, 'pool1.graph_pool.gnn.lin_rel.weight', 'pool1.graph_pool.gnn.lin_l.weight')
        cfgUpdater(model, 'pool1.graph_pool.gnn.lin_rel.bias', 'pool1.graph_pool.gnn.lin_l.bias')
        cfgUpdater(model, 'pool1.graph_pool.gnn.lin_root.weight', 'pool1.graph_pool.gnn.lin_r.weight') """

        #print(model.keys())

        """ for iter in model:
            print(iter)
            #print(len(model[iter]))
            print(model[iter].shape)
            with open("modelData.txt", 'w') as file:
            print(model, file = file) 
        #print(model.keys()) """



        self.load_state_dict(model)
        
    def set_graph_conv(self, convs):
        self.layers = []
        
        for conv in convs:
            conv.to(self.config.device)
            self.layers.append(conv)
        self.layers = nn.ModuleList(self.layers)

    def set_graph_pool(self, pool_layer):
        self.pool1 = pool_layer.to(self.config.device)
            
    def set_graph_readout(self, typeofreadout):
        self.graph_readout = typeofreadout

    def set_output_layer(self, layer):
        self.fc = layer.to(self.config.device)
    
    def embed_graph(self, x, edge_index, batch):
        attn_weights = dict()
        x = F.one_hot(x, num_classes=self.config.num_feature_dim).float()
        for layer in self.layers:
            x = F.dropout(F.relu(layer(x, edge_index)), p=self.config.dropout, training=self.training)
        x, edge_index, _, batch, attn_weights['pool_perm'], attn_weights['pool_score'] = \
            self.pool1(x, edge_index, batch=batch)
        x = self.graph_readout(x, batch)

        attn_weights['batch'] = batch
        return x, attn_weights

    def embed_node(self, x, edge_index):
        x = F.one_hot(x, num_classes=self.config.num_feature_dim).float()
        for layer in self.layers:
            x = F.dropout(F.relu(layer(x, edge_index)), p=self.config.dropout, training=self.training)
        return x

    def mlp(self, x):
        return self.fc(x)