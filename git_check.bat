@echo off
cd /d "C:\src\Github - P-TC\Website"

echo === GIT LOG (last 3 commits) === > git_output.txt
git log --oneline -3 >> git_output.txt 2>&1

echo. >> git_output.txt
echo === GIT STATUS === >> git_output.txt
git status >> git_output.txt 2>&1

echo. >> git_output.txt
echo === EXISTING TAGS === >> git_output.txt
git tag >> git_output.txt 2>&1
