;; * All
;; init.el --- GNU Emacs Setup by Martin Selergren
;;
;;; Commentary:
;;
;; My personal GNU Emacs configuration.
;;
;;; Code:

;; This is the official Emacs init file for the course IOOPM. It
;; uses English, not because anyone thinks it's cooler than
;; Swedish, but to avoid encoding problems with using Swedish
;; characters. Put it in `~/.emacs.d/init.el` to use it for your
;; own Emacs. You can use as many or as few of these settings as
;; you would like. Experiment and try to find a set-up that suits
;; you!
;;
;; Some settings in this file are commented out. They are the ones
;; that require some choice of parameter (such as a color) or that
;; might be considered more intrusive than other settings (such as
;; linum-mode).
;;
;; Whenever you come across something that looks like this
;;
;;    (global-set-key (kbd "C-e") 'move-end-of-line)
;;
;; it is a command that sets the keyboard shortcut for some
;; function. If you find a function that you like, whose keyboard
;; shortcut you don't like, you can (and should!) always change it to
;; something that you do like.

;; * Appearance

(set-face-attribute 'region nil
  :distant-foreground "white" :background "deep sky blue")

;; Disable the menu bar
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))

;; Disable the tool bar
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

;; Disable the scroll bar
;; (if (fboundp 'scroll-bar-mode)
;;     (scroll-bar-mode -1))

;; Turn off annoying splash screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)

