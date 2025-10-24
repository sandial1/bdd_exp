# Observations

This is a test project to get familiar with wdio and cucumber in the Behaviour Driven Development testing space.

## NPM vs PNPM

NPM has had some really bad moments in regards to security issues which highlight a fundamental issue with it:

**Security was not a primary consideration in its development**, sure its been progressively being enhanced in this
regard integrating developments from comparable tools like yarn and pnpm but its package toolchain has been vulnerated
in many occasions thorugh social engineering which means that for the moment it is a risk.

One of the considerations I made for this project is to move away from npm as a package manager and use instead pnpm
as a safer alternative. This comes with its own issues since pnpm does not allow post install scripts by default
(which is an intended security feature) creates a certain level of friction while trying to get my dev environment working.
Amongst them:

- Progressively detect and install (manually first and then add to the setup script) the strictly neccesary dependencies.
- Setup addons and plugins for the wdio framework to run the appropiate test using headless browsers

Due to conflict with system level dependencies I moved the project inside a docker container with volumes for pnpm
installs and project files. This in turn generated a series of conflicts that I solved with a stop gap measure:

```bash
pnpm install --dangerously-allow-all-builds
```

This is counter productive in the sense that while it allows me to get everything setup properly it bypasses many
security intended checks.
