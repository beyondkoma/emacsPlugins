;; 自动补全
   (global-set-key [f1] ' hippie-expand)
;; C-t 设置标记 
(global-set-key (kbd "C-t") 'set-mark-command)	

;;---------- redo
(global-set-key ( kbd "C-.") 'redo)	

 ;;关闭当前缓冲区 Alt+4  (init-key  C-x 0)
(global-set-key (kbd "M-4") 'delete-window)	
;;关闭其它缓冲区 Alt+1  (init-key C-x 1)
(global-set-key (kbd "M-1") 'delete-other-windows)	
;;水平分割缓冲区 Alt+2  (init-key C-x 
(global-set-key (kbd "M-2") 'split-window-vertically)	
;;垂直分割缓冲区 Alt+3  (init-key C-x 3)
(global-set-key (kbd "M-3") 'split-window-horizontally)	
;;切换到其它缓冲区 Alt+0 (init-key C-x o )
(global-set-key (kbd "M-0") 'other-window)	
	  
 ;; (global-set-key [f2] (quote shell)) ;
 (global-set-key [f2] 'shell)

 ;;显示/隐藏菜单栏 ;; M-x menu-bar-open
(global-set-key  [(f10)]'menu-bar-mode) 
(global-set-key  [(f11)]'tool-bar-mode) 

;; ibuffer
(global-set-key ( kbd "C-x C-b ")' ibuffer)


;; tabbar key-binding
(global-set-key (kbd "C-9") 'tabbar-backward-group)
(global-set-key (kbd "C-0") 'tabbar-forward-group)
(global-set-key (kbd "C--") 'tabbar-backward)
(global-set-key (kbd "C-=") 'tabbar-forward)

;; org-mode
(define-key global-map "\C-ca" 'org-agenda) 

;;;用%来实现括号之间的扩展
(global-set-key "%" 'match-paren)        


;; 注释/反注释一行或是一个区域的代码
;; 如果没有选择一个区域(region), 则注释掉/反注释当前的行
(global-set-key "\M-;" 'qiang-comment-dwim-line)


