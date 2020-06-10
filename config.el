;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
;;(setq user-full-name "John Doe"
;;      user-mail-address "john.doe@aol.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-vibrant)
(setq doom-themes-enable-italic nil)
(setq doom-vibrant-brighter-modeline t)
(setq doom-vibrant-brighter-comments t)
(setq doom-vibrant-comment-bg nil)
(custom-theme-set-faces! 'doom-vibrant
  '(fringe :foreground "teal"))  ;; can't see fringe

;;(setq doom-theme 'doom-material)
;;(setq doom-theme 'doom-monokai-pro)
;;(setq doom-theme 'doom-oceanic-next)
;;(setq doom-theme 'doom-solarized-dark)
;;(setq doom-theme 'doom-sourcerer)
;;(setq doom-theme 'doom-spacegrey)
;;(setq doom-theme 'doom-tomorrow-night)
;;(load-theme 'deeper-blue t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; vanilla line wrap mode
(setq-default truncate-lines nil
              word-wrap nil)

;; vanilla fringe, we want to see the fringe!
(after! git-gutter-fringe (fringe-mode nil))

;; alter company mode delay
;;(after! company
;;  (setq company-idle-delay 0.1))

;; disable lsp doc
;;(setq lsp-ui-doc-enable nil)

;; disable company mode in shell
;; disable company mode in shell
(add-hook 'shell-mode-hook (lambda ()
                             (company-mode -1)))

;; blinky cursor!
(blink-cursor-mode 1)

;; use hunspell
(if (file-exists-p "/usr/bin/hunspell")
    (progn
      (setq ispell-program-name "hunspell")
      (setq ispell-dictionary "american"
            ispell-extra-args '("-a" "-i" "utf-8" "-d" "en_US")
            ispell-silently-savep t
            )))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; auto reverts files when changed on disk
(global-auto-revert-mode)
(auto-revert-mode)

(setq ag-highlight-search t)

;; ido support  -- i'm still on the fence ido vs ivy
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (setq ido-create-new-buffer 'always)
;; (setq confirm-kill-emacs nil)

;;; Michael's Preferences                  *** -------------------------------
(setq kill-whole-line t)                   ;;; Killing line also deletes \n
(setq next-line-add-newlines nil)          ;;; Down arrow won't add \n at end
(setq require-final-newline t)             ;;; Put \n at end of last line
(setq make-backup-files nil)               ;;; Don't make backup files
(setq line-number-mode t)                  ;;; Put line number in display
(setq default-major-mode 'text-mode)       ;;; New buffers are text mode
;(setq fill-column 80)                      ;;; Text lines limit to 80 chars
;(add-hook 'text-mode-hook 'turn-on-auto-fill); Line limit on in text mode
                                           ;;; -------------------------------

;;; Michael's
;;; Function
;;; Definitions:        *** --------------------------------------------------
;;;  indent-all         ;;; Indents buffer (use fset because of indent-region)
;;;  open-new-line      ;;; Open a new line after the current line
;;;  c-return           ;;; In c: indent & open indented new line
;;;  java-return        ;;; In java: indent & open indented new line
;;;  prolog-return      ;;; In prolog: indent & open indented new line
;;;                     *** --------------------------------------------------
(fset 'indent-all "\C-xh\C-[\C-\\")
(defun open-new-line( ) (interactive) (end-of-line) (newline-and-indent))
(defun c-return( ) (interactive) (c-indent-line) (newline-and-indent))
(defun java-return( ) (interactive) (c-indent-line) (newline-and-indent))
(defun prolog-return( ) (interactive) (prolog-indent-line) (newline-and-indent))


;; convert from tabs to spaces on the fly... not recommded :P
(defun to-tab-or-not-to-tab( ) (interactive)
  (if (not toggle-tabs)
      (setq-default indent-tabs-mode t tab-width 4 toggle-tabs 1)
      (setq-default indent-tabs-mode nil toggle-tabs nil)
  )
)

;;; Key Bindings
(map! :after make-mode
      :map makefile-gmake-mode-map
      "M-n" nil
      "M-p" nil)  ;;; turn of keybinds in makefile-mode that interfere with goto next error
(global-set-key [8]  'delete-backward-char);;; Ctrl-h = Backspace
(global-set-key [delete] 'delete-char) ;;; Delete = Delete char before cursor
(global-set-key [kp-delete] 'delete-char);; Delete = Delete char before cursor
(global-set-key [f4] 'help-command)        ;;; F4 = Help
(global-set-key "\M-g" 'goto-line)         ;;; alt-g = goto line
(global-set-key (kbd "\e\el") 'compile)    ;;; Esc Esc l = compile
(global-set-key (kbd "\e\ek") 'recompile)  ;;; Esc Esc k = compile
(global-set-key (kbd "\e\et") 'to-tab-or-not-to-tab)
(global-set-key "\M-n" 'next-error)        ;;; alt-n = goto next error
(global-set-key "\M-p" 'previous-error)    ;;; alt-p = goto previous error
(global-set-key "\C-c#" 'comment-region)     ;;; ctrl-x # comment region
(global-set-key "\C-c3" 'uncomment-region)     ;;; ctrl-x # comment region

;;; ------------------------------


;;; Michael's special actions upon entering various editing modes
;;; c-mode
(add-hook 'c-mode-hook
'(lambda()
        (local-set-key [13] 'c-return)        ;;; RET with automatic indent
        (c-set-style "bsd")
        (setq c-basic-offset 4)               ;;; 4 spaces for indentations
        (c-set-offset 'substatement-open 0)   ;;; No indent for open bracket
    )
)
;;; c++-mode
(add-hook 'c++-mode-hook
   '(lambda()
        (local-set-key [13] 'c-return)        ;;; RET with automatic indent
        (c-set-style "bsd")
        (setq c-basic-offset 4)               ;;; 4 spaces for indentations
        (c-set-offset 'substatement-open 0)   ;;; No indent for open bracket
    )
)
;;; jde-mode
(add-hook 'jde-mode-hook
   '(lambda()
        (local-set-key [13] 'java-return)     ;;; RET with automatic indent
        (c-set-style "k&r")
        (setq java-basic-offset 4)            ;;; 4 spaces for indentations
        (c-set-offset 'substatement-open 0)   ;;; No indent for open bracket
    )
)
;;; java-mode
(add-hook 'java-mode-hook
   '(lambda()
        (local-set-key [13] 'java-return)     ;;; RET with automatic indent
;        (c-set-style "k&r")
        (setq c-basic-offset 4)               ;;; 4 spaces for indentations
        (c-set-offset 'substatement-open 0)   ;;; No indent for open bracket
    )
)

;;; csharp-mode
(add-hook 'csharp-mode-hook
   '(lambda()
        (setq c-basic-offset 4)            ;;; 4 spaces for indentations
    )
)

;;; prolog-mode
(add-hook 'prolog-mode-hook
   '(lambda()
      (local-set-key [13] 'prolog-return)   ;;; RET with automatic indent
    )
)

;; makes script executable on save
(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)
