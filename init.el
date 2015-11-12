
;; === Init ===

(require 'cl)
(require 'cl-lib)
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))

(require 'use-package)

;; If the gpg executable is not found disable signature checking.
(defun sanityinc/package-maybe-enable-signatures()
  (setq package-check-signature (when (executable-find "gpg") 'allow-unsigned)))
(sanityinc/package-maybe-enable-signatures)


;; === Appearance ===

(use-package afternoon-theme
  :ensure t
  :config
  (load-theme 'afternoon t))

(use-package rainbow-delimiters
  :ensure t)

(use-package fill-column-indicator
  :ensure t)

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
  :ensure t
  :init (progn
          (require 'helm-config)
          (helm-mode))
  :bind (;("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x C-b" . helm-buffers-list)))

(use-package helm-ls-git
  :ensure t
  :bind (("C-x C-g" . helm-ls-git-ls)))


;; === Editor config ===

(use-package evil
  :init (evil-mode t)
  :bind (("C-k" . evil-scroll-up)
         ("C-j" . evil-scroll-down)))

(defun dl93/kill-default-buffer ()
  "Kill the currently active buffer"
  (interactive)
  (let (kill-buffer-query-functions) (kill-buffer)))

(use-package evil-leader
    :ensure t
    :init (global-evil-leader-mode)
    :config
    (global-evil-leader-mode 1)
    (evil-leader/set-leader ",")
    (setq evil-leader/in-all-states 1)
    (evil-leader/set-key
      "1" 'delete-other-windows
      "g" 'helm-bookmarks
      "b" 'bookmark-set
      "q" 'dl93/kill-default-buffer
      "f" 'helm-find
      "h" 'helm-apropos
      "a" 'windmove-left
      "s" 'windmove-down
      "w" 'windmove-up
      "d" 'windmove-right))

(use-package evil-surround
  :ensure t
  :init (global-evil-surround-mode t))

(use-package yasnippet
  :ensure t
  :init
  (progn
    (setq yas-snippet-dirs
          '("~/.emacs.d/snippets"))
    (yas-global-mode 1)))

(use-package flycheck
  :ensure t
  :config (progn
            (add-hook 'after-init-hook #'global-flycheck-mode)
            (evil-leader/set-key "n" 'flycheck-next-error)
            (evil-leader/set-key "p" 'flycheck-previous-error)))

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
  :ensure t
  :mode "\\.md\\'"
  :config (progn
            (setq markdown-command "pandoc")
            (evil-leader/set-key "t" 'markdown-cycle)))
(eval-after-load 'markdown-mode
  '(define-key markdown-mode-map (kbd "C-c C-c") 'markdown-preview))

(use-package tex
  :ensure auctex
  :config (progn
            (add-hook 'latex-mode-hook (tex-source-correlate-mode t))
            (setq font-latex-fontify-sectioning 1.0)))

;; python

(use-package elpy
  :ensure t
  :init (elpy-enable))

;; cpp

(use-package auto-complete-clang
  :ensure t)

(use-package rtags)

(use-package cmake-ide
  :ensure t
  :init (require 'rtags)
  :config (cmake-ide-setup))

(use-package cmake-mode
  :mode "\\.cmake\\'"
  :mode "CMakeLists.txt\\'")

(use-package cmake-font-lock
  :ensure t
  :config (cmake-font-lock-activate))

(use-package cpputils-cmake
  :ensure t)

(add-hook 'c++-mode-hook (evil-leader/set-key "c" 'cmake-ide-compile))

;; clojure
(use-package clojure-mode
  :ensure t)

(use-package cider
  :pin melpa-stable)
(use-package cider
  :ensure t
  :init (progn
          (add-hook 'cider-mode-hook #'eldoc-mode))
  :config (progn
            (evil-leader/set-key-for-mode 'clojure-mode "jv" 'cider-jump-to-var)
            (evil-leader/set-key-for-mode 'cider-test-report-mode "jv" 'cider-test-jump)))
  

(use-package matlab-mode
  :ensure t)

;; === Other packages ===

(use-package magit
  :bind (("C-x g" . magit-status)))

(use-package diffview
  :ensure t)

(use-package auto-complete
  :init 
  :config (progn
            (ac-set-trigger-key "TAB")
            (ac-config-default)))

(use-package expand-region
  :ensure t
  :bind (("C-=" . er/expand-region)))

(use-package multiple-cursors
  :ensure t
  :config (evil-leader/set-key "m" 'mc/edit-lines))

(use-package smartparens
  :ensure t)

(use-package writeroom-mode
  :ensure t
  :init (setq writeroom-width fill-column)
  :bind ("C-c C-w" . global-writeroom-mode))
(global-set-key (kbd "C-c C-f C-f") 'toggle-frame-fullscreen)

(use-package keyfreq
  :ensure t)

;; === Shortcut to files ===
(global-set-key (kbd "<f10>") (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
