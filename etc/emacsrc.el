;;/usr/bin/env emacs
;;
;; Emacs setup for Ledger.
;;

;; Add the emacs path.
(add-to-list 'load-path
	     (concat project-dir "/lib/emacs"))

(require 'ledger)
(require 'ledger-plus)

(defun user-ledger-mode-hook ()
  (set-fill-column 200)

;;  (outline-minor-mode 1)
  (setq outline-regexp "^;;;;; ")

  (define-key ledger-mode-map [(control ?c) (control ?n)]
    'outline-next-visible-heading)
  (define-key ledger-mode-map [(control ?c) (control ?p)]
    'outline-previous-visible-heading)

  ;; FIXME: we should make this work for the current entry when a region is not
  ;; selected.
  (define-key ledger-mode-map [(control ?c) (control ?q)]
    (lambda () (interactive) (ledger-align-amounts 80)))

  ;; Remove tab bindings that are injected illegally in ledger.el.
  (define-key ledger-mode-map [tab] nil)
  (define-key ledger-mode-map [(control ?i)] nil)

  ;; Bring back comment-region.
  (define-key ledger-mode-map [(control ?c) (control ?c)] 'comment-region)

  (setq comment-start "; ")

  )

(add-hook 'ledger-mode-hook 'user-ledger-mode-hook)

(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))






;; Support parsing Python logging errors, with a suitable logging.basicConfig()
;; format.
(unless (assq 'python-logging compilation-error-regexp-alist-alist)

  (add-to-list
   'compilation-error-regexp-alist-alist
   '(python-logging "\\(ERROR\\|WARNING\\):\\s-*\\([^:]+\\):\\([0-9]+\\)\\s-*:" 2 3))

  (add-to-list
   'compilation-error-regexp-alist 'python-logging)
  )
