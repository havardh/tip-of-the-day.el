(defconst tip-buffer-name "*tip-of-the-day*")
(defconst tip-file-name "/Users/havard/Documents/programmering/elisp/tip-of-the-day/test-file")

(defun rotate (list)
  (append (cdr list) (cons (car list) nil)))

(defun rotate-file (file)
  (let ((lines (read-lines file)))
    (delete-file file)
    (write-lines file (rotate lines))))

(defun read-lines (file)
  "Return file as list of lines"
  (interactive)
  (with-temp-buffer
    (insert-file-contents file)
    (split-string (buffer-string) "\n" t)))

(defun write-lines (file lines)
  "Writes the lines to a file"
  (interactive)
  (when lines
    (append-to-file (concat (car lines) "\n") nil file)
    (write-lines file (cdr lines))))

(defun read-first-line (file)
  (car (read-lines file)))

(defun show-tip-of-the-day nil
  (interactive)
  (split-window)
  (switch-to-buffer (get-buffer-create tip-buffer-name))
  (with-current-buffer tip-buffer-name
    (insert (read-first-line tip-file-name)))
  (rotate-file tip-file-name))

(provide 'tip-of-the-day)
