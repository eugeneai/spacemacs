(require 'package)

;(add-to-list 'package-archives
;             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

;(add-to-list 'package-archives
;             '("marmalade" . "http://marmalade-repo.org/packages/"))

;(add-to-list 'package-archives
;             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;;(add-to-list 'load-path "~/.emacs.d/site-lisp/")


; list the packages you want
;; (setq package-list
;;     '(python-environment deferred epc
;;         flycheck ctable jedi concurrent company cyberpunk-theme elpy
;;         yasnippet pyvenv highlight-indentation find-file-in-project
;;         sql-indent sql exec-path-from-shell iedit
;;         auto-complete popup let-alist magit git-rebase-mode
;;         git-commit-mode minimap popup))


; list the packages you want
;(setq package-list '(auctex magit ...))

; activate all the packages
;(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (dotspacemacs-additional-packages)
  (unless (package-installed-p package)
    (package-install package)))
