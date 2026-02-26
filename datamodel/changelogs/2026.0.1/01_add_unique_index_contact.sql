ALTER TABLE tce_od.contact ADD CONSTRAINT unique_contact UNIQUE (
    fk_kind,
    fk_organisation,
    fk_civility,
    first_name,
    last_name,
    street_name,
    house_number,
    address_supplement,
    city,
    postal_code,
    phone,
    email
);
