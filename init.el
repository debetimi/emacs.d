(require 'cl)
;;; ---------------------- Package Management -------------------
(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("elpa" . "http://tromey.com/elpa/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

(setq package-list '(
		     ;; Parens editing mode
		     smartparens
		     
		     ;; Git integration
		     magit

		     ;; Key Bindings and Code Colorization for Clojure
		     clojure-mode

		     ;; extra syntax highlighting
		     clojure-mode-extra-font-locking

		     ;; refactoring clojure
		     clj-refactor

		     ;; autocomplete
		     company
		     
		     ;; Integrated Clojure Repl and more.
		     cider

		     ;; Minibuffer completion
		     smex
		     flx-ido
		     ido-ubiquitous

		     ;;project navigation
		     projectile

		     ;; For OSX so Emacs seems same path as Shell
		     exec-path-from-shell

		     ;; Theme
		     zenburn-theme

		     ;; Text Editor - VIM MODE!!!!!
		     evil

		     ;; KeyChord for making two button movements act as a command
		     ;; like jk for Esc in vim
		     key-chord		     
		     ))
(package-initialize)

;; check if the packages is installed; if not, install it.
					; fetch the list of packages available
(unless package-archive-contents
  (or (file-exists-p package-user-dir) (package-refresh-contents)))


(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


;;;;--------- Customizations ----------
;; Correctly sets up path
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Set option to meta
(setq mac-option-modifier 'meta)

;;;; -------------- Clojure --------------
;; Enable Paredit Mode
(require 'smartparens-config)
(sp-use-paredit-bindings)

(add-hook 'clojure-mode-hook #'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparen-strict-mode)
(setq sp-autoescape-string-quote t)

;; Enabling Clojure Refactorings
(require 'clj-refactor)
(defun my-clojure-mode-hook ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

;; Enable clojure documentation in minibuffer
(add-hook 'cider-mode-hook #'eldoc-mode)


;;;; -------------- Styling --------------
;; Enable color theme
(load-theme 'zenburn t)

;;; Line numbers
(global-linum-mode t)

;; VIM !!!!!1
(require 'evil)
(evil-mode 1)

;;; Keymap for VIM

(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "jk" 'evil-normal-state)

;;;; --------------- Navigation/Search -----------
;; Turn on auto complete globally
(global-company-mode)

;; ido-mode allows you to more easily navigate choices. For example,                   
;; when you want to switch buffers, ido presents you with a list
;; of buffers in the the mini-buffer. As you start to type a buffer's       
;; name, ido will narrow down the list of buffers to match the text
;; you've typed in
;; http://www.emacswiki.org/emacs/InteractivelyDoThings                                
(ido-mode t)
(flx-ido-mode 1)
;; This allows partial matches, e.g. "tl" will match "Tyrion Lannister"                
(setq ido-enable-flex-matching t)

;; Turn this behavior off because it's annoying                                        
(setq ido-use-filename-at-point nil)

;; Don't try to match file across all "work" directories; only match files
;; in the current directory displayed in the minibuffer                                
(setq ido-auto-merge-work-directories-length -1)                                              
;; Includes buffer names of recently open files, even if they're not
;; open now
(setq ido-use-virtual-buffers t)

;; This enables ido in all contexts where it could be useful, not just       
;; for selecting buffer and file names                                                 
(ido-ubiquitous-mode 1)

;; smex for M-x autocomplete
(smex-initialize)
(smex-auto-update 60)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(projectile-global-mode)

;;;; -------------- Random ----------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("11636897679ca534f0dec6f5e3cb12f28bf217a527755f6b9e744bd240ed47e1" default)))
 '(sp-base-key-bindings (quote sp)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; Mac specific modification
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)
(setq mac-pass-command-to-system nil)

;;; Save backupfiles in a back up folder so they don't
;;; clutter workspace
(setq backup-directory-alist `(("." . "~/.saves")))
