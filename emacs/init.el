; Use packages
(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

; Auto-install of use-package
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

; Use add necessaary PATHs for OS X
(when (memq window-system '(mac ns))
  (use-package exec-path-from-shell
    :ensure t
    :config
    (exec-path-from-shell-initialize)
  ))

(use-package evil
  :ensure t
  :config
  (evil-mode t)
)

; Autocomplete
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)

  (use-package company-irony
    :ensure t
    :config
    (add-to-list 'company-backends 'company-irony))

  (add-hook 'c-mode-hook 'company-mode)
  (add-hook 'c++-mode-hook 'company-mode)
)

 (use-package irony
  :ensure t
  :init
  (unless (irony--find-server-executable)
  (irony-install-server "bash -c \"cd ~/.emacs.d/elpa/irony-*/server && mkdir -p build && cd build && cmake -DCMAKE_INSTALL_PREFIX=~/.emacs.d/irony -DCMAKE_BUILD_TYPE=Release .. && make -j2 && make install\""))
  :config
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package irony-eldoc
  :ensure t
  :config
  (add-hook 'irony-mode-hook 'irony-eldoc))

 (use-package flycheck
  :ensure t
  :config
  (add-hook 'c-mode-hook 'flycheck-mode)
  (add-hook 'c++-mode-hook 'flycheck-mode))

(use-package flycheck-irony
  :ensure t
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-irony-setup)
  (add-hook 'flyckeck-mode-hook 'flycheck-irony-setup))

(use-package flycheck-pos-tip
  :ensure t
  :config
  (flycheck-pos-tip-mode))

; Project navigation
(use-package helm
  :ensure t
  :config
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  (helm-mode))

(use-package projectile
  :ensure t
  :config
  (projectile-mode))

(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))

(use-package dracula-theme
  :ensure t
  :config
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
  (load-theme 'dracula t))

(use-package key-chord
  :ensure t
  :after evil
  :init
  (setq key-chord-two-keys-delay 0.2)
  :config
  (key-chord-mode t)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  (key-chord-define evil-visual-state-map "jk" 'evil-normal-state)
  (key-chord-define evil-replace-state-map "jk" 'evil-normal-state))

; General settings
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(global-hl-line-mode)

; Stolen from rasendubi
(c-add-style "rasen"
             '("k&r"
	       (indent-tabs-mode . nil)
               (c-basic-offset . 4)
               (fill-column . 70)
               (whitespace-line-column . 100)
               (c-block-comment-prefix . "* ")
               (c-label-minimum-indentation . 0)
               (c-offsets-alist . ((case-label . +)
                                   (arglist-intro . ++)
                                   (arglist-cont-nonempty . ++)
                                   (innamespace . 0)
                                   (inline-open . 0)
                                   (inextern-lang . 0)))))

(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "rasen")))
(setq superword-mode t)
(add-hook 'prog-mode-hook
          (lambda () (modify-syntax-entry ?_ "w")))

; Set font if available.
(when (member "Terminus (TTF)" (font-family-list))
  (set-frame-font "Terminus (TTF) Medium 16" nil)
)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (key-chord dracula-theme helm flycheck-pos-tip flycheck-pos-tip-mode flycheck-irony flycheck flyckeck-irony irony evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
