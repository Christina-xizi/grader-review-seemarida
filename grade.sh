CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [ -f student-submission/ListExamples.java ]
then
    echo 'File exists'
else
    echo 'File does not exist'
fi



cp student-submission/ListExamples.java grading-area

cp -r TestListExamples.java grading-area
cp -r lib grading-area
cd grading-area

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java
java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > output.txt

# Extract number of tests run and failures
tests_run=$(grep -o 'Tests run: [0-9]*' output.txt | awk '{print $3}')
failures=$(grep -o 'Failures: [0-9]*' output.txt | awk '{print $2}')

# Check if tests_run is greater than 0 before calculating the score
if [ "$tests_run" -gt 0 ]; then
    # Calculate the score
    score=$(( (tests_run - failures) * 100 / tests_run ))
else
    # Set a default score if no tests were run
    score=0
fi

# Check for test failures
if [ "$failures" -gt 0 ]; then
    echo "Tests failed. Score: $score"
else
    echo "All tests passed. Full Credit! Score: $score"
fi

# Clean up grading area
rm -rf ../grading-area



# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
