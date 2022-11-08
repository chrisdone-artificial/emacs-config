;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SSH

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Postgres service

(defun my-build-pg-args (args)
  "Assemble the docker pg argument list."
  `("run"
    "--name"
    ,(getf args :container-name)
    "-e"
    ,(format "POSTGRES_PASSWORD=%s" (getf args :pg-pass))
    "-e"
    ,(format "POSTGRES_USER=%s" (getf args :pg-user))
    "-e"
    ,(format "POSTGRES_DB=%s" (getf args :pg-db))
    "--rm"
    "-p"
    ,(format "%d:5432" (getf args :pg-port))
    "postgres:12.12"))

(prodigy-define-tag
  :name 'postgres
  :command "/usr/local/bin/docker"
  :cwd (getenv "HOME")
  :args (prodigy-callback (service)
          (my-build-pg-args
           (getf service :config)))
  :ready-message "listening on IPv4 address")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Services

(prodigy-define-service
  :name "brossa-pg"
  :tags '(postgres)
  :config
  (list
   :container-name "brossa-postgres"
   :pg-port 5432
   :pg-user "brossa-test"
   :pg-password "brossa-test"
   :pg-db "brossa-test"))
