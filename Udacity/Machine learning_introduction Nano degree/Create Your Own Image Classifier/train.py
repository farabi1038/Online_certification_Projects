import matplotlib.pyplot as plt
import numpy as np
import time
import argparse
import Utils
import torch
from torch import nn
from torch import tensor
from torch import optim
import torch.nn.functional as F
from torch.autograd import Variable
from torchvision import datasets, transforms
import torchvision.models as models




ap = argparse.ArgumentParser(description='train.py')
# Command Line ardguments
ap.add_argument('--arch', dest="arch", action="store", default="vgg16", type = str)
ap.add_argument('--hidden_units', type=int, dest="hidden_units", action="store", default=100)
ap.add_argument('--dropout', dest = "dropout", action = "store", default = 0.3)
ap.add_argument('--epochs', dest="epochs", action="store", type=int, default=1)
ap.add_argument('data_dir', nargs='*', action="store", default="./flowers/")
ap.add_argument('--gpu', dest="gpu", action="store", default="gpu")
ap.add_argument('--save_dir', dest="save_dir", action="store", default="./checkpoint.pth")
ap.add_argument('--learning_rate', dest="learning_rate", action="store", default=0.002)



pa = ap.parse_args()
where = pa.data_dir
dropout = pa.dropout
hidden_layer1 = pa.hidden_units
path = pa.save_dir
lr = pa.learning_rate
structure = pa.arch
epochs = pa.epochs
power = pa.gpu
arch=pa.arch

trainloader, v_loader, testloader = Utils.load_data(where)


model, optimizer, criterion = Utils.nn_setup(arch,dropout,hidden_layer1,lr,power)


Utils.train_network(model, optimizer, criterion, epochs, 20, trainloader, power)


Utils.save_checkpoint(model,path,arch,hidden_layer1,dropout,lr)


print(" Model is trained")