;; 自动补全
(global-set-key [f1] ' hippie-expand)
;; C-t 设置标记 
(global-set-key (kbd "C-t") 'set-mark-command)	
(global-set-key (kbd "C-c j") 'goto-line)	

;;---------- redo
(global-set-key ( kbd "C-.") 'redo)	

 ;;关闭当前缓冲区 Alt+4  (init-key  C-x 0)
(global-set-key (kbd "M-0") 'delete-window)	
;;关闭其它缓冲区 Alt+1  (init-key C-x 1)
(global-set-key (kbd "M-1") 'delete-other-windows)	
;;水平分割缓冲区 Alt+2  (init-key C-x 
(global-set-key (kbd "M-2") 'split-window-vertically)	
;;垂直分割缓冲区 Alt+3  (init-key C-x 3)
(global-set-key (kbd "M-3") 'split-window-horizontally)	
;;切换到其它缓冲区 Alt+0 (init-key C-x o )
;; (global-set-key (kbd "M-0") 'other-window)	

;;;window key-bound
(global-set-key (kbd "C-x o") 'switch-window)
	  
 ;; (global-set-key [f2] (quote shell)) ;
 (global-set-key [f2] 'shell)



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
;

;; helm config
(global-set-key (kbd "M-x")                          'undefined)
(global-set-key (kbd "M-x")                          'helm-M-x)
(global-set-key (kbd "C-x r b")                      'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f")                      'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-c  m") 'helm-all-mark-rings)
(global-set-key (kbd "C-c h x") 'helm-register)
(global-set-key (kbd "C-c h g") 'helm-google-suggest)





;;  windows move
(global-set-key (kbd "C-<up>") 'windmove-up)
(global-set-key (kbd "C-<down>") 'windmove-down)
(global-set-key (kbd "C-<left>") 'windmove-left)
(global-set-key (kbd "C-<right>") 'windmove-right)


;;;avy key-bindings

(global-set-key (kbd "C-'") 'avy-goto-char)
(global-set-key (kbd "C-<return>") 'avy-goto-char-2)
(global-set-key (kbd "M-g g") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(global-set-key (kbd "M-g e") 'avy-goto-word-0)


