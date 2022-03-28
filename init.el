
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

(use-package nix-mode
  :mode ("\\.nix\\'" "\\.nix.in\\'"))
(use-package nix-drv-mode
  :ensure nix-mode
  :mode "\\.drv\\'")
(use-package nix-shell
  :ensure nix-mode
  :commands (nix-shell-unpack nix-shell-configure nix-shell-build))
(use-package nix-repl
  :ensure nix-mode
  :commands (nix-repl))

(recentf-mode 1) ; find recent files
(global-set-key (kbd "C-c r") 'recentf-open-files)
(setq history-length 25)
(savehist-mode 1)

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

(defun my/dashboard-banner ()
  """Set a dashboard banner including information on package initialization
   time and garbage collections."""
  (setq dashboard-banner-logo-title
        (format "Emacs ready in %.2f seconds with %d garbage collections."
                (float-time (time-subtract after-init-time before-init-time)) gcs-done)))

(use-package dashboard
  :init
  (add-hook 'after-init-hook 'dashboard-refresh-buffer)
  (add-hook 'dashboard-mode-hook 'my/dashboard-banner)
  :config
  (setq dashboard-startup-banner 'logo)
  (dashboard-setup-startup-hook)
  :bind ("C-c d r b" . dashboard-refresh-buffer))

(use-package elfeed)
(setq elfeed-feeds
      '("https://lukesmith.xyz/rss.xml" linux
        "https://planet.emacslife.com/atom.xml" emacs ))
(setq-default elfeed-search-filter "@1-week-ago +unread ")
(global-set-key (kbd "C-c e f") 'elfeed)
(global-set-key (kbd "C-c e b") 'eval-buffer)




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
(setq org-startup-indented t) ;;wraps text?
(setq org-startup-folded t) ;; starts org folded
(add-hook 'text-mode-hook 'visual-line-mode)

;; Tab Bar Mode
(setq initial-major-mode 'org-mode);; create an org-mode *scratch* buffer
(setq tab-bar-new-tab-choice "*scratch*")

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
  (org-roam-directory "~/Documents/orgfiles/roam")
  (org-roam-completion-everywhere t)
(org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head "${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)))
  
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
	 ("C-c n r" . org-roam-ref-add)
	 ("C-c n r r" . org-roam-ref-remove)
         :map org-mode-map
         ("C-M-i"    . completion-at-point))
  :config
  (org-roam-setup))

(use-package org-roam-ui
  :ensure t
  :bind ("C-c u i" . org-roam-ui-mode))

(use-package moe-theme
  :ensure t)
(load-theme 'moe-light t)

(use-package all-the-icons
  :if (display-graphic-p))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(moe-theme which-key use-package smex rainbow-delimiters org-roam-ui org-journal ido-vertical-mode dashboard avy)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
