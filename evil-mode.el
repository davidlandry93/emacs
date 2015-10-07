
(require 'evil-leader)
(global-evil-leader-mode 1)
(evil-leader/set-leader ",")
(setq evil-leader/in-all-states 1)

;; Sucessive calls to this function doesn't seem to work; you have to map
;; everything at once.
(evil-leader/set-key
  "g" 'bookmark-jump
  "b" 'bookmark-set
  "k" 'dl93/kill-default-buffer)

(require 'evil)
(evil-mode t)
