
;; === Init ===

(require 'cl)
(require 'cl-lib)
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))

(require 'use-package)
(setq use-package-always-ensure t)

;; If the gpg executable is not found disable signature checking.
(defun sanityinc/package-maybe-enable-signatures()
  (setq package-check-signature (when (executable-find "gpg") 'allow-unsigned)))
(sanityinc/package-maybe-enable-signatures)


;; === Appearance ===

(use-package afternoon-theme
  :config
  (load-theme 'afternoon t))

(use-package rainbow-delimiters)

(use-package fill-column-indicator)

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
(set-frame-font "Inconsolata 13")

(add-hook 'prog-mode-hook 'line-number-mode t)
(add-hook 'prog-mode-hook 'global-hl-line-mode 1)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode 1)
(add-hook 'prog-mode-hook 'fci-mode 1)


;; === Helm ===

(use-package helm
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x C-b" . helm-buffers-list))
  :init
  (require 'helm-config))

(use-package helm-ls-git
  :bind (("C-x C-g" . helm-ls-git-ls)))


;; === Editor config ===


(use-package evil
  :init
    (evil-mode t))

(defun dl93/kill-default-buffer ()
  "Kill the currently active buffer"
  (interactive)
  (let (kill-buffer-query-functions) (kill-buffer)))

(use-package evil-leader
    :init (global-evil-leader-mode)
    :config
    (global-evil-leader-mode 1)
    (evil-leader/set-leader ",")
    (setq evil-leader/in-all-states 1)
    (evil-leader/set-key
      "g" 'helm-bookmarks
      "b" 'bookmark-set
      "q" 'dl93/kill-default-buffer
      "f" 'helm-find
      "a" 'helm-apropos
      "h" 'windmove-left
      "j" 'windmove-down
      "k" 'windmove-up
      "l" 'windmove-right))

(use-package yasnippet
  :init
  (yas-global-mode 1)
  :config
  (setq yas-snippet-dirs
        '("~/.emacs.d/snippets")))

(add-hook 'text-mode-hook (lambda ()
                            (turn-on-auto-fill)
                            (setq show-trailing-whitespace 't)))

(setq-default fill-column 100)
(setq require-final-newline t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq make-backup-files nil)
(setq-default indent-tabs-mode nil)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(defun dl93/save-all ()
  (interactive)
  (save-some-buffers t))
(add-hook 'focus-out-hook 'dl93/save-all)

(desktop-save-mode 1)


;; === Language-specific support ===

(use-package markdown-mode
  :mode "\\.md\\'"
  :bind (("C-c C-c" . markdown-preview))
  :config (setq markdown-command "pandoc"))

(use-package tex
  :ensure auctex
  :config (progn
            (add-hook 'latex-mode-hook 'tex-source-correlate-mode)
            (setq font-latex-fontify-sectioning 1.0)))


;; === Other packages ===

(use-package magit
  :bind (("C-x g" . magit-status)))


