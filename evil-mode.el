
(require 'evil-leader)
(global-evil-leader-mode 1)
(evil-leader/set-leader ",")
(setq evil-leader/in-all-states 1)

;; Sucessive calls to this function doesn't seem to work; you have to map
;; everything at once.
(evil-leader/set-key
  "g" 'helm-bookmarks
  "b" 'bookmark-set
  "k" 'dl93/kill-default-buffer
  "f" 'helm-find
  "h" 'helm-apropos)

(global-set-key (kbd "C-k")
                (lambda ()
                  (interactive)
                  (evil-scroll-up nil)))
(global-set-key (kbd "C-j")
                (lambda ()
                  (interactive)
                  (evil-scroll-down nil)))

(require 'evil)
(evil-mode t)
;;; evil-mode.el ends here
