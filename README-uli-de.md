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
- Änderungen einbinden: `git rebase upstream/stable`
- Neuen Stand markieren: `git tag 5.2.2u071`
- Neuen Stand sichern:
  - `git push --tags`
  - `git push -f`
- Neue Version erzeugen: `./uli-release.sh 5.2.2u071`

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
