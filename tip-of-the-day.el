; Tip of the day
;
; Shows a new tip of the day for each time emacs is opened.
;
; Usage:
;   Append this to the end of your .emacs file
;
;   (load-file "<path-to-this-file>")
;   (require 'tip-of-the-day)
;   (show-and-rotate-tip-of-the-day "<path-to-tip-file>")

(defconst tip-buffer-name "*tip-of-the-day*")

(defun show-and-rotate-tip-of-the-day (file)
  "Opens a buffer with the tip of the day and rotates the tip file"
  (interactive)
  (split-window)
  (switch-to-buffer (get-buffer-create tip-buffer-name))
  (with-current-buffer tip-buffer-name
    (insert (read-first-line file)))
  (rotate-file file))

(defun read-first-line (file)
  "Read the first line from a file"
  (car (read-lines file)))

(defun rotate-file (file)
  "Rotates a file"
  (let ((lines (read-lines file)))
    (delete-file file)
    (write-lines file (rotate lines))))

(defun read-lines (file)
  "Return file as list of lines"
  (with-temp-buffer
    (insert-file-contents file)
    (split-string (buffer-string) "\n" t)))

(defun rotate (list)
  "Rotates a list left"
  (append (cdr list) (cons (car list) nil)))

(defun write-lines (file lines)
  "Writes the lines to a file"
  (when lines
    (append-to-file (concat (car lines) "\n") nil file)
    (write-lines file (cdr lines))))

(provide 'tip-of-the-day)
