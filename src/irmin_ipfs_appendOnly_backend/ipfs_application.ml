
(*The application would be like a user interface, where user can specify the add, delete and list commands along with key and value, 
as required. The command will be processed in the application middle layer, where irmin commands are exposed for the user. Further it
will connect with irmin-ipfs backend and do the processing.*)

(*Memipfs_ao.add "key1" "data1";*)

Memipfs_ao.add_data "key_5" "data_5";;
print_string "\ndone adding\n";;
Memipfs_ao.find_key "key_5";;

(*Memipfs_ao.add_data "key_5" "data_5_1";;
print_string "\ndone adding\n";;
Memipfs_ao.find_key "key_5";;*)