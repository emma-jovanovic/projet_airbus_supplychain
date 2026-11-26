-- Création de ma base airbus_supplychain : 5 tables
-- Relancer ce fichier reconstruit la base de zéro.

DROP DATABASE IF EXISTS airbus_supplychain;
CREATE DATABASE airbus_supplychain CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE airbus_supplychain;

-- 1. La table parente d'abord : les pièces (elle ne pointe vers aucune autre table)
CREATE TABLE pieces (
  part_id              VARCHAR(10)    PRIMARY KEY,                                  -- le numéro de la pièce, unique et jamais vide
  part_family          VARCHAR(30)    NOT NULL,                                     -- la famille (Engine, Avionics...)
  criticality_class    CHAR(1)        NOT NULL CHECK (criticality_class IN ('A', 'B', 'C')),   -- A = sécurité, B = opérationnel, C = non critique
  unit_cost            DECIMAL(12,2)  NOT NULL CHECK (unit_cost > 0),               -- le coût d'une pièce
  lead_time_days       INT            NOT NULL CHECK (lead_time_days > 0),          -- le délai de livraison annoncé, en jours
  supplier_id_primary  VARCHAR(10)    NOT NULL,                                     -- le fournisseur principal
  supplier_risk_class  VARCHAR(10)    NOT NULL CHECK (supplier_risk_class IN ('Low', 'Medium', 'High'))   -- le niveau de risque du fournisseur
);

-- 2. Les tables enfants ensuite : elles pointent vers la table des pièces
CREATE TABLE commandes (
  po_id          VARCHAR(10)  PRIMARY KEY,                                          -- le numéro de la commande, unique et jamais vide
  part_id        VARCHAR(10)  NOT NULL,                                             -- la pièce commandée (renvoie à la table pieces)
  supplier_id    VARCHAR(10)  NOT NULL,
  site_id        VARCHAR(10)  NOT NULL,
  order_date     DATE         NOT NULL,                                             -- date de la commande
  promised_date  DATE         NOT NULL,                                             -- date de livraison promise
  receipt_date   DATE         NOT NULL,                                             -- date de réception réelle
  ordered_qty    INT          NOT NULL CHECK (ordered_qty > 0),                     -- quantité commandée
  received_qty   INT          NOT NULL CHECK (received_qty >= 0),                   -- quantité reçue
  annee          INT          NOT NULL,
  mois           INT          NOT NULL CHECK (mois BETWEEN 1 AND 12),
  CHECK (receipt_date >= order_date),                                               -- on ne peut pas recevoir avant d'avoir commandé
  CHECK (received_qty <= ordered_qty),                                              -- on ne reçoit jamais plus que ce qu'on a commandé
  FOREIGN KEY (part_id) REFERENCES pieces (part_id)
);

CREATE TABLE historique_hebdo (
  id               INT  AUTO_INCREMENT PRIMARY KEY,                                 -- un numéro attribué automatiquement par MySQL
  part_id          VARCHAR(10)  NOT NULL,                                           -- la pièce (renvoie à la table pieces)
  site_id          VARCHAR(10)  NOT NULL,
  date             DATE         NOT NULL,                                           -- le lundi de la semaine
  consumption_qty  INT          NOT NULL CHECK (consumption_qty >= 0),              -- pièces utilisées dans la semaine
  on_hand_qty      INT          NOT NULL CHECK (on_hand_qty >= 0),                  -- pièces en stock
  backorder_qty    INT          NOT NULL CHECK (backorder_qty >= 0),                -- pièces demandées mais pas livrées
  annee            INT          NOT NULL,
  mois             INT          NOT NULL CHECK (mois BETWEEN 1 AND 12),
  UNIQUE (site_id, part_id, date),                                                  -- une seule ligne par site, pièce et semaine
  FOREIGN KEY (part_id) REFERENCES pieces (part_id)
);

-- 3. Les deux indices externes : des tables à part, reliées aux autres par annee + mois
CREATE TABLE gscpi_mensuel (
  date    DATE           PRIMARY KEY,                                               -- la fin du mois
  gscpi   DECIMAL(10,6)  NOT NULL,                                                  -- la valeur de l'indice
  annee   INT            NOT NULL,
  mois    INT            NOT NULL CHECK (mois BETWEEN 1 AND 12)
);

CREATE TABLE taux_change_mensuel (
  annee               INT           NOT NULL,
  mois                INT           NOT NULL CHECK (mois BETWEEN 1 AND 12),
  taux_eur_usd_moyen  DECIMAL(8,4)  NOT NULL CHECK (taux_eur_usd_moyen > 0),     -- 1 euro vaut X dollars, en moyenne sur le mois
  PRIMARY KEY (annee, mois)                                                       -- une seule ligne par mois : année + mois ensemble identifient la ligne
);
