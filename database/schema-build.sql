.nullvalue -NULL-

CREATE TABLE plant (
    individualID VARCHAR(255) PRIMARY KEY NOT NULL, -- e.g. NEON.PLA.D16.ABBY.06020
    namedLocation VARCHAR(255),
    domainID VARCHAR(255),
    siteID VARCHAR(255),
    plotID VARCHAR(255),
    decimalLatitude DECIMAL(9, 6),
    decimalLongitude DECIMAL(9, 6),
    elevation DECIMAL(10, 2),
    subtypeSpecification VARCHAR(255), 
    taxonID VARCHAR(255),
    taxonRank VARCHAR(255),
    scientificName VARCHAR(255),
    nativeStatusCode VARCHAR(10), 
    growthForm VARCHAR(255),
    date TIMESTAMP, -- install / tag date
    editedDate TIMESTAMP
); 

INSERT INTO plant SELECT * FROM read_csv("../phenology_csv/phe_perindividual.csv", HEADER=TRUE, nullstr='NA');

CREATE TABLE census (
    individualID VARCHAR(255),
    uid VARCHAR PRIMARY KEY NOT NULL,  -- synthetic key
    date TIMESTAMP, -- census date
    eventID VARCHAR(255),
    patchOrIndividual VARCHAR(50), 
    canopyPosition VARCHAR(255),
    plantStatus VARCHAR(50), -- "Live" | "Dead"
    stemDiameter DECIMAL(10, 2),
    measurementHeight DECIMAL(10, 2),
    maxCanopyDiameter DECIMAL(10, 2),
    ninetyCanopyDiameter DECIMAL(10, 2),
    patchSize DECIMAL(10, 2),
    percentCover DECIMAL(5, 2),
    height DECIMAL(10, 2),
    diseaseType VARCHAR(255),
    obsYear INTEGER,
    FOREIGN KEY (individualID) REFERENCES plant(individualID),
    UNIQUE (individualID, obsYear)
);

INSERT INTO census SELECT * FROM read_csv("../phenology_csv/phe_perindividualperyear.csv", HEADER=TRUE, nullstr='NA');

CREATE TABLE phenophase (
    individualID VARCHAR(255) NOT NULL,
    uid UUID PRIMARY KEY NOT NULL, -- synthetic key
    date TIMESTAMP, -- observation timestamp
    eventID VARCHAR(255),
    phenophaseName VARCHAR(255),
    phenophaseStatus VARCHAR(50), -- "yes" | "no" | "uncertain"
    phenophaseIntensityDefinition VARCHAR(255),
    phenophaseIntensity VARCHAR(255),
    remarks TEXT,
    obsYear INTEGER, -- YEAR(date), materialised for FK
    FOREIGN KEY (individualID) REFERENCES plant(individualID)
);

INSERT INTO phenophase SELECT * FROM read_csv("../phenology_csv/phe_statusintensity.csv",HEADER=TRUE, nullstr='NA');