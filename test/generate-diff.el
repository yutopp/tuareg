(require 'subr-x) ; >= emacs 24.4

(setq indent-tabs-mode nil)
(setq make-backup-files nil)
(setq message-log-max nil)
(defun ask-user-about-lock (file opponent) nil) ; Disable an interactive function

(let* ((gen-file-suffix ".generated.test")
       (diff-file-suffix ".diff")
       (files (with-temp-buffer
                (insert-file-contents "/dev/stdin")
                (split-string (string-trim (buffer-string)) " +"))))
  ;; TODO: Parallelize
  (dolist (file files)
    (let ((gen-file (concat file gen-file-suffix))
          (diff-file (concat file diff-file-suffix)))
      (with-temp-buffer
        ;; Indent a source-code by yuareg
        (yuareg-mode)
        (insert-file-contents file)
        (indent-region (point-min) (point-max) nil)
        ;; Output
        (write-file gen-file)
        ;; Take a diff
        (let* ((cmd (concat "diff " (shell-quote-argument file) " " (shell-quote-argument gen-file)))
               (result (shell-command-to-string cmd)))
          (erase-buffer)
          (if (string= result "")
              (princ (format "\x1b[32m✔\x1b[0m %s\n" file))
            (princ (format "\x1b[31m×\x1b[0m %s\n" file))
            (princ (format "%s" result))
            )
          (insert result)
          (write-file diff-file))))))
