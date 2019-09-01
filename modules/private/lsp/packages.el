;; -*- no-byte-compile: t; -*-
;; lsp/packages.el

(package! lsp-mode)

(when EMACS26+
  (package! lsp-ui))

(when (featurep! :completion company)
  (package! company-lsp))

;; (when (featurep! :lang cc)
;;   (package! ccls))

(when (featurep! :lang python)
  (package! ms-python :recipe (:host github :repo "xhcoding/ms-python")))

;; (package! lsp-java)
(package! dap-mode)
