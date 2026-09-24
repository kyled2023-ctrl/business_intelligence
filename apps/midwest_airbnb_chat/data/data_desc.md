# Midwest Airbnb data dictionary

## Dataset

`data/midwest_airbnb.db` contains one SQLite table, `listings`, with **14,887 rows and 29 columns**. Each row represents one listing. All 14,887 listing IDs are distinct in this copy; hosts can own several listings.

| Market | Snapshot date | Rows |
| --- | --- | ---: |
| Chicago | 2026-07-20 | 7,439 |
| Columbus | 2026-07-23 | 2,587 |
| Twin Cities | 2026-07-21 | 4,861 |

## All 29 columns

Types below are the **SQLite declared types in this course database**, which can differ from the types in the original CSV dictionary. Examples, ranges, and missing-value counts were inspected directly from this database. Ranges exclude NULL values. Numeric identifiers are stored as TEXT to preserve their digits.

| Column | SQLite type | Meaning | Observed values / interpretation | NULL rows |
| --- | --- | --- | --- | ---: |
| `city` | TEXT | Course market label. | `Chicago`, `Columbus`, `Twin Cities` | 0 |
| `snapshot_date` | TEXT | Date of the market snapshot. | `2026-07-20`, `2026-07-23`, `2026-07-21`; ISO YYYY-MM-DD | 0 |
| `id` | TEXT | Unique listing identifier. | Example: `2384`; preserve as text, including large digit strings | 0 |
| `name` | TEXT | Listing title. | Example: `Tiny Studio Apartment 94 Walk Score` | 0 |
| `host_id` | TEXT | Host account identifier; may repeat across listings. | Example: `2613`; preserve as text | 0 |
| `host_name` | TEXT | Host display name. | Example: `Rebecca`; names are not unique identifiers | 25 |
| `host_since` | TEXT | Host account creation date. | All 14,887 values are NULL; no observed dates | 14,887 |
| `host_is_superhost` | TEXT | Superhost status at the snapshot. | `t` = yes; `f` = no; NULL = unknown | 25 |
| `neighbourhood` | TEXT | Area label within the market. | Examples: `Hyde Park`, `Westland`; use together with `city` | 0 |
| `latitude` | REAL | Approximate north-south coordinate in decimal degrees. | Observed range: 39.8753494 to 46.24415 | 0 |
| `longitude` | REAL | Approximate east-west coordinate in decimal degrees. | Observed range: -94.52678888 to -82.7809534 | 0 |
| `property_type` | TEXT | Detailed accommodation category. | Examples: `Entire rental unit`, `Private room in condo`, `Barn` | 0 |
| `room_type` | TEXT | Broad accommodation category. | `Entire home/apt`, `Private room`, `Shared room`, `Hotel room` | 0 |
| `accommodates` | INTEGER | Reported maximum guest capacity. | Observed range: 1 to 16 guests | 0 |
| `bedrooms` | REAL | Reported bedroom count. | Observed nonmissing range: 1 to 16; stored as REAL | 2,976 |
| `beds` | REAL | Reported bed count. | Observed nonmissing range: 1 to 32; stored as REAL | 668 |
| `bathrooms_text` | TEXT | Bathroom description, including shared/private qualifiers. | Examples: `1 bath`, `1.5 baths`, `1 shared bath`, `Shared half-bath` | 71 |
| `price` | REAL | Listed nightly price in USD. | Observed range: $2.56 to $11,412.00; numeric, without currency symbols | 0 |
| `minimum_nights` | INTEGER | Required minimum stay length. | Observed nonmissing range: 1 to 365 nights | 15 |
| `availability_365` | INTEGER | Calendar-available nights over the next 365 days. | Observed range: 0 to 365; not an occupancy measure | 0 |
| `number_of_reviews` | INTEGER | Total recorded review count. | Observed range: 0 to 2,246 reviews | 0 |
| `number_of_reviews_ltm` | INTEGER | Review count during the last twelve months. | Observed range: 0 to 1,220 reviews | 0 |
| `first_review` | TEXT | Date of the earliest recorded review. | Observed range: `2009-07-03` to `2026-07-20`; ISO YYYY-MM-DD | 1,761 |
| `last_review` | TEXT | Date of the most recent recorded review. | Observed range: `2014-08-23` to `2026-07-22`; ISO YYYY-MM-DD | 1,761 |
| `review_scores_rating` | REAL | Overall guest rating. | Observed nonmissing range: 1 to 5 stars; NULL is not zero | 1,761 |
| `reviews_per_month` | REAL | Average monthly review rate. | Observed nonmissing range: 0.01 to 77.72 reviews per month | 1,761 |
| `instant_bookable` | TEXT | Whether booking requires host approval. | All values NULL here; source convention is `t` = instant booking, `f` = approval required | 14,887 |
| `estimated_revenue_l365d` | REAL | Estimated revenue over the prior 365 days, USD. | Observed range: $0.00 to $1,114,800.00; model estimate, not verified income or profit | 0 |
| `amenities_count` | INTEGER | Count of recorded amenities. | Observed range: 0 to 100; individual amenity names are not included | 0 |

## Interpretation notes

- `city`, `snapshot_date`, and the compact selection of fields belong to the course's combined dataset. Use the stored names here, such as `neighbourhood`, rather than assuming every raw Inside Airbnb field is available.
- `host_since` and `instant_bookable` are entirely NULL. Do not infer host tenure or instant-booking prevalence from them.
- Missing bedrooms, beds, ratings, and review dates remain unknown. In SQL, `COUNT(*)` counts listings while `COUNT(column)` counts nonmissing values; `AVG(column)` ignores NULL values.
- Prices are nightly amounts, not complete trip prices. Do not assume cleaning fees, taxes, or service fees are included. Compare the same room types and markets when possible.
- An unavailable calendar night may be booked or blocked. `availability_365` does not identify which and cannot establish actual occupancy.
- Revenue is a model-based estimate. Do not reinterpret `estimated_revenue_l365d` as actual receipts, profit, or guaranteed future earnings.
- Coordinates are approximate. These snapshots support historical market comparisons, not current booking availability.
- `amenities_count` counts entries but does not reveal which amenities exist. The database cannot answer whether a listing has a specific amenity such as a pool.

## Sources

- [Inside Airbnb data and city downloads](https://insideairbnb.com/get-the-data/)
- [Inside Airbnb data assumptions and linked dictionary](https://insideairbnb.com/data-assumptions/)
- [Course database used for the observed values above](https://github.com/fmegahed/isa401/blob/main/data/midwest_airbnb.db)

The public course copy was checked against the assignment: the table name, row count, column count, cities, and snapshot dates all match. If a Canvas download differs, use the instructor's assigned database and recheck its types, values, and missingness before substituting it.
