(in-package :paster)

(setq hunchentoot:*dispatch-table*
      (list (hunchentoot:create-regex-dispatcher "^/$" 'index)
            (hunchentoot:create-regex-dispatcher "^/new$" 'new)
            (hunchentoot:create-regex-dispatcher "^/create$" 'create)
            (hunchentoot:create-regex-dispatcher "^/[a-fA-F0-9]{40}/raw$" (lambda () (show :raw t)))
            (hunchentoot:create-regex-dispatcher "^/[a-fA-F0-9]{40}$" 'show)))

(defun index ()
  (if (file-exists-p #P"pastes/public")
      (render :index `((:pastes ,@(reverse (read-file-into-list "pastes/public")))))
      (render :index)))

(defun new ()
  (render :new))

(defun show (&key (raw nil))
  (let ((sha1-file (sha1-string-to-file (subseq (request-uri*) 1 41))))
    (unless (file-exists-p sha1-file)
      (return-404))
    (let ((data (read-from-string (read-file-into-string sha1-file :external-format :utf-8))))
      (if raw
          (render-raw (cdr (assoc :body data)))
          (render :show data)))))

(defun create ()
  (let ((private (post-parameter "private"))
        (lang (post-parameter "lang"))
        (paste (post-parameter "paste")))
    (if (string= "" paste)
        (render :new '((:errors . ((:error . "Paste is required")))))
        (let* ((sha1-string (string-to-sha1-sum paste))
               (sha1-file (sha1-string-to-file sha1-string)))

          (with-open-or-create-file
              sha1-file out
              (print `((:lang . ,lang)
                       (:private . ,(and private t))
                       (:body . ,paste)) out))
          (unless private
            (with-create-or-append-file
                "pastes/public" out
                (format out "~a~%" sha1-string)))

          (redirect (concatenate 'string "/" sha1-string ))))))
