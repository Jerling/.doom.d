;;; private/lsp/config.el -*- lexical-binding: t; -*-

(use-package! spinner)

(use-package! lsp-mode
  :commands (lsp-register-client)
  :config
  (setq lsp-print-io t
        lsp-auto-guess-root t
        lsp-prefer-flymake nil
        lsp-session-file (expand-file-name ".lsp-session" doom-etc-dir)
        lsp-project-blacklist '("^/usr/")
        lsp-highlight-symbol-at-point nil))

(use-package! company-lsp
  :after lsp-mode
  :init
  (setq company-transformers nil
        company-lsp-cache-candidates 'auto
        )
  :config
  (set-company-backend! 'lsp-mode 'company-lsp)
  )

(use-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (set-lookup-handlers! 'lsp-ui-mode
    :definition #'lsp-ui-peek-find-definitions
    :references #'lsp-ui-peek-find-references)
  (setq
   lsp-ui-doc-use-webkit nil
   lsp-ui-doc-use-childframe t
   lsp-ui-doc-max-height 20
   lsp-ui-doc-max-width 50
   lsp-ui-sideline-enable nil
   lsp-ui-peek-always-show t)
  (map!
   :map lsp-ui-peek-mode-map
   "h" #'lsp-ui-peek--select-prev-file
   "j" #'lsp-ui-peek--select-next
   "k" #'lsp-ui-peek--select-prev
   "l" #'lsp-ui-peek--select-next-file))


(use-package! dap-mode
  :after lsp-mode
  :config
  (setq dap--breakpoints-file (expand-file-name ".dap-breakpoints" doom-etc-dir))
  (dap-mode +1)
  (dap-ui-mode +1))


;; lsp client config

(use-package! ccls
  :init
  (add-hook! (c-mode c++-mode cuda-mode) #'lsp)
  :config

 (setq ccls-initialization-options `(:cacheDirectory ,(expand-file-name "~/.cache/ccls_cache")))

  (evil-set-initial-state 'ccls-tree-mode 'emacs)

  (after! projectile
    (setq projectile-project-root-files-top-down-recurring
          (append '("compile_commands.json")
                  projectile-project-root-files-top-down-recurring))
    (add-to-list 'projectile-globally-ignored-directories ".ccls-cache")
    (add-to-list 'projectile-globally-ignored-directories "build"))
  (if IS-WINDOWS
      (setq ccls-executable "~/ccls/Release/ccls.exe")
    (setq ccls-executable (concat doom-private-dir "tools/ccls"))
    )
  )

;; (use-package! dap-lldb
;;   :after (ccls)
;;   :config
;;   (setq dap-lldb-debugged-program-function 'cp-project-debug))

;; ms-python
(use-package! ms-python
 :config
 (add-hook 'python-mode-hook #'+my-python/enable-lsp)
 (setq ms-python-server-install-dir (expand-file-name "ms-pyls" doom-etc-dir))
 )

(use-package! dap-python
 :after (ms-python))

;; lsp-java
;; (use-package! lsp-java
;;   :config
;;   (add-hook 'java-mode-hook #'lsp)
;;   (setq lsp-java-server-install-dir (expand-file-name "lsp-java/server" doom-etc-dir)
;;         lsp-java-workspace-dir (expand-file-name "lsp-java/workspace" doom-etc-dir)))


;; (use-package! dap-java
;;   :after (lsp-java))

;; (use-package! lsp-java-treemacs
;;   :after (treemacs))

(setq lsp-enable-file-watchers nil)
(add-to-list 'lsp-file-watch-ignored "build")
