# Data Scientist Nanodegree Capstone Project

The goal of this project is to use a CNN to classify dog breeds. The steps are the classification of an image as a dog or a human,later, a prediction of which dog breed the dog is if classified as a dog, or which dog breed the human most look like. If the image is detected  neither as a dog nor as a human, the classifier will not say it.

# Files included:
- dog-app.ipynb is the python 3 file that can be run to classify dog images
- The test_images folder has the test images for this project.
- The saved models weights folder contains the models saved during this project
- haarcascades folder contains the Opencv's haarcascasde pretrained model

# Library used:
- Scikit_learn
- NUmpy
- Pandas
- keras
- Tensorflow

# bottleneck features for ResNet-50 :
https://s3-us-west-1.amazonaws.com/udacity-aind/dog-project/DogResnet50Data.npz

# Result Summary

 The pre-train model's performance was way more better  the hand the CNN made from scratch. The accuracy of ResNet-50 (pre-trained on ImageNet) reached 85% whereas  CNN from scratch was 4%. This drastical improvement was happened because of the huge dataset from Imagenet on which ResNet-50 model was pretrained on. ImageNet has huge amount of data and also the complexity of ResNet helped a lot reach this accuracy of 85% from 4%.
