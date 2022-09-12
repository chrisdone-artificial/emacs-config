;;; watch-mode.el ---

;; Copyright (c) 2022 Chris Done. All rights reserved.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(define-derived-mode watch-mode
  fundamental-mode "Watch"
  "Major mode for watching outputs to commands.
 \\{watch-mode-map}")

(define-key watch-mode-map
  (kbd "g") 'watch-refresh)

(defvar-local watch-mode-command "echo")
(defvar-local watch-mode-arguments '(list "Hello, World!"))

(defun watch-refresh ()
  "Refresh the current buffer's output."
  (interactive)
  (let ((start (point)))
    (erase-buffer)
    (apply #'call-process
           (append (list watch-mode-command
                         nil            ; in-file
                         (current-buffer)
                         t
                         )
                   watch-mode-arguments))
    (goto-char start)))

(defun watch-shell-other-window (command)
  "Watch the given shell COMMAND in the other window."
  (interactive "sCommand: ")
  (watch-other-window
   "/bin/sh"
   (list "-c" command)))

(defun watch-other-window (proc args)
  "Watch the process output of PROC with arguments ARGS in a fresh buffer."
  (with-current-buffer (switch-to-buffer-other-window (get-buffer-create (format "*watch: %s %S*" proc args)))
    (watch-mode)
    (setq-local watch-mode-command proc)
    (setq-local watch-mode-arguments args)
    (watch-refresh)))

(provide 'watch-mode)
