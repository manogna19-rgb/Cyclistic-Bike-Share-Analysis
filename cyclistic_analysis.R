# -----------------------------------------
# Cyclistic Bike Share Analysis
# -----------------------------------------

# Load required libraries
library(readr)
library(ggplot2)

# Load dataset
bike_data <- read_csv("202301-divvy-tripdata.csv")

# Preview data
head(bike_data)

# Convert columns to datetime format
bike_data$started_at <- as.POSIXct(bike_data$started_at)
bike_data$ended_at <- as.POSIXct(bike_data$ended_at)

# Create ride length (in seconds)
bike_data$ride_length <- as.numeric(bike_data$ended_at - bike_data$started_at)

# Create weekday column
bike_data$weekday <- weekdays(bike_data$started_at)

# Clean data (remove invalid rides)
clean_data <- bike_data[bike_data$ride_length > 0 & bike_data$ride_length < 86400, ]

# Summary statistics
summary(clean_data$ride_length)

# Average ride length by user type
aggregate(ride_length ~ member_casual, data = clean_data, mean)

# Number of rides by user type
table(clean_data$member_casual)

# -----------------------------------------
# Visualization: Average Ride Length
# -----------------------------------------

ggplot(clean_data, aes(x = member_casual, y = ride_length, fill = member_casual)) +
  stat_summary(fun = mean, geom = "bar") +
  labs(title = "Average Ride Length by User Type",
       x = "User Type",
       y = "Average Ride Length (seconds)") +
  theme_minimal()

