
;; Standard libraries needed

(require 'cl)


;; Packages and configs to load

;; Commented out are candidates for removal
(defvar packages
  '(god-mode
    smex
    string-inflection
    git-link
    magit
    color-theme
    zenburn
    sunburn
    inheritenv
    envrc
    ag
    swiper
    watchexec
    quickjump
    h98-mode
    ts-mode
    paredit
    markdown-mode)
  "Packages whose location follows the
  packages/package-name/package-name.el format.")

(defvar custom-load-paths
  '("git-modes")
  "Custom load paths that don't follow the normal
  package-name/module-name.el format.")

(defvar configs
  '("global-macros"
    "global-functions"
    "global-keys"
    "global-config"
    "god"
    "dired"
    "git"
    "macos"
    "envrc"
    "shell"
    "ivy"
    "haskell-functions"
    "paredit-functions"
    "lisp-functions"
    "paredit-keys"
    "hooks"
    "autoload")
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


;; Custom require calls

(require 'counsel)


;; Emacs configurations

(loop for name in configs
      do (load (concat (file-name-directory (or load-file-name
                                                buffer-file-name))
                       "config/"
                       name ".el")))


;; Mode initializations

(progn (load "zenburn") (zenburn))
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(god-mode-all)
(smex-initialize)
(global-linum-mode)
(ido-mode)
(global-font-lock-mode)
(show-paren-mode)
(line-number-mode)
(column-number-mode)
(size-indication-mode)
(transient-mark-mode)
(delete-selection-mode)
(envrc-global-mode)


;; Disable auto-revert mode
(magit-auto-revert-mode -1)


;; Extra setups

(set-auto-saves)
