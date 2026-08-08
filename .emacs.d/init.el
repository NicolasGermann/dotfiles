(defvar bootstrap-version)
    (let ((bootstrap-file
	(expand-file-name
	    "straight/repos/straight.el/bootstrap.el"
	    (or (bound-and-true-p straight-base-dir)
		user-emacs-directory)))
	(bootstrap-version 7))
    (unless (file-exists-p bootstrap-file)
	(with-current-buffer
	    (url-retrieve-synchronously
	    "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
	    'silent 'inhibit-cookies)
	(goto-char (point-max))
	(eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage))

    (straight-use-package 'use-package)
    (straight-use-package 'bind-key)
(require 'bind-key)
(setq straight-use-package-by-default t)

(use-package emacs
  :config
  (keymap-global-set "M-5" (lambda () (interactive) (insert "[]")))
  (keymap-global-set "M-6" (lambda () (interactive) (insert "]")))
  (keymap-global-set "M-7" (lambda () (interactive) (insert "|")))
  (keymap-global-set "M-/" (lambda () (interactive) (insert "\\")))
  (keymap-global-set "M-8" (lambda () (interactive) (insert "{}")))
  (keymap-global-set "M-9" (lambda () (interactive) (insert "}")))
  (keymap-global-set "M-L" (lambda () (interactive) (insert "@")))
  (keymap-global-set "M-n" (lambda () (interactive) (insert "~")))
  (keymap-global-set "M-&" (lambda () (interactive) (insert "^")))
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (setq auto-save-default nil)
  (if (window-system)
      (set-frame-height (selected-frame) 50))
  (setq make-backup-files nil)
  (setq-default truncate-lines t)
  (setq ns-command-modifier 'meta)
  (global-display-line-numbers-mode)
  (which-key-mode 1)
  (setq ring-bell-function 'ignore)
  (electric-pair-mode 1)
  (setq delete-by-moving-to-trash t)
  (setq dired-dwim-target t)
  (load (expand-file-name "local.el" user-emacs-directory) 'noerror)
  (setq custom-file (locate-user-emacs-file "custom.el"))
  (set-face-attribute 'default nil :height 160)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'meta)
  (setq initial-buffer-choice 'scratch-buffer)
  (setq-default mode-line-format
		'("%*" " " "%b"
		  mode-line-format-right-align
		  (:eval (format "%d/%d " (line-number-at-pos) (count-lines (point-min) (point-max))))))
  (setq-default header-line-format mode-line-format)
  (setq-default mode-line-format nil)
  :bind
  ("C-x C-c" . save-buffers-kill-emacs)
  ("C-c r" . recentf)
  )

(use-package doom-themes
  :config
  (load-theme 'doom-gruvbox t))

(use-package spacious-padding
  :config
  (spacious-padding-mode 1))

(use-package avy
  :defer t
  :bind ("C-ö" . avy-goto-char)
  :config
  (setq avy-all-windows 'all-frames)
  :custom-face
  (avy-lead-face ((t (:background unspecified :foreground "#ff0000" :weight bold :underline t))))
  (avy-lead-face-0 ((t (:background unspecified :foreground "#af00ff" :weight bold))))
  )

(use-package all-the-icons
  :if (display-graphic-p))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (orderless-matching-styles '(orderless-literal orderless-flex))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package vertico
  :init
  (vertico-mode 1)
  :config
  (setq vertico-count 10)
  (setq vertico-cycle t))

(use-package swiper
  :defer t
  :bind
  ("C-s" . swiper))

(use-package marginalia
  :init
  (marginalia-mode 1))

(use-package org-modern
  :defer t
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("◉" "○" "◈" "◇" "⁖"))
  (setq org-attach-auto-tag nil) ; manchmal stört das
  (require 'org-attach)
  (setq org-startup-with-inline-images t)
  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.5 :weight bold))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.3 :weight bold))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.1 :weight bold))))
   '(org-document-title ((t (:height 1.7 :weight bold :underline t)))))
   (setq org-directory "~/org")
    (setq org-agenda-files '("~/org/"))
    (setq org-default-notes-file "~/org/inbox.org")
    (setq org-capture-templates
	'(
	    ("n" "Notiz" entry (file+headline "~/org/inbox.org" "Notizen")
	    "* %? :NOTE:\n  %U\n  %a")
	))
    (setq org-refile-targets
	'((org-agenda-files . (:maxlevel . 3))))
    (setq org-refile-use-outline-path 'file)
    (setq org-outline-path-complete-in-steps nil)
    (setq org-refile-allow-creating-parent-nodes 'confirm))

(use-package magit
  :defer t
  :bind ("C-c g" . magit-status))

(use-package evil
  :defer t
  :init
  (setq evil-want-keybinding nil)
  :hook
  (prog-mode . evil-local-mode)
  (text-mode . evil-local-mode)
  :config
  (define-key evil-motion-state-map "j" 'evil-backward-char)
  (define-key evil-motion-state-map "k" 'evil-next-line)
  (define-key evil-motion-state-map "l" 'evil-previous-line)
  (define-key evil-motion-state-map "ö" 'evil-forward-char)
  (define-key evil-window-map "j" 'evil-window-left)
  (define-key evil-window-map "k" 'evil-window-down)
  (define-key evil-window-map "l" 'evil-window-up)
  (define-key evil-window-map "ö" 'evil-window-right))

(use-package corfu
  :defer t
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-prefix 1)
  (corfu-auto-delay 0.1)
  (corfu-quit-at-boundary 'separator)
  (corfu-popupinfo-mode 1)
  :config
  (setq corfu-popupinfo-delay '(0.1 . 0.2))
  :init
  (global-corfu-mode))

(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-use-icons nil)
  (kind-icon-default-face 'corfu-default)
  (kind-icon-blend-background t)
  (kind-icon-blend-fraction 0.00)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init '(corfu)))

(use-package lsp-mode
  :defer t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-headerline-breadcrumb-enable-diagnostics nil)
  (setq lsp-completion-provider :none)
  (setq completion-category-defaults nil
      completion-category-overrides '((eglot (styles orderless basic))
                                      (lsp-capf (styles orderless basic))))
  (setq lsp-eldoc-render-all t)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq eldoc-echo-area-use-multiline-p nil))

(use-package languagetool
  :defer t
  :config
    (setq languagetool-java-arguments '("-Dfile.encoding=UTF-8")
        languagetool-server-command "~/.languagetool/languagetool-server.jar"
        languagetool-console-command "~/.languagetool/languagetool-commandline.jar")
    (defun setup-languagetool ()
    (interactive)
    (languagetool-set-language 'de-DE)
    (languagetool-server-start)
    (sit-for 3)
    (languagetool-server-mode)))
