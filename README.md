# Owl Dataset

This repository provides easy access to various datasets to be used in the
Neural Network module of [Owl](https://github.com/ryanrhymes/owl).
Currently it mainly includes [MNIST](http://yann.lecun.com/exdb/mnist/) and
[CIFAR-10](https://www.cs.toronto.edu/~kriz/cifar.html).

You can get all these data in `Owl` by executing: `Dataset.download_all ()`.
The downloaded data are stored in the home directory, for example,  `~/.owl/dataset` on Linux.

## MNIST

The MNIST database of handwritten digits, available from this page, has a training set of 60,000 examples, and a test set of 10,000 examples. Each example is of size 28 x 28.

You can get MNIST data via these `Owl` functions:

- `Dataset.load_mnist_train_data ()`: return a triplet `x, y, y'`.
  + `x` is a 60000 x 784 matrix (`Owl_dense_matrix.S.mat`) where each row represent a 28 x 28 image.
  + `y` is a 60000 x 1 label matrix. Each row is an integer ranging from 0 to 9,
  indicating the digit on each image.
  + `y'` is a 60000 x 10 label matrix. Each one-hot row vector corresponding to
  one label.

- `Dataset.load_mnist_test_data ()`: return a triplet.
  Similar to `load_mnist_train_data`, only that it returns the test set, so
  the example size is 10, 000 instead of 60, 000.

- `Dataset.load_mnist_train_data_arr ()`: similar to `load_mnist_train_data`,   but returns `x` as [60000,28,28,1] ndarray

- `Dataset.load_mnist_test_data_arr ()`: similar to
  `load_mnist_train_data_arr`, but it returns the test set, so the example size
  is 10, 000 instead of 60, 000.

## CIFAR-10
The CIFAR-10 dataset consists of 60000 32 x 32 colour images in 10 classes,
with 6000 images per class. There are 50000 training images and 10000 test
images.

Due to the limit of file size on Github, the training set is cut into 5 smaller
batch. You can get CIFAR-10 data using `Owl`:

- `Dataset.load_cifar_train_data batch`: return a triplet `x, y, y'`.
  + The input `batch` can range from 1 to 5, indicating which training set batch to choose.
  + `x` is an [10000, 32, 32, 3] ndarry (`Owl_dense_ndarray.S.arr`). The final
  dimension indicates color channels (first Red, then Green, finally Blue).
  + Similar to MNIST, `y` is an 10000 x 1 label matrix, each number representing
  an image class.
  + `y'` is the corresponding 10000 x 10 one-hot label matrix.  

- `Dataset.load_cifar_test_data ()`: similar to `load_cifar_train_data`, only
  that it loads test data.

Note that all elements in the loaded matrices and ndarrays are of `float32` format.
