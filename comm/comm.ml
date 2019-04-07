(*for ipfs dag put, we need to execute a command using unix.execv. 
his command does not return back to the calling process. 
hence we need to create a child process to execute this command, 
so that we could return back to the parent process and continue*)

(*ipfs dag put command takes input only from the standard input, 
hence we need to modify the file descriptors for the same*)

let ipfs_dag_get _a= 
  let ipfs_path = "/usr/local/bin/ipfs" in
  
  match Unix.fork() with
  | 0 -> ignore @@ Unix.handle_unix_error Unix.execv ipfs_path 
                ([| ipfs_path; "dag"; "get";|]);
  | _ -> (match Unix.wait() with
         | (_pid, Unix.WEXITED _retcode) -> ()
         | _ -> failwith "ipfs get"); 
  Printf.printf "ipfs dag get is finished\n";  
  ();;

let ipfs_dag_put _a = 
  let ipfs_path = "/usr/local/bin/ipfs" in

  let (fd_read_in1, fd_write_out1) = Unix.pipe() in 
  (*let (fd_read_in2, fd_write_out2) = Unix.pipe() in *)

  match Unix.fork() with
  | 0 -> 
  (*Unix.dup2 fd_read_in1 Unix.stdin;*)
  Unix.dup2 fd_write_out1 Unix.stdout;
  Unix.close fd_read_in1;

  ignore @@ Unix.handle_unix_error Unix.execv ipfs_path 
                ([| ipfs_path; "dag"; "put"; "--input-enc"; "raw"; |]);
  | _ -> 
  (*Unix.dup2 fd_read_in1 Unix.stdin;*)
  (*Unix.dup2 fd_write_out1 Unix.stdout;*)

  (match Unix.wait() with
         | (_pid, Unix.WEXITED _retcode) -> ()
         | _ -> failwith "ipfs put"); 

  Unix.close fd_write_out1;
  let buf = Bytes.create 100 in
    ignore @@ Unix.read fd_read_in1 buf 0 100;
    Unix.close fd_read_in1;
    Printf.printf "ipfs dag put is finished\nhash=%s" buf;                    
  ();;




let () = 
  ipfs_dag_put 5;
  Printf.printf "back to main\n";
  (*ipfs_dag_get;*)
  Printf.printf "back to main2\n";



(*let input_msg = "this input msg is for ipfs dag put" in 
  let a =545645 in 
  Printf.printf "%d" a;
  
  ignore @@ Unix.execv "/bin/ls" [|"ls";"-l";|];*)