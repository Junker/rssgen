(in-package #:rssgen)

(defmacro stresc (str)
  `(str (escape-string-minimal ,str)))

(defun prepare-date (date)
  (typecase date
    (string
     (escape-string-minimal date))
    (local-time:timestamp
     (local-time:format-timestring nil date
                                   :format local-time:+rfc-1123-format+))))

(defun rss (title link description &key items
                                     language copyright managing-editor web-master pub-date
                                     last-build-date category generator docs ttl image rating
                                     text-input skip-hours skip-days)
  (with-html-output-to-string (*standard-output* nil
                               :prologue "<?xml version='1.0' encoding='utf-8'?>"
                               )
    (:rss :version "2.0"
	        (:channel (:title (stresc title))
	                  (:link (stresc link))
	                  (:description (stresc description))
	                  (when items (dolist (item items)
                                  (str item)))
                    (when language (htm (:language (stresc language))))
                    (when copyright (htm (:copyright (stresc copyright))))
                    (when managing-editor (htm (:|managingEditor| (stresc managing-editor))))
                    (when web-master (htm (:|webMaster| (stresc web-master))))
                    (when pub-date (htm (:|pubDate| (str (prepare-date pub-date)))))
                    (when last-build-date (htm (:|lastBuildDate| (str (prepare-date last-build-date)))))
                    (when generator (htm (:generator (stresc generator))))
                    (when docs (htm (:docs (stresc docs))))
                    (when ttl (htm (:ttl (str ttl))))
                    (when rating (htm (:rating (stresc rating))))
                    (when image (str image))
                    (when text-input (str text-input))
                    (when skip-hours (htm (:|skipHours| (dolist (hour (ensure-list skip-hours))
                                                          (htm (:hour (str hour)))))))
                    (when skip-days (htm (:|skipDays| (dolist (day (ensure-list skip-days))
                                                        (htm (:day (str day)))))))
                    (when category (dolist (cat (ensure-list category))
                                     (str cat)))))))

(defun rss-image (url title link &key width height description)
  (with-html-output-to-string (*standard-output* nil :prologue nil)
    (:image (:url (stresc url))
            (:title (stresc title))
            (:link (stresc link))
            (when width (htm (:width (str width))))
            (when height (htm (:height (str height))))
            (when description (htm (:description (stresc description)))))))

(defun rss-category (category &key domain)
  (with-html-output-to-string (*standard-output* nil :prologue nil)
    (:category :domain domain
               (str category))))

(defun rss-text-input (title description name link)
  (with-html-output-to-string (*standard-output* nil :prologue nil)
    (:|textInput|
      (:title (stresc title))
      (:description (stresc description))
      (:name (stresc name))
      (:link (stresc link)))))

(defun rss-item-enclosure (url length type)
  (with-html-output-to-string (*standard-output* nil :prologue nil)
    (:enclosure :url (escape-string-minimal-plus-quotes url)
                :length length
                :type type)))

(defun rss-item-source (url text)
  (with-html-output-to-string (*standard-output* nil :prologue nil)
    (:source :url url
             (str text))))

(defun rss-item-guid (guid &key perma)
  (with-html-output-to-string (*standard-output* nil :prologue nil)
    (:guid :|isPermaLink| (if perma "true" "false")
           (str guid))))

(defun rss-item-category (category &key domain)
  (rss-category category :domain domain))

(defun rss-item (title link description &key author category comments enclosure guid pub-date source)
  (with-html-output-to-string
      (*standard-output* nil :prologue nil)
    (:item
     (:title (stresc title))
     (:link (stresc link))
     (:description (stresc description))
     (when author (htm (:author (stresc author))))
     (when comments (htm (:comments (stresc comments))))
     (when enclosure (str enclosure))
     (when guid (str guid))
     (when pub-date (htm (:|pubDate| (str (prepare-date pub-date)))))
     (when source (str source))
     (when category (dolist (cat (ensure-list category))
                      (str cat))))))
