;; -*- no-byte-compile: t; -*-
;;; config/private/packages.el

;; (disable-packages! anaconda-mode)

(package! visual-regexp)
(package! visual-regexp-steroids)
(package! org-edit-latex)
(package! pyim)
(package! package-lint)


(package! isolate :recipe (:fetcher github :repo "casouri/isolate"))
(package! color-rg :recipe (:fetcher github :repo "manateelazycat/color-rg"))
(package! company-english-helper :recipe (:fetcher github :repo "manateelazycat/company-english-helper"))
(package! aweshell :recipe (:fetcher github :repo "manateelazycat/aweshell"))


(package! auto-save :ignore t)
(package! scroll-other-window :ignore t)
(package! openwith :ignore t)
(package! youdao-dictionary)

