;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;;
;; Defaults config

(setq-default
 user-full-name    "Nikita Shatov"
 user-mail-address "xamenrax@gmail.com"

 doom-variable-pitch-font (font-spec :family "FuraCode Nerd Font" :size 12)
 doom-unicode-font (font-spec :family "Input Mono Narrow" :size 12)
 doom-big-font (font-spec :family "FuraCode Nerd Font" :size 19)

 +workspaces-switch-project-function #'ignore
 +pretty-code-enabled-modes '(emacs-lisp-mode org-mode)
 +format-on-save-enabled-modes '(not emacs-lisp-mode))

;;
;; Host-specific config

(when IS-MAC
  (setq ns-use-thin-smoothing t)
  (add-to-list
'default-frame-alist '(ns-transparent-titlebar . t))
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

;; Just kill the buffer I'm looking at

(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; Sly config

(require 'sly-autoloads)
(setq inferior-lisp-program "/usr/local/bin/sbcl")

(require 'rainbow-delimiters)

(add-hook 'sly-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'sly-mode-hook 'rainbow-delimiters-mode)

(add-to-list 'auto-mode-alist '("\\.lass\\'" . sly-mode))

;;(def-project-mode! +javascript-screeps-mode
;;  :match "/screeps\\(?:-ai\\)?/.+$"
;;  :modes (+javascript-npm-mode)
;;  :add-hooks (+javascript|init-screeps-mode)
;;  :on-load (load! "lisp/screeps"))

