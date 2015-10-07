
(setq require-final-newline t)

;; Replace yes by y.
(fset 'yes-or-no-p 'y-or-n-p)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(setq make-backup-files nil)

(defun save-all ()
  (interactive)
  (save-some-buffers t))
(add-hook 'focus-out-hook 'save-all)

;; Make it so that the C-x k binding kills the current buffer instead of
;; offering a prompt.
(defun dl93/kill-default-buffer ()
  "Kill the currently active buffer"
  (interactive)
  (let (kill-buffer-query-functions) (kill-buffer)))
(global-set-key (kbd "C-x k") 'kill-default-buffer)

(setq-default indent-tabs-mode nil)

(desktop-save-mode 1)
