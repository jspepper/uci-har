README
======

This project creates a clean and tidy dataset from data gathered by
the Human Activity Recognition Experiment conducted by the Center
for Machine Learning and Intelligent Systems at the University of
California, Irvine.

The original data contains measurements from the inertial sensors present
on a Galaxy S2 smartphone. The measurements were taken from a pool of 30
volunteers wile performing six different activities: walking, walking
upstairs, walking downstairs, sitting, standing, and laying.

The run_analysis.R script combines the measurements from the original
test and training datasets. It then removes all columns except for
the computed mean and standard deviation measurements. The subject
and activity (in textual form) are added to measurement data. Each
column name is stripped of special characters and converted to
lowercase. Finally, the measurements are averaged for each activity
and subject.

