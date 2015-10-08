
(require 'cl-lib)
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://melpa.org/packages/"))
(package-initialize)

;; If the gpg executable is not found disable signature checking.
(defun sanityinc/package-maybe-enable-signatures()
  (setq package-check-signature (when (executable-find "gpg") 'allow-unsigned)))
(sanityinc/package-maybe-enable-signatures)

(defvar required-packages
  '(
    use-package
    cyberpunk-theme
    powerline
    rainbow-delimiters
    hydra
    evil
    evil-leader
    evil-surround
    helm
    helm-ls-git
    magit
    fill-column-indicator
    yasnippet
    )
  )			    

(defun required-packages-installed-p ()
  (cl-loop for package in required-packages
	when (not (package-installed-p package)) do (cl-return nil)
	finally (cl-return t)))

(unless (required-packages-installed-p)
  (message "%s" "Packages were missing, updating packages...")
  (package-refresh-contents)
  (dolist (package required-packages)
    (when (not (package-installed-p package))
      (package-install package))))

(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))

(require 'use-package)

(load "~/.emacs.d/approved-themes.el")
(load "~/.emacs.d/personal-info.el")
(load "~/.emacs.d/appearance.el")
(load "~/.emacs.d/global-config.el")
(load "~/.emacs.d/text-mode.el")
(load "~/.emacs.d/prog-mode.el")
(load "~/.emacs.d/evil-mode.el")
(load "~/.emacs.d/helm.el")
