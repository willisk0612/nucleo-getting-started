@echo off
REM Sign the FSBL binary
STM32_SigningTool_CLI.exe -bin "FSBL\Debug\nucleo-example-project_FSBL.bin" -nk -of 0x80000000 -t fsbl -o "nucleo-example-project_FSBL-trusted.bin" -hv 2.3 -dump "nucleo-example-project_FSBL-trusted.bin"

REM Sign the Appli binary
STM32_SigningTool_CLI.exe -bin "Appli\Debug\nucleo-example-project_Appli.bin" -nk -of 0x80000000 -t fsbl -o "nucleo-example-project_Appli-trusted.bin" -hv 2.3 -dump "nucleo-example-project_Appli-trusted.bin"
exit
