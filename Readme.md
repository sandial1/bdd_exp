# BDD Testing example running in docker

The idea behind this project setup is to practice making container out of testing environment to isolate my machine
out of the test environment dependencies.

## Tech stack

- Mostly wdio based testing for .js / .ts projects as a base.
- Using chrome, firefox and edge drivers for cross browser testing.
- Cucumber framework setup for BDD based testing.

## Scripts

Inside the directory scripts/ there are a series of utilities to check over the development files:

- lint-check.sh : uses pnpm dlx to run prettier --check . without installing node_modules to check the format of all
  project files without making changes.
- lint-list.sh : uses pnpm dlx to run prettier -l . without installing node_modules to list all format divergent
  files.
- lint-write.sh : uses pnpm dlx to run prettier --write . without installing node_modules to forcefully lint
  and correct all .js / .ts project files.

## Changelog

251024:4:34 PM UTC (UTC+0): Finished setting up development propery to run inside docker containers with
persistency thorugh docker volumes.
