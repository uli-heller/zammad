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

TBD

### Neuigkeiten übernehmen

- Aktuellen Stand ermitteln: `git describe --tags` -> 5.2.2u070
- Neuen Stand festlegen:
  - **5.2.2u071**
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
