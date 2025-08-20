CREATE OR REPLACE TABLE DIM_COLLISION_DATE (
    date_id NUMBER(38,0) PRIMARY KEY,
    full_date DATE,
    day_of_week VARCHAR(10),
    day_name VARCHAR(20),
    week_number NUMBER(38,0),
    month_number NUMBER(38,0),
    month_name VARCHAR(20),
    quarter NUMBER(38,0),
    year NUMBER(38,0),
    is_weekend BOOLEAN,
    is_holiday BOOLEAN
);

CREATE OR REPLACE TABLE DIM_COLLISION_TIME (
    time_id NUMBER(38,0) PRIMARY KEY,
    full_time TIME,
    hour_24 NUMBER(38,0),
    hour_12 NUMBER(38,0),
    minute NUMBER(38,0),
    second NUMBER(38,0),
    am_pm VARCHAR(2),
    time_of_day VARCHAR(20),
    rush_hour BOOLEAN
);

CREATE OR REPLACE TABLE DIM_COLLISION_LOCATION (
    location_id NUMBER(38,0) PRIMARY KEY,
    latitude FLOAT,
    longitude FLOAT,
    borough VARCHAR(255),
    zip_code VARCHAR(20),
    on_street_name VARCHAR(255),
    cross_street_name VARCHAR(255),
    off_street_name VARCHAR(255),
    zone VARCHAR(255),
    service_zone VARCHAR(255)
);

CREATE OR REPLACE TABLE DIM_COLLISION_VEHICLE (
    vehicle_id NUMBER(38,0) PRIMARY KEY,
    collision_id NUMBER(38,0),
    vehicle_type VARCHAR(255),
    vehicle_make VARCHAR(255),
    vehicle_model VARCHAR(255),
    vehicle_year NUMBER(38,0),
    contributing_factor_1 VARCHAR(255),
    contributing_factor_2 VARCHAR(255),
    state_registration VARCHAR(20),
    driver_sex VARCHAR(10),
    driver_license_status VARCHAR(50),
    point_of_impact VARCHAR(50),
    vehicle_damage VARCHAR(50)
);

CREATE OR REPLACE TABLE DIM_COLLISION_PERSON (
    person_id NUMBER(38,0) PRIMARY KEY,
    collision_id NUMBER(38,0),
    person_type VARCHAR(50),
    person_role VARCHAR(50),
    age NUMBER(38,0),
    sex VARCHAR(10),
    injury_status VARCHAR(50),
    emotional_status VARCHAR(50),
    bodily_injury VARCHAR(50),
    ejection VARCHAR(50),
    position_in_vehicle VARCHAR(50),
    safety_equipment VARCHAR(50),
    contributing_factor VARCHAR(255)
);