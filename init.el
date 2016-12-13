;; init.el --- Emacs configuration



;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(menu-bar-mode -1) ;; hide menu bar
(load-theme 'eugeneai-theme t) ;; load material theme
;(global-linum-mode t) ;; enable line numbers globally

;; If async is installed
(add-to-list 'load-path "~/.emacs.d/site-lisp/async")

(add-to-list 'load-path "~/.emacs.d/site-lisp/helm")


;; INSTALL PACKAGES
;; --------------------------------------
(setq windowed-system (or (eq window-system 'x) (eq window-system 'w32)))
(setq win32-system (eq window-system 'w32))

(if (eq window-system 'w32)
    (progn
      (if (file-directory-p "c:/GNU/bin")
          (progn
            (add-to-list 'exec-path "c:/GNU/bin")
            )
        )
      (setq url-proxy-services '(("no_proxy" . "172.27.24.")
                                 ("http" . "titan.cyber:ghbdtnbr@172.27.100.5:4444")))

      )
  )

;; Set path to dependencies
(setq dotfiles-dir (expand-file-name "~/.emacs.d/"))
(setq site-lisp-dir (expand-file-name "site-lisp" dotfiles-dir))
(add-to-list 'load-path site-lisp-dir)

(require 'package)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("elpy" . "https://jorgenschaefer.github.io/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    s
    ein
    elpy
    flycheck
;;    material-theme
    py-autopep8
    ac-ispell
    ;ace-jump
    ag
    auctex
    auctex-latexmk
    flyspell
    flycheck
    ;helm
    ;helm-ag
    ;helm-company
    ;helm-core
    ;helm-pydoc
    ;helm-themes
    helm-ls-git
    swiper
    magit
    magit-filenotify
    magithub
    color-theme
    color
    cursor-chg
    fiplr
    gh
    goto-last-change
    markdown-mode+
    markdown-mode
                                        ; python-
    s
    w3m
    htmlize
                                        ;flycheck
                                        ;company-racer
                                        ;racer
                                        ;flycheck-rust
    projectile
    ace-jump-mode
    pyenv-mode-auto
                                      ; company-jedi
                                      ; wcheck-mode
    ))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)



;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
;; (elpy-use-ipython)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(require 'helm-config)

(setq default-frame-alist '((vertical-scroll-bars . nil)
                            (tool-bar-lines . 0)
                            (menu-bar-lines . 0)
                            (fullscreen . nil)))
;(blink-cursor-mode -1)
(require 'helm-config)
(helm-mode 1)
(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(global-set-key (kbd "M-x") 'helm-M-x)
(unless (boundp 'completion-in-region-function)
  (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
  (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))

(global-set-key (kbd "C-<f6>") 'helm-ls-git-ls)
(global-set-key (kbd "C-x C-d") 'helm-browse-project)

(require 'cursor-chg)
(setq curchg-default-cursor-color "LightSkyBlue1")
(setq curchg-input-method-cursor-color "red")
(setq curchg-default-cursor-type '(hbar . 5))
(change-cursor-mode 1) ; On for overwrite/read-only/input mode
(toggle-cursor-type-when-idle 1) ; On when idle

;(setq backup-directory-alist `(("." . ,(expand-file-name
   ;(concat dotfiles-dir "backups")))))

(require 'linum+)
(defun linum-update-window-scale-fix (win)
  "fix linum for scaled text"
  (set-window-margins win
                      (ceiling (* (if (boundp 'text-scale-mode-step)
                                      (expt text-scale-mode-step
                                            text-scale-mode-amount) 1)
                                  (if (car (window-margins))
                                      (car (window-margins)) 1)
                                  ))))
(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
(setq prolog-system 'swi) ;; swi
(setq auto-mode-alist (append '(("\\.pl$" . prolog-mode)
                                ("\\.pro$" . prolog-mode)
                                ("\\.m$" . mercury-mode)
                                ("\\.P$" . prolog-mode)
                                ("\\.tex$" . latex-mode)
                                )
                              auto-mode-alist)
      )

(global-set-key (kbd "C-c q") 'auto-fill-mode)

(autoload 'vala-mode "vala-mode" "Major mode for editing Vala code." t)
(add-to-list 'auto-mode-alist '("\.vala$" . vala-mode))
(add-to-list 'auto-mode-alist '("\.vapi$" . vala-mode))
(add-to-list 'file-coding-system-alist '("\.vala$" . utf-8))
(add-to-list 'file-coding-system-alist '("\.vapi$" . utf-8))
(setq
;;  recentf-menu-path '("File")
;;  recentf-menu-title "Recent"
  recentf-max-saved-items 200
;;  recentf-max-menu-items 20
  )
(global-set-key "\C-x\ \C-r" 'recentf-open-files)


(if
    windowed-system
    (progn
      (mouse-wheel-mode t)
      (global-font-lock-mode t)
      (setq font-lock-maximum-decoration t)
      )
  (progn
    )
  )

(setq-default
 default-truncate-lines t
 ; blink-cursor-alist '((t . hollow))
 user-full-name "Evgeny Cherkashin"
 user-mail-address "eugeneai@irnok.net"
 column-number-mode t
 line-number-mode t
 page-delimiter "^\\s *\n\\s *"
 minibuffer-max-depth nil
 display-time-day-and-date t
 frame-title-format '(buffer-file-name "%f" "%b")
 )

;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun reconstruct-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)
    )
  (replace-regexp "\\(\\w+\\)-\\s-+\\(\\w+\\)" "\\1\\2" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\s-*вЂ\”" "~--" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\s—" "~--" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\(\\w+\\)-\\(\\w+\\)" "\\1\"=\\2" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\.\\.\\." "\\\\ldots{}" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\[\\([[:digit:]]+\\)\\]" "\\\\cite{b\\1}" nil (line-beginning-position) (line-end-position))
  ;(replace-regexp "\\(\\w\\|\\.\\):" "\\1\\\\,:" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\([тТ]\\.\\)\\s-*\\(\\w\\.\\)" "\\1~\\2" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\([[:upper:]]\\.\\)\\s-*\\([[:upper:]]\\.\\)\\s-+\\([[:upper:]]\\w*\\)" "\\1~\\2~\\3" nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\([[:upper:]]\\.\\)\\s-+\\([[:upper:]]\\w*\\)" "\\1~\\2" nil (line-beginning-position) (line-end-position))
  ;(replace-regexp "\"\\(\\w+\\)" "<<\1" nil (line-beginning-position) (line-end-position))
  ;(replace-regexp "\\(\\w+\\)\"" "\1>>" nil (line-beginning-position) (line-end-position))
  ;(replace-regexp "\"\\(\\.\\)\"" "<<\1>>" nil (line-beginning-position) (line-end-position))
  ;(replace-regexp "\\s-+" "_")
  )

(defun reconstruct-minted ()
  "From cursor till '\end{' performs text cleaning."
  (interactive)
  (let ((endpos (point)))
    (save-excursion
      (goto-char (mark))
      (beginning-of-line)
      (while (< (point) endpos)
        ;; (funcall fun (buffer-substring (line-beginning-position) (line-end-position)))
        (reconstruct-minted-line)
        )
      )
    )
  )

(defun reconstruct-minted-line ()
  (interactive)
  (beginning-of-line)
  (replace-regexp "\\\\textquotedbl{}" "\"" nil (line-beginning-position) (line-end-position))
  (replace-regexp "#doctest:.*$" "" nil (line-beginning-position) (line-end-position))
  (replace-regexp "^\\.\\.\\." "   " nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\~" " " nil (line-beginning-position) (line-end-position))
  (replace-regexp "\\\\" "" nil (line-beginning-position) (line-end-position))
  (replace-regexp "{\\[}" "[" nil (line-beginning-position) (line-end-position))
  (replace-regexp "{\\]}" "]" nil (line-beginning-position) (line-end-position))
  (forward-line 1)
  ; #doctest: +ELLIPSIS
  )

;; Handy key definition
(define-key global-map [f9] 'reconstruct-paragraph)
(define-key global-map [f12] 'reconstruct-minted-line)
(define-key global-map [f4] 'delete-other-windows)

(add-to-list 'auto-mode-alist '("\\.zcml\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

;;;;; key bindings

(global-set-key (kbd "C-x e") 'erase-buffer)
(global-set-key (kbd "C-<escape>") 'keyboard-escape-quit)
(global-unset-key (kbd "<escape>-<escape>-<escape>"))
(global-set-key (kbd "C-q") 'quoted-insert)
(global-set-key (kbd "C-z") 'undo)

(global-set-key (kbd "s-<right>") 'next-buffer)
(global-set-key (kbd "s-<left>") 'previous-buffer)
(global-set-key (kbd "C-<return>") 'open-next-line)

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x C-k") 'kill-current-buffer)
(global-set-key (kbd "C-x c") 'compile)
(global-set-key (kbd "C-x h") 'view-url)
(global-set-key (kbd "C-x M-m") 'shell)
;(global-set-key [f7] 'split-window-vertically)
;(global-set-key [f8] 'delete-other-windows)
;(global-set-key [f9] 'split-window-horizontally)
(global-set-key (kbd "C-j") 'newline-and-indent)
(global-set-key (kbd "RET") 'newline-and-indent)

(require 'open-next-line)

(setq visible-bell 1)

(setq echo-keystrokes 0.1
      font-lock-maximum-decoration t
      inhibit-startup-message t
      transient-mark-mode t
      color-theme-is-global t
      delete-by-moving-to-trash t
      shift-select-mode nil
      mouse-yank-at-point t
      require-final-newline t
      truncate-partial-width-windows nil
      uniquify-buffer-name-style 'forward
      whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab)
      whitespace-line-column 80
      ediff-window-setup-function 'ediff-setup-windows-plain
      xterm-mouse-mode t
      )

(add-to-list 'safe-local-variable-values '(lexical-binding . t))
(add-to-list 'safe-local-variable-values '(whitespace-line-column . 80))

(set-default 'indent-tabs-mode nil)
(set-default 'indicate-empty-lines t)
(set-default 'imenu-auto-rescan nil)


;defalias 'yes-or-no-p 'y-or-n-p)
(random t) ;; Seed the random-number generator

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(ansi-color-for-comint-mode-on)

(global-set-key [C-f1] 'bookmark-set)
(global-set-key [f1] 'bookmark-jump)

;; Strange colous

(setq inhibit-startup-message   t)   ; Don't want any startup message

;(require 'highlight-indentation)
;(add-hook 'python-mode-hook 'highlight-indentation)
(add-hook 'python-mode-hook (lambda ()
                              (setq skeleton-pair nil)
                                        ;(local-set-key [f5] 'spacemacs/python-execute-file)
                              (local-set-key [f5] 'elpy-shell-send-region-or-buffer)
                                        ;(local-set-key [f6] 'spacemacs/python-execute-file-focus)
                              ))

;;; Set some more

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import pu?db")
  (highlight-lines-matching-regexp "pdb.set_trace()"))
(add-hook 'python-mode-hook 'annotate-pdb)

(defun python-add-breakpoint ()
  (interactive)
  (newline-and-indent)
  (insert "import pdb; pdb.set_trace()")
  (newline-and-indent)
  (highlight-lines-matching-regexp "^[ ]*import pdb; pdb.set_trace()"))

(defun python-add-pubreakpoint ()
  (interactive)
  (newline-and-indent)
  (insert "import pudb; pu.db")
  (newline-and-indent)
  (highlight-lines-matching-regexp "^[ ]*import pudb; pu.db"))

(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map (kbd "C-c C-t") 'python-add-breakpoint)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map (kbd "C-c C-y") 'python-add-pubreakpoint)))

(add-hook 'python-mode-hook '(lambda ()
                               (electric-indent-local-mode -1)
                               ))

(defun tex-add-russian-dash ()
  (interactive)
  (insert "~-- "))

(add-hook 'late-mode-hook (lambda ()
                            (local-set-key (kbd "C-=") #'tex-add-russian-dash)
                            (local-set-key (kbd "C-c C-=") 'tex-add-verb-environment))

          )

(defun tex-add-verb-environment ()
  (interactive)
  (open-next-line 1)
  (insert "{\\tt%")
  (open-next-line 1)(beginning-of-line)
  (insert "\\begin{verbatim}")
  (open-next-line 1)
  (open-next-line 1)
  (insert "\\end{verbatim}%")
  (open-next-line 1)(beginning-of-line)
  (insert "}%")
  (backward-char 2)
  (forward-line -2)
  )

(defun my-ttt ()
  (erase-buffer)
  (face-remap-add-relative 'default '(
          ; :family "Monospace"
          ; :height 160 ;Seseg
           :height 100
          ))
)

(add-hook 'comint-mode-hook 'my-ttt)
(add-hook 'compilation-mode-hook 'my-ttt)
(add-hook 'gdb-locals-mode-hook 'my-ttt)
(add-hook 'gdb-frames-mode-hook 'my-ttt)
(add-hook 'gdb-registers-mode-hook 'my-ttt)


;; vala
(autoload 'vala-mode "vala-mode" "Major mode for editing Vala code." t)
(add-to-list 'auto-mode-alist '("\\.vala$" . vala-mode))
(add-to-list 'auto-mode-alist '("\\.vapi$" . vala-mode))
(add-to-list 'file-coding-system-alist '("\\.vala$" . utf-8))
(add-to-list 'file-coding-system-alist '("\\.vapi$" . utf-8))

;(load custom-file)

(defun set-input-method-english ()
  (interactive)
  (if current-input-method (toggle-input-method))
  )

(defun latex-b-slash ()
  (interactive)
  (set-input-method-english)
  (insert "\\")
)

;; (set-background-color        "wheat3") ; Set emacs bg color

;;(toggle-fullscreen)

;; Adjust line number fonts.

(defun dollar-equation ()
  (interactive)
  (set-input-method-english)
  (insert "$$")
  (backward-char)
  (set-input-method-english)
)

(defun latex-dollar-hack ()
  (interactive)
  (local-set-key (kbd "C-4") 'dollar-equation)
  )

(defun turn-off-auto-fill ()
  (interactive)
  (auto-fill-mode 0)
  )

(add-hook 'text-mode-hook 'turn-off-auto-fill)
;(add-hook 'text-mode-hook 'turn-on-flyspell)

(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(add-hook 'diff-mode-hook 'turn-on-visual-line-mode)
(add-hook 'latex-mode-hook 'turn-off-auto-fill)
(add-hook 'latex-mode-hook 'turn-on-visual-line-mode)

(defun latex-12-hacks ()
  (latex-dollar-hack)
  ; (add-hook 'post-command-hook 'auto-language-environment)
  )

(global-set-key (kbd "C-`") 'linum-mode)
(put 'scroll-left 'disabled nil)

;; Patching wrong scrolllock behaviour
(defun scroll-lock-next-line (&optional arg)
  "Scroll up ARG lines keeping point fixed."
  (interactive "p")
  (or arg (setq arg 1))
  (scroll-lock-update-goal-column)
  (if (pos-visible-in-window-p (point-max))
      (progn
        (next-line arg)
        (print "vis-p")
        (print arg)
      )
    (progn
      (scroll-up arg)
      (next-line (- arg))
      (print arg)
      (print "not-vis-p")
      )
    )
  (scroll-lock-move-to-column scroll-lock-temporary-goal-column)
  )

(defvar gud-overlay
(let* ((ov (make-overlay (point-min) (point-min))))
(overlay-put ov 'face 'secondary-selection)
ov)
"Overlay variable for GUD highlighting.")

(defadvice gud-display-line (after my-gud-highlight act)
"Highlight current line."
(let* ((ov gud-overlay)
(bf (gud-find-file true-file)))
(save-excursion
  (set-buffer bf)
  (move-overlay ov (line-beginning-position) (line-end-position)
  (current-buffer)))))

(defun gud-kill-buffer ()
(if (eq major-mode 'gud-mode)
(delete-overlay gud-overlay)))

(add-hook 'kill-buffer-hook 'gud-kill-buffer)
(add-hook 'gdb-mode-hook '(lambda ()
                            ;(new-frame)
                            ;(switch-to-buffer "**gdb**")
                            ;(tool-bar-mode 1)
                            (gdb-many-windows)
                            ))
;;-------------------------------------------------------------

(put 'erase-buffer 'disabled nil)

(require 'goto-last-change)
(global-set-key (kbd "C-x C-\\") 'goto-last-change)

;; Some additional features
(defalias 'qrr 'query-replace-regexp)

; ########### HUNSPELL in EMACS ########################

;; список используемых нами словарей
(setq ispell-local-dictionary-alist
      '(("russian"
         "[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюя]"
         "[^АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюя]"
         "[-]"  nil ("-d" "ru_RU") nil utf-8)
        ("english"
         "[A-Za-z]" "[^A-Za-z]"
         "[']"  nil ("-d" "en_US") nil iso-8859-1)))

;; вместо aspell использовать hunspell
(setq ispell-really-aspell nil
      ispell-really-hunspell t
      ispell-dictionary "english")

(setq ispell-program-name "/usr/local/bin/hunspell")

;; ;(require 'ispell)

(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
         (change (if (string= dic "russian") "english" "russian")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

(global-set-key (kbd "<f8>")   'fd-switch-dictionary)

;; ;; полный путь к нашему пропатченному hunspell
;; ;;(setq ispell-program-name "/usr/bin/hunspell")

;(load "enchant.el")

(if (eq window-system 'w32)
    (progn
      (custom-set-variables
       '(rw-hunspell-dicpath-list (quote ("c:/GNU/share/hunspell")))
       )
      )
  )

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

(define-key global-map (kbd "M-SPC") 'ace-jump-mode)

(global-set-key (kbd "C-x f") 'fiplr-find-file)


;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

(global-set-key "\C-x\ \C-m" 'magit-status)

(setq ring-bell-function
      (lambda ()
	(unless (memq this-command
		      '(isearch-abort abort-recursive-edit exit-minibuffer keyboard-quit))
	  (ding))))

;; Multitran dictionary lookup
(defun multitran-lookup-english (keyword)
  (interactive (list (thing-at-point 'word)))
  (switch-to-buffer-other-window
   (eww
   ;; (w3m-goto-url
    (concat "http://multitran.ru/c/m.exe?l1=1&s=" keyword "&%CF%EE%E8%F1%EA=%CF%EE%E8%F1%EA")
    )
   )
  ;;(run-at-time 4 nil 'iconify-frame)
  )

(add-hook 'after-init-hook 'global-company-mode)
;(add-hook 'after-init-hook 'spaceline-spacemacs-theme)

(global-set-key (kbd "C-c m") 'multitran-lookup-english)
(require 'recentf)
(setq recentf-auto-cleanup 'never) ;; disable before we start recentf!
(recentf-mode t)
(recentf-load-list)


; ########### END HUNSPELL in EMACS ########################




(custom-set-variables
; '(TeX-install-font-lock 'tex-font-setup)
 '(TeX-auto-save t)
 '(TeX-parse-self t)
 '(TeX-master nil)
 '(TeX-save-query nil)
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server (quote ask)))


;; init.el ends here
  (setq custom-file "~/.emacs.d/custom.el")
  (load-file custom-file)

  (add-hook 'after-init-hook 'global-auto-complete-mode)
  (require 'yasnippet)
  (setq yas-snippet-dirs (append yas-snippet-dirs
                                 '("~/.emacs.d/snippets")))
  (yas-reload-all)
  (yas-global-mode 1)
  ;;(add-to-list 'company-backends 'company-jedi)
  (global-set-key (kbd "M-p") 'mark-paragraph)

  ;; (add-hook 'after-init-hook 'global-company-mode)
  ;; (setq company-idle-delay 0.2)
  ;; (setq company-minimum-prefix-length 1)

  (add-hook 'LaTeX-mode-hook 'turn-off-auto-fill)
  ;; (add-hook 'LaTeX-mode-hook 'turn-on-visual-line-mode)
  ;(add-hook 'LaTeX-mode-hook 'turn-on-flyspell)
  ;(add-hook 'after-init-hook 'turn-on-flyspell)

  ;(add-hook 'python-mode-hook 'jedi-mode)
  ;; (setq reftex-plug-into-AUCTeX t)

  ;; (setq curchg-default-cursor-color "LightSkyBlue1")
  ;; (setq curchg-input-method-cursor-color "red")
  ;; (setq curchg-default-cursor-type '(hbar . 5))
  ;; (change-cursor-mode 1) ; On for overwrite/read-only/input mode
  ;; (toggle-cursor-type-when-idle 1) ; On when idle
  (setq font-latex-fontify-script nil
        font-latex-fontify-sectioning 'color)
