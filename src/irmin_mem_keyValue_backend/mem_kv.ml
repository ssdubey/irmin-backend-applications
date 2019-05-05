open Lwt.Infix;;
module Store = Irmin_mem.KV(Irmin.Contents.String)    (*changed here *)

(* Database configuration *)
let config = Irmin_mem.config                         (*changed here *)

(* Commit author *)
let author = "Example <example@example.com>"

(* Commit information *)
let info fmt = Irmin_unix.info ~author fmt

let main =
    (* Open the repo *)
    let cconfig = config () in                        (*changed here *)

    Store.Repo.v cconfig >>=                          (*changed here *)

    (* Load the master branch *)
    Store.master >>= fun t ->

    (* Set key "foo/bar" to "testing 123" *)
    Store.set t ~info:(info "Updating foo/bar") ["foo"; "bar"] "testing 123" >>= fun () ->

    (* Get key "foo/bar" and print it to stdout *)
    Store.get t ["foo"; "bar"] >|= fun x ->
    Printf.printf "foo/bar => '%s'\n" x

(* Run the program *)
let () = Lwt_main.run main

