(asdf:defsystem :paster
  :serial t
  :description "simple pastebin application"
  :depends-on (:hunchentoot
               :cl-mustache
               :alexandria
               :cl-fad
               :ironclad)
  :components ((:file "package")
               (:module :src
                        :serial t
                        :components
                        ((:module :util
                                  :serial t
                                  :components ((:file "general-utils")
                                               (:file "macro-utils")
                                               (:file "hunchentoot-utils")))
                         (:file "controller")))))
