README-uli-de.md
================

[English version](README-uli-en.md) (does not exist at the moment)

Dieses Repo entspricht im Wesentlichen dem Original-Repo von Zammad.
Ich folge dem "stable"-Zweig und publiziere diesen samt meinen Änderungen
in "stable-5.0" (Stand 2021-12-07, früher war's mal "stable-4.0").

Aktuell läuft mein "stable-5.0" nicht linear, ein sinnvolles Folgen auf
diesen Zweig ist nicht möglich. Warum? Weil ich meine Änderungen immer
wieder frisch auf "upstream:stable" anwende mit `git rebase ...`
und danach dann ein "force push" (`git push -f`) auf meinen
"stable-5.0"-Zweig mache!

Von diesen Ständen erzeuge ich dann

- ein Tag/eine Version in Github - bspw. 5.0.3u28
- eine Release-Datei - bspw. zammad-5.0.3u28.tar.bz2
- eine SHA256-Datei - bspw. zammad-5.0.3u28.tar.bz2.sha256
- eine SSH-SIG-Datei - bspw. zammad-5.0.3u28.tar.bz2.ssh-sig

Alle diese Artefakte werden dann auf Github veröffentlicht.

## Aktualisierung auf eine neue Upstream-Version

### Neuigkeiten ermitteln

#### Keine Neuigkeiten

```
$ git fetch --all
Fordere an von origin
Fordere an von upstream
Fordere an von mattk42
```

#### Neuigkeiten vorhanden

```
$ git fetch --all
Fordere an von origin
Fordere an von upstream
remote: Enumerating objects: 333, done.
remote: Counting objects: 100% (333/333), done.
remote: Compressing objects: 100% (86/86), done.
remote: Total 333 (delta 251), reused 325 (delta 245), pack-reused 0
Empfange Objekte: 100% (333/333), 2.71 MiB | 4.28 MiB/s, fertig.
Löse Unterschiede auf: 100% (251/251), abgeschlossen mit 67 lokalen Objekten.
Von github.com:zammad/zammad
   6a0d3f356..d452b0184  develop    -> upstream/develop
   7dadccdea..eb9780155  stable     -> upstream/stable
Fordere an von mattk42
```

#### Neuigkeiten vorhanden mit neuem Zweig

```
$ git fetch --all
Fordere an von origin
Fordere an von upstream
remote: Enumerating objects: 247, done.
remote: Counting objects: 100% (244/244), done.
remote: Compressing objects: 100% (41/41), done.
remote: Total 133 (delta 99), reused 116 (delta 82), pack-reused 0
Empfange Objekte: 100% (133/133), 16.56 KiB | 16.56 MiB/s, fertig.
Löse Unterschiede auf: 100% (99/99), abgeschlossen mit 68 lokalen Objekten.
Von github.com:zammad/zammad
   48933cfac..ae2c5244f  develop    -> upstream/develop
   bca422439..65550ad83  stable     -> upstream/stable
 * [neues Tag]           5.2.3      -> 5.2.3
Fordere an von mattk42
```

### Neuigkeiten übernehmen

- Aktuellen Stand ermitteln: `git describe --tags`
  - Guter Stand: 5.2.2u070
  - Unklarer Stand: 5.2.2u070-1-g68ef2fec5 - Markierung ist veraltet
- Neuen Stand festlegen - je nachdem, ob ein neuer Zweig vorhanden ist:
  - **5.2.2u071**
  - 5.2.3u071
  - 5.3.0u071
- Änderungen einbinden:
  - Bislang: `git rebase upstream/stable`
  - Künftig:
    - `git checkout stable-6.0`
    - `git checkout -b next-stable-6.0 stable-5.4`
    - `git rebase --onto stable-6.0 upstream/stable-5.4 next-stable-6.0`
    - `git checkout stable-6.0`
    - `git rebase next-stable-6.0`
    - `git push -u origin stable-6.0`
    - `git branch -d next-stable-6.0`
- Neuen Stand markieren: `git tag 5.2.2u071`
- Neuen Stand sichern:
  - `git push --tags`
  - `git push`
- Neue Version erzeugen: `./uli-release.sh 5.2.2u071`

### Für 6.1.0

Neuen Stand herholen von Github:

```
$ git fetch --all
Fordere an von origin
Fordere an von upstream
remote: Enumerating objects: 5643, done.
remote: Counting objects: 100% (3802/3802), done.
remote: Compressing objects: 100% (1265/1265), done.
remote: Total 5643 (delta 2637), reused 3593 (delta 2468), pack-reused 1841
Empfange Objekte: 100% (5643/5643), 28.38 MiB | 4.81 MiB/s, fertig.
Löse Unterschiede auf: 100% (3493/3493), abgeschlossen mit 382 lokalen Objekten.
Von github.com:zammad/zammad
   1da038011..2cce72283  develop                              -> upstream/develop
 * [neuer Branch]        develop-docker-tags                  -> upstream/develop-docker-tags
 + 207343b96...d865102a3 develop_ts_maintenance_pkg-installer -> upstream/develop_ts_maintenance_pkg-installer  (Aktualisierung erzwungen)
 + bcb37f95b...4747590e4 stable                               -> upstream/stable  (Aktualisierung erzwungen)
 * [neuer Branch]        stable-6.0                           -> upstream/stable-6.0
 * [neuer Branch]        stable-mh-issue4816                  -> upstream/stable-mh-issue4816
 * [neues Tag]           6.1.0                                -> 6.1.0
 * [neues Tag]           6.2.0-alpha                          -> 6.2.0-alpha
Fordere an von mattk42
```

Ich erkenne:

- Es gibt ein neues Tag "6.1.0"
- Es gibt einen neuen Branch "stable-6.0"
- Es gibt Änderungen am Branch "stable"
- Mittels `gitk` ermitteln: "stable" baut auf auf "6.1.0"

Also: Wir brauchen einen neuen Branch "stable-6.1" statt "stable-5.4" wie bisher.

```
$ git branch -m stable-5.4 stable-6.1
$ git push -u origin stable-6.1:stable-6.1
Gesamt 0 (Delta 0), Wiederverwendet 0 (Delta 0), Pack wiederverwendet 0
remote: 
remote: Create a pull request for 'stable-6.1' on GitHub by visiting:
remote:      https://github.com/uli-heller/zammad/pull/new/stable-6.1
remote: 
To github.com:uli-heller/zammad.git
 * [new branch]          stable-6.1 -> stable-6.1
Branch 'stable-6.1' folgt nun 'origin/stable-6.1'.

$ git rebase upstream/stable
Warnung: zuvor angewendeten Commit 7f28bf522 übersprungen
Warnung: zuvor angewendeten Commit 7e73bd789 übersprungen
Warnung: zuvor angewendeten Commit 8d706a0b0 übersprungen
...
Warnung: zuvor angewendeten Commit b4371d8cd übersprungen
Warnung: zuvor angewendeten Commit d074a0f4b übersprungen
Hinweis: verwenden Sie --reapply-cherry-picks, um übersprungene Commits einzubeziehen
Hinweis: Disable this message with "git config advice.skippedCherryPicks false"
automatischer Merge von i18n/zammad.am.po
KONFLIKT (Inhalt): Merge-Konflikt in i18n/zammad.am.po
automatischer Merge von i18n/zammad.ar.po
KONFLIKT (Inhalt): Merge-Konflikt in i18n/zammad.ar.po
...
KONFLIKT (Inhalt): Merge-Konflikt in i18n/zammad.zh-cn.po
automatischer Merge von i18n/zammad.zh-tw.po
KONFLIKT (Inhalt): Merge-Konflikt in i18n/zammad.zh-tw.po
Fehler: Konnte 7416b4c53... (Maintenance: Translations update from translations.zammad.org.) nicht anwenden
Hinweis: Resolve all conflicts manually, mark them as resolved with
Hinweis: "git add/rm <conflicted_files>", then run "git rebase --continue".
Hinweis: You can instead skip this commit: run "git rebase --skip".
Hinweis: To abort and get back to the state before "git rebase", run "git rebase --abort".
Konnte 7416b4c53... (Maintenance: Translations update from translations.zammad.org.) nicht anwenden
```

## Upstream-Version

```
./uli-release 5.0.3
# Erzeugt:
#  zammad-5.0.3.tar.bz2
#  zammad-5.0.3.tar.bz2.sha256
#  zammad-5.0.3.tar.bz2.ssh-sig
```

## Uli-Version

```
./uli-release.sh 5.0.3u28
# Erzeugt:
#  zammad-5.0.3u28.tar.bz2
#  zammad-5.0.3u28.tar.bz2.sha256
#  zammad-5.0.3u28.tar.bz2.ssh-sig
```
