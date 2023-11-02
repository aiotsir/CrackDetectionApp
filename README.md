# Crack Detection App

## Overview

The Crack Detection App is a mobile application developed in Flutter for detecting cracks on concrete surfaces. It uses a deep learning model based on InceptionNet that has been trained on a dataset comprising more than 10,000 images of concrete surfaces, both cracked and uncracked.

## Features

- Real-time crack detection using the device's camera.
- Offline crack detection for pre-captured images.
- User-friendly interface for capturing and analyzing images.
- High accuracy in detecting concrete cracks.

## Usage

1. Open the app on your device.
2. Use the camera to capture images of concrete surfaces.
3. The app will automatically detect and highlight cracks in the images.

## Model Details

- The model is based on InceptionNet architecture.
- It has been trained on a dataset of over 10,000 images of concrete surfaces, labeled as cracked and uncracked.
- Training was conducted using TensorFlow and Keras.
- The model achieves high accuracy in crack detection.

## Project Report
Crack Detection Android App in Flutter

Project Report prepared on                                                                  22 November 2021

An Android application to detect cracks in tunnels using Deep Learning trained model.
The app has been built using Google’s Flutter SDK and it is able to detect cracks on surfaces by capturing the live image and also from an image stored within the device’s gallery.
TensorFlow Lite framework has been used to connect the given Tunnel Crack detection Deep Learning Inception model with the app. As required the h5 model file was converted to tflite format to put it to use in the Flutter project. This conversion was done in Google’s Colab and model training was done in Colab too by Gibson.
The code editor software Android Studio was used to Create Flutter Project Application and used the Image Picker plugin provided by flutter to enable the app to capture image using camera and also to pick image from the device’s storage.

The major functions used in the project are the following: 

loadmodel() – to load the tflite model to the Stateful Widget class.

classifyImage() – to run the tflite model on the image.

pickImage()  - to capture image using the on-device camera.

pickGalleryImage() – to select an image from the device’s storage.

The label.txt file listing “Cracked” and “Not Cracked” was used to load result for the image picked.
