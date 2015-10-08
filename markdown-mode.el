
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(add-hook 'markdown-mode-hook
          (lambda () (local-set-key (kbd "C-c C-c") 'markdown-preview)))

(setq markdown-command "pandoc")
