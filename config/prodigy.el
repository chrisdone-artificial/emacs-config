;;; prodigy service example ssh tunnels
;; This example uses `prodigy-callback' in a tag definition to make it
;; easy to define new tunnels: The generic :ARGS property of the tag
;; accesses the service definition (lower in the hierarchy!) to get
;; the tunnel specific data (property :TUNNEL) as property list and
;; pass that to the helper `my-build-tunnel-args'.
;;
;; This code uses `getf' from `cl.el', an autoloaded function; if you
;; don't like that, replace it with `plist-get'
(defun my-build-tunnel-args (args)
  "Assemble the ssh tunnel argument list."
  `("-v" ;; allows us to parse for the ready message
    "-N" ;; don't start an interactive shell remotely
    "-L" ,(concat (getf args :localport) ;; the tunnel spec
                  ":"
                  (getf args :tunnel-ip)
                  ":"
                  (getf args :tunnel-port))
    ,(getf args :host)))    ;; the remote host

(prodigy-define-tag
  :name 'ssh-tunnel
  :command "ssh"
  :cwd (getenv "HOME")
  :args (prodigy-callback (service)
                          (my-build-tunnel-args
                           (getf service :tunnel)))
  :ready-message "debug1: Entering interactive session.")

;; Example:
;;
;; (prodigy-define-service
;;   :name "my-forward"
;;   :tags '(ssh-tunnel)
;;   :tunnel (list
;;            :localport  "38161"
;;            :tunnel-ip  "127.0.0.1"
;;            :tunnel-port  "38161"
;;            :host  "some-host"))
