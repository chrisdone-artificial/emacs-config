;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Focus state changes
;;
;; see accompanying scripts here: https://gist.github.com/chrisdone-artificial/89ff606c0e93dc2e39fb29b161b0bd41

;; (add-function :after after-focus-change-function 'my-after-focus)
;; (defun my-after-focus ()
;;   (when (frame-focus-state)
;;     (send-string-to-terminal "\a")))

;; (defvar last-clipboard-update "")
;; (defun update-clipboard (base64)
;;   "Given a base64 string, decode it, strip final newline, and replace ^M with \n."
;;   (unless (string= base64 last-clipboard-update)
;;     (kill-new (with-temp-buffer
;;                 (set-buffer-multibyte nil)
;;                 (insert (base64-decode-string base64))
;;                 (decode-coding-region (point-min) (point-max) 'utf-8 t))))
;;   (setq last-clipboard-update base64)
;;   "Clipboard updated.")