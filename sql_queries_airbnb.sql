-- REVIEWS_CLEANED.CSV
-- reviews contains information from file reviews_cleaned.csv
CREATE TABLE reviews (
    listing_id BIGINT,          -- id of the listing
    id BIGINT PRIMARY KEY,      -- unique id of the review
    date DATE,                  -- date of the review
    reviewer_id BIGINT,         -- id of the reviewer
    reviewer_name TEXT,         -- name of the reviewer
    comments TEXT               -- text
);
-- NOW WE UPLOAD REVIEWS_CLEANED.CSV


-- reviewers table to store unique reviewer info.
-- it helps to reduce redundancy by storing reviewers info separately.
CREATE TABLE reviewers (
    reviewer_id BIGINT PRIMARY KEY,  -- unique id of the reviewer
    reviewer_name TEXT               -- reviewer name
);

-- populate the reviewers table
INSERT INTO reviewers (reviewer_id, reviewer_name)
SELECT DISTINCT reviewer_id, reviewer_name
FROM reviews;

-- remove reviewer_name column from reviews (normalization process)
ALTER TABLE reviews
DROP COLUMN reviewer_name;

-- reviewer_id in reviews must match with a reviewer_id in reviewers
ALTER TABLE reviews
ADD CONSTRAINT fk_reviewer
FOREIGN KEY (reviewer_id)
REFERENCES reviewers(reviewer_id);

----------------------------------------------------------------------------------------------------------------------------

-- CALENDAR_CLEANED.CSV
-- calendar contains information from file reviews_cleaned.csv
CREATE TABLE calendar (
    listing_id BIGINT NOT NULL,
    date DATE NOT NULL,
    available BOOLEAN NOT NULL,
    price_dkk DECIMAL(10, 2) NOT NULL,
    minimum_nights INT NOT NULL,
    maximum_nights INT NOT NULL,
    PRIMARY KEY (listing_id, date)
);
-- NOW WE UPLOAD CALENDAR_CLEANED.CSV

----------------------------------------------------------------------------------------------------------------------------

-- LISTINGS_CLEANED.CSV
-- listings contains information from file listings_cleaned.csv
CREATE TABLE listings (
    id BIGINT PRIMARY KEY,
    listing_url TEXT,
    scrape_id BIGINT,
    last_scraped DATE,
    source TEXT,
    name TEXT,
    description TEXT,
    neighbourhood_overview TEXT,
    picture_url TEXT,
    host_id BIGINT,
    host_url TEXT,
    host_name TEXT,
    host_since DATE,
    host_location TEXT,
    host_about TEXT,
    host_response_time TEXT,
    host_response_rate NUMERIC,
    host_acceptance_rate NUMERIC,
    host_is_superhost BOOLEAN,
    host_thumbnail_url TEXT,
    host_picture_url TEXT,
    host_neighbourhood TEXT,
    host_listings_count NUMERIC,
    host_total_listings_count NUMERIC,
    host_verifications TEXT,
    host_has_profile_pic BOOLEAN,
    host_identity_verified BOOLEAN,
    neighbourhood_cleansed TEXT,
    latitude NUMERIC,
    longitude NUMERIC,
    property_type TEXT,
    room_type TEXT,
    accommodates INTEGER,
    bathrooms NUMERIC,
    bathrooms_text TEXT,
    bedrooms NUMERIC,
    beds NUMERIC,
    amenities TEXT,
    price_dkk NUMERIC,
    minimum_nights INTEGER,
    maximum_nights INTEGER,
    minimum_minimum_nights INTEGER,
    maximum_minimum_nights INTEGER,
    minimum_maximum_nights INTEGER,
    maximum_maximum_nights INTEGER,
    minimum_nights_avg_ntm NUMERIC,
    maximum_nights_avg_ntm NUMERIC,
    has_availability BOOLEAN,
    availability_30 INTEGER,
    availability_60 INTEGER,
    availability_90 INTEGER,
    availability_365 INTEGER,
    calendar_last_scraped DATE,
    number_of_reviews INTEGER,
    number_of_reviews_ltm INTEGER,
    number_of_reviews_l30d INTEGER,
    first_review DATE,
    last_review DATE,
    review_scores_rating NUMERIC,
    review_scores_accuracy NUMERIC,
    review_scores_cleanliness NUMERIC,
    review_scores_checkin NUMERIC,
    review_scores_communication NUMERIC,
    review_scores_location NUMERIC,
    review_scores_value NUMERIC,
    instant_bookable BOOLEAN,
    calculated_host_listings_count NUMERIC,
    calculated_host_listings_count_entire_homes NUMERIC,
    calculated_host_listings_count_private_rooms NUMERIC,
    calculated_host_listings_count_shared_rooms NUMERIC,
    reviews_per_month NUMERIC,
    is_bathroom_shared BOOLEAN
);
-- NOW WE UPLOAD LISTINGS_CLEANED.CSV

