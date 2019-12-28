;;; styling --- Emacs's appearance

(set-frame-parameter (selected-frame) 'alpha '(75 . 75))
(add-to-list 'default-frame-alist '(alpha . (75 . 75)))

(set-fringe-mode '(0 . 0))
(add-hook 'window-configuration-change-hook
          (lambda ()
            (set-window-margins (car (get-buffer-window-list (current-buffer) nil t)) 1 1)))

(setq show-paren-style 'expression)
(show-paren-mode 2)

;; startup message off
(setq inhibit-startup-message t)
(tooltip-mode      -1)
(menu-bar-mode     -1)
(tool-bar-mode     -1)
(scroll-bar-mode   -1)
(blink-cursor-mode -1)
(setq frame-title-format "GNU Emacs: %b")
(setq use-dialog-box     nil)
(setq ring-bell-function 'ignore)
;;(setq word-wrap          t)
(global-visual-line-mode t)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
;; make tab key call indent command or insert tab character, depending on cursor position
(setq-default tab-always-indent nil)

;; themes
;;(use-package cyberpunk-theme)
(use-package monochrome-theme)
;;(require 'monochrome-theme)
;;(load-file	"~/.emacs.d/monochrome-theme.el")
;;(require 'hober-theme)
;;(load-theme 'default-theme)
;;(load-file "~/.emacs.d/themes/dark-emacs-theme.el")

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
;;(set-frame-font "Source Code Pro 12")
(setq default-frame-alist '((font . "-FBI -Input-normal-normal-condensed-*-*-*-*-*-m-0-iso10646-1")))
;;
;;(set-frame-font "bitocra13" nil t)
;;(set-frame-font "RobotoMono Nerd Font 13")
;;(set-frame-font "" nil t)

;; linum mode
;;(use-package linum)
(require 'linum+)
(setq linum-format " %d ")
(global-linum-mode 0)
(column-number-mode t)
(line-number-mode t)

;; autopair
(use-package autopair
  :config
  (autopair-global-mode))

;; Rainbow delimiters
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))



(provide 'styling)

;;; styling.el ends here
