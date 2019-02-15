;;; config/private/+bindings.el -*- lexical-binding: t; -*-
(map! [remap indent-region] #'+my/indent-or-format

      :gnvime "M-g s"     #'sp-up-sexp
      :gnvime "M-g S"     #'sp-backward-sexp
      :gnvime "M-g k"     #'+my/kill-in-pair
      :gnvime "C-k"       #'kill-line
      :gnvime "M-g b"     #'+my/toggle-chrome-play-video
      :n      "RET"       #'next-buffer
      :n      "M-RET"     #'previous-buffer
      :i      "M-/"       #'+company/complete
      :i      "M-f"       #'forward-char
      :i      "M-b"       #'backward-char
      :i      "M-n"       #'next-line
      :i      "M-p"       #'previous-line
      :i      "C-s"       #'counsel-grep-or-swiper
      :i      "C-v"       #'yank
      :i      "C-j"       #'+my/newline
      :m      "gb"        #'evil-jump-backward
      :m      "gB"        #'evil-jump-forward
      :ov     "s"         #'isolate-quick-add
      :ov     "S"         #'isolate-long-add

      (:leader
        (:prefix "o"
          :desc "Agenda"           :n  "a"    #'org-agenda
          :desc "Blog"             :n  "B"    #'easy-hugo
          :desc "Debugger"         :n  "d"    #'gdb-executable
          :desc "Youdao translate" :n  "y"    #'youdao-dictionary-search-at-point+)
        (:desc "toggle" :prefix "t"
          :desc "Transparency"     :n  "T"    #'+my/toggle-transparency
          :desc "Auto save"        :n  "a"    #'+my/toggle-auto-save
          :desc "Comment "         :n  "c"    #'comment-line
          :desc "Cycle theme"      :n  "t"    #'+my/toggle-cycle-theme
          :desc "English Helper"   :n  "e"    #'toggle-company-english-helper
          )
        (:prefix "r"
          :desc "replace"          :n  "r"    #'vr/replace
          :desc "query replace"    :n  "R"    #'vr/query-replace)
        (:prefix "c"
          :desc "comment or uncomment region" :n  "l"    #'comment-or-uncomment-region
          :desc "comile"                      :n  "C"    #'compile
          :desc "recompile"                   :n  "c"    #'recompile)
        (:prefix "f"
          :desc "Find file"                   :n  "f"    #'counsel-find-file)
        
		  :desc "excute command"              :n  "SPC"  #'execute-extended-command
		  :desc "eshell"                      :n  "'"    #'eshell
        )
      )
