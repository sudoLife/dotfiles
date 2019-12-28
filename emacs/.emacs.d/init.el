;; init.el
(server-start)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of tline.
;; You may delete these explanatory comments.
;;; Code:
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


(setq make-backup-files     nil)
(setq make-save-list-file-name   nil)

(use-package visual-regexp-steroids)
(use-package visual-regexp
  :requires visual-regexp-steroids)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'init-key-bindings)
(require 'styling)
(require 'keybindings)

(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "firefox")


(defalias 'yes-or-no-p 'y-or-n-p)
(setq x-select-enable-clipboard t)



;; Helm

(use-package helm
  :config
  (require 'helm-config)
  (setq projectile-completion-system 'helm)
  (helm-mode 1)
  :bind
  (
   ("C-x C-f" . helm-find-files)
   ("M-x" . helm-M-x)
   ("C-x b" . helm-buffers-list)
   ("C-x r b" . helm-bookmarks)
   ("C-x r m" . bookmark-set)
   ("M-y" . helm-show-kill-ring)
   )
  )


;; engine-mode

(use-package engine-mode
  :config
  (engine-mode t)
  (defengine github
	"https://github.com/search?ref=simplesearch&q=%s"
	:keybinding "h")

  (defengine cambridge
	"https://dictionary.cambridge.org/dictionary/english/%s"
	:keybinding "v")

  (defengine duckduckgo
	"https://duckduckgo.com/?q=%s"
	:keybinding "d")

  (defengine stackoverflow
	"https://stackoverflow.com/search?q=%s"
	:keybinding "s")

  (defengine google
	"https://www.google.com/search?q=%s"
	:keybinding "g"))

;; multiple cursors
(use-package multiple-cursors
  :config
  (bind-key "C-c c e" 'mc/edit-lines)
  (bind-key "C-c c m" 'mc/mark-all-like-this)
  )


(use-package imenu
  :config
  (setq imenu-auto-rescan      t)
  (setq imenu-use-popup-menu nil)
  (bind-key "<f6>" 'imenu)
  )


;; google-translate
(use-package google-translate
  :requires google-translate-smooth-ui
  :config
  (bind-key "\C-ct" 'google-translate-smooth-translate)
  (setq google-translate-translation-directions-alist '(("en" . "ru") ("lt" . "ru") ("ru" . "en")))
  (setq google-translate-show-phonetic t)
  (setq google-translate-pop-up-buffer-set-focus t)
  )


;; c++
(setq c-default-style "k&r"
      c-basic-offset 4
      indent-tabs-mode t)
;; (add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-hungry-state)))
;;(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-newline)))
;;(add-hook 'c-mode-common-hook '(lambda () (c-toggle-electric-state)))
;;(add-hook 'c-mode-common-hook '(lambda () (c-toggle-syntactic-indentation)))
(add-hook 'c-mode-common-hook '(lambda () (subword-mode)))


(use-package arduino-mode)

(use-package company
  :no-require t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (global-set-key (kbd "M-/") 'company-complete-common-or-cycle)
  (setq company-tooltip-limit 20)                      ; bigger popup window
  (setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
  (setq company-echo-delay 0)                          ; remove annoying blinking
  (setq company-tooltip-align-annotations 't)
  (with-eval-after-load 'company
	(add-to-list
	  'company-backends '(company-irony-c-headers company-irony))
	)
  )

(use-package company-go
  :requires company
  :config
  (setq gofmt-command "goimports")
  (add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode))))



(use-package flycheck
  :config
  (global-flycheck-mode))


(use-package flycheck-irony
  :requires (flycheck irony)
  :config
  (eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

(use-package minions
  :config
  (minions-mode 1)
  )


(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))


;; yasnippet package
(use-package yasnippet
  :config
  (yas-global-mode t)
  )

(use-package projectile
  :config
  (projectile-mode 1)
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
  )

(use-package magit
  :bind
  (
   ("C-x g" . magit-status)
   ))

(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode 1)
  )


;; ------------------------------
;; F E A T U R E S  F O R  W E B
;; ------------------------------
(require 'web-config)


;; Golang
(use-package go-mode
  :config
  (add-hook 'before-save-hook 'gofmt-before-save))


;; --------------
;; E - M A I L
;; -------------
(require 'mu4e-config)
;; k is a keybinding for links

;; ---------------
;; O R G  M O D E
;; ---------------
(require 'org-config)

(setq custom-file "~/.emacs.d/custom.el")

;; (put 'narrow-to-region 'disabled nil)
;; (put 'narrow-to-page 'disabled nil)
(provide 'init)
;;; init.el ends here
