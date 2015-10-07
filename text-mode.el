
(add-hook 'text-mode-hook
	  (lambda()
	    (turn-on-auto-fill)
	    (setq show-trailing-whitespace 't))
	  )
