-- 1. Sauvegarder les valeurs actuelles (courtes)
UPDATE tce_vl.civility
SET
    short_fr = value_fr,
    short_en = CASE
        WHEN id = 6101 THEN 'Mr'
        WHEN id = 6102 THEN 'Mrs'
    END,
    short_de = CASE
        WHEN id = 6101 THEN 'Hr.'
        WHEN id = 6102 THEN 'Fr.'
    END,
    short_it = CASE
        WHEN id = 6101 THEN 'Sig.'
        WHEN id = 6102 THEN 'Sig.ra'
    END
WHERE id IN (6101, 6102);

-- 2. Remplacer par les valeurs longues
UPDATE tce_vl.civility
SET
    value_fr = CASE
        WHEN id = 6101 THEN 'Monsieur'
        WHEN id = 6102 THEN 'Madame'
    END,
    value_en = CASE
        WHEN id = 6101 THEN 'Mister'
        WHEN id = 6102 THEN 'Misses'
    END
WHERE id IN (6101, 6102);
