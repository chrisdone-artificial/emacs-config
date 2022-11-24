(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'shell-mode-hook 'set-ansi-colors)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'magit-status-mode-hook 'turn-off-linum-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'minibuffer-setup-hook 'conditionally-enable-paredit-mode)
(add-hook 'h98-mode-hook 'company-mode)
