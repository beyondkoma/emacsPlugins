;;  emacs packet configure
  (require 'package)


(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(add-to-list 'package-archives
          '("popkit" . "http://elpa.popkit.org/packages/"))


(package-initialize)



(add-to-list 'load-path (concat  Relative-Path "util-plugin/"))
(load-file (concat  Relative-Path "util-plugin/setnu.el"))
(add-hook 'text-mode-hook 'turn-on-setnu-mode)

;;;;; tabbar mode
(load-file (concat  Relative-Path "util-plugin/tabbar.el"))
(require 'tabbar)
(tabbar-mode)
(put 'dired-find-alternate-file 'disabled nil)


;;;;;配置org-mode
  (setq load-path (cons (concat  Relative-Path "org-8.2.1/lisp")
                    load-path))
  (require 'org-install)

 (setq org-hide-leading-stars t) 
 (setq org-log-done 'time) 


;;;日程管理文件位置
(setq org-agenda-files (list  (concat Relative-Path "toDoList/TODO.org")  (concat Relative-Path"toDoList/everydayTodo.org")));;从这里读取数据用以让agendaview来进行管理
(setq org-default-notes-file "~/.notes")
(org-agenda-to-appt);;可以去掉时间戳 以用来定时提醒


;;;;;Scheme半结构化编程模式
;;;;;M-x paredit-mode 就可以自动载入这个模式。具体的操作方式可以看它的说明（按 C-h m 查看“模式帮助”）
(load-file  (concat Relative-Path "util-plugin/paredit.el"))
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)

(load-file (concat Relative-Path "sicp-scheme.el"));
;;;color -theme
(load-file (concat Relative-Path "util-plugin/koma-theme.el"));;;非常nice的theme仿vim的我只能说nice！






;; cscope
;;(require 'xcscope)			

;; add python for emacs
(load-file (concat Relative-Path "emacs-for-python/epy-init.el"))
(add-to-list 'load-path (concat Relative-Path "emacs-for-python/"))
(require 'epy-setup)      ;; It will setup other loads, it is required!
(require 'epy-python)     ;; If you want the python facilities [optional]
(require 'epy-completion) ;; If you want the autocompletion settings [optional]
(require 'epy-editing)    ;; For configurations related to editing [optional]
(require 'epy-bindings)   ;; For my suggested keybindings [optional]
(require 'epy-nose)       ;; For nose integration
(epy-setup-ipython)
;; (epy-django-snippets)
(epy-setup-checker "pyflakes %f")




;;;web -mode 
(load-file (concat Relative-Path "web-mode.el"));

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;;; window number control
(require 'switch-window)

;; ‘C-c left’    ‘C-c right’
(when (fboundp 'winner-mode)
      (winner-mode 1))




;;; emacs-async
(add-to-list 'load-path (concat Relative-Path "emacs-async/"))

;;emacs helm
(add-to-list 'load-path (concat Relative-Path "helm/"))
(require 'helm-config);

(helm-mode 1)

;; 
(add-to-list 'load-path (concat Relative-Path "avy/"))
(require  'avy)
(avy-setup-default)
