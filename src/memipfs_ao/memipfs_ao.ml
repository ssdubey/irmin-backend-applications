open Lwt_main

(* this applicatin will store values in Irmin_mem and fetch them*)
module Store_module = Irmin_memipfs.Append_only (Irmin.Contents.String) (Irmin.Contents.String);;

(*to understand the design, imagine that there are 2 ipfs instances (binaries) available in our local system. 
Now to use both of them one by one, we need to create separate configurations for both, and use this configurationto 
point out which ipfs instance we are using in which operation.*)

let config1 = Irmin_memipfs.config "/usr/local/bin/ipfs" in
let hashtable = Lwt_main.run @@ Store_module.v config1 in
Store_module.batch hashtable (fun hashtable -> Store_module.add hashtable "key" "12345");;

(*print_string "\nthe value is stored in the mem\n";;*)

(*let item = Lwt_main.run @@ Store_module.find hashtable "key" in 
  match item with
  | Some i -> print_string @@ i ^ "\n"
  | None -> print_string "its a scam\n"*)

  
  module Key_module = Irmin_memipfs.Atomic_write (Irmin.Contents.String) (Irmin.Contents.String);;
  let config1 = Irmin_memipfs.config "/usr/local/bin/ipfs" in
  let key_hashtable = Lwt_main.run @@ Key_module.v config1 in
    ignore @@ Key_module.set key_hashtable "key" "value";
    ignore @@ Key_module.find key_hashtable "key";
    let keylist = Lwt_main.run @@ Key_module.list key_hashtable in
      List.iter print_string keylist;;