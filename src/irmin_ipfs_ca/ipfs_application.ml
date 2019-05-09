open Lwt_main
(*The application would be like a user interface, where user can specify the commands along with key and value, 
as required. The command will be processed in the application middle layer, where irmin commands are exposed for the user. Further it
will connect with irmin-ipfs backend and do the processing.*)

module Store_module = Irmin_ipfs_ca.Content_addressable (Irmin.Contents.String) (Irmin.Contents.String);;
module Key_module = Irmin_ipfs_ca.Atomic_write (Irmin.Contents.String) (Irmin.Contents.String);;

let config = Irmin_ipfs_ca.config ();;

(*add data to ipfs*)
(*let hash = Lwt_main.run @@ Store_module.add "dummy_t" "data_8";;
print_string ("\ndata hash = " ^ hash ^ "\n");;*)

(*publish data over a key*)
let hashmap = Lwt_main.run @@ Key_module.v config ;;

(*Key_module.set hashmap "key_8" hash;;*)

Key_module.remove hashmap "key3";;
Key_module.list hashmap


(*Store_module.add "data_1";;
print_string "\ndone adding\n";;
Memipfs_ao.find_key "key_6";;

Memipfs_ao.add_data "key_5" "data_5_1";;
print_string "\ndone adding\n";;
Memipfs_ao.find_key "key_5";;*)