;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;;
;; Defaults config

(setq-default
 user-full-name    "Nikita Shatov"
 user-mail-address "xamenrax@gmail.com"

 doom-font (font-spec :family "Fira Code" :size 12)
 doom-variable-pitch-font (font-spec :family "Fira Code" :size 12)
 doom-unicode-font (font-spec :family "Fira Code" :size 12)
 doom-big-font (font-spec :family "Fira Code" :size 19)
 +workspaces-switch-project-function #'ignore
 +pretty-code-enabled-modes '(scheme-repl-mode emacs-lisp-mode org-mode)
 +format-on-save-enabled-modes '(not emacs-lisp-mode))

;; doom-themes config
(require 'doom-themes)

(load-theme 'doom-dracula t)
(doom-themes-visual-bell-config)
(doom-themes-treemacs-config)
(doom-themes-org-config)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; doom-modeline config
(require 'doom-modeline)

(doom-modeline-mode 1)
(setq doom-modeline-height 25)
(setq doom-modeline-bar-width 3)
(setq doom-modeline-icon t)
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-major-mode-color-icon t)
(setq doom-modeline-minor-modes nil)
(setq doom-modeline-persp-name t)
(setq doom-modeline-lsp t)
(setq doom-modeline-github t)
(setq doom-modeline-github-interval (* 30 60))
(setq doom-modeline-env-version t)

;;
;; Host-specific config

(when IS-MAC
  (setq ns-use-thin-smoothing t)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . dark))
  (add-to-list 'default-frame-alist '(fullscreen . maximized)))

;;
;; Modules

;; emacs/eshell
(after! eshell
  (set-eshell-alias!
   "f"   "find-file $1"
   "l"   "ls -lh"
   "d"   "dired $1"
   "gl"  "(call-interactively 'magit-log-current)"
   "gs"  "magit-status"
   "gc"  "magit-commit"
   "rg" "rg --color=always $*"))

;; tools/magit
(setq magit-repository-directories '(("~/work" . 2))
      magit-save-repository-buffers nil)

;;
;; Custom

;; requires
(require 'rainbow-delimiters)

;; custom keybeindings
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; Scheme
(setq scheme-program-name "/usr/local/bin/scheme")
(add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)
(add-hook 'scheme-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'inferior-scheme-mode-hook 'rainbow-delimiters-mode)

;; SLY (sbcl)
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'sly-mrepl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'sly-editing-mode-hook 'rainbow-delimiters-mode)

;;Clojure (cider)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook 'evil-smartparens-mode)

;; Golang config
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

;; Fira code
(load! "fira-code")
(provide 'fira-code-mode)
(add-hook 'prog-mode-hook 'fira-code-mode--enable)
(add-hook 'sly-mrepl-mode-hook 'fira-code-mode--enable)
(add-hook 'sly-editing-mode-hook 'fira-code-mode--enable)
(add-hook 'scheme-mode-hook 'fira-code-mode--enable)
(add-hook 'scheme-repl-mode-hook 'fira-code-mode--enable)
(add-hook 'inferior-scheme-mode-hook 'fira-code-mode--enable)
(add-hook 'cider-repl-mode-hook 'fira-code-mode--enable)
