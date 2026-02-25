# bonnefrankette

Plugin Claude Code inspiré de Kaamelott. Détecte les insultes en français et te répond avec des répliques cultes.

## Fonctionnalités

- **Pouah ! Ca puir !** — Te salue chaleureusement au début de chaque session
- **Détection d'insultes** — Détecte les insultes FR dans tes prompts et te répond avec une réplique Kaamelott
- **C'est Okay ! / Ils sont partis dans les couloirs du temps !** — Son aléatoire quand Claude termine un travail
- **Ah !** — Joue un son quand Claude te pose une question

## Prérequis

- macOS (utilise `afplay` pour l'audio)
- `jq` installé (`brew install jq`)
- Claude Code CLI

## Installation

1. Clone le repo :

```bash
git clone https://github.com/hedborg1/bonnefrankette.git
```

2. Rends les scripts exécutables :

```bash
chmod +x bonnefrankette/scripts/*.sh
```

3. Ajoute le plugin dans ta config Claude Code (`~/.claude/settings.json`) :

```json
{
  "plugins": [
    "/chemin/absolu/vers/bonnefrankette"
  ]
}
```

Remplace `/chemin/absolu/vers/bonnefrankette` par le vrai chemin du dossier cloné.

4. Relance Claude Code. Tu devrais entendre "Pouah ! Ca puir !" si tout marche.

## Structure

```
bonnefrankette/
├── .claude-plugin/
│   └── plugin.json            # Métadonnées du plugin
├── hooks/
│   └── hooks.json             # Déclaration des hooks
├── scripts/
│   ├── greeting.sh            # Salut au démarrage
│   ├── insult-detector.sh     # Détection + réplique Kaamelott
│   ├── task-done-fart.sh      # Son de fin de tâche
│   └── question-sound.sh      # Son de question
├── sounds/
│   ├── greeting.mp3           # Pouah ! Ca puir !
│   ├── task-done-1.mp3        # C'est Okay !
│   ├── task-done-2.mp3        # Ils sont partis dans les couloirs du temps !
│   └── question.mp3           # Ah !
└── insults/
    ├── silence-vilaine.mp3    # Silence vilaine !
    └── sarrasin-chariotte.mp3 # Un Sarrasin dans une chariotte du diable !
```

## Debug

Les logs sont dans `/tmp/` :

```bash
# Logs du détecteur d'insultes
cat /tmp/bonnefrankette-insult-debug.log

# Logs du son de question
cat /tmp/bonnefrankette-question-debug.log
```

## Licence

MIT
