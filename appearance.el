
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode 1)
(setq inhibit-splash-screen t)

;; Prevent too much font decoration. It's ugly anyway.
(setq font-lock-maximum-decoration 2)

;; Indicate the end of the buffer on the left.
(setq-default indicate-buffer-boundaries 'left)
(setq-default indicate-empty-lines 1)

;; Fonts.
(set-default-font "Inconsolata 13")
(set-frame-font "Inconsolata 13")

;; Themes
(require 'cyberpunk-theme)
(load-theme 'cyberpunk)

(require 'powerline)
(powerline-default-theme)
