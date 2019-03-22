;;; private/my-cc/config.el -*- lexical-binding: t; -*-

(def-package! google-c-style
  :config
  (add-hook! (c-mode c++-mode) #'google-set-c-style))

;; (def-package! clang-format
;;   :after (ccls)
;;   :commands (clang-format-region clang-format-buffer))

(def-package! cmake-project
  :after cc-mode
  :commands (cp-project-refresh cp-project-new cp-project-debug)
  :config
  (add-hook! (c-mode c++-mode) #'cp-project-refresh)
  (defun +my-cc-gen-template()
    (concat
     (format "cmake_minimum_required(VERSION %s)" cp-cmake-minimum-version)
     (format "\nset(PROJECT_NAME \"%s\")" (file-name-nondirectory (directory-file-name cp-project-root-cache)))
     (format "\nproject(${PROJECT_NAME})")
     (format "\nset(CMAKE_EXPORT_COMPILE_COMMANDS ON)")
     (format  "\nset(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)")
     (format "\nset(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)")
     (format "\n\nadd_executable(main main.cpp)")
     ))
  (setq cp-project-template-function '+my-cc-gen-template)
  (when (and (not IS-WINDOWS) (featurep! :private lsp))
    (add-hook
     'cp-after-new-project-hook
     #'(lambda()
         (shell-command
          (concat
           (format "echo \"\nint main() {\n  return 0;\n}\" > main.cpp && ")
           (format "touch %s/compile_commands.json && " cp-project-build-directory)
           (format "ln -sf %s/compile_commands.json compile_commands.json" cp-project-build-directory)))
         (cp-project-gen))))
  (map!
   (:mode (c-mode c++-mode)
     :gnvime "<f7>" #'cp-project-build
     :gnvime "<f8>" #'cp-project-run)))

(after! realgud
  (setq realgud-safe-mode nil))

;; (def-package! gdb-mi 
;;   :load-path "~/data/Code/Elisp/emacs-gdb/" 
;;   :commands (gdb-mi)
;;   :init
;;   (fmakunbound 'gdb)
;;   (fmakunbound 'gdb-enable-debug))

;; (setq gdb-many-windows t)
;; (global-set-key [f5] 'gud-run)
;; (global-set-key [S-f5] 'gud-kill)
;; (global-set-key [C-f7] '(lambda () (interactive) (compile compile-command)))
;; (global-set-key [f6] 'gud-print)
;; (global-set-key [C-f6] 'gud-pstar)
;; (global-set-key [f9] 'gud-break-remove)
;; (global-set-key [f10] 'gud-next)
;; (global-set-key [C-f10] 'gud-until)
;; (global-set-key [S-f10] 'gud-jump)
;; (global-set-key [f11] 'gud-step)
;; (global-set-key [C-f11] 'gud-finish)
