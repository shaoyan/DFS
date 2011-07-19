;;������չ 
(setq load-path (cons "~/.emacs.d/lisp/" load-path))
(setq load-path (cons "~/.emacs.d/lisp/auto-complete-1.3.1" load-path))
(setq load-path (cons "~/.emacs.d/lisp/color-theme-6.6.0/" load-path))
(setq load-path (cons "~/.emacs.d/lisp/git-emacs/" load-path))
(setq load-path (cons "~/.emacs.d/lisp/auctex-11.86-e23.3-msw/site-lisp/site-start.d/" load-path))
(setq load-path (cons "~/.emacs.d/lisp/lua-mode" load-path))

(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

(require 'tabbar)
(tabbar-mode)

(require 'auto-complete)
(global-auto-complete-mode t)

(require 'shell-command)
(shell-command-completion-mode)

(require 'session)
(add-hook 'after-init-hook 'session-initialize)

(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(require 'ido)
(ido-mode t)

(require 'git-emacs)

(autoload 'thumbs "thumbs" "Preview images in a directory." t)

(desktop-save-mode 1)

(setq org-hide-leading-stars t) 
(define-key global-map "\C-ca" 'org-agenda) 
(setq org-log-done 'time)

 ;; (load "AucTeX.el" nil t t)
 ;; (load "preview-latex.el" nil t t)
 ;; (if (string-equal system-type "windows-nt")
 ;;     (require 'tex-mik))
 ;; (setq TeX-auto-save t)
 ;; (setq TeX-parse-self t)
 ;; (setq-default TeX-master nil)

(setq browse-url-browser-function 'w3m-browse-url)
 (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
 ;; optional keyboard short-cut
 (global-set-key "\C-xm" 'browse-url-at-point)
(setq w3m-use-cookies t)
(setq w3m-default-display-inline-images t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; customize the evironment variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;����Emacs Server,Ȼ����emacsclient��emacs
;;�ӿ�emacs�����ٶ�
;(server-start)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(tool-bar-mode nil)
;; '(menu-bar-mode nil)			
 '(display-time-mode t)
 '(show-paren-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))

;customize the Evironment Variables
 (set-register ?1 '(file . "~/.emacs"))

;;���е�������y/n��ʽ������yes/no��ʽ���е�����ֻ������һ����ĸ
(fset 'yes-or-no-p 'y-or-n-p)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; customize the edit habbit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;comment and uncomment 
 ;; (global-set-key [(meta   m)] 'comment-region)
 ;; (global-set-key [(meta   u)] 'uncomment-region)

;mouse editing set
 (setq mouse-yank-at-point t)

;enable use the clipboard
(setq x-select-enable-clipboard t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; customize the UI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;�ı�emacs�������ı���,��ʾbuffer������
 (setq frame-title-format "emacs-snapshot@%b")

;�к�
 (global-linum-mode t)

(set-default-font "-unknown-DejaVu Sans Mono-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1")
 (setq inhibit-startup-message t)

;�﷨����
 (global-font-lock-mode t)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;;�޸������ı����о�,3�����ؾͿ����˰�
 (setq-default line-spacing 3)

;;ָ�벻Ҫ�����ҵ��۾�����
(blink-cursor-mode -1)
(transient-mark-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ����ʹ��ϰ��
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;�趨���ӽ�β����Ҫ�������������
(setq sentence-end "\\([������]\\|����\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")

(setq default-major-mode 'text-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (setq load-path (cons "~/.emacs.d/python-mode/" load-path))
 (load "python-mode")
 (setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
 (setq interpreter-mode-alist (cons '("python" . python-mode)
                                    interpreter-mode-alist))
 (autoload 'python-mode "python-mode" "Python editing mode." t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; һЩ�Զ��庯��
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;{{{ ɾ��һЩ��ʱ��buffers����ռ�ҵ��ڴ�
(defvar my-clean-buffers-names
  '("\\*Completions" "\\*Compile-Log" "\\*.*[Oo]utput\\*$"
    "\\*Apropos" "\\*compilation" "\\*Customize" "\\*Calc""\\keywiz-scores"
    "\\*BBDB\\*" "\\*trace of SMTP" "\\*vc" "\\*cvs" "\\*keywiz"
    "\\*WoMan-Log" "\\*tramp" "\\*desktop\\*" ;;"\\*Async Shell Command"
    )
  "List of regexps matching names of buffers to kill.")

(defvar my-clean-buffers-modes
  '(help-mode );Info-mode)
  "List of modes whose buffers will be killed.")

(defun my-clean-buffers ()
  "Kill buffers as per `my-clean-buffer-list' and `my-clean-buffer-modes'."
  (interactive)
  (let (string buffname)
    (mapcar (lambda (buffer)
              (and (setq buffname (buffer-name buffer))
                   (or (catch 'found
                         (mapcar '(lambda (name)
                                    (if (string-match name buffname)
                                        (throw 'found t)))
                                 my-clean-buffers-names)
                         nil)
                       (save-excursion
                         (set-buffer buffname)
                         (catch 'found
                           (mapcar '(lambda (mode)
                                      (if (eq major-mode mode)
                                          (throw 'found t)))
                                   my-clean-buffers-modes)
                           nil)))
                   (kill-buffer buffname)
                   (setq string (concat string
                                        (and string ", ") buffname))))
            (buffer-list))
    (if string (message "����buffer: %s" string)
    ;(if string (message "Deleted: %s" string)
       (message "û�ж����buffer"))))
      ;(message "No buffers deleted"))))


;;open a new line macro
(defun my-open-new-line ()
  "open a new line after the current line"
  (interactive)
  (move-end-of-line 1)
  (newline 1))

(defun my-kill-word ()
   (interactive)
   (unless (looking-at "\\<")
     (backward-word))
   (kill-word 1))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;f1 -> f12
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (global-set-key [f1] 'tabbar-forward-group)
 ;; (global-set-key [C-f1] 'tabbar-backward-group)
 (global-set-key [f2] 'tabbar-backward-group)
 ;; (global-set-key (kbd "<f3>") 'next-buffer)
 ;; (global-set-key (kbd "<f4>") 'previous-buffer)
 (global-set-key [f3] 'other-window)         ; ��ת�� Emacs ����һ������
 (global-set-key [f4] 'delete-window) 
 (global-set-key [f11] 'menu-bar-mode) 
 (global-set-key [f12] 'kill-this-buffer)


;;Win����tabbar,ǰ�������ڲ�ͬ�ķ����л�,���������ͬ���л�
(global-set-key [(control shift tab)] 'tabbar-backward-tab)
(global-set-key [(control tab)]       'tabbar-forward-tab)

;;��Ĵ���׷���ַ���
(global-set-key (kbd "C-x r a") 'append-to-register)

;;auto-complete
(global-set-key (kbd "C-x a f") 'ac-complete-filename)
(global-set-key (kbd "C-x a w") 'ac-complete-files-in-current-dir)

;;��ݱ༭
(global-set-key (kbd "C-o") 'my-open-new-line)

(global-set-key (kbd "M-d") 'my-kill-word)

(global-set-key (kbd "C-`") 'set-mark-command)
