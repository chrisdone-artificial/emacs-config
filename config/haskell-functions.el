(defun haskell-copy-module-name ()
  "Guess the current module name of the buffer."
  (interactive)
  (kill-new (haskell-guess-module-name)))

(defun haskell-guess-module-name ()
  "Guess the current module name of the buffer."
  (interactive)
  (let ((components (cl-loop for part
                             in (reverse (split-string (buffer-file-name) "/"))
                             while (let ((case-fold-search nil))
                                     (string-match "^[A-Z]+" part))
                             collect (replace-regexp-in-string "\\.l?hs$" "" part))))
    (mapconcat 'identity (reverse components) ".")))

(defun hasktags ()
  "Runs hasktags."
  (interactive)
  (message "Running hasktags ...")
  (redisplay)
  (apply #'call-process
         (append (list "hasktags" nil (get-buffer-create "*hasktags-output*") t)
                 hasktags-directories
                 (list "-o" hasktags-path)))
  (message "Running hasktags ... done!"))

(defun hiedb-index ()
  "Runs hiedb index."
  (interactive)
  (message "Running hiedb index asynchronously ...")
  (apply #'start-process
         (append (list "hiedb-index" (get-buffer-create "*hiedb-index-output*") "hiedb")
                 (list "index")
                 hiedb-directories
                 (list "--database" hiedb-path))))

(defun haskell-refresh ()
  "Refresh databases."
  (interactive)
  (hasktags)
  (hiedb-index))
