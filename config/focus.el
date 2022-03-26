;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Focus state changes

; (add-function :after after-focus-change-function 'my-after-focus)
(defun my-after-focus ()
  ;; (when (frame-focus-state)
  ;;   (send-string-to-terminal "\a"))
  )

(defun update-clipboard ()
  (kill-new (with-temp-buffer
              (insert-file-contents "~/.clipboard/clipboard.txt")
              (buffer-substring (point-min) (1- (point-max)))))
  nil)
