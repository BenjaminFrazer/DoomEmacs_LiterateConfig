(setq user-full-name "Ben Frazer"
      user-mail-address "benjamin.frazer.1997@gmail.com")

(setq doom-theme 'doom-vibrant)

(doom/set-frame-opacity 95)
(setq doom-font (font-spec :family "Source Code Pro" :size 16 :weight 'semi-light)
        doom-variable-pitch-font (font-spec :family "Ubuntu") ; inherits `doom-font''s :size
        doom-unicode-font (font-spec :family "JetBrainsMono Nerd Font" :size 11)
        doom-unicode-font (font-spec :family "Ubuntu" :size 12))

(setq display-line-numbers-type t)

(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))

(setq org-directory "~/notes/")

(setq org-link-file-path-type 'relative)

(add-hook 'org-mode-hook 'mixed-pitch-mode)

(after! org
(setq! org-startup-folded t))

(defun my/babel-ansi ()
  (when-let ((beg (org-babel-where-is-src-block-result nil nil)))
    (save-excursion
      (goto-char beg)
      (when (looking-at org-babel-result-regexp)
    (let ((end (org-babel-result-end))
    (ansi-color-context-region nil))
    (ansi-color-apply-on-region beg end))))))

(define-minor-mode org-babel-ansi-colors-mode
  "Apply ANSI color codes to Org Babel results."
  :global t
  :after-hook
  (if org-babel-ansi-colors-mode
      (add-hook 'org-babel-after-execute-hook #'my/babel-ansi)
    (remove-hook 'org-babel-after-execute-hook #'my/babel-ansi)))

(after! org
(add-hook 'org-mode-hook 'org-babel-ansi-colors-mode))

(setq org-ellipsis " v")

(setq org-cycle-separator-lines 3) ;; stops the ellipsis miss-displaying

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.4 :weight semi-bold))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.2 :weight semi-bold))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.1 :weight semi-bold))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.0 :weight semi-bold))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
)

(custom-set-faces
 '(org-link ((t (:inherit link :foreground "maroon")))))

(after! org
(setq org-superstar-item-bullet-alist '((42 . 8226) (43 . 9655) (45 . 9658))))

(after! org
(setq! org-image-actual-width 300))

(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))

;; (require 'ox-latex)

(add-to-list 'org-latex-packages-alist '("" "minted" nil))
(add-to-list 'org-latex-packages-alist '("" "tikz" t))
(add-to-list 'org-latex-packages-alist '("" "circuitikz" t))
(add-to-list 'org-latex-packages-alist '("" "gensymb" t))
(add-to-list 'org-latex-packages-alist '("" "amsfonts" t))
(add-to-list 'org-latex-packages-alist '("" "amssymb" t))

(setq org-latex-pdf-process
      '("pdflatex -f -pdf -%latex -shell-escape -interaction=nonstopmode -output-directory=%o %f"
       "bibtex %b"
       "makeglossaries %b"
       "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
       "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
       ))

(add-to-list 'org-latex-classes
             '("IEEEtran"
               "\\documentclass{IEEEtran}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("bf_thesis"
               "\\documentclass[11pt]{report}"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section{%s}")
               ("\\subsection{%s}" . "\\subsection{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq org-latex-toc-command "\\tableofcontents \\clearpage")

(setq org-latex-image-default-width "0.8\\textwidth")
(setq org-latex-default-figure-position "H")

(setq org-noter-always-create-frame nil)
(setq org-noter-doc-split-fraction '(0.6 . 0.6))

(setq +org-capture-todo-file "~/gtd/inbox.org")
(after! org
(setq org-capture-templates '(
    ("i" "inbox" entry
    (file +org-capture-todo-file)
    "* IN %?\n%i\n%a" :prepend t)

    ;; ("n" "Personal notes" entry
    ;;   (file+headline +org-capture-notes-file "Inbox")
    ;;   "* %u %?\n%i\n%a" :prepend t)

    ;; ("j" "Journal" entry
    ;;   (file+olp+datetree +org-capture-journal-file)
    ;;   "* %U %?\n%i\n%a" :prepend t)

    ("d" "Templates for tickler" entry
    (file "~/gtd/tickler.org")
    "* TODO %?\n%i\n%a" :prepend t)

    ("p" "Templates for projects" entry
    (file +org-capture-projects-file)
    "* PROJ %?\n%i\n%a" :prepend t)
)))

(after! org
  (setq org-refile-targets '(
                        (nil :maxlevel . 2)             ; refile to headings in the current buffer
                        ("~/gtd/gtd.org" :maxlevel . 2)
                        ("~/gtd/gtd_household.org" :maxlevel . 2)
                        ("~/gtd/someday.org" :maxlevel . 2)
                        ("~/gtd/calendar.org" :maxlevel . 2)
                        ("~/gtd/waitingfor.org" :maxlevel . 2)
                        ("~/gtd/people.org" :maxlevel . 2)
                        ("~/gtd/places.org" :maxlevel . 2)
                        ("~/gtd/tickler.org" :maxlevel . 2))))
(setq org-refile-allow-creating-parent-nodes (quote confirm))

(after! org
(setq org-agenda-files '("~/gtd/inbox.org"
                         "~/gtd/gtd.org"
                         "~/gtd/calendar.org"
                         "~/gtd/gtd_household.org"
                         "~/gtd/people.org"
                         "~/gtd/waitingfor.org"
                         "~/gtd/tickler.org")))
;; ignores scheduled todo items from todo list in aganda view
(setq org-agenda-todo-ignore-scheduled t)
(setq org-agenda-skip-function-global
      '(org-agenda-skip-entry-if 'todo '("DONE" "BLOCK" "TODO" )))

(after! org
(add-to-list 'org-todo-keywords
             '(sequence  "⚙"))
(add-to-list 'org-todo-keywords
             '(sequence "IN" "TODO" "PROJ" "|" "DONE"))

(add-to-list 'org-todo-keywords
             '(sequence "READ" "|" "DONE"))

;; This is so I cannot set a headline to DONE if children aren’t DONE.
(setq-default org-enforce-todo-dependencies t)

(add-to-list 'org-todo-keyword-faces '("IN" :foreground "orange" :weight bold))
(add-to-list 'org-todo-keyword-faces '("SCHED" :foreground "dark cyan" :weight bold))
(add-to-list 'org-todo-keyword-faces '("READ" :foreground "blue" :weight bold))
(add-to-list 'org-todo-keyword-faces '("PROJ" :foreground "purple" :weight bold))
(add-to-list 'org-todo-keyword-faces '("MILE" :foreground "MediumVioletRed" :weight bold))
(add-to-list 'org-todo-keyword-faces '("NEXT" :foreground "green" :weight bold))
(add-to-list 'org-todo-keyword-faces '("BLOCK" :foreground "red" :weight bold))
(add-to-list 'org-todo-keyword-faces '("SENT" :foreground "green" :weight bold))
(add-to-list 'org-todo-keyword-faces '("RECIEVED" :foreground "purple" :weight bold))
(add-to-list 'org-todo-keyword-faces '("UNSENT" :foreground "green" :weight bold))
)

(setq org-roam-capture-templates
      '(("r" "bibliography reference" plain
         (file "~/.doom.d/capture_templates/org_roam/literature.org") ; <-- template store in a separate file
         :target
         (file+head "literature/${citekey}.org" "#+title: Notes on \"\\${title}\\\"")
         :unnarrowed t)
      ("d" "default" plain "%?"
        :target (file+head "roam/%<%Y%m%d%H%M%S>-${slug}.org"
                        "#+title: ${title}\n
#+STARTUP: latexpreview  ")
        :unnarrowed t))
      )

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(add-to-list 'auto-mode-alist '("\\.ino$" . cpp-mode))
