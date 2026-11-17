<!--
  MODÈLE DE README — Pipeline Data, séquence 1, chapitre 5
  Les blocs comme celui-ci sont des consignes : GitHub ne les affiche pas.
  Remplace chaque [crochet] par ton texte, puis supprime les crochets.
  Repères Markdown : une ligne qui commence par # est un titre ; une ligne qui commence par - est une puce.
-->

# Projet final Airbus Hélicoptères

<!-- Une phrase qui dit ce que fait ton projet. Exemple : « Prévoir la production de 6 boulangeries selon la météo pour réduire les invendus. » -->
Repérer les références qui ont le plus de retard (en incluant les manquants comme retards extrêmes) pour agir en priorité dessus.

## 1. Le problème

<!-- Reprends ta fiche projet : le contexte en 2 ou 3 phrases, la question centrale, l'utilisateur. -->
- **Contexte** : Pour absorber la hausse des commandes, Airbus Helicopters doit accélérer sa production, mais la moindre pièce manquante ou en retard bloque toute la chaîne d'assemblage
- **Question centrale** : Comment identifier et prioriser les références critiques à partir des écarts de délais pour sécuriser la montée en cadence d'Airbus Hélicoptères ?
- **Utilisateur** : Les managers du département logistique 

## 2. Les données

<!-- Une ligne par source envisagée, comme dans ta fiche projet. -->
| Source | Type | Ce qu'elle apporte |
| --- | --- | --- |
| Kaggle, Aerospace Supply Chain Performance & Forecasting | CSV | Contient les références de pièces, délais promis vs réels par commande fournisseur ainsi que l'historique hebdomadaire des ruptures et manquants. Permet de calculer les 3 KPI et d’identifier composants critiques |
| Airbus SE (Espace Investisseurs / Newsroom officiel), Airbus Orders & Financial Results / Rapports de livraisons d'Airbus Helicopters | Excel | Contexte business, montre évolution de Airbus (évolution du nombre d'appareils à produire et livrer d'une année sur l'autre) |

## 3. L'organisation du dépôt

<!-- Laisse cette liste telle quelle : elle décrit les dossiers créés au chapitre 3. -->
- `data/raw/` : les données brutes, telles que reçues, jamais modifiées
- `data/processed/` : les données nettoyées, prêtes pour l'analyse
- `notebooks/` : les notebooks Jupyter d'exploration et d'analyse
- `scripts/` : les scripts Python du projet
- `sql/` : les requêtes SQL
- `api/` : l'API du projet
- `dashboard/` : le rapport Power BI et ses captures d'écran
- `docs/` : la fiche projet et les documents du projet

## 4. L'avancement

<!-- Les étapes de ton projet. La première est faite. Tu cocheras les suivantes une fois le module terminé, quand tu appliqueras chaque méthode à ton projet : remplace alors [ ] par [x]. -->
- [x] Sujet choisi, dossiers créés, dépôt publié
- [ ] Collecte des données
- [ ] Requêtes SQL
- [ ] Nettoyage et dataset final
- [ ] Stockage en base
- [ ] API
- [ ] Analyse et tableau de bord

---
Emma Jovanovic · Formation Data Analyst & IA · DataSuits
