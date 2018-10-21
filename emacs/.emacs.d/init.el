;; init.el
;;(server-start)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;; Code:
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
;; (package-initialize)
;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/") t)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


;; Transparency
(set-frame-parameter (selected-frame) 'alpha '(85 . 50))
(add-to-list 'default-frame-alist '(alpha . (85 . 50)))
(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(85 . 50) '(100 . 100)))))



(setq show-paren-style 'expression);;Подсветка скобок
(show-paren-mode 2)

(setq make-backup-files     nil)
(setq make-save-list-file-name   nil)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'init-key-bindings)


(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "firefox-quantum")


;; startup message off
(setq inhibit-startup-message t)
(tooltip-mode      -1)
(menu-bar-mode     -1)
(tool-bar-mode     -1)
(scroll-bar-mode   -1)
(blink-cursor-mode -1)
(setq frame-title-format "GNU Emacs: %b")
(setq use-dialog-box     nil)
(setq redisplay-dont-pause t)
(setq ring-bell-function 'ignore)
(windmove-default-keybindings 'meta)
;;(setq word-wrap          t)
(global-visual-line-mode t)
(setq scroll-step 1)
(setq scroll-margin 10)
(setq scroll-conservatively 10000)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq x-select-enable-clipboard t)
;;(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
;; make tab key call indent command or insert tab character, depending on cursor position
(setq-default tab-always-indent nil)
(global-set-key (kbd "RET") 'newline-and-indent)


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


;; themes
(use-package cyberpunk-theme)
;;(require 'hober-theme)
;;(load-theme 'default-theme)
;;(load-file "~/.emacs.d/themes/dark-emacs-theme.el")



;; engine-mode

(use-package engine-mode
  :config
  (engine-mode t)
  (defengine github
	"https://github.com/search?ref=simplesearch&q=%s"
	:keybinding "h")

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


;; Beacon-mode
(use-package beacon
  :config
  (beacon-mode 1)
  )


;; font
;;(set-frame-font "Courier Prime Code 16" nil t)
;;(set-frame-font "Monaco 15" nil t)
;;(set-frame-font "Roboto Mono 14")
;;(set-frame-font "Anonymous Pro 17" nil t)
(set-frame-font "Source Code Pro 11")
;;
;;(set-frame-font "bitocra13" nil t)
;;(set-frame-font "RobotoMono Nerd Font 13")
;;(set-frame-font "" nil t)

;; buffer-selection
;; (use-package bs
;;   :config
;;   (setq bs-configurations
;; 		'(("files" "^\\*scratch\\*" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)))
;;   (bind-key "<f2>" 'bs-show)
;;   )


(use-package imenu
  :config
  (setq imenu-auto-rescan      t)
  (setq imenu-use-popup-menu nil)
  (bind-key "<f6>" 'imenu)
  )
;;(global-set-key (kbd "TAB") 'tab-to-tab-stop);

;; linum mode
;;(use-package linum)
(require 'linum+)
(setq linum-format 'dynamic)
(global-linum-mode 1)
(column-number-mode t)
(line-number-mode t)

;; autopair
(use-package autopair
  :config
  (autopair-global-mode))


;; google-translate
(use-package google-translate
  :requires google-translate-smooth-ui
  :config
  (bind-key "\C-ct" 'google-translate-smooth-translate)
  (setq google-translate-translation-directions-alist '(("en" . "ru") ("lt" . "ru") ("ru" . "en")))
  (setq google-translate-show-phonetic t)
  (setq google-translate-pop-up-buffer-set-focus t)
  )

;; Convert spaces into tabs before save
;; (add-hook 'before-save-hook
;;           (lambda () (tabify (point-min) (point-max))))

;; auto-complete
;; (global-auto-complete-mode t)
;; (setq ac-delay 0.5)
;; (add-to-list 'ac-modes 'web-mode)
;; (defun auto-complete-mode-maybe ()
;;   "No maybe for you. Only AC!"
;;   (unless (minibufferp (current-buffer))
;;  (auto-complete-mode 1)))


;; c++
(setq c-default-style "gnu"
      c-basic-offset 4
      indent-tabs-mode t)
;; (add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-hungry-state)))
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-newline)))
(add-hook 'c-mode-common-hook '(lambda () (subword-mode)))

;; irony



(use-package irony
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (unless (irony--find-server-executable) (call-interactively #'irony-install-server))
  (add-hook 'c++-mode-hook 'my-irony-mode-on)
  (add-hook 'c-mode-hook 'my-irony-mode-on)
  (setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
                                                  irony-cdb-clang-complete))
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  (defun my-irony-mode-on ()
  (when (member major-mode irony-supported-major-modes)
    (irony-mode 1)))
  )


;; Python
(use-package elpy
  :config
  (elpy-enable)
  )

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (global-set-key (kbd "M-/") 'company-complete-common-or-cycle)
  (setq company-idle-delay 0))

(use-package company-irony
  :requires (company irony)
  )

(use-package flycheck
  :config
  (global-flycheck-mode))


(use-package flycheck-irony
  :requires (flycheck irony)
  :config
  (eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

(use-package irony-eldoc
  :requires (eldoc irony)
  :config
  (add-hook 'irony-mode-hook #'irony-eldoc))

(use-package company-irony-c-headers
  :requires (irony))
;; Load with `irony-mode` as a grouped backend

;;Company mode

(use-package company
  :no-require t
  :config
  (setq company-idle-delay 0)
  (setq company-tooltip-limit 20)                      ; bigger popup window
  (setq company-tooltip-align-annotations 't)
  (add-to-list
    'company-backends '(company-irony-c-headers company-irony))

  (add-hook 'php-mode-hook
			'(lambda ()
			   (require 'company-php)
			   (company-mode t)
			   (add-to-list 'company-backends 'company-ac-php-backend )))


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




;; yasnippet package
(use-package yasnippet
  :config
  (yas-global-mode t)
  )

(use-package projectile
  :config
  (projectile-global-mode)
  )

(use-package magit
  :bind
  (
   ("C-x g" . magit-status)
   ))


;; Rainbow delimiters
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; ------------------------------
;; F E A T U R E S  F O R  W E B
;; ------------------------------

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.html\\'" . html-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\'" . html-mode))
  (add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
  (setq web-mode-enable-current-element-highlight t)
  )


(use-package emmet-mode
  :config
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'html-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook 'emmet-mode)
)

(use-package js2-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  )


;; --------------
;; E - M A I L
;; -------------
(require 'mu4e-config)
;; k is a keybinding for links
;; ---------------
;; L U A  C O D E
;; ---------------

(use-package lua-mode
  :config
  (autoload 'lua-mode "lua-mode" "Lua editing mode." t)
  (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
  (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
  )


;; ---------------
;; O R G  M O D E
;; ---------------


(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(global-set-key "\e\el" 'org-store-link)
(global-set-key "\e\ec" 'org-capture)
(global-set-key "\e\ea" 'org-agenda)
(global-set-key "\e\eb" 'org-iswitchb)
(require 'ox-odt nil t)

(setq org-agenda-files (quote ("~/projects/org")))

                                        ;my prefer identation
(setq org-startup-indented t)

;;logging stuff
(setq org-log-done (quote time))
(setq org-log-into-drawer nil)
(setq org-log-redeadline (quote note))
(setq org-log-reschedule (quote time))
                                        ;todo keywords
(setq org-todo-keywords
      (quote ((sequence "TODO(t!)" "NEXT(n!)" "WAITING(w@/!)" "STARTED(s!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
              (sequence "QUOTE(Q!)" "QUOTED(D!)" "|" "ACHIEVED(A@)" "EXPIRED(E@)" "REJECTED(R@)")
              (sequence "OPEN(O!)" "|" "CLOSED(C!)"))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(linum+ elpy flycheck-irony company-irony company-irony-c-headers irony use-package mu4e-alert mu4e-maildirs-extension multiple-cursors engine-mode helm helm-ebdb magit yasnippet web-mode rainbow-delimiters projectile lua-mode js2-mode impatient-mode google-translate flycheck emmet-mode cyberpunk-theme company-web company-php beacon autopair auto-complete abyss-theme)))
 '(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(provide 'init)
;;; init.el ends here