-- Hosts Table
CREATE TABLE hosts (
    host_id BIGINT PRIMARY KEY,
    host_url TEXT,
    host_name TEXT,
    host_since DATE,
    host_location TEXT,
    host_about TEXT,
    host_response_time TEXT,
    host_response_rate NUMERIC,
    host_acceptance_rate NUMERIC,
    host_is_superhost BOOLEAN,
    host_thumbnail_url TEXT,
    host_picture_url TEXT,
    host_neighbourhood TEXT,
    host_listings_count NUMERIC,
    host_total_listings_count NUMERIC,
    host_verifications TEXT,
    host_has_profile_pic BOOLEAN,
    host_identity_verified BOOLEAN,
	calculated_host_listings_count NUMERIC,
    calculated_host_listings_count_entire_homes NUMERIC,
    calculated_host_listings_count_private_rooms NUMERIC,
    calculated_host_listings_count_shared_rooms NUMERIC
);

-- Availability Table
CREATE TABLE availability (
    id BIGINT PRIMARY KEY,
    price_dkk NUMERIC,
    minimum_nights INTEGER,
    maximum_nights INTEGER,
	minimum_minimum_nights INTEGER,
    maximum_minimum_nights INTEGER,
    minimum_maximum_nights INTEGER,
    maximum_maximum_nights INTEGER,
    minimum_nights_avg_ntm NUMERIC,
    maximum_nights_avg_ntm NUMERIC,
    availability_30 INTEGER,
    availability_60 INTEGER,
    availability_90 INTEGER,
    availability_365 INTEGER,
    calendar_last_scraped DATE,
	has_availability BOOLEAN,
    instant_bookable BOOLEAN
);

-- Listing Reviews Summary Table
CREATE TABLE listings_reviews_summary (
    id BIGINT PRIMARY KEY,
    number_of_reviews INTEGER,
    number_of_reviews_ltm INTEGER,
    number_of_reviews_l30d INTEGER,
    first_review DATE,
    last_review DATE,
    review_scores_rating NUMERIC,
    review_scores_accuracy NUMERIC,
    review_scores_cleanliness NUMERIC,
    review_scores_checkin NUMERIC,
    review_scores_communication NUMERIC,
    review_scores_location NUMERIC,
    review_scores_value NUMERIC,
    reviews_per_month NUMERIC
);

-- Web Scrape Table
CREATE TABLE web_scrape (
	id BIGINT PRIMARY KEY,
	scrape_id BIGINT,
    last_scraped DATE,
    source TEXT
);

-- Fill Hosts table
INSERT INTO hosts (
    host_id ,host_url ,host_name ,host_since ,host_location ,host_about ,host_response_time ,host_response_rate ,
    host_acceptance_rate ,host_is_superhost ,host_thumbnail_url ,host_picture_url ,host_neighbourhood ,
    host_listings_count ,host_total_listings_count ,host_verifications ,host_has_profile_pic ,
    host_identity_verified ,calculated_host_listings_count ,calculated_host_listings_count_entire_homes ,
    calculated_host_listings_count_private_rooms ,calculated_host_listings_count_shared_rooms 
)
SELECT DISTINCT
    host_id ,host_url ,host_name ,host_since ,host_location ,host_about ,host_response_time ,host_response_rate ,
    host_acceptance_rate ,host_is_superhost ,host_thumbnail_url ,host_picture_url ,host_neighbourhood ,
    host_listings_count ,host_total_listings_count ,host_verifications ,host_has_profile_pic ,
    host_identity_verified ,calculated_host_listings_count ,calculated_host_listings_count_entire_homes ,
    calculated_host_listings_count_private_rooms ,calculated_host_listings_count_shared_rooms
FROM listings;

