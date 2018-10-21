(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(require 'mu4e)
(setq mail-user-agent 'mu4e-user-agent)

;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
	  starttls-use-gnutls t)
;; (setq message-send-mail-function 'smtpmail-send-it
;;	  starttls-use-gnutls t
;;	  smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;	  smtpmail-auth-credentials
;;	  '(("smtp.gmail.com" 587 "mt.ovinov@gmail.com" nil))
;;	  smtpmail-default-smtp-server "smtp.gmail.com"
;;	  smtpmail-smtp-server "smtp.gmail.com"
;;	  smtpmail-smtp-service 587)

(setq mu4e-contexts
	  `( ,(make-mu4e-context
		   :name "Gmail"
		   :enter-func (lambda () (mu4e-message "Entering Gmail..."))
		   :leave-func (lambda () (mu4e-message "Leaving Gmail..."))
		   :match-func (lambda (msg) (when msg
									   (string-prefix-p "/Gmail" (mu4e-message-field msg :maildir))))
		   :vars '(
				   (user-mail-address . "mt.ovinov@gmail.com")
				   (smtpmail-default-smtp-server . "smtp.gmail.com")
				   (smtpmail-smtp-user . "mt.ovinov")
				   (smtpmail-smtp-server . "smtp.gmail.com")
				   (smtpmail-smtp-service . 587)
				   (smtpmail-stream-type . starttls)
				   (mu4e-refile-folder . "/Gmail/[Gmail].Archive")
				   (mu4e-drafts-folder . "/Gmail/[Gmail].Drafts")
				   (mu4e-sent-folder . "/Gmail/[Gmail].Sent Mail")
				   (mu4e-trash-folder . "/Gmail/[Gmail].Trash")
				   (mu4e-maildir-shortcuts . (
											  ("/Gmail/INBOX"				. ?i)
											  ("/Gmail/[Gmail].Sent Mail"	. ?s)
											  ("/Gmail/[Gmail].Trash"		. ?t)
											  ("/Gmail/[Gmail].All Mail"	. ?a)))
				   (user-full-name . "Matvey Ovinov")
				   (mu4e-compose-signature .
										   (concat
											"Matvey Ovinov (sudoLife)\n"
											"Web-developer\n"))

				   ))
		 ))


(setq message-kill-buffer-on-exit t)

;; (setq mu4e-get-mail-command "offlineimap")
(setq mu4e-view-show-images t)



(use-package mu4e-alert
  :ensure t
  :after mu4e
  :init
  (setq mu4e-alert-interesting-mail-query
		"flag:unread maildir:/Gmail/INBOX"
		)
  (mu4e-alert-enable-mode-line-display)
  (defun gjstein-refresh-mu4e-alert-mode-line ()
	(interactive)
	(mu4e~proc-kill)
	(mu4e-alert-enable-mode-line-display)
	)
  (run-with-timer 0 60 'gjstein-refresh-mu4e-alert-mode-line)
  )



(use-package mu4e-maildirs-extension
  :config
  (mu4e-maildirs-extension))

(provide 'mu4e-config)
;;; mu4e-config.el ends here
