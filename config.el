;;; config/private/+ui.el -*- lexical-binding: t; -*-

(load! "+bindings")
(load! "+ui")
(load! "+org")

;; remove doom advice, I don't need deal with comments when newline
(advice-remove #'newline-and-indent #'doom*newline-and-indent)

(after! evil
  (setq evil-want-integration t))

;; Reconfigure packages
(after! evil-escape
  (setq evil-escape-key-sequence "jk"))

(after! projectile
  (setq projectile-require-project-root t))

(after! company
  (setq company-minimum-prefix-length 2
        company-idle-delay 0
        company-tooltip-limit 10
        company-show-numbers t
        company-global-modes '(not comint-mode erc-mode message-mode help-mode gud-mode)
        )
  (map! :map company-active-map
        "M-g" #'company-abort
        "M-d" #'company-next-page
        "M-u" #'company-previous-page))

(use-package! package-lint
  :commands (package-lint-current-buffer))

(use-package! auto-save
  :load-path +my-ext-dir
  :config
  (setq +my-auto-save-timer nil)
  (setq auto-save-slient t))

(use-package! visual-regexp
  :commands (vr/query-replace vr/replace)
  )

(after! emacs-snippets
  (add-to-list 'yas-snippet-dirs +my-yas-snipper-dir))


(use-package! company-english-helper
  :commands (toggle-company-english-helper))


(use-package! scroll-other-window
  :load-path +my-ext-dir
  :config
  (sow-mode 1)
  (map!
   :gnvime "<M-up>"    #'sow-scroll-other-window-down
   :gnvime "<M-down>"  #'sow-scroll-other-window))


(use-package! openwith
  :load-path +my-ext-dir
  :config
  (setq openwith-associations
        '(
          ("\\.pdf\\'" "foxitreader" (file))
          ("\\.docx?\\'" "wps" (file))
          ("\\.pptx?\\'" "wpp" (file))
          ("\\.xlsx?\\'" "et" (file))))
  (add-hook! 'emacs-startup-hook #'openwith-mode)
  )


(set-lookup-handlers! 'emacs-lisp-mode :documentation #'helpful-at-point)

(set-company-backend! '(yaml-mode cmake-mode) 'company-dabbrev)

(after! format
  (set-formatter!
    'clang-format
    '("clang-format"
      ("-assume-filename=%S" (or (buffer-file-name) ""))
      "-style=Google"))
  :modes
  '((c-mode ".c")
    (c++-mode ".cpp")
    (java-mode ".java")
    (objc-mode ".m")
    ))

(after! ws-butler
  (setq ws-butler-global-exempt-modes
        (append ws-butler-global-exempt-modes
                '(prog-mode org-mode))))


(after! tex
  (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil t))
  (setq-hook! LaTeX-mode TeX-command-default "XeLaTex")

 ;;  (add-to-list 'TeX-view-program-list '("foxitreader" foxitreader))
 ;;  (add-to-list 'TeX-view-program-selection '(output-pdf "foxitreader"))
 )

(use-package! pyim
  :defer 2
  :config
  (setq pyim-dcache-directory (expand-file-name "pyim" doom-cache-dir))
  (setq pyim-dicts
        '((:name "bigdict" :file "~/.config/doom/tools/pyim-bigdict.pyim")))
        ;; '((:name "greatdict" :file "~/.config/doom/tools/pyim-greatdict.pyim")))

  (setq default-input-method "pyim")

  ;; 我使用全拼 
  (setq pyim-default-scheme 'quanpin)

  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  ;; 我自己使用的中英文动态切换规则是：
  ;; 1. 光标只有在注释里面时，才可以输入中文。
  ;; 2. 光标前是汉字字符时，才能输入中文。
  ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
  (setq-default pyim-english-input-switch-functions
                '(
                  pyim-probe-dynamic-english
                  pyim-probe-isearch-mode
                  pyim-probe-program-mode
                  pyim-probe-org-structure-template))

  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))

  ;; 开启拼音搜索功能
  ;;(pyim-isearch-mode 1)

  ;; 使用 pupup-el 来绘制选词框, 如果用 emacs26, 建议设置
  ;; 为 'posframe, 速度很快并且菜单不会变形，不过需要用户
  ;; 手动安装 posframe 包。
  (setq pyim-page-tooltip 'posframe)

  ;; 选词框显示8个候选词
  (setq pyim-page-length 8)

  :bind
  (("M-l" . pyim-convert-code-at-point) ;与 pyim-probe-dynamic-english 配合
   ("C-;" . pyim-delete-word-from-personal-buffer)))

(after! eshell
  (setq eshell-directory-name (expand-file-name "eshell" doom-etc-dir)))

(use-package! aweshell)

(use-package! color-rg
  :commands (color-rg-search-input))

(global-auto-revert-mode 0)

;; 中文字体显示异常问题
;; https://emacs-china.org/t/doom-emacs/6967
;;(set-charset-priority 'unicode)

;; 有道翻译
;; Enable Cache
(setq url-automatic-caching t)

;; 全频
(toggle-frame-maximized)

;; (setq +latex-viewers '(zathura))

(add-to-list '+lookup-provider-url-alist
             '("Bing"     . "https://cn.bing.com/search?q=%s")
)
(add-to-list '+lookup-provider-url-alist
             '("Linux"    . "https://elixir.bootlin.com/linux/v2.6.39.4/ident/%s")
)

(setq multi-term-program "/usr/bin/zsh")