-- Fill Availability table
INSERT INTO availability (
    id, price_dkk ,minimum_nights ,maximum_nights ,minimum_minimum_nights ,
	maximum_minimum_nights ,minimum_maximum_nights ,maximum_maximum_nights ,
    minimum_nights_avg_ntm ,maximum_nights_avg_ntm ,availability_30 ,availability_60 ,
	availability_90 ,availability_365 ,calendar_last_scraped ,has_availability ,
	instant_bookable 
)
SELECT
    id, price_dkk ,minimum_nights ,maximum_nights ,minimum_minimum_nights ,
	maximum_minimum_nights ,minimum_maximum_nights ,maximum_maximum_nights ,
    minimum_nights_avg_ntm ,maximum_nights_avg_ntm ,availability_30 ,availability_60 ,
	availability_90 ,availability_365 ,calendar_last_scraped ,has_availability ,
	instant_bookable
FROM listings;

-- Fill Listing Reviews Summary Table
INSERT INTO listings_reviews_summary (
    id ,number_of_reviews ,number_of_reviews_ltm ,number_of_reviews_l30d ,first_review ,
    last_review ,review_scores_rating ,review_scores_accuracy ,review_scores_cleanliness ,review_scores_checkin ,
    review_scores_communication ,review_scores_location ,review_scores_value ,reviews_per_month 
)
SELECT
    id ,number_of_reviews ,number_of_reviews_ltm ,number_of_reviews_l30d ,first_review ,
    last_review ,review_scores_rating ,review_scores_accuracy ,review_scores_cleanliness ,review_scores_checkin ,
    review_scores_communication ,review_scores_location ,review_scores_value ,reviews_per_month 
FROM listings;

-- Fill Web Scrape Table
INSERT INTO web_scrape (
    id, scrape_id, last_scraped, source
)
SELECT
    id, scrape_id, last_scraped, source
FROM listings;

-- Remove redudancy from listings table
ALTER TABLE listings
DROP COLUMN host_url,
DROP COLUMN host_name,
DROP COLUMN host_since,
DROP COLUMN host_location,
DROP COLUMN host_about,
DROP COLUMN host_response_time,
DROP COLUMN host_response_rate,
DROP COLUMN host_acceptance_rate,
DROP COLUMN host_is_superhost,
DROP COLUMN host_thumbnail_url,
DROP COLUMN host_picture_url,
DROP COLUMN host_neighbourhood,
DROP COLUMN host_listings_count,
DROP COLUMN host_total_listings_count,
DROP COLUMN host_verifications,
DROP COLUMN host_has_profile_pic,
DROP COLUMN host_identity_verified,
DROP COLUMN calculated_host_listings_count,
DROP COLUMN calculated_host_listings_count_entire_homes,
DROP COLUMN calculated_host_listings_count_private_rooms,
DROP COLUMN calculated_host_listings_count_shared_rooms,
DROP COLUMN price_dkk,
DROP COLUMN minimum_nights,
DROP COLUMN maximum_nights,
DROP COLUMN minimum_minimum_nights,
DROP COLUMN maximum_minimum_nights,
DROP COLUMN minimum_maximum_nights,
DROP COLUMN maximum_maximum_nights,
DROP COLUMN minimum_nights_avg_ntm,
DROP COLUMN maximum_nights_avg_ntm,
DROP COLUMN availability_30,
DROP COLUMN availability_60,
DROP COLUMN availability_90,
DROP COLUMN availability_365,
DROP COLUMN calendar_last_scraped,
DROP COLUMN has_availability,
DROP COLUMN instant_bookable,
DROP COLUMN number_of_reviews,
DROP COLUMN number_of_reviews_ltm,
DROP COLUMN number_of_reviews_l30d,
DROP COLUMN first_review,
DROP COLUMN last_review,
DROP COLUMN review_scores_rating,
DROP COLUMN review_scores_accuracy,
DROP COLUMN review_scores_cleanliness,
DROP COLUMN review_scores_checkin,
DROP COLUMN review_scores_communication,
DROP COLUMN review_scores_location,
DROP COLUMN review_scores_value,
DROP COLUMN reviews_per_month,
DROP COLUMN scrape_id,
DROP COLUMN last_scraped,
DROP COLUMN source;

-- Add constraint to listings (host_id foreign key and neighbourhood foreign key)
ALTER TABLE listings
ADD CONSTRAINT fk_host_id
FOREIGN KEY (host_id)
REFERENCES hosts(host_id)
ON DELETE SET NULL;
----------------------------------------------------------------------------------------------------------------------------
