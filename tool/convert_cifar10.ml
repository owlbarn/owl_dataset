open Bigarray

(* Function to read CIFAR-10 binary file *)
let read_cifar10_file filename =
  let num_images = 10000 in
  let num_channels = 3 in
  let height = 32 in
  let width = 32 in

  (* Create Bigarrays for images and labels *)
  let images = Genarray.create float32 c_layout [|num_images; height; width; num_channels|] in
  let labels = Genarray.create float32 c_layout [|num_images|] in

  let ic = open_in_bin filename in
  for i = 0 to num_images - 1 do
    let label = input_byte ic in
    Genarray.set labels [|i|] (float_of_int label);
    
    for h = 0 to height - 1 do
      for w = 0 to width - 1 do
        for c = 0 to num_channels - 1 do
          let pixel = input_byte ic in
          Genarray.set images [|i; h; w; c|] (float_of_int pixel /. 255.0)
        done
      done
    done
  done;

  close_in ic;
  (images, labels)

let () =
  let images, labels = read_cifar10_file "data_batch_1.bin" in
  let lblvec  = Dense.Ndarray.S.one_hot 10 labels in
  let labels  = Dense.Ndarray.S.expand labels ~hi:true 2 in
  Dense.Ndarray.S.save ~out:"cifar10_train1_data" images;
  Dense.Ndarray.S.save ~out:"cifar10_train1_labels" labels;
  Dense.Ndarray.S.save ~out:"cifar10_train1_lblvec" lblvec



let () =
  let images, labels = read_cifar10_file "test_batch.bin" in
  let lblvec  = Dense.Ndarray.S.one_hot 10 labels in
  let labels  = Dense.Ndarray.S.expand labels ~hi:true 2 in
  Dense.Ndarray.S.save ~out:"cifar10_test_data" images;
  Dense.Ndarray.S.save ~out:"cifar10_test_labels" labels;
  Dense.Ndarray.S.save ~out:"cifar10_test_lblvec" lblvec
  