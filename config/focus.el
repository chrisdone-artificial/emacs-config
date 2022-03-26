;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Focus state changes

(add-function :after after-focus-change-function 'my-after-focus)
(defun my-after-focus ()
  (when (frame-focus-state)
    (send-string-to-terminal "\a")))

(defun update-clipboard ()
  (kill-new (shell-command-to-string "cat ~/.clipboard/clipboard.txt"))
  nil)
