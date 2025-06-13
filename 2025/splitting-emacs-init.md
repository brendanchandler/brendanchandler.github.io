Below is a short guide on how I split up my Emacs configuration into multiple files for better organization.

Brendan Chandler
13June2025

## Overview

Emacs can load multiple Emacs Lisp files, making it easier to manage and maintain your configuration. The general process is:

1. Create a dedicated folder for your Lisp files (e.g., `~/.config/emacs/lisp/`).
2. Move logical chunks of your setup (package configs, custom functions, etc.) into separate `.el` files in that folder.
3. Add that folder to the Emacs `load-path`.
4. Use `(provide 'feature-name)` at the end of each file, and `(require 'feature-name)` from your main `init.el`.

## Example File Structure

I arranged my config like this:

- `~/.config/emacs/init.el`  
- `~/.config/emacs/lisp/init-packages.el`  
- `~/.config/emacs/lisp/custom-functions.el`  

### `init.el`

My main `init.el` starts with package management setup, then add the new folder to `load-path`, and require the split configs:

```emacs-lisp
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(eval-when-compile
  (require 'use-package))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-packages)
(require 'custom-functions)

;; custom-set-variables ...

;; custom-set-faces ...
```

### `init-packages.el`

In `init-packages.el`, I load and configure packages, set up custom key bindings, and so on. By calling `(provide 'init-packages)`, Emacs knows this file provides the feature `init-packages`. That way, `(require 'init-packages)` works from `init.el`.

```emacs-lisp
;;; init-packages.el --- elisp for loading and configuring Emacs plugins

(provide 'init-packages)

(define-prefix-command 'o-map)
(global-set-key (kbd "C-o") 'o-map)

(use-package emacs
  :ensure t
  :bind (("C-o e" . hippie-expand)
         ;; ... more bindings ...
         )
  :config
  ;; ... your config ...
  )

(use-package clang-format
  :ensure t
  :config
  (setq clang-format-style "Mozilla")
  ;; ... more clang-format setup ...
  )

;; ... more packages ...
```

### `custom-functions.el`

This file holds personal functions and hooks.

```emacs-lisp
;;; custom-functions.el --- Custom functions for my Emacs usage

(provide 'custom-functions)

(defun bc-next-buffer ()
  (interactive)
  ;; ...
  )

(defun bc-prev-buffer ()
  (interactive)
  ;; ...
  )

;; ... more handy functions ...
```

