Vorgabe-Typ für Ticket-Ergänzungen: Email
=========================================

- Ist: 'note' (?)
- Soll: 'email'

## article_new.coffee

```diff
--- app/assets/javascripts/app/controllers/ticket_zoom/article_new.coffee ----
index 0d88c3e80..13b7fdffe 100644
@@ -130,14 +130,14 @@ class App.TicketZoomArticleNew extends App.Controller
 
   tokanice: (type = 'email') ->
     App.Utils.tokanice('.content.active .js-to, .js-cc, js-bcc', type)
 
   setPossibleArticleTypes: =>
-    @articleTypes = []
-    for config in @actions()
-      if config && config.articleTypes
-        @articleTypes = config.articleTypes(@articleTypes, @ticket, @)
+    @articleTypes = [ 'email' ]
+    # for config in @actions()
+    #   if config && config.articleTypes
+    #     @articleTypes = config.articleTypes(@articleTypes, @ticket, @)
 
   placeCaretAtEnd: (el) ->
     el.focus()
     if typeof window.getSelection isnt 'undefined' && typeof document.createRange isnt 'undefined'
       range = document.createRange()
```

Das funktioniert so nicht!

- "Manchmal" wird keine Mail verschickt
- "Manchmal" wird eine Mail verschickt
- Änderung des Ticket.-Besitzers klappt nicht mehr
