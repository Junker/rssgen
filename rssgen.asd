(defsystem "rssgen"
  :version "0.1.0"
  :author "Dmitrii Kosenkov"
  :license "MIT"
  :depends-on ("cl-who" "local-time" "alexandria")
  :description "RSS 2.0 generator"
  :components ((:file "package")
               (:file "rssgen")))
