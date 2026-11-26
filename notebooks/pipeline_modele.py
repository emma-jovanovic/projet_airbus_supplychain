"""Pipeline de mon projet : prépare mes données brutes et les range dans data/processed/.

Modèle de la séquence 4, à adapter APRÈS le module, pour ton projet final.
1. Range ce fichier dans le dossier scripts/ de ton projet, sous le nom pipeline.py.
2. Remplace chaque ... par ce qui correspond à tes sources (reprends les cellules de ton notebook 04_preparation).
3. Lance-le depuis une cellule d'un notebook du dossier notebooks/ :  %run ../scripts/pipeline.py
"""
import logging
import sys

import pandas as pd

RAW = "../data/raw/"
PROCESSED = "../data/processed/"

# Le journal : chaque message s'affiche sous la cellule et s'ajoute au fichier pipeline.log
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(message)s",
    datefmt="%d/%m/%Y %H:%M:%S",
    handlers=[logging.FileHandler("../pipeline.log", encoding="utf-8"), logging.StreamHandler(sys.stdout)],
    force=True,
)
journal = logging.getLogger("pipeline")


def charger():
    """Lit mes fichiers bruts."""
    source_1 = pd.read_csv(RAW + "...")
    source_2 = pd.read_csv(RAW + "...")
    journal.info(f"Chargement : {len(source_1)} lignes et {len(source_2)} lignes")
    return source_1, source_2


def nettoyer(source):
    """Recette 7 : doublons, lignes invalides, cases vides."""
    avant = len(source)
    source = source.drop_duplicates()
    source = source[(source["..."] > 0)]                 # ma règle de validité
    journal.info(f"Nettoyage : {avant - len(source)} lignes supprimées")
    return source


def homogeneiser(source):
    """Recette 8 : noms de colonnes, types, dates, unités, formats."""
    source = source.rename(columns={"...": "..."})
    source["date"] = pd.to_datetime(source["date"])
    return source


def assembler(source_1, source_2):
    """Recette 9 : jointure sur une clé commune."""
    donnees = source_1.merge(source_2, on=["..."], how="left")
    journal.info(f"Jointure : {len(source_1)} lignes avant, {len(donnees)} lignes après")
    return donnees


def controler(donnees, attendu):
    """Recette 9 : contrôles qualité avant stockage. Le pipeline s'arrête si l'un d'eux échoue."""
    controles = {
        "volume": len(donnees) == attendu,
        "unicité": donnees.duplicated(subset=["..."]).sum() == 0,
        "aucune case vide dans ...": donnees["..."].isna().sum() == 0,
        "types : la date est une date": str(donnees["date"].dtype).startswith("datetime"),
        "cohérence : ...": (donnees["..."] >= 0).all(),
    }
    for nom, resultat in controles.items():
        if resultat:
            journal.info(f"Contrôle OK : {nom}")
        else:
            journal.error(f"Contrôle ÉCHOUÉ : {nom}")
            raise ValueError(f"Contrôle échoué : {nom}. Rien n'a été enregistré.")


def enregistrer(donnees):
    """Écrit le résultat dans data/processed/."""
    donnees.to_csv(PROCESSED + "....csv", index=False)
    journal.info(f"Enregistrement : {len(donnees)} lignes")


def lancer():
    """Enchaîne toutes les étapes, dans l'ordre."""
    journal.info("Début du pipeline")
    source_1, source_2 = charger()
    source_1 = homogeneiser(nettoyer(source_1))
    source_2 = homogeneiser(nettoyer(source_2))
    donnees = assembler(source_1, source_2)
    controler(donnees, len(source_1))
    enregistrer(donnees)
    journal.info("Fin du pipeline")


lancer()
