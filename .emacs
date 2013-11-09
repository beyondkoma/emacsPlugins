(setq byte-compile-warnings nil)

;;;;;;;;;;cedet插件设置
(add-to-list 'load-path "~/install/cedet-1.1/eieio")
(add-to-list 'load-path "~/install/cedet-1.1/semantic")
(add-to-list 'load-path "~/install/cedt-1.1/common")
(load-file "~/install/cedet-1.1/common/cedet.el")
(require 'cedet)


;;;; CC-mode配置  http://cc-mode.sourceforge.net/
(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)


;; Enable EDE (Project Management) features
;; (global-ede-mode 1)
 
;(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
;;(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)
 
;; Enable SRecode (Template management) minor-mode.
;;(global-srecode-minor-mode 1)

;;;;yasnippet配置
(add-to-list 'load-path  "~/install/yasnippet-master")
(require 'yasnippet)

(yas/load-directory "~/install/yasnippet-master/snippets")
(yas/global-mode 1)
(yas/minor-mode-on) ; 以minor mode打开，这样才能配合主mode使用

;设置auto-complete
(add-to-list 'load-path "~/install/auto-complete-1.3.1")
(require 'auto-complete-config)

(defun ac-yasnippet-candidates ()
(with-no-warnings
;; >0.6.0
(apply 'append (mapcar 'ac-yasnippet-candidate-1 (yas/get-snippet-tables)))))

(add-to-list 'ac-dictionary-directories "~/install/auto-complete-1.3.1/dict")
(ac-config-default)
;全局开启auto-complete
(global-auto-complete-mode t)
;显示doc文档信息
(setq ac-use-quick-help t)
(setq ac-quick-help-delay 0)
;输入错误时仍能匹配,需手动触发
(setq ac-fuzzy-enable t)   
;添加需要提示的内容
(setq-default ac-sources '(ac-source-words-in-same-mode-buffers))
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


;; (setq-default ac-sources '(ac-source-words-in-same-mode-buffers))
;; (add-hook 'emacs-lisp-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-symbols)))
;; (add-hook 'auto-complete-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-filename)))

(global-set-key (kbd "M-[") 'auto-complete)
(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue") ;;; 设置比上面截图中更好看的背景颜色
(define-key ac-completing-map "\M-n" 'ac-next)  ;;; 列表中通过按M-n来向下移动
(define-key ac-completing-map "\M-p" 'ac-previous)
(setq ac-auto-start 0.5)
(setq ac-dwim t)
(define-key ac-mode-map (kbd "M-/") 'auto-complete)



(global-set-key [f4] 'semantic-ia-fast-jump)
(global-set-key [S-f4]
                (lambda ()
                  (interactive)
                  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                      (error "Semantic Bookmark ring is currently empty"))
                  (let* ((ring (oref semantic-mru-bookmark-ring ring))
                         (alist (semantic-mrub-ring-to-assoc-list ring))
                         (first (cdr (car alist))))
                    (if (semantic-equivalent-tag-p (oref first tag)
                                                   (semantic-current-tag))
                        (setq first (cdr (car (cdr alist)))))
                    (semantic-mrub-switch-tags first))))

(define-key c-mode-base-map [M-S-f12] 'semantic-analyze-proto-impl-toggle)
(define-key c-mode-base-map [(f5)] 'compile)


 ;;;;;代码折叠
(require 'semantic-tag-folding nil 'noerror)
(global-semantic-tag-folding-mode 1)
(define-key semantic-tag-folding-mode-map (kbd "C-x q") 'semantic-tag-folding-fold-block)
(define-key semantic-tag-folding-mode-map (kbd "C-x w") 'semantic-tag-folding-show-block)


(define-key semantic-tag-folding-mode-map (kbd "C-_") 'semantic-tag-folding-fold-all)
(define-key semantic-tag-folding-mode-map (kbd "C-+") 'semantic-tag-folding-show-all)


;; ;;;h/cpp切换
(require 'eassist nil 'noerror)
(define-key c-mode-base-map [M-f12] 'eassist-switch-h-cpp)
(setq eassist-header-switches
      '(("h" . ("cpp" "cxx" "c++" "CC" "cc" "C" "c" "mm" "m"))
        ("hh" . ("cc" "CC" "cpp" "cxx" "c++" "C"))
        ("hpp" . ("cpp" "cxx" "c++" "cc" "CC" "C"))
        ("hxx" . ("cxx" "cpp" "c++" "cc" "CC" "C"))
        ("h++" . ("c++" "cpp" "cxx" "cc" "CC" "C"))
        ("H" . ("C" "CC" "cc" "cpp" "cxx" "c++" "mm" "m"))
        ("HH" . ("CC" "cc" "C" "cpp" "cxx" "c++"))
        ("cpp" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
        ("cxx" . ("hxx" "hpp" "h++" "HH" "hh" "H" "h"))
        ("c++" . ("h++" "hpp" "hxx" "HH" "hh" "H" "h"))
        ("CC" . ("HH" "hh" "hpp" "hxx" "h++" "H" "h"))
        ("cc" . ("hh" "HH" "hpp" "hxx" "h++" "H" "h"))
        ("C" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
        ("c" . ("h"))
        ("m" . ("h"))
        ("mm" . ("h"))))


(setq semanticdb-project-roots (list "/"))
;; ;;;; Include settings

(defconst cedet-user-include-dirs
  (list ".." "../include" "../inc" "../common" "../public" "."
        "../.." "../../include" "../../inc" "../../common" "../../public"))

(setq cedet-sys-include-dirs (list
			      "lib"
			      "/usr/lib"
                             "/usr/include"
                              "/usr/include/bits"
			      "/usr/include/c++/4.7"
                              "/usr/include/glib-2.0"
                              "/usr/include/i386-linux-gnu/c++/4.7/."
                              "/usr/include/c++/4.7/backward"
			      "/usr/lib/gcc/i686-linux-gnu/4.7/include"
			      "/usr/lib/gcc/i686-linux-gnu/4.7/include-fixed"
			      "/usr/include/i386-linux-gnu"		        
                              "/usr/local/include"))
(require 'semantic-c nil 'noerror)
(let ((include-dirs cedet-user-include-dirs))
  (setq include-dirs (append include-dirs cedet-sys-include-dirs))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))

(setq semantic-c-dependency-system-include-path "/usr/include/")


;; ;;;;为了安装ecb！
(setq stack-trace-on-error t)

(add-to-list 'load-path "~/install/ecb-2.40")
(load-file "~/install/ecb-2.40/ecb.el")
(require 'ecb-autoloads)
(setq ecb-tip-of-the-day nil)  ;;;;防止弹友好提示框

;;;(global-set-key [(f7)] 'speedbar) 显示与当前工作目录相关的窗口



(global-set-key [f1] 'hippie-expand)
(setq hippie-expand-try-functions-list 
      '(try-expand-dabbrev
	try-expand-dabbrev-visible
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-file-name-partially
	try-complete-file-name
	try-expand-all-abbrevs
	try-expand-list
	try-expand-line
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol))


;; 外观设置  	;;;http://i.linuxtoy.org/docs/guide/ch25s04.html
;;========================================
   
(tool-bar-mode nil)  ;;禁用工具栏

(menu-bar-mode nil)  ;;禁用菜单栏

(scroll-bar-mode nil) ;;禁用滚动栏，用鼠标滚轮代替

(setq inhibit-startup-message t) ;;禁用启动画面

(setq default-directory "~/")    ;;设置打开文件的默认路径

(auto-image-file-mode)		 ;;让emas可以直接打开和显示图片


(load-file "~/install/wangyinelisp/koma-theme.el")	;;;非常nice的theme仿vim的我只能说nice！
;;========================================
;; 键值绑定
;;========================================



(global-set-key (kbd "C-t") 'set-mark-command)	;; C-t 设置标记 

(global-set-key ( kbd "C-.") 'redo)	;;---------- redo

;;========================================

(global-set-key (kbd "M-4") 'delete-window)	 ;;关闭当前缓冲区 Alt+4  (init-key  C-x 0)
(global-set-key (kbd "M-1") 'delete-other-windows)	;;关闭其它缓冲区 Alt+1  (init-key C-x 1)
(global-set-key (kbd "M-2") 'split-window-vertically)	;;水平分割缓冲区 Alt+2  (init-key C-x 
(global-set-key (kbd "M-3") 'split-window-horizontally)	;;垂直分割缓冲区 Alt+3  (init-key C-x 3)
(global-set-key (kbd "M-0") 'other-window)	;;切换到其它缓冲区 Alt+0 (init-key C-x o )
	  
 (global-set-key [f2] (quote shell)) ;
;;F10
 ;;显示/隐藏菜单栏 ;; M-x menu-bar-open
(global-set-key  [(f10)]'menu-bar-mode) 
(global-set-key  [(f11)]'tool-bar-mode) 


;;========================================
;; 缓冲区
;;========================================

;;设定行距
(setq default-line-spacing 0)

;;页宽 
(setq default-fill-column 90)

;;缺省模式 text-mode
;;(setq default-major-mode 'text-mode)

;;设置删除纪录
(setq kill-ring-max 200)

;;以空行结束
(setq require-final-newline t) 

;;语法加亮
(global-font-lock-mode t)

;;高亮显示区域选择
(transient-mark-mode t)

;;页面平滑滚动， scroll-margin 5 靠近屏幕边沿3行时开始滚动，可以很好的看到上下文。
(setq scroll-margin 5
      scroll-conservatively 10000)


;高亮显示成对括号，但不来回弹跳
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;; 鼠标指针规避光标
(mouse-avoidance-mode 'animate)

;;粘贴于光标处，而不是鼠标指针处
(setq mouse-yank-at-point t)

;;========================================
;; 回显区
;;========================================

;;闪屏报警
(setq visible-bell t)

;;使用 y or n 提问
(fset 'yes-or-no-p 'y-or-n-p)

;;锁定行高
(setq resize-mini-windows nil)

;;递归 minibuffer
(setq enable-recursive-minibuffers t)

;; 当使用 M-x COMMAND 后，过 1 秒钟显示该 COMMAND 绑定的键。
;;(setq suggest-key-bindings 1) ;;

;;========================================
;; 状态栏
;;========================================

;;显示时间
(display-time)
;;时间格式
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-interval 10)

;;显示列号
(setq column-number-mode t)

;;标题栏显示 %f 缓冲区完整路径 %p 页面百分数 %l 行号
;; (setq frame-title-format "%f")
(setq frame-title-format "beyondkoma@%b");

;;========================================
;; 编辑器设定
;;========================================


;;;设置个人信息
(setq user-full-name "beyondkoma")
(setq user-mail-address "hn1lightning@gmail.com")


;;;;;让dired可以递归的拷贝和删除目录
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)


;;只渲染当前屏幕语法高亮，加快显示速度
(setq font-lock-maximum-decoration t)

;; 将错误信息显示在回显区
(condition-case err
   (progn
   (require 'xxx) )
 (error
  (message "Can't load xxx-mode %s" (cdr err))))

;;使用X剪贴板
(setq x-select-enable-clipboard t) 

;;;;;;;; 使用空格缩进 ;;;;;;;;
;; indent-tabs-mode  t 使用 TAB 作格式化字符  nil 使用空格作格式化字符
(setq indent-tabs-mode nil)
(setq tab-always-indent nil)
(setq tab-width 4)
	        
;;========================================
;; 字体设置
;;========================================

(set-default-font "Monospace-10")
(if window-system
   (set-fontset-font (frame-parameter nil 'font)
	  'unicode '("Microsoft YaHei" . "unicode-bmp"))
)


;;========================================
;; 必备扩展 
;;========================================

;; menu设置为12 lines
(setq ac-menu-height 12)(add-hook 'c-mode-common-hook '(lambda ()

         (add-to-list 'ac-omni-completion-sources
                       (cons "\\." '(ac-source-semantic)))
          (add-to-list 'ac-omni-completion-sources
                       (cons "->" '(ac-source-semantic)))
          (setq ac-sources '(ac-source-semantic ac-source-yasnippet))
  ))

;;;;go to char 命令 ctrl-x a
(define-key global-map (kbd "C-x a") 'wy-go-to-char)
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))




;;;
(add-to-list 'load-path "~/install/wangyinelisp/")
(load-file "~/install/wangyinelisp/setnu.el")
(add-hook 'text-mode-hook 'turn-on-setnu-mode)

;;;;;
(load-file "~/install/wangyinelisp/tabbar.el")
(require 'tabbar)
(tabbar-mode)
(global-set-key (kbd "C-9") 'tabbar-backward-group)
(global-set-key (kbd "C-0") 'tabbar-forward-group)
(global-set-key (kbd "C--") 'tabbar-backward)
(global-set-key (kbd "C-=") 'tabbar-forward)
(put 'dired-find-alternate-file 'disabled nil)





;; 桌面缓存功能，不知道怎么回事没有起作用
(load "desktop") 
(desktop-load-default)
(desktop-read)


;;;session扩展功能为修改过的文件和最近的操作过的文件。
(load-file "~/install/wangyinelisp/session.el")
(require 'session)
  (add-hook 'after-init-hook 'session-initialize)


;;========== ibuffer
(require 'ibuffer)
(global-set-key ( kbd "C-x C-b ")' ibuffer)


;;========== outline
(setq outline-minor-mode-prefix [(control o)])


;;;;;配置org-mode
  (setq load-path (cons "~/install/org-8.2.1/lisp"
                    load-path))
  (require 'org-install)

 (setq org-hide-leading-stars t) 
 (define-key global-map "\C-ca" 'org-agenda) 
 (setq org-log-done 'time) 


;;;日程管理文件位置
(setq org-agenda-files (list "~/work/ToDoList/TODO.org" "~/work/ToDoList/everydayTodo.org" ));;从这里读取数据用以让agendaview来进行管理
(setq org-default-notes-file "~/.notes")
;; (define-key global-map [f2] 'org-remember) 出错了以后在修复吧
(org-agenda-to-appt);;可以去掉时间戳 以用来定时提醒
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; 以下为实现 redo 的代码 ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'redo)
(defvar redo-version "1.02"
  "Version number for the Redo package.")
(defvar last-buffer-undo-list nil
  "The head of buffer-undo-list at the last time an undo or redo was done.")
(make-variable-buffer-local 'last-buffer-undo-list)

(make-variable-buffer-local 'pending-undo-list)

;; Emacs 20 variable
(defvar undo-in-progress)
(defun redo (&optional count)
  "Redo the the most recent undo.
Prefix arg COUNT means redo the COUNT most recent undos.
If you have modified the buffer since the last redo or undo,
then you cannot redo any undos before then."
  (interactive "*p")
  (if (eq buffer-undo-list t)
      (error "No undo information in this buffer"))
  (if (eq last-buffer-undo-list nil)
      (error "No undos to redo"))
  (or (eq last-buffer-undo-list buffer-undo-list)
      ;; skip one undo boundary and all point setting commands up
      ;; until the next undo boundary and try again.
      (let ((p buffer-undo-list))
	(and (null (car-safe p)) (setq p (cdr-safe p)))
	(while (and p (integerp (car-safe p)))
	  (setq p (cdr-safe p)))
	(eq last-buffer-undo-list p))
      (error "Buffer modified since last undo/redo, cannot redo"))
  (and (or (eq buffer-undo-list pending-undo-list)
	   (eq (cdr buffer-undo-list) pending-undo-list))
       (error "No further undos to redo in this buffer"))
  (or (eq (selected-window) (minibuffer-window))
      (message "Redo..."))
  (let ((modified (buffer-modified-p))
	(undo-in-progress t)
	(recent-save (recent-auto-save-p))
	(old-undo-list buffer-undo-list)
	(p (cdr buffer-undo-list))
	(records-between 0))
    ;; count the number of undo records between the head of the
    ;; undo chain and the pointer to the next change.  Note that
    ;; by `record' we mean clumps of change records, not the
    ;; boundary records.  The number of records will always be a
    ;; multiple of 2, because an undo moves the pending pointer
    ;; forward one record and prepend a record to the head of the
    ;; chain.  Thus the separation always increases by two.  When
    ;; we decrease it we will decrease it by a multiple of 2
    ;; also.
    (while p
      (cond ((eq p pending-undo-list)
	     (setq p nil))
	    ((null (car p))
	     (setq records-between (1+ records-between))
	     (setq p (cdr p)))
	    (t
	     (setq p (cdr p)))))
    ;; we're off by one if pending pointer is nil, because there
    ;; was no boundary record in front of it to count.
    (and (null pending-undo-list)
	 (setq records-between (1+ records-between)))
    ;; don't allow the user to redo more undos than exist.
    ;; only half the records between the list head and the pending
    ;; pointer are undos that are a part of this command chain.
    (setq count (min (/ records-between 2) count)
	  p (primitive-undo (1+ count) buffer-undo-list))
    (if (eq p old-undo-list)
            nil ;; nothing happened
      ;; set buffer-undo-list to the new undo list.  if has been
      ;; shortened by `count' records.
      (setq buffer-undo-list p)
      ;; primitive-undo returns a list without a leading undo
      ;; boundary.  add one.
      (undo-boundary)
      ;; now move the pending pointer backward in the undo list
      ;; to reflect the redo.  sure would be nice if this list
      ;; were doubly linked, but no... so we have to run down the
      ;; list from the head and stop at the right place.
      (let ((n (- records-between count)))
	(setq p (cdr old-undo-list))
	(while (and p (> n 0))
	  (if (null (car p))
	      (setq n (1- n)))
	  (setq p (cdr p)))
	(setq pending-undo-list p)))
    (and modified (not (buffer-modified-p))
	 (delete-auto-save-file-if-necessary recent-save))
    (or (eq (selected-window) (minibuffer-window))
	(message "Redo!"))
    (setq last-buffer-undo-list buffer-undo-list)))

(defun undo (&optional arg)
  "Undo some previous changes.
Repeat this command to undo more changes.
A numeric argument serves as a repeat count."
  (interactive "*p")
  (let ((modified (buffer-modified-p))
	(recent-save (recent-auto-save-p)))
    (or (eq (selected-window) (minibuffer-window))
	(message "Undo..."))
    (or (eq last-buffer-undo-list buffer-undo-list)
	;; skip one undo boundary and all point setting commands up
	;; until the next undo boundary and try again.
	(let ((p buffer-undo-list))
	  (and (null (car-safe p)) (setq p (cdr-safe p)))
	  (while (and p (integerp (car-safe p)))
	    (setq p (cdr-safe p)))
	  (eq last-buffer-undo-list p))
	(progn (undo-start)
	       (undo-more 1)))
    (undo-more (or arg 1))
    ;; Don't specify a position in the undo record for the undo command.
    ;; Instead, undoing this should move point to where the change is.
    ;;
    ;;;; The old code for this was mad!  It deleted all set-point
    ;;;; references to the position from the whole undo list,
    ;;;; instead of just the cells from the beginning to the next
    ;;;; undo boundary.  This does what I think the other code
    ;;;; meant to do.
    (let ((list buffer-undo-list)
    	  (prev nil))
      (while (and list (not (null (car list))))
    	(if (integerp (car list))
    	    (if prev
    		(setcdr prev (cdr list))
    	      ;; impossible now, but maybe not in the future 
    	      (setq buffer-undo-list (cdr list))))
    	(setq prev list
    	      list (cdr list))))
    (and modified (not (buffer-modified-p))
	 (delete-auto-save-file-if-necessary recent-save)))
  (or (eq (selected-window) (minibuffer-window))
      (message "Undo!"))
  (setq last-buffer-undo-list buffer-undo-list))

	  


;;;;开启stardict词典
     
     (load-file "~/install/wangyinelisp/stardict.el")	
     (require 'stardict)
     (global-set-key (kbd "C-c d") 'view-stardict-in-buffer)


;;;;;Scheme半结构化编程模式
;;;;;M-x paredit-mode 就可以自动载入这个模式。具体的操作方式可以看它的说明（按 C-h m 查看“模式帮助”）
(load-file "~/install/wangyinelisp/paredit.el")
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)

;;;;;;
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


	
;; 注释/反注释一行或是一个区域的代码
;; 如果没有选择一个区域(region), 则注释掉/反注释当前的行
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line)


;;;用%来实现括号之间的扩展
(global-set-key "%" 'match-paren)        
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))


;; ;;;;;;实现在文件中设置临时标记以用来来回跳转
(global-set-key [(control ?\,)] 'ska-point-to-register)
(global-set-key [(control ?\;)] 'ska-jump-to-register)
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register. 
Use ska-jump-to-register to jump back to the stored 
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
        (jump-to-register 8)
        (set-register 8 tmp)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-time-mode t)
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(send-mail-function nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
