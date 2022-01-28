
(set-frame-parameter (selected-frame) 'alpha '(95 . 50))
(add-to-list 'default-frame-alist '(alpha . (95 . 50)))


(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Auto install use-package
(unless (package-installed-p 'use-package)
   (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; pars rainbows
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Smex
(unless (package-installed-p 'smex)
    (package-install 'smex))
(require 'smex) ; Not needed if you use package.el
  (smex-initialize) ; Can be omitted. This might cause a (minimal) delay
					; when Smex is auto-initialized on its first run.

;; Org-Agenda
;(setq org-agenda-files (quote ("~/agenda.org")))

;; Dashboard
(use-package dashboard
  :ensure t
  :init
    (add-hook 'after-init-hook 'dashboard-refresh-buffer)
    (progn
    (setq dashboard-items '((bookmarks . 5)
			    (agenda . 5))))
    (setq dashboard-center-content t)
    (setq show-week-agenda-p t)
    (setq dashboard-set-footer nil)
    )
(setq dashboard-startup-banner 'logo)
(dashboard-setup-startup-hook)




;; num pad keybind
;; (global-set-key (kbd "<kp-1>") 'bookmark-bmenu-list)
;; (global-set-key (kbd "<kp-2>") 'ibuffer)
;; (global-set-key (kbd "<kp->"))
;; (global-set-key (kbd "<kp->"))
;; (global-set-key (kbd "<kp->"))
;; (global-set-key (kbd "<kp->"))
;; (global-set-key (kbd "<kp->"))
;; (global-set-key (kbd "<kp->"))
;; (global-set-key (kbd "<kp->"))

;; whick-key
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0))


;; Avy
(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-char))

;; ido
(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

;; Ido-vert
(use-package ido-vertical-mode
  :ensure
  :init
  (ido-vertical-mode 1))
;; (setq ido-vertical-define-keys 'C-n-and-C-p-only)
(setq ido-vertical-define-keys 'up-and-down-only)
;; Minor edits
;; Disable the default startup screen
(setq inhibit-startup-message t)

;; Disable most gui elements
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode t)
(display-time-mode 1);;show time in buffer

;; Enable copypasting outside of Emacs
(setq x-select-enable-clipboard t)

;; Disable automatic creation of backup files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Transform yes-or-no questions into y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Highlight current line
(global-hl-line-mode t)

(package-refresh-contents)
(unless (package-installed-p 'org-journal)
  (package-install 'org-journal)) 

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Documents/Org/roam")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i"    . completion-at-point))
  :config
  (org-roam-setup))

(use-package org-roam-ui
	     :ensure t)

