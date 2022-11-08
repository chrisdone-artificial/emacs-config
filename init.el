;; Emacs version
;; GNU Emacs 25.2.1 (x86_64-pc-linux-gnu, X toolkit, Xaw3d scroll bars)
;;  of 2017-09-22, modified by Debian


;; Standard libraries needed

(require 'cl)


;; Packages and configs to load

(defvar packages
  '(color-theme
    s
    zenburn
    sunburn
    god-mode
    paredit
    audit
    haskell-mode
    rust-mode
    clipetty
    web-mode
    typescript-mode
    smex
    magit
    goto-last-change
    markdown-mode
    dockerfile-mode
    dash
    elisp-slime-nav
    echo-keys
    align-by-current-symbol
    ag
    goto-last-point
    git-link
    number
    hide-region
    resmacro
    flycheck
    json-reformat
    restclient
    purescript-mode
    yaml-mode
    websocket
    quickjump
    slow-keys
    psc-ide
    neotree
    string-inflection
    tail-on-change
    graphql-mode
    markdown-toc
    swiper
    find-file-in-project
    edit-comment
    prodigy
    docker
    kubel
    graphviz-dot-mode
    dogears
    go-mode
    hiedb
    art-mode
    watch-mode)
  "Packages whose location follows the
  packages/package-name/package-name.el format.")

(defvar custom-load-paths
  '("structured-haskell-mode/elisp"
    "hindent/elisp"
    "git-modes"
    "company-mode"
    "intero/elisp"
    "psc-ide-emacs/")
  "Custom load paths that don't follow the normal
  package-name/module-name.el format.")

(defvar configs
  '("global"
    "god"
    "haskell"
    "lisp"
    "markdown"
    "org"
    "ivy"
    "prodigy"
    "focus")
  "Configuration files that follow the config/foo.el file path
  format.")


;; Load packages

(loop for location in custom-load-paths
      do (add-to-list 'load-path
             (concat (file-name-directory (or load-file-name
                                              (buffer-file-name)))
                     "packages/"
                     location)))

(loop for name in packages
      do (progn (unless (fboundp name)
                  (add-to-list 'load-path
                               (concat (file-name-directory (or load-file-name
                                                                (buffer-file-name)))
                                       "packages/"
                                       (symbol-name name)))
                  (require name))))

(require 'shm)
(require 'hindent)
(require 'shm-case-split)
(require 'shm-reformat)
(require 'company)
(require 'magit-blame)
(require 'intero)
(require 'haskell-mode)
(require 'haskell)
(require 'haskell-simple-indent)
(require 'haskell-move-nested)
(require 'psc-ide)
(require 'counsel)
(require 'hiedb)


;; Emacs configurations

(loop for name in configs
      do (load (concat (file-name-directory load-file-name)
                       "config/"
                       name ".el")))


;; Mode initializations

(smex-initialize)
(zenburn)
(god-mode)
(goto-last-point-mode)
(turn-on-haskell-simple-indent)
(global-set-key (kbd "C-z") 'ido-switch-buffer)
(winner-mode)

(global-display-line-numbers-mode)

(add-hook 'shell-mode-hook 'turn-off-display-line-numbers-mode)
(add-hook 'magit-status-mode-hook 'turn-off-display-line-numbers-mode)
(add-hook 'flycheck-error-list-mode-hook 'turn-off-display-line-numbers-mode)
(add-hook 'messages-buffer-mode-hook 'turn-off-display-line-numbers-mode)
(add-hook 'intero-help-mode-hook 'turn-off-display-line-numbers-mode)
(add-hook 'git-commit-mode-hook 'turn-off-display-line-numbers-mode)
(add-hook 'intero-repl-mode-hook 'turn-off-display-line-numbers-mode)
(defun turn-off-display-line-numbers-mode ()
  (interactive)
  (display-line-numbers-mode -1))
