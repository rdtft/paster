(defpackage :paster
  (:use #:cl #:hunchentoot #:ironclad-system)
  (:import-from #:alexandria
                #:read-file-into-string)
  (:import-from #:mustache
                #:mustache-render-to-string)
  (:import-from #:cl-fad
                #:file-exists-p
                #:pathname-as-file)
  (:export #:start-http-server
           #:stop-http-server))