;; When in doubt, use text-mode
(setq default-major-mode 'text-mode)

;; Show time using Swedish format
(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)

;; Set which colors to use
;; You can see a list of all the available colors by checking the
;; variable "color-name-rgb-alist" (Type "C-h v color-name-rgb-alist
;; <RET>"). Most normal color names work, like black, white, red,
;; green, blue, etc.
; (set-background-color "black")
; (set-foreground-color "white")
; (set-cursor-color "white")

;; Set a custom color theme
;; You can also try using a custom theme, which changes more colors
;; than just the three above. For a list of all available themes,
;; press "M-x customize-themes <RET>". You can also use a theme in
;; combination with the above set-color-commands.
;(if display-graphic-p
;    (progn
;      (load-theme 'wombat)))

;; Default window-split horizontally
;(setq split-height-threshold nil)
;(setq split-width-threshold 0)

;; * Packages

;; Use more package-archives (M-x list-packages)
;; (setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
;;                          ("marmalade" . "https://marmalade-repo.org/packages/")
;;                          ("melpa" . "https://melpa.org/packages/")))

(require 'package)
;; (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
;; (add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; Tell Emacs where to look for packages
(let ((default-directory "~/.emacs.d/ioopm-packages/"))
  (normal-top-level-add-subdirs-to-load-path))

(let ((default-directory "~/.emacs.d/elpa/"))
  (normal-top-level-add-subdirs-to-load-path))

;; * Navigation

;; Show both line and column number in the bottom of the buffer
(column-number-mode t)

;; Show parenthesis matching the one below the cursor
(show-paren-mode t)

;; Show line numbers to the left of all buffers
; (global-linum-mode t)

;; Sentences are not followed by two spaces
;; Makes navigating with M-e and M-a (forward/backward senctence)
;; behave like you would expect
(setq sentence-end-double-space nil)

;; C-SPC after C-u C-SPC cycles mark stack
(setq-default set-mark-command-repeat-pop t)

;; Move entire paragraph with M-n/M-p
(global-set-key "\M-n" 'forward-paragraph)
(global-set-key "\M-p" 'backward-paragraph)

;; Back to indentation with M-a
(global-set-key "\M-a" 'back-to-indentation)

;; Avy mode
;; Jump anywhere on screen in four keystrokes or less.
(require 'avy)
(define-key global-map (kbd "C-j") 'avy-goto-word-or-subword-1)
(define-key global-map (kbd "C-M-j") 'avy-goto-char)
(define-key global-map (kbd "C-M-l") 'avy-goto-line)

;; Ace window
;; Select which window to switch to, rather than shuffling through them all
;; (require 'ace-window)
;; (global-set-key (kbd "C-x o") 'ace-window)

;; imenu
;; Language-aware navigation
(require 'imenu-anywhere)
(setq imenu-auto-rescan t)
(global-set-key (kbd "C-.") 'imenu-anywhere)

;; Keep point position when scrolling
;; (setq scroll-preserve-screen-position t)

;; Scroll one line shortcuts
(global-set-key (kbd "C-<down>") 'scroll-up-line)
(global-set-key (kbd "C-<up>") 'scroll-down-line)
(global-set-key (kbd "C-'") 'scroll-up-line)
(global-set-key (kbd "C-¨") 'scroll-down-line)

;; * Editing

;; Allow deletion of selected text with <DEL>
(delete-selection-mode 1)

;; Use multiple spaces instead of tab characters
(setq-default indent-tabs-mode nil)
(setq-default tab-stop-list (number-sequence 4 200 4))
;;(define-key text-mode-map (kbd "TAB") 'tab-to-tab-stop)


;; Use 4 spaces
;;(setq-default tab-width 4)
;;(setq indent-line-function 'insert-tab)
;;(setq-default c-basic-offset 4)

;; hippie-expand instead of dabbrev-expand
;; dabbrev-expand will try to expand the word under the cursor by
;; searching your open buffers for words beginning with the same
;; characters. For example, if you have written "printf" in an open
;; buffer you can just write "pr" and expand it to the full
;; word. hippie-expand does the same kind of search, plus some
;; additional searching, such as in your kill ring or the names of the
;; files you have open.
(global-set-key (kbd "M-/") 'hippie-expand)

;; Alternative mapping
 (global-set-key [(control tab)] 'hippie-expand)

;; Expand from everything!
(setq hippie-expand-try-functions-list
  '(try-expand-dabbrev
    try-expand-dabbrev-all-buffers
    try-complete-file-name-partially
    try-complete-file-name
    try-expand-all-abbrevs
    try-expand-list
    try-expand-dabbrev-from-kill
    try-expand-line
    try-complete-lisp-symbol-partially
    try-complete-lisp-symbol))

;; Auto complete mode
;; Always suggest completions.
; (require 'popup)
; (require 'auto-complete)
; (global-set-key (kbd "C-<return>")
;                 (lambda () (interactive)
;                   (progn (auto-complete-mode 1) (auto-complete))))

;; Visual Regexp
;; Replace normal query-replace with a better one
(require 'visual-regexp)
(global-set-key "\M-%" 'vr/query-replace)

;; Multiple cursors
;; What it sounds like
(require 'multiple-cursors)

;; Suggested bindings
; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
; (global-set-key (kbd "C-M-c") 'mc/edit-lines)

;; Expand region
;; Select the thing I'm currently inside
(require 'expand-region)
(global-set-key (kbd "M-h") 'er/expand-region)

;; Delete all trailing whitespaces in buffer before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Cycle kill-ring in reverse dir
(defun yank-pop-forwards (arg)
  (interactive "p")
  (yank-pop (- arg)))
(global-set-key "\M-Y" 'yank-pop-forwards) ; M-Y (Meta-Shift-Y)

;; ==========
;; Interface
;; ==========

;; ido mode
;; Automatic auto-complete for many things, including opening files.
(ido-mode)

;; Don't automatically select things though...
(setq ido-auto-merge-delay-time 9999)

;; smex
;; M-x on steroids
(require 'smex)
(global-set-key "\M-x" 'smex)

;; Uniquify buffernames
;; Give better names to buffers of same name
(require 'uniquify)

;; Save-place
;; Remember the cursor position when you close a file, so that you
;; start with the cursor in the same position when opening it again
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

;; Recent files
;; Enable a command to list your most recently edited files. If you
;; know you are opening a file that you have edited recently, this
;; should be faster than using find-file ("C-x C-f"). The code below
;; binds this to the keyboard shortcut "C-x C-r", which replaces the
;; shortcut for the command find-file-read-only.
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

(global-set-key "\C-x\C-r" 'recentf-ido-find-file)

;; copy clipboard to kill ring before overwritten
(setq save-interprogram-paste-before-kill t)

(fset 'list-c-functions
   [?\M-s ?o ?^ ?\\ ?w ?. ?* ?\) ?$ return])


;; * Programming

;; Flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Key binding for finding next error
(dolist (hook '(prog-mode-hook))
  (add-hook hook
            (lambda () (interactive)
              (local-set-key (kbd "C-c C-n")
                             'next-error))))

;; Key binding for finding previous error
(dolist (hook '(prog-mode-hook))
  (add-hook hook
            (lambda () (interactive)
              (local-set-key (kbd "C-c C-p")
                             'previous-error))))

;; Display flymake errors in minibuffer. And more..
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 0.2)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")))))

;; YASnippets
;; Expand e.g. "for<tab>" to "for(int i = 0; i < N; i++) {}"
(require 'yasnippet)
(yas-global-mode 1)

;; Undo-tree
(require 'undo-tree)
(global-undo-tree-mode 1)

;; java syntax checking
(require 'flymake)
(add-hook 'java-mode-hook 'flymake-mode-on)

(defun my-java-flymake-init ()
  (list "javac" (list (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-with-folder-structure))))

(add-to-list 'flymake-allowed-file-name-masks '("\\.java$" my-java-flymake-init flymake-simple-cleanup))

(when (require 'flymake)
  (set-variable 'flymake-log-level 9)
  (setq flymake-start-syntax-check-on-newline nil)
  (setq flymake-no-changes-timeout 10)
  (add-hook 'java-mode-hook 'flymake-mode-on))


;; drag stuff
(add-to-list 'load-path "/path/to/drag-stuff")
(require 'drag-stuff)
(drag-stuff-mode t)
(drag-stuff-global-mode 1)
(drag-stuff-define-keys)

(fset 'jlayout
   [?\M-s ?o ?\\ ?\( ?p ?u ?b ?l ?i ?c ?\\ ?| ?p ?r ?i ?v ?a ?t ?e ?\\ ?\) ?. ?* ?\{ ?$ return])
(global-set-key (kbd "C-å") 'jlayout)

(fset 'jpublic
   [?\M-x ?o ?c ?c ?u ?r return ?p ?u ?b ?l ?i ?c ?. ?* ?\{ ?$ return ?\C-x])
(global-set-key (kbd "C-ä") 'jpublic)


;; * Other

;; sql indent 2 spaces
;; (defun my-sql-mode-hook ()
;;   (add-hook 'hack-local-variables-hook
;;             (lambda () (setq indent-tabs-mode nil) (setq tab-width 4) )))
;; (add-hook 'sql-mode-hook 'my-sql-mode-hook)

;; javascript indent 2 spaces
(add-hook 'js-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

(setq backup-directory-alist `(("." . "~/.saves")))
(setq use-dialog-box nil)

(defun open-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))
(global-set-key (kbd "C-c I") 'open-init-file)

;; org-mode
(setq org-src-fontify-natively t)

;; dumb-jump
(dumb-jump-mode)
(setq dumb-jump-aggressive t)

;; visual-regexp-steroids, for python regexp engine
(add-to-list 'load-path "folder-to/visual-regexp/")
(add-to-list 'load-path "folder-to/visual-regexp-steroids/")
(require 'visual-regexp-steroids)
(define-key global-map (kbd "C-c r") 'vr/replace)
(define-key global-map (kbd "C-c q") 'vr/query-replace)
;; if you use multiple-cursors, this is for you:
(define-key global-map (kbd "C-c m") 'vr/mc-mark)
;; to use visual-regexp-steroids's isearch instead of the built-in regexp isearch, also include the following lines:
(define-key esc-map (kbd "C-r") 'vr/isearch-backward) ;; C-M-r
(define-key esc-map (kbd "C-s") 'vr/isearch-forward) ;; C-M-s


;; ** jump between parentesis - replace forward/backward sexp
  (defun skip-string-forward (&optional limit)
     (if (eq (char-after) ?\")
         (catch 'done
           (forward-char 1)
           (while t
             (skip-chars-forward "^\\\\\"" limit)
             (cond ((eq (point) limit)
                   (throw 'done nil) )
                   ((eq (char-after) ?\")
                   (forward-char 1)
                   (throw 'done nil) )
                   (t
                   (forward-char 1)
                   (if (eq (point) limit)
                        (throw 'done nil)
                      (forward-char 1) ) ) ) ) ) ) )

   (defun skip-string-backward (&optional limit)
     (if (eq (char-before) ?\")
         (catch 'done
           (forward-char -1)
           (while t
             (skip-chars-backward "^\"" limit)
             (if (eq (point) limit)
                 (throw 'done nil) )
             (forward-char -1)
             (if (eq (point) limit)
                 (throw 'done nil) )
             (if (not (eq (char-before) ?\\))
                 (throw 'done nil) ) ) ) ) )

;; ** Jump between parentesis

   (defun forward-pexp (&optional arg)
     (interactive "p")
     (or arg (setq arg 1))
     (let (open close next notstrc notstro notstre depth pair)
       (catch 'done
         (cond ((> arg 0)
                (skip-chars-forward " \t\n")
                (if (not (memq (char-after) '(?\( ?\[ ?\{ ?\<)))
                   (goto-char (or (scan-sexps (point) arg) (buffer-end arg)))
                  (skip-chars-forward "^([{<\"")
                  (while (eq (char-after) ?\")
                   (skip-string-forward)
                   (skip-chars-forward "^([{<\"") )
                  (setq open (char-after))
                  (if (setq close (cadr (assq open '( (?\( ?\))
                                                      (?\[ ?\])
                                                      (?\{ ?\})
                                                      (?\< ?\>) ) ) ) )
                      (progn
                        (setq notstro (string ?^ open ?\")
                              notstre (string ?^ open close ?\") )
                        (while (and (> arg 0) (not (eobp)))
                          (skip-chars-forward notstro)
                          (while (eq (char-after) ?\")
                           (if (eq (char-before) ?\\)
                                (forward-char 1)
                              (skip-string-forward) )
                           (skip-chars-forward notstro) )
                          (forward-char 1)
                          (setq depth 1)
                          (while (and (> depth 0) (not (eobp)))
                           (skip-chars-forward notstre)
                           (while (eq (char-after) ?\")
                              (if (eq (char-before) ?\\)
                                  (forward-char 1)
                                (skip-string-forward) )
                              (skip-chars-forward notstre) )
                           (setq next (char-after))
                           (cond ((eq next open)
                                   (setq depth (1+ depth)) )
                                  ((eq next close)
                                   (setq depth (1- depth)) )
                                  (t
                                   (throw 'done nil) ) )
                           (forward-char 1) )
                          (setq arg (1- arg) ) ) ) ) ) )
               ((< arg 0)
                (skip-chars-backward " \t\t")
                (if (not (memq (char-before) '(?\) ?\] ?\} ?\>)))
                   (progn
                      (goto-char (or (scan-sexps (point) arg) (buffer-end arg)))
                      (backward-prefix-chars) )
                  (skip-chars-backward "^)]}>\"")
                  (while (eq (char-before) ?\")
                   (skip-string-backward)
                   (skip-chars-backward "^)]}>\"") )
                  (setq close (char-before))
                  (if (setq open (cadr (assq close '( (?\) ?\()
                                                      (?\] ?\[)
                                                      (?\} ?\{)
                                                      (?\> ?\<) ) ) ) )
                      (progn
                        (setq notstrc (string ?^ close ?\")
                              notstre (string ?^ close open ?\") )
                        (while (and (< arg 0) (not (bobp)))
                          (skip-chars-backward notstrc)
                          (while (eq (char-before) ?\")
                           (if (eq (char-before (1- (point))) ?\\)
                                (forward-char -1)
                              (skip-string-backward) )
                           (skip-chars-backward notstrc) )
                          (forward-char -1)
                          (setq depth 1)
                          (while (and (> depth 0) (not (bobp)))
                           (skip-chars-backward notstre)
                           (while (eq (char-before) ?\")
                              (if (eq (char-before (1- (point))) ?\\)
                                  (forward-char -1)
                                (skip-string-backward) )
                              (skip-chars-backward notstre) )
                           (setq next (char-before))
                           (cond ((eq next close)
                                   (setq depth (1+ depth)) )
                                  ((eq next open)
                                   (setq depth (1- depth)) )
                                  (t
                                   (throw 'done nil) ) )
                           (forward-char -1) )
                          (setq arg (1+ arg)) ) ) ) ) ) ) ) ))

   (setq forward-sexp-function 'forward-pexp)





;; ** indent and unindent
;; https://stackoverflow.com/questions/2249955/emacs-shift-tab-to-left-shift-the-block

(defun indent-region-custom(numSpaces)
    (progn
        ; default to start and end of current line
        (setq regionStart (line-beginning-position))
        (setq regionEnd (line-end-position))

        ; if there's a selection, use that instead of the current line
        (when (use-region-p)
            (setq regionStart (region-beginning))
            (setq regionEnd (region-end))
        )

        (save-excursion ; restore the position afterwards
            (goto-char regionStart) ; go to the start of region
            (setq start (line-beginning-position)) ; save the start of the line
            (goto-char regionEnd) ; go to the end of region
            (setq end (line-end-position)) ; save the end of the line

            (indent-rigidly start end numSpaces) ; indent between start and end
            (setq deactivate-mark nil) ; restore the selected region
        )
    )
)

(defun untab-region (N)
    (interactive "p")
    (indent-region-custom -4)
)

(defun tab-region (N)
    (interactive "p")
    (if (active-minibuffer-window)
        (minibuffer-complete)    ; tab is pressed in minibuffer window -> do completion
    ; else
    (if (string= (buffer-name) "*shell*")
        (comint-dynamic-complete) ; in a shell, use tab completion
    ; else
    (if (use-region-p)    ; tab is pressed is any other buffer -> execute with space insertion
        (indent-region-custom 4) ; region was selected, call indent-region
        (insert "    ") ; else insert four spaces as expected
    )))
)

(global-set-key (kbd "<backtab>") 'untab-region)
;;(global-set-key (kbd "<tab>") 'tab-region)

;; ** Outshine (code folding)
(defvar outline-minor-mode-prefix "\M-#")
;;(add-hook 'prog-mode-hook 'outshine-mode)
(require 'outshine)
(define-key outshine-mode-map (kbd "C-M-0") 'outshine-cycle)
(define-key outshine-mode-map (kbd "M-<up>") nil)
(define-key outshine-mode-map (kbd "M-<down>") nil)
(define-key outshine-mode-map (kbd "C-M-<up>") 'outline-previous-visible-heading)
(define-key outshine-mode-map (kbd "C-M-<down>") 'outline-next-visible-heading)

;; save when loses focus
;; (add-hook 'focus-out-hook 'save-buffer)

;; * My stuff, new additions last

(fset 'lua
      [?\M-x ?f ?i ?n ?d ?- ?l ?i ?b ?r ?a ?r ?y return ?l ?u ?a ?- ?m ?o ?d ?e return ?\M-x ?e ?v ?a ?l return ?\C-x ?b return ?\M-x ?l ?u ?a ?- ?m ?o ?d ?e return ?\M-x ?o ?u ?s backspace ?t ?h backspace ?s ?h ?i ?n ?e ?- ?m ?o ?d ?e return])

(setq tramp-verbose 10)

(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

(setq dired-listing-switches "-alh")

(fset 'sortbysize
   [?\C-u ?s ?\C-a ?\C-k ?- ?a ?l ?h ?S return])

(fset 'sortbynameordate
      "s")

(fset 'sql-over-ssh
      [?\M-x ?s ?e ?t ?- ?v ?a ?r ?i ?a ?b ?l ?e return ?s ?q ?l ?- ?d ?e ?f ?a ?u ?l ?t ?- ?d ?i ?r ?e ?c ?t ?o ?r ?y return ?\" ?/ ?l ?o ?c ?a ?s ?e ?r ?v ?e ?r ?2 ?: ?\" ?\C-b ?\C-b ?\C-b ?\C-b ?\C-b ?\C-b ?\C-b ?\C-b ?\C-b ?\C-b ?\C-b ?\C-b ?\C-b ?s ?s ?h ?: return])

(fset 'catquery
      [?s ?e ?l ?e ?c ?t ?  ?n ?a ?m ?e ?, ?c ?a ?t ?e ?g ?o ?r ?y ?, ?t ?o ?r ?w ?e ?b ?s ?( ?o ?s ?m ?i ?d ?s ?) ?, ?a ?s ?w ?e ?b ?( ?g ?e ?o ?m ?) ?  ?f ?r ?o ?m ?  ?c ?a ?t ?e ?l ?e ?m ?s ?  ?w ?h ?e ?r ?e ?  ?o ?s ?m ?i ?d ?s ?  ?@ ?> ?  ?a ?r ?r ?a ?y ?\[ ?\] ?\; left left ?\' ?\' left ?\C-y])

(fset 'popquery
      [?s ?e ?l ?e ?c ?t ?  ?n ?a ?m ?e ?, ?c ?a ?t ?e ?g ?o ?r ?y ?, ?t ?o ?r ?w ?e ?b ?s ?\( ?o ?s ?m ?i ?d ?s ?\) ?, ?a ?s ?w ?e ?b ?\( ?g ?e ?o ?m ?\) ?  ?f ?r ?o ?m ?  ?p ?o ?p ?e ?l ?e ?m ?s ?  ?w ?h ?e ?r ?e ?  ?o ?m ?s backspace backspace ?s ?m ?i ?d ?s ?  ?@ ?> ?  ?a ?r ?r ?a ?y ?\[ ?\' ?\C-y ?\' ?\] ?\;])

(fset 'popnquery
      [?s ?e ?l ?e ?c ?t ?  ?n ?a ?m ?e ?, ?c ?a ?t ?e ?g ?o ?r ?y ?, ?t ?o ?r ?w ?e ?b ?s ?\( ?o ?s ?m ?i ?d ?s ?\) ?, ?a ?s ?w ?e ?b ?\( ?g ?e ?o ?m ?\) ?  ?f ?r ?o ?m ?  ?p ?o ?p ?e ?l ?e ?m ?s ?  ?w ?h ?e ?r ?e ?  ?l ?o ?w ?e ?r ?\( ?n ?a ?m ?e ?\) ?  ?= ?  ?l ?o ?w ?e ?r ?\( ?\) left ?\' ?\' left ?\C-y ?\C-e ?\;])

(fset 'catnquery
   [?s ?e ?l ?e ?c ?t ?  ?n ?a ?m ?e ?, ?c ?a ?t ?e ?g ?o ?r ?y ?, ?t ?o ?r ?w ?e ?b ?s ?\( ?o ?s ?m ?i ?d ?s ?\) ?, ?a ?s ?w ?e ?b ?\( ?g ?e ?o ?m ?\) ?  ?f ?r ?o ?m ?  ?c ?a ?t ?e ?l ?e ?m ?s ?  ?w ?h ?e ?r ?e ?  ?l ?o ?w ?e ?r ?\( ?n ?a ?m ?e ?\) ?  ?= ?  ?l ?o ?w ?e ?r ?\( ?\) left ?\' ?\' left ?\C-y ?\C-e ?\;])



;; sql column jumping
(fset 'prev_sql_column
   "\C-r|\C-b\C-r|\C-f\C-f")
(fset 'next_sql_column
      "\C-s|\C-f")
(global-set-key (kbd "C-M-;") 'prev_sql_column)
(global-set-key (kbd "C-M-:") 'next_sql_column)

(global-set-key (kbd "C-M-_") 'browse-url-at-point)

;;; init.el ends here
