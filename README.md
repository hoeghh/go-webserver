# go-webserver
A simple service example for the go-plan

## List available targets
to get both local and plan targets, run
```
make list
```

### Build the go code
Simply run
```
make build
```

### Build docker container
Again, simply run 
```
make build-container
```

### Scan the container for security issues (sysdig)
even easier
```
make scan
```

### Extend the plan locally
simply create a folder called "scripts" and put the new script there. It should be executable and have a line like
```
# Help .......
```
Then it will show up in the `make list` command

### Opt out of a single target
Let's say that the build target is not good enough, and you want to opt out of that one target. Simply run
```
make copy-build
```
Now it will create a folder called scripts in your repo and copy the build script from the plan to this folder. It will have set executable permissions by default. Not check `make list` and it will be listed twice, one for the local target and one for the target in the plan. If you run `make build` it will always run the local target you just created

### how to remove an opt out
Let's say you opt out on the build target but wants to use the plan version again (always). Simply delete the script in the local folder `scripts`. Run `make list` to verify that it only exist in the plan now.