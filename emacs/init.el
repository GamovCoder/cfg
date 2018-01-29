; Customization.
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))


(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(require 'evil)
(evil-mode 1)

(set-frame-font "Terminus (TTF) Medium 16" nil t)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(global-hl-line-mode)

(fset 'yes-or-no-p 'y-or-n-p)

(setq evil-magit-state 'motion)
(require 'evil-magit)

(global-set-key (kbd "C-x g") 'magit-status)

; CMake Mode
(use-package cmake-mode
  :mode ("^CMakeLists\\.txt$" . cmake-mode)
  :config
  (setq cmake-tab-width 4)
  (use-package cmake-font-lock)
  (use-package company-cmake))

(require 'powerline)
(powerline-evil-center-color-theme)

(use-package key-chord
  :after evil
  :config
  (key-chord-mode 1)
  (key-chord-define-global "jk" 'evil-force-normal-state)
  (key-chord-define-global "[]" 'whitespace-cleanup))

(use-package helm-projectile
  :commands (helm-projectile-switch-to-buffer
             helm-projectile-find-dir
             helm-projectile-dired-find-dir
             helm-projectile-recentf
             helm-projectile-find-file
             helm-projectile-grep
             helm-projectile
             helm-projectile-switch-project)
  :init
  (helm-projectile-on)
  (global-set-key (kbd "C-c p p")
                  'helm-projectile)
  :config
  (helm-projectile-on))

(use-package helm
  :init
  (global-set-key (kbd "C-x C-b") 'helm-mini)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-h") 'helm-command-prefix)
  :config
  (require 'helm-config)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (helm-mode 1)
)

(use-package projectile
  :commands (projectile-ack
             projectile-ag
             projectile-compile-project
             projectile-run-project
             projectile-dired
             projectile-grep
             projectile-find-dir
             projectile-find-file
             projectile-find-tag
             projectile-find-test-file
             projectile-invalidate-cache
             projectile-kill-buffers
             projectile-multi-occur
             projectile-project-root
             projectile-recentf
             projectile-regenerate-tags
             projectile-register-project-type
             projectile-replace
             projectile-run-async-shell-command-in-root
             projectile-run-shell-command-in-root
             projectile-switch-project
             projectile-switch-to-buffer
             projectile-vc)
  :diminish projectile-mode
  :config
  ;; Use prefix arg, is you want to change compilation command
  ;;(setq compilation-read-command nil)

  (projectile-global-mode)
  (setq projectile-completion-system 'helm))

(global-set-key (kbd "<f9>") 'projectile-compile-project)
(global-set-key (kbd "<f8>") 'projectile-test-project)
(global-set-key (kbd "<f7>") 'projectile-run-project)

(setq compilation-read-command nil)
(setq projectile-project-compilation-cmd  "mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug .. && make")

(require 'yasnippet)
(yas-global-mode 1)

(require 'auto-complete)
(require 'auto-complete-config)


(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'architect t)


(setq-default indent-tabs-mode nil)
(add-to-list 'projectile-globally-ignored-directories "build")
(add-to-list 'projectile-globally-ignored-directories "target")

;; Tramp mode
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(enable-remote-dir-locals t nil (tramp) "Enable remote dir locals files")
 '(package-selected-packages
   (quote
    (edit-server exec-path-from-shell rust-mode key-chord evil-magit magit ac-ispell helm-ispell ycmd evil use-package powerline-evil php-mode markdown-mode helm-projectile flycheck-ycmd company-ycmd company-ycm cmake-mode auto-complete-clang-async auto-complete-clang ac-clang)))
 '(password-cache t nil (tramp) "Cache Passwords")
 '(password-cache-expiry nil nil (tramp) "Password expiration is off")
 '(safe-local-variable-values
   (quote
    ((projectile-project-run-cmd . "rm -rf build && rm main*")
     (projectile-project-run-cmd . "rm -rf build && rm report*")
     (projectile-project-test-cmd . "open main.pdf")
     (projectile-project-compilation-cmd . "mkdir -p build && cd build && cmake -Dwithout_report=ON -DCMAKE_BUILD_TYPE=Debug .. && make")
     (projectile-project-compilation-cmd . "mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug -Dwithout_report=ON .. && make")
     (projectile-project-test-cmd . "open report.pdf")
     (projectile-project-run-cmd . "rm -rf build report.pdf report.aux report.log")
     (projectile-project-test-cmd . "ls")
     (projectile-project-test-cmd . "mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DWITH_TESTS=ON .. && make && make test")
     (projectile-project-test-cmd . "mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DWITH_TESTS=ON .. && make -j2 && make test")
     (projectile-project-run-cmd . "rm -rf build")
     (projectile-project-test-cmd . "mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DWITH_TESTS=ON .. && make test")
     (projectile-project-compilation-cmd . "mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug .. && make")
     (projectile-project-compilation-cmd . "mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DWITH_TESTS=ON .. && make")
     (projectile-project-compilation-cmd . "mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DWITH_TEST=ON .. && make")
     (compilation-read-command)
     (projectile-project-run-cmd . "cargo run")
     (projectile-project-compilation-cmd . "cargo build")
     (projectile-project-run-cmd . "cd build && make test")
     (projectile-project-compilation-cmd . "mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DWITH_TESTS=ON .. && make -j4"))))
 '(tramp-default-method "ssh" nil (tramp) "Default connection mode now is ssh"))

(add-to-list 'tramp-default-user-alist
             '("ssh" "10.2.15.157" "architec"))


(require 'edit-server)
(edit-server-start)

(setq superword-mode t)
(add-hook 'prog-mode-hook
          (lambda () (modify-syntax-entry ?_ "w"))) ;;underscore as a part of the word
(add-hook 'prog-mode-hook (lambda() (setq electric-indent-mode t)))

(add-hook 'prog-mode-hook (lambda() (setq c-basic-offset 4)))

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(global-set-key (kbd "M-+") 'other-window)
(setq-default ispell-program-name "/usr/local/bin/ispell")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
