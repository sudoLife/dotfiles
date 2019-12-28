;;; web-config --- a simple config for editing web-related stuff

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.html\\'" . html-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\'" . html-mode))
  (add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
  (setq web-mode-enable-current-element-highlight t)
  )

(add-hook 'html-mode-hook
          (lambda()
            (setq sgml-basic-offset 4)
            (setq indent-tabs-mode t)))


(use-package emmet-mode
  :config
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'html-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook 'emmet-mode)
  )

(use-package com-css-sort
  :after (css-mode)
  :config
  (setq com-css-sort-sort-type 'alphabetic-sort)
  ;; Sort attributes inside block.
  (define-key css-mode-map (kbd "C-k s") #'com-css-sort-attributes-block)

  ;; Sort attributes through the whole document.
  (define-key css-mode-map (kbd "C-k d") #'com-css-sort-attributes-document)
  )

(use-package js2-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  )

(use-package company-php)

(use-package php-mode
  :config
  (add-hook 'php-mode-hook '(lambda ()
                            (setq tab-width 4
                                  indent-tabs-mode t)
                            (c-set-style "symfony2")
                            ))
  (add-hook 'php-mode-hook
			'(lambda ()
			   (company-mode t)
			   (add-to-list 'company-backends 'company-ac-php-backend )))
  )

(use-package company
  :config
  (defun company-my-php-backend (command &optional arg &rest ignored)
    (case command
      (prefix (and (eq major-mode 'php-mode)
				   (company-grab-symbol)))
      (sorted t)
      (candidates (all-completions
                   arg
				   n           (if (and (boundp 'my-php-symbol-hash)
										my-php-symbol-hash)
								   my-php-symbol-hash

								 (with-temp-buffer
								   (call-process-shell-command "php -r '$all=get_defined_functions();foreach ($all[\"internal\"] as $fun) { echo $fun . \";\";};'"\
															   nil t)
								   (goto-char (point-min))
								   (let ((hash (make-hash-table)))
									 (while (re-search-forward "\\([^;]+\\);" (point-max) t)
									   (puthash (match-string 1) t hash))
									 (setq my-php-symbol-hash hash))))))))

  (defun my-php ()
	(add-to-list 'company-backends 'company-my-php-backend))

  (add-hook 'php-mode-hook 'my-php)
  )


(provide 'web-config)

;;; web-config.el ends here
