open Bigarray


let read_int32 ic =
  let b1 = input_byte ic in
  let b2 = input_byte ic in
  let b3 = input_byte ic in
  let b4 = input_byte ic in
  Int32.logor (Int32.shift_left (Int32.of_int b1) 24)
    (Int32.logor (Int32.shift_left (Int32.of_int b2) 16)
       (Int32.logor (Int32.shift_left (Int32.of_int b3) 8)
          (Int32.of_int b4)))


let read_images filename =
  let ic = open_in_bin filename in
  let magic = read_int32 ic in
  let num_images = Int32.to_int (read_int32 ic) in
  let num_rows = Int32.to_int (read_int32 ic) in
  let num_cols = Int32.to_int (read_int32 ic) in
  let images = Array2.create float32 c_layout num_images (num_rows * num_cols) in
  for i = 0 to num_images - 1 do
    for j = 0 to (num_rows * num_cols) - 1 do
      let pixel = input_byte ic in
      Array2.set images i j (float_of_int pixel)
    done
  done;
  close_in ic;
  images


let read_labels filename =
  let ic = open_in_bin filename in
  let magic = read_int32 ic in
  let num_labels = Int32.to_int (read_int32 ic) in
  let labels = Array1.create float32 c_layout num_labels in
  for i = 0 to num_labels - 1 do
    let label = input_byte ic in
    Array1.set labels i (float_of_int label)
  done;
  close_in ic;
  labels


let train_images = read_images "train-images.idx3-ubyte" |> genarray_of_array2
let test_images = read_images "t10k-images.idx3-ubyte"   |> genarray_of_array2
let train_labels = read_labels "train-labels.idx1-ubyte" |> genarray_of_array1
let test_labels = read_labels "t10k-labels.idx1-ubyte"   |> genarray_of_array1

let train_lblvec = Dense.Ndarray.S.one_hot 10 train_labels
let test_lblvec = Dense.Ndarray.S.one_hot 10 test_labels

let train_labels = Dense.Ndarray.S.expand train_labels ~hi:true 2 
let test_labels  = Dense.Ndarray.S.expand test_labels ~hi:true 2

let _ = Dense.Ndarray.S.save "mnist-test-images" test_images
let _ = Dense.Ndarray.S.save "mnist-train-images" train_images
let _ = Dense.Ndarray.S.save "mnist-test-lblvec" test_lblvec
let _ = Dense.Ndarray.S.save "mnist-train-lblvec" train_lblvec
let _ = Dense.Ndarray.S.save "mnist-test-labels" test_labels
let _ = Dense.Ndarray.S.save "mnist-train-labels" train_labels

