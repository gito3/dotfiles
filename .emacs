(setq display-line-numbers-type 'relative)
(setq inhibit-startup-screen t)
(setq-default indent-tabs-mode nil)
(setq make-backup-files nil)
(setq dired-kill-when-opening-new-dired-buffer t)
(setq kill-whole-line t)
(global-set-key (kbd "TAB") (lambda () (interactive) (insert-char 32 2)))
(global-set-key (kbd "C-x C-k") 'kill-current-buffer)
(global-set-key (kbd "<C-tab>") 'next-buffer)
(global-display-line-numbers-mode)
(tool-bar-mode 0)
(menu-bar-mode 0)
(context-menu-mode 0)
(scroll-bar-mode 0)
(set-face-attribute 'default nil :height 165)
(add-to-list 'default-frame-alist '(undecorated . t))
(ido-mode)
(ido-everywhere)

(setq-default switch-to-prev-buffer-skip-regexp "\\*\\(Messages\\|magit-.*\\|Help\\)\\*")

(with-eval-after-load 'magit
  (define-key magit-mode-map (kbd "<C-tab>") nil)
  (define-key magit-section-mode-map (kbd "<C-tab>") nil))

(add-hook 'magit-process-terminated-hook
          (lambda (proc _evt)
            (when (and (eq (process-status proc) 'exit) (zerop (process-exit-status proc)))
              (kill-buffer (process-buffer proc)))))

(setq magit-bury-buffer-function #'magit-mode-quit-window)

(setq-default mode-line-format
      '("%e "
        (:propertize "%b" face (:weight bold :foreground "#51afef"))
        (:propertize " " display (space :align-to (+ center -15)))
        " "
        (:eval (mapconcat #'buffer-name 
                          (seq-filter (lambda (b) 
                                        (let ((n (buffer-name b)))
                                          (and (not (eq b (current-buffer)))
                                               (not (string-prefix-p " " n))
                                               (or (not (string-prefix-p "*" n))
                                                   (string-match-p "\\*\\(scratch\\|.*[a-zA-Z].*\\)\\*" n))
                                               (not (string-match-p "\\*\\(Messages\\|magit-.*\\|Help\\)\\*" n)))))
                                      (buffer-list)) " | "))))

;; Auto installers for Gruber-Darker, Magit, & Multiple Cursors.
;; --- Package System Setup ---
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install use-package if it's not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t) ; Automatically download packages

;; --- UI / Theme ---
(use-package gruber-darker-theme
  :config
  (load-theme 'gruber-darker t))

;; --- Git Configuration ---
(use-package magit
  :bind ("C-x g" . magit-status)
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; --- Multiple Cursors Configuration ---
(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->"         . mc/mark-next-like-this)
         ("C-<"         . mc/mark-previous-like-this)
         ("C-c C-<"     . mc/mark-all-like-this)
         ("C-S-<mouse-1>" . mc/add-cursor-on-click)))

;; --- Custom Generated Variables (Keep at bottom) ---
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(gruber-darker-theme magit multiple-cursors)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
