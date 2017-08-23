# Owl Dataset

This repository provides easy access to various datasets to be used in the Neural Network module of [Owl](https://github.com/ryanrhymes/owl).
Currently it mainly includes [MNIST](http://yann.lecun.com/exdb/mnist/) and [CIFAR10](https://www.cs.toronto.edu/~kriz/cifar.html).

You can get all these data in `Owl` by running: `download_data fname ();;`.

## MNIST

The MNIST database of handwritten digits, available from this page, has a training set of 60,000 examples, and a test set of 10,000 examples. Each example is of size 28 x 28.

You can get MNIST data via these functions:

- `load_mnist_train_data ()`: return a triplet.
   The first is a 60000 x 784 matrix where each row represent a 28 x 28 image.
   The second is label
   The third is the corresponding unravelled row vector of the label.
