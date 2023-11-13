(defsystem "rssgen"
  :version "0.1.0"
  :author "Dmitrii Kosenkov"
  :license "MIT"
  :depends-on ("cl-who" "local-time" "alexandria")
  :description "RSS 2.0 generator"
  :homepage "https://github.com/Junker/rssgen"
  :source-control (:git "https://github.com/Junker/rssgen.git")
  :components ((:file "package")
               (:file "rssgen")))
