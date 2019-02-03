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

(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Theme config
(load-theme 'doom-dracula t)
(doom-themes-visual-bell-config)
(doom-themes-treemacs-config)
(doom-themes-org-config)

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
(require 'sly-autoloads)

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


;; Sly config
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(add-hook 'sly-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'sly-mode-hook 'rainbow-delimiters-mode)

(add-to-list 'auto-mode-alist '("\\.lass\\'" . sly-mode))

;; Fira Code ligatures config
(global-prettify-symbols-mode 1)

(when (window-system)
  (set-frame-font "Fira Code"))
(let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
               (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
               (36 . ".\\(?:>\\)")
               (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
               (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
               (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
               (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
               (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
               (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
               (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
               (48 . ".\\(?:x[a-zA-Z]\\)")
               (58 . ".\\(?:::\\|[:=]\\)")
               (59 . ".\\(?:;;\\|;\\)")
               (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
               (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
               (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
               (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
               (91 . ".\\(?:]\\)")
               (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
               (94 . ".\\(?:=\\)")
               (119 . ".\\(?:ww\\)")
               (123 . ".\\(?:-\\)")
               (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
               (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
               )
             ))
  (dolist (char-regexp alist)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))

;; Golang config
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

;;(def-project-mode! +javascript-screeps-mode
;;  :match "/screeps\\(?:-ai\\)?/.+$"
;;  :modes (+javascript-npm-mode)
;;  :add-hooks (+javascript|init-screeps-mode)
;;  :on-load (load! "lisp/screeps"))

