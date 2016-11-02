(deftheme eugeneai
  "Created 2016-07-15.")

(custom-theme-set-faces
 'eugeneai
 '(default ((t (:inherit nil :stipple nil :background "gray20" :foreground "wheat1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 143 :width normal :foundry "CTDB" :family "Fira Mono"))))
 '(cursor ((t (:background "SkyBlue2"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((t (:family "Sans Serif"))))
 '(escape-glyph ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "brown"))))
 '(minibuffer-prompt ((t (:foreground "#4f97d7" :inherit (bold)))))
 '(highlight ((t (:foreground "#b2b2b2" :background "#444155"))))
 '(region ((t (:background "orange3"))))
 '(shadow ((((class color grayscale) (min-colors 88) (background light)) (:foreground "grey50")) (((class color grayscale) (min-colors 88) (background dark)) (:foreground "grey70")) (((class color) (min-colors 8) (background light)) (:foreground "green")) (((class color) (min-colors 8) (background dark)) (:foreground "yellow"))))
 '(secondary-selection ((t (:background "#100a14"))))
 '(trailing-whitespace ((t (:background "#2aa1ae"))))
 '(font-lock-builtin-face ((t (:foreground "#4f97d7"))))
 '(font-lock-comment-delimiter-face ((default (:inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((t (:foreground "#2aa1ae" :background "#292e34"))))
 '(font-lock-constant-face ((t (:foreground "#a45bad"))))
 '(font-lock-doc-face ((t (:foreground "#2aa1ae"))))
 '(font-lock-function-name-face ((t (:foreground "#bc6ec5" :inherit (bold)))))
 '(font-lock-keyword-face ((t (:foreground "#4f97d7" :inherit (bold)))))
 '(font-lock-negation-char-face ((t (:foreground "#a45bad"))))
 '(font-lock-preprocessor-face ((t (:foreground "#bc6ec5"))))
 '(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
 '(font-lock-string-face ((t (:foreground "#2d9574"))))
 '(font-lock-type-face ((t (:foreground "#ce537a" :inherit (bold)))))
 '(font-lock-variable-name-face ((t (:foreground "#7590db"))))
 '(font-lock-warning-face ((t (:foreground "#dc752f" :background "#292b2e"))))
 '(button ((t (:inherit (link)))))
 '(link ((t (:underline (:color foreground-color :style line) :foreground "#2aa1ae"))))
 '(link-visited ((t (:underline (:color foreground-color :style line) :foreground "#c56ec3"))))
 '(fringe ((t (:foreground "#b2b2b2" :background "#292b2e"))))
 '(header-line ((t (:background "#0a0814"))))
 '(tooltip ((t (:height 0.5 :weight normal :slant normal :underline nil :foreground "black" :background "lightyellow" :inherit (variable-pitch)))))
 '(mode-line ((t (:box (:line-width 1 :color "#5d4d7a" :style nil) :foreground "#b2b2b2" :background "#222226"))))
 '(mode-line-buffer-id ((t (:foreground "#bc6ec5" :inherit (bold)))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((((class color) (min-colors 88)) (:box (:line-width 2 :color "grey40" :style released-button))) (t (:inherit (highlight)))))
 '(mode-line-inactive ((t (:box (:line-width 1 :color "#5d4d7a" :style nil) :foreground "#b2b2b2" :background "#292b2e"))))
 '(isearch ((t (:foreground "#292b2e" :background "#86dc2f"))))
 '(isearch-fail ((((class color) (min-colors 88) (background light)) (:background "RosyBrown1")) (((class color) (min-colors 88) (background dark)) (:background "red4")) (((class color) (min-colors 16)) (:background "red")) (((class color) (min-colors 8)) (:background "red")) (((class color grayscale)) (:foreground "grey")) (t (:inverse-video t))))
 '(lazy-highlight ((t (:weight normal :background "#293239"))))
 '(match ((t (:foreground "#86dc2f" :background "#444155"))))
 '(next-error ((t (:inherit (region)))))
 '(query-replace ((t (:inherit (isearch))))))

(provide-theme 'eugeneai)
