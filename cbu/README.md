# cbu

The __*C*__ontainer __*B*__ackup __*U*__tility

## How to Install

1. Clone this repo to your local machine
2. Run the `install.sh` script. (as root)
3. Restart your shell. You should now have access to the `cbu` command!

## Troubleshooting

* This is __NOT__ windows compliant. It will __NOT__ work in `cmd.exe` or `powershell`. It was developed strictly to help making backups easier on the machine running our containers, which runs Linux!
* Make sure the file has execute permissions before trying to run it!

That means it should looks something like this when you do an `ls -l` in the folder it's in.

```console
-rwxr-xr-x 1 <user> <group> <size> <Last Modified> cbu 
```

## How to use

`cbu -h` __OR__ `cbu --help`

