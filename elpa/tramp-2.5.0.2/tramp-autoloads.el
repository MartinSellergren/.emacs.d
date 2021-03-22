;;; tramp-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "tramp-adb" "tramp-adb.el" (0 0 0 0))
;;; Generated autoloads from tramp-adb.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "tramp-adb" '("tramp-")))

;;;***

;;;### (autoloads nil "tramp-archive" "tramp-archive.el" (0 0 0 0))
;;; Generated autoloads from tramp-archive.el

(defvar tramp-archive-enabled (featurep 'dbusbind) "\
Non-nil when file archive support is available.")

(defconst tramp-archive-suffixes '("7z" "apk" "ar" "cab" "CAB" "cpio" "deb" "depot" "exe" "iso" "jar" "lzh" "LZH" "msu" "MSU" "mtree" "odb" "odf" "odg" "odp" "ods" "odt" "pax" "rar" "rpm" "shar" "tar" "tbz" "tgz" "tlz" "txz" "tzst" "warc" "xar" "xpi" "xps" "zip" "ZIP") "\
List of suffixes which indicate a file archive.
It must be supported by libarchive(3).")

(defconst tramp-archive-compression-suffixes '("bz2" "gz" "lrz" "lz" "lz4" "lzma" "lzo" "uu" "xz" "Z" "zst") "\
List of suffixes which indicate a compressed file.
It must be supported by libarchive(3).")

(defmacro tramp-archive-autoload-file-name-regexp nil "\
Regular expression matching archive file names." (quote (concat "\\`" "\\(" ".+" "\\." (regexp-opt tramp-archive-suffixes) "\\(?:" "\\." (regexp-opt tramp-archive-compression-suffixes) "\\)*" "\\)" "\\(" "/" ".*" "\\)" "\\'")))

(defalias 'tramp-archive-autoload-file-name-handler #'tramp-autoload-file-name-handler)

(defun tramp-register-archive-file-name-handler nil "\
Add archive file name handler to `file-name-handler-alist'." (when tramp-archive-enabled (add-to-list (quote file-name-handler-alist) (cons (tramp-archive-autoload-file-name-regexp) (function tramp-archive-autoload-file-name-handler))) (put (function tramp-archive-autoload-file-name-handler) (quote safe-magic) t)))

(add-hook 'after-init-hook #'tramp-register-archive-file-name-handler)

(add-hook 'tramp-archive-unload-hook (lambda nil (remove-hook 'after-init-hook #'tramp-register-archive-file-name-handler)))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "tramp-archive" '("tramp-" "with-parsed-tramp-archive-file-name")))

;;;***

;;;### (autoloads nil "tramp-cache" "tramp-cache.el" (0 0 0 0))
;;; Generated autoloads from tramp-cache.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "tramp-cache" '("tramp-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; tramp-autoloads.el ends here
