;;  emacs packet configure
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("popkit" . "http://elpa.popkit.org/packages/")))

;; elpy support
(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

(package-initialize)

;; elpy support
(elpy-enable)

;; ipdb adjust
(defun python-add-breakpoint ()
    "Add a break point"
    (interactive)
    (newline-and-indent)
    (insert "import ipdb; ipdb.set_trace()")
    (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))

(add-to-list 'load-path (concat  Relative-Path "util-plugin/"))

;; linum.el
(load-file (concat  Relative-Path "util-plugin/linum.el"))
(require 'linum)
(setq linum-format "%4d \u2502")

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

;; emacs helm


(require 'helm-config);

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(setq helm-autoresize-mode t)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)  ;;; fuzzy matching for fuzzy match

(semantic-mode 1)
(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match    t)

(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))


(setq helm-apropos-fuzzy-match t)

(helm-mode 1)



;; golden-ratio.el  rezise windows automatic
(load-file (concat Relative-Path "util-plugin/golden-ratio.el"));

(require 'golden-ratio)
(golden-ratio-mode 1)
(setq golden-ratio-auto-scale t)

(defun pl/helm-alive-p ()
  (if (boundp 'helm-alive-p)
      (symbol-value 'helm-alive-p)))

(add-to-list 'golden-ratio-inhibit-functions 'pl/helm-alive-p)


;; avy
(add-to-list 'load-path (concat Relative-Path "avy/"))
(require  'avy)
(avy-setup-default)



;;helm + projectile
(require 'helm-projectile)
(projectile-global-mode)		
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-switch-project-action 'helm-projectile)

;; erlang distel
;; (add-to-list 'load-path (concat Relative-Path "erl-share/distel/elisp"))
;; (require 'distel)
;; (distel-setup)

;; erlang mode

(require 'erlang-start)


