---
title: "Codebook for run_analysis.R"
---


# Description

This markdown gives the information on the variables used in the analysis, their classes, values ranges and units.

# Numeric Variables

Typical representation of a numeric variable follows this pattern: [x][Parameter]-[operation]-[direction]

##[x]
Denotes the domain in which the value is measured.

1. t - time domain
2. f - frequency domaun
3. Mean prefix to t or f denotes it is the mean value calculated in step 5 (mean variable for each subject for each activity)

##[parameter]
Denotes the parameter that is measrued

### BodyAcc

Description: Body Acceleration - The component of acceleration due to body movement alone after separating gravity component from total accerlation

UNITs: m/s2. 
Class: Numeric. 
Value range: -1 to 1

### GravityAcc 
Description: Gravity Acceleration - The component of acceleration due to gravity alone

UNITs: m/s2. 
Class: Numeric. 
Value range: -1 to 1

### BodyAccJerk
Description: Jerk from body acceleration - Jerk is defined as rate of change of acceleration. This jerk is computed purely based on body acceleration

UNITs: m/s3. 
Class: Numeric 
Value range: -1 to 1

### BodyGyro 
Description: Body Angular velocity - This variable is the output of the gyroscope sensor and will give the angular velocty

UNITs: rad/s. 
Class: Numeric 
Value range: -1 to 1

### BodyGyroJerk
Description: Jerk from body angular velocity - Angular Jerk is defined as rate of change of angular acceleration. This jerk is computed purely based on body acceleration

UNITs: rad/s2. 
Class: Numeric 
Value range: -1 to 1

### BodyAccMag
Description: Magnitude of the Body acceleration without having any directional reference. It is obtained by taking the square root of sum of squares of body component in X, Y and Z direction. The sign shows the vector direction of the component.

UNITs: m/s2. 
Class: Numeric 
Value range: -1 to 1

### GravityAccMag
Description: Magnitude of the gravity acceleration without having any directional reference. It is obtained by taking the square root of sum of squares of gravity component in X, Y and Z direction. The sign shows the vector direction of the component.

UNITs: m/s2. 
Class: Numeric 
Value range: -1 to 1

### BodyAccJerkMag
Description: Magnitude of the jerk without having any directional reference. It is obtained by taking the square root of sum of squares of jerk component in X, Y and Z direction. The sign shows the vector direction of the component.

UNITs: m/s3. 
Class: Numeric 
Value range: -1 to 1

### BodyGyroMag
Description: Magnitude of the angular velocity without having any directional reference. It is obtained by taking the square root of sum of squares of components in X, Y and Z direction. The sign shows the vector direction of the component.

UNITs: rad/s. 
Class: Numeric 
Value range: -1 to 1

### BodyGyroJerkMag
Description: Magnitude of the jerk due to angular acceleration without having any directional reference. It is obtained by taking the square root of sum of squares of components in X, Y and Z direction. The sign shows the vector direction of the component.

UNITs: rad/s. 
Class: Numeric 
Value range: -1 to 1

##[Operation]
The kind of operation performed on the data

1. mean(): Mean value
2. std(): Standard deviation
3. mad(): Median absolute deviation 
4. max(): Largest value in array
5. min(): Smallest value in array
6. sma(): Signal magnitude area
7. energy(): Energy measure. Sum of the squares divided by the number of values. 
8. iqr(): Interquartile range 
8. entropy(): Signal entropy
10. arCoeff(): Autorregresion coefficients with Burg order equal to 4
11. correlation(): correlation coefficient between two signals
12. maxInds(): index of the frequency component with largest magnitude
13. meanFreq(): Weighted average of the frequency components to obtain a mean frequency
14. skewness(): skewness of the frequency domain signal 
15. kurtosis(): kurtosis of the frequency domain signal 
16. bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
17. angle(): Angle between two vectors

##[direction]
the direction of the component. it is not applicable for the magnitude parameters as they are the resultant values with no directional reference

1. X: X-axis direction
2. Y: Y-axis direction
3. Z: Z-axis direction

# Non-numeric variable
Variables that signifies the activity performed, subject on which the measurement is taken or the dataset type comes under this category.

## Dataset
Description: It identifies the type of data.
Class: Factor
Values: 2 Levels - "Test", 'Train

1. Test: belongs to the test set
2. Train: belongs to the train set

## Subject
Description: Identifies the person on which the measruement is taken.

Class: Factor
Values: 30 Levels - Subject1, Subject2, SUbject3...Subject30

1.  Subject1
2.  Subject11
3.  Subject14
4.  Subject15
5.  Subject16
6.  Subject17
7.  Subject19
8.  Subject21
9.  Subject22
10. Subject23
11. Subject25
12. Subject26
13. Subject27
14. Subject28
15. Subject29
16. Subject3
17. Subject30
18. Subject5
19. Subject6
20. Subject7
21. Subject8
22. Subject10
23. Subject12
24. Subject13
25. Subject18
26. Subject2
27. Subject20
28. Subject24
29. Subject4
30. Subject9


## Activity
Description: identifies the activity for which the measrement is taken.

Class: Factor
Values: 6 Levels - "Lay","Sit","Stand","Walk","Walk_down","Walk_up"

1. Lay
2. Sit
3. Stand
4. Walk
5. Walk_down
6. Walk_up


