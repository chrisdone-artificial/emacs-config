(define-key paredit-mode-map (kbd "\\") 'paredit-return-or-backslash)
(define-key paredit-mode-map (kbd "<delete>") 'paredit-delete-sexp)
(define-key paredit-mode-map (kbd "C-M-k") 'paredit-kill-sexp)
(define-key paredit-mode-map (kbd "M-k") 'paredit-kill-sexp)
(define-key paredit-mode-map (kbd "DEL") 'paredit-backward-delete.)
(define-key paredit-mode-map (kbd "M-^") 'paredit-delete-indentation)
(define-key paredit-mode-map (kbd "M-a") 'paredit-backward-up)
