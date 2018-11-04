(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)
(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(windmove-default-keybindings)
(show-paren-mode +1)
(blink-cursor-mode -1)
(tool-bar-mode -1)

(eval-when-compile
  (require 'use-package))

(use-package magit
  :ensure t)

(setq-default indent-tabs-mode nil)

(use-package paredit
  :ensure t
  :pin melpa
  :config
  (progn
    (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
    (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
    (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
    (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
    (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
    (add-hook 'scheme-mode-hook           #'enable-paredit-mode)
    (add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))))

(use-package slime
  :ensure t
  :pin melpa
  :config
  (progn
    (setq slime-lisp-implementations
      '((sbcl ("/usr/local/bin/sbcl" "--dynamic-space-size" "4096") :coding-system utf-8-unix)))
    (setq slime-contribs '(slime-fancy
			   slime-highlight-edits
			   slime-autodoc
			   slime-indentation))
    (setq slime-net-coding-system 'utf-8-unix
          slime-truncate-lines nil
          slime-multiprocessing t)
    (setq lisp-lambda-list-keyword-parameter-alignment t
          lisp-lambda-list-keyword-alignment t
          lisp-align-keywords-in-calls t)
    (add-hook 'lisp-mode-hook (lambda ()
				(slime-highlight-edits-mode)))))

;;; 
(use-package tangotango-theme
  :ensure t
  :config
  (load-theme 'tangotango t))


(use-package ido
  :ensure t
  :config
  (progn
    (setq ido-enable-flex-matching t)
    (setq ido-everywhere t)
    (ido-mode 1)))

(use-package elpy
  :pin melpa
  :ensure t
  :config
  (progn
    (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)))

(use-package julia-mode
  :ensure t)

(use-package julia-repl
  :ensure t
  :config
  (progn (setq julia-repl-executable-records
               '((default "/usr/local/bin/julia")))
         (add-hook 'julia-mode-hook 'julia-repl-mode)))

(use-package flycheck
  :ensure t)

(use-package py-autopep8
  :ensure t)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "/usr/local/bin/pandoc"))


(use-package ein
  :ensure t
  :init (setq ein:jupyter-default-server-command "/usr/local/bin/jupyter"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ein markdown-mode julia-repl julia-mode flycheck py-autopep8 elpy magit tangotango-theme ido-mode solarized-theme slime paredit use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
