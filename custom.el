(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((line-spacing . 0.2)
     (eval add-hook 'after-save-hook
      (lambda nil
        (if
            (y-or-n-p "Tangle?")
            (org-babel-tangle)))
      nil t)
     (eval add-hook 'after-save-hook
      (lambda nil
        (if
            (y-or-n-p "Reload?")
            (load-file user-init-file)))
      nil t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-code ((t (:inherit org-code :foreground "#7bc275"))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.4 :weight semi-bold))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.2 :weight semi-bold))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.1 :weight semi-bold))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.0 :weight semi-bold))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
 '(org-link ((t (:inherit link :foreground "maroon"))))
 '(org-list-dt ((t (:weight semi-bold :foreground "#bebebe")))))
