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
  (message "Started hiedb index job.")
  (apply #'start-process
         (append (list "hiedb-index" (with-current-buffer (get-buffer-create "*hiedb-index-output*")
                                       (erase-buffer)
                                       (current-buffer))
                       "hiedb")
                 (list "index")
                 hiedb-directories
                 (list "--database" hiedb-path))))

(defun haskell-refresh ()
  "Refresh databases."
  (interactive)
  (hasktags)
  (hiedb-index))

(defun haskell-refresh-hook ()
  "Attempt to run haskell-refresh, but it's fine if it fails."
  (condition-case nil
      (haskell-refresh)
    (error (message "haskell-refresh was not successful."))))

(defun hiedb-show-type-h98 ()
  "Show type of thing at point, formatted with h98-mode."
  (interactive)
  (let ((types (hiedb-call-by-point 'hiedb-point-types)))
    (when types
      (message "%s"
               (with-temp-buffer
                 (h98-mode)
                 (insert types)
                 (font-lock-ensure)
                 (buffer-string))))))

(defun haskell-copy-imports ()
  (interactive)
  (save-excursion
    (let* ((start (progn (goto-char (point-min))
                         (search-forward-regexp "^import")
                         (line-beginning-position)))
           (end (progn (goto-char (point-max))
                       (search-backward-regexp "^import")
                       (line-end-position)))
           (string (buffer-substring start end)))
      (kill-new string)
      (message "Copied %d lines of imports." (length (split-string string "\n"))))))
