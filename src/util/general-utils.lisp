(in-package :paster)

(defun string-to-sha1-sum (s)
  (let* ((octets (babel:string-to-octets s :encoding :utf-8))
         (sequences (ironclad:digest-sequence :sha1 octets)))
    (ironclad:byte-array-to-hex-string sequences)))

(defun template-name (name)
  (concatenate 'string (string-downcase (symbol-name name)) ".mustache"))

(defun render (file &optional params)
  (let* ((layout (read-file-into-string "src/views/layout.mustache"))
         (template (read-file-into-string
                    (merge-pathnames
                     (template-name file)
                     (merge-pathnames "src/views/"))))
         (template-body (mustache-render-to-string template params)))
    (mustache-render-to-string layout `((:body . ,template-body)))))

(defun sha1-string-to-file (s)
  (let* ((dir (subseq s 0 2))
         (name (subseq s 2 40)))
    (concatenate 'string "pastes/" dir "/" name)))
