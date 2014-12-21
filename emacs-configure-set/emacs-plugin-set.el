;;  emacs packet configure
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://elpa.gnu.org/ ") t)
          (add-to-list 'package-archives '("melpa" . "http://tromey.com/elpa/ ") t)
	  (add-to-list 'package-archives '("melpa" . "http://marmalade-repo.org/") t)
	  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/ ") t)
  )

;; yasnippet配置
(add-to-list 'load-path  (concat  Relative-Path  "yasnippet-master")) ;
(require 'yasnippet)

(yas/load-directory   (concat  Relative-Path "yasnippet-master/snippets"))
(yas/global-mode 1)
(yas/minor-mode-on) ; 以minor mode打开，这样才能配合主mode使用

;设置auto-complete
(add-to-list 'load-path   (concat  Relative-Path "auto-complete-1.3.1"))
(require 'auto-complete-config)

(defun ac-yasnippet-candidates ()
(with-no-warnings       ;; >0.6.0
(apply 'append (mapcar 'ac-yasnippet-candidate-1 (yas/get-snippet-tables)))))

(add-to-list 'ac-dictionary-directories  (concat  Relative-Path "auto-complete-1.3.1/dict"))
(ac-config-default)
(global-auto-complete-mode t)   ;全局开启auto-complete
(setq ac-use-quick-help t)     ;显示doc文档信息
(setq ac-quick-help-delay 0)
(setq ac-fuzzy-enable t)     ;输入错误时仍能匹配,需手动触发

(setq-default ac-sources '(ac-source-words-in-same-mode-buffers))     ;添加需要提示的内容
(setq-default ac-sources '(ac-source-yasnippet
ac-source-semantic
ac-source-ropemacs
ac-source-imenu
ac-source-functions
ac-source-symbols
ac-source-features
ac-source-dictionary
ac-source-abbrev
ac-source-words-in-buffer
ac-source-files-in-current-dir
ac-source-filename))

(add-hook 'emacs-lisp-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-symbols)))
(add-hook 'auto-complete-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-filename)))


(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue") ;;; 设置比上面截图中更好看的背景颜色
(define-key ac-completing-map "\M-n" 'ac-next)  ;;; 列表中通过按M-n来向下移动
(define-key ac-completing-map "\M-p" 'ac-previous)
(setq ac-auto-start 0.5)
(setq ac-dwim t)
(define-key ac-mode-map (kbd "M-q") 'auto-complete) ;



(add-to-list 'load-path (concat  Relative-Path "wangyinelisp/"))
(load-file (concat  Relative-Path "wangyinelisp/setnu.el"))
(add-hook 'text-mode-hook 'turn-on-setnu-mode)

;;;;; tabbar mode
(load-file (concat  Relative-Path "wangyinelisp/tabbar.el"))
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
(load-file  (concat Relative-Path "wangyinelisp/paredit.el"))
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)

(load-file (concat Relative-Path "sicp-scheme.el"));
;;;color -theme
(load-file (concat Relative-Path "wangyinelisp/koma-theme.el"));;;非常nice的theme仿vim的我只能说nice！

(require 'xcscope)












