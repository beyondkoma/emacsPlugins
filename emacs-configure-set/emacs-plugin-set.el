	;;;;yasnippet配置
	(add-to-list 'load-path  "~/work/gitProject/emacsPlugins/emacs-configure-set/yasnippet-master") ;
(require 'yasnippet)

(yas/load-directory "~/work/gitProject/emacsPlugins/emacs-configure-set/yasnippet-master/snippets")
(yas/global-mode 1)
(yas/minor-mode-on) ; 以minor mode打开，这样才能配合主mode使用g

;设置auto-complete
(add-to-list 'load-path "~/work/gitProject/emacsPlugins/emacs-configure-set/auto-complete-1.3.1")
(require 'auto-complete-config)

(defun ac-yasnippet-candidates ()
(with-no-warnings       ;; >0.6.0
(apply 'append (mapcar 'ac-yasnippet-candidate-1 (yas/get-snippet-tables)))))

(add-to-list 'ac-dictionary-directories "~/work/gitProject/emacsPlugins/Plugin/auto-complete-1.3.1/dict")
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



(add-to-list 'load-path "~/work/gitProject/emacsPlugins/emacs-configure-set/wangyinelisp/")
(load-file "~/work/gitProject/emacsPlugins/emacs-configure-set/wangyinelisp/setnu.el")
(add-hook 'text-mode-hook 'turn-on-setnu-mode)

;;;;; tabbar mode
(load-file "~/work/gitProject/emacsPlugins/emacs-configure-set/wangyinelisp/tabbar.el")
(require 'tabbar)
(tabbar-mode)
(put 'dired-find-alternate-file 'disabled nil)


;;;;;配置org-mode
  (setq load-path (cons "~/work/gitProject/emacsPlugins/emacs-configure-set/org-8.2.1/lisp"
                    load-path))
  (require 'org-install)

 (setq org-hide-leading-stars t) 
 (setq org-log-done 'time) 


;;;日程管理文件位置
(setq org-agenda-files (list "~/work/toDoList/TODO.org" "~/work/toDoList/everydayTodo.org" ));;从这里读取数据用以让agendaview来进行管理
(setq org-default-notes-file "~/.notes")
(org-agenda-to-appt);;可以去掉时间戳 以用来定时提醒


;;;;;Scheme半结构化编程模式
;;;;;M-x paredit-mode 就可以自动载入这个模式。具体的操作方式可以看它的说明（按 C-h m 查看“模式帮助”）

(load-file "~/work/gitProject/emacsPlugins/emacs-configure-set/wangyinelisp/paredit.el")
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)

;;;;;;;;;;;;
;; Scheme 
;;;;;;;;;;;;

(require 'cmuscheme)
(setq scheme-program-name "racket")         ;; 如果用 Petite 就改成 "petite"
;; bypass the interactive question and start the default interpreter
(defun scheme-proc ()
  "Return the current Scheme process, starting one if necessary."
  (unless (and scheme-buffer
               (get-buffer scheme-buffer)
               (comint-check-proc scheme-buffer))
    (save-window-excursion
      (run-scheme scheme-program-name)))
  (or (scheme-get-process)
      (error "No current process. See variable `scheme-buffer'")))


(defun scheme-split-window ()
  (cond
   ((= 1 (count-windows))
    (delete-other-windows)
    (split-window-vertically (floor (* 0.68 (window-height))))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window 1))
   ((not (find "*scheme*"
               (mapcar (lambda (w) (buffer-name (window-buffer w)))
                       (window-list))
               :test 'equal))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window -1))))



(defun scheme-send-last-sexp-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-last-sexp))


(defun scheme-send-definition-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-definition))

(add-hook 'scheme-mode-hook
  (lambda ()
    (paredit-mode 1)
    (define-key scheme-mode-map (kbd "<f5>") 'scheme-send-last-sexp-split-window)
    (define-key scheme-mode-map (kbd "<f6>") 'scheme-send-definition-split-window)))



;; xcscope
(load-file "~/work/gitProject/emacsPlugins/emacs-configure-set/xcscope.el")
(require 'xcscope)

;;;web python 

(load-file  "~/work/gitProject/emacsPlugins/emacs-configure-set/emacs-for-python/epy-init.el")  ;; work/gitProject/emacsPlugins the emacs-for-python
(epy-setup-checker "pyflakes %f")		       ;configuring the flymake checker
;;(epy-django-snippets)				       ;adding the django snippets
(epy-setup-ipython)				       ;ipyhon integration
;(global-h1-line-mod t)				       ;line highlighting
;(set-face-background 'h1-line "black")

(require 'highlight-indentation)
(add-hook 'python-mode-hook 'highlight-indentation) ; Highlight Indentation


;;;color -theme
(load-file "~/work/gitProject/emacsPlugins/emacs-configure-set/wangyinelisp/koma-theme.el")	;;;非常nice的theme仿vim的我只能说nice！
