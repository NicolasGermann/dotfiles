(keymap-global-set "M-5" (lambda () (interactive) (insert "[")))
(keymap-global-set "M-6" (lambda () (interactive) (insert "]")))
(keymap-global-set "M-7" (lambda () (interactive) (insert "|")))
(keymap-global-set "M-/" (lambda () (interactive) (insert "\\")))
(keymap-global-set "M-8" (lambda () (interactive) (insert "{")))
(keymap-global-set "M-9" (lambda () (interactive) (insert "}")))
(keymap-global-set "M-L" (lambda () (interactive) (insert "@")))
(keymap-global-set "M-n" (lambda () (interactive) (insert "~")))
(keymap-global-set "M-&" (lambda () (interactive) (insert "^")))

(setq ns-command-modifier 'meta)

(with-eval-after-load 'doc-view
  (setq doc-view-resolution 300))
(add-hook 'doc-view-mode-hook (lambda () (display-line-numbers-mode -1)))
(setq auto-save-default nil)
(setq-default truncate-lines t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(which-key-mode)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(global-hl-line-mode t)

(electric-pair-mode 1)

(set-fringe-mode 10)


(setq-default line-spacing 0.12)

(set-face-attribute 'default nil :height 120)

(setq inhibit-startup-screen t)    ; Begrüßung deaktivieren
(setq initial-scratch-message ";;Willkommen") ; Scratch-Buffer komplett leeren

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(use-package base16-theme	    
  :ensure t			    
  :config			    
  (load-theme 'base16-everforest 0))

(use-package golden-ratio
  :ensure t
  :init
  (golden-ratio-mode 1))

(defun my-balance-windows-and-disable-golden-ratio ()
  "Balanciert die Fenster aus und schaltet den golden-ratio-mode aus."
  (interactive)
  ;; 1. Golden-Ratio ausschalten, falls er aktiv ist
  (when (bound-and-true-p golden-ratio-mode)
    (golden-ratio-mode -1))
  ;; 2. Fenster ausbalancieren
  (balance-windows))

;; Die neue Funktion auf C-+ legen
;; Hinweis: In manchen Terminals/Systemen ist C-+ eigentlich C-=
(global-set-key (kbd "C-x +") #'my-balance-windows-and-disable-golden-ratio)

(use-package avy
  :ensure t
  :bind ("C-ö" . avy-goto-word-1)
  :config
  (setq avy-all-windows 'all-frames)
  :custom-face
  (avy-lead-face ((t (:background unspecified :foreground "#ff0000" :weight bold :underline t))))
  (avy-lead-face-0 ((t (:background unspecified :foreground "#af00ff" :weight bold))))
  )

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package vertico
  :ensure t
  :init
  (vertico-mode 1)
  :config
  ;; Optik: Zeige 10 Ergebnisse auf einmal
  (setq vertico-count 10)
  ;; Ermöglicht es, mit der Eingabetaste ein Verzeichnis auszuwählen
  (setq vertico-cycle t))

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (orderless-matching-styles '(orderless-literal orderless-flex))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package corfu
  :ensure t
  ;; Optionale Einstellungen für eine bessere Erfahrung:
  :custom
  (corfu-cycle t)                ; Ermöglicht das Kreisen durch die Liste
  (corfu-auto t)                 ; Aktiviert automatische Vervollständigung beim Tippen
  (corfu-auto-prefix 1)          ; Startet nach 2 getippten Zeichen
  (corfu-auto-delay 0.1)         ; Wie schnell das Popup erscheint
  (corfu-quit-at-boundary 'separator) ; Beendet Corfu bei Leerzeichen
  :init
  (global-corfu-mode))

(use-package kind-icon
  :ensure t
  :after corfu
  :custom
  (kind-icon-use-icons nil)
  (kind-icon-default-face 'corfu-default) ; Passt sich deinem Theme an
  (kind-icon-blend-background t)         ; Das ist der entscheidende Schalter
  (kind-icon-blend-fraction 0.00)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package corfu-terminal
  :ensure t
  :unless (display-graphic-p)
  :config
  (corfu-terminal-mode 1))

(use-package eglot
  :ensure t
  :pin gnu
  :config
  (add-hook 'eglot-managed-mode-hook #'flymake-mode-off)
  (setq eldoc-documentation-strategy #'eldoc-documentation-compose-effectively)
  (setq eldoc-idle-delay 0)
  :bind
  (("C-x c" . eglot-code-actions)))

(use-package org
  :ensure nil
  :config
  (setq org-attach-auto-tag nil) ; manchmal stört das
  (require 'org-attach)
  (setq org-startup-with-inline-images t)
  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.5 :weight bold))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.3 :weight bold))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.1 :weight bold))))
   '(org-document-title ((t (:height 1.7 :weight bold :underline t)))))
  :bind (("C-c a" . org-agenda)
	 ("C-c c" . org-capture)
	 ))

(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("◉" "○" "◈" "◇" "⁖")))

(use-package ox-typst
  :ensure t
  :defer t
  :after org)

(use-package magit
  :ensure t
  :bind ("C-c g" . magit-status))

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

(setq org-refile-allow-creating-parent-nodes 'confirm)

(set-face-attribute 'line-number nil 
                    :height 0.8    ; 80% der normalen Textgröße
                    :slant 'normal)
(set-face-attribute 'line-number-current-line nil 
                    :height 0.8
                    :weight 'bold)

(use-package vc-fossil
  :ensure t
  :defer t)

(use-package vterm
  :ensure t
  :defer t)

(use-package languagetool
  :ensure t
  :config
    (setq languagetool-java-arguments '("-Dfile.encoding=UTF-8")
        languagetool-server-command "~/.languagetool/languagetool-server.jar"
        languagetool-console-command "~/.languagetool/languagetool-commandline.jar"))

(defun setup-languagetool ()
  "Einrichten des Languagtools für de-DE"
  (interactive)
  (languagetool-set-language 'de-DE)
  (languagetool-server-start)
  (sit-for 3)
  (languagetool-server-mode))

(use-package evil
  :ensure t
  :config
  (evil-mode 1)
)

(with-eval-after-load 'evil
  ;; --- Bewegungstasten neu belegen (jkli/ö statt hjkl) ---
  ;; Motion State deckt Normal, Visual und Operator-Pending-State ab
  (define-key evil-motion-state-map "j" 'evil-backward-char)
  (define-key evil-motion-state-map "k" 'evil-next-line)
  (define-key evil-motion-state-map "l" 'evil-previous-line)
  (define-key evil-motion-state-map "ö" 'evil-forward-char)

  ;; --- Fenstersteuerung (<C-w> + Richtungstaste) ---
  (define-key evil-window-map "j" 'evil-window-left)
  (define-key evil-window-map "k" 'evil-window-down)
  (define-key evil-window-map "l" 'evil-window-up)
  (define-key evil-window-map "ö" 'evil-window-right))


(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
    :config
  (setq lsp-headerline-breadcrumb-enable-diagnostics nil)
  (setq lsp-completion-provider :none)
  (setq completion-category-defaults nil
      completion-category-overrides '((eglot (styles orderless basic))
                                      (lsp-capf (styles orderless basic))))
  (setq lsp-eldoc-render-all t)
  (setq eldoc-echo-area-use-multiline-p nil)
  )

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :config
  ;; --- DOKUMENTATION (Hover-Popup) ---
  (setq lsp-ui-doc-enable t             ;; Aktiviert das Info-Fenster beim Hovern
        lsp-ui-doc-delay 1.5            ;; Zeigt das Fenster nach 0.5 Sekunden an
	lsp-ui-doc-show-with-cursor t
        lsp-ui-doc-position 'at-point))

(use-package mood-line
  :ensure t
  ;; Enable mood-line
  :config
  (mood-line-mode)
  ;; Use pretty Fira Code-compatible glyphs
  :custom
  (mood-line-glyph-alist mood-line-glyphs-fira-code))

(use-package go-mode
  :ensure nil
  :defer t
  :config
  (add-to-list 'exec-path (expand-file-name "~/go/bin")))

(use-package flycheck
  :ensure t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(all-the-icons avy base16-theme corfu-terminal evil flycheck
		   golden-ratio kind-icon languagetool lsp-ui magit
		   marginalia meow mood-line nix-mode orderless
		   org-modern ox-typst vc-fossil vertico vterm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-document-title ((t (:height 1.7 :weight bold :underline t))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.5 :weight bold))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.3 :weight bold))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.1 :weight bold)))))
