;;; org-config --- org config



;;; Code:
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

(setq org-agenda-files (quote ("~/org")))

(setq org-startup-indented t)

;;logging stuff
(setq org-log-done (quote time))
(setq org-log-into-drawer nil)
(setq org-log-redeadline (quote note))
(setq org-log-reschedule (quote time))
                                        ;todo keywords
(setq org-todo-keywords
      (quote ((sequence "TODO(t!)" "NEXT(n!)" "WAITING(w@/!)" "STARTED(s!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
              ;; (sequence "QUOTE(Q!)" "QUOTED(D!)" "|" "ACHIEVED(A@)" "EXPIRED(E@)" "REJECTED(R@)")
              (sequence "OPEN(O!)" "|" "CLOSED(C!)"))))

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )

(provide 'org-config)
;;; org-config.el ends here
