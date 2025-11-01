@echo off
REM Copy the raw binary to a .bin file
copy network_atonbuf.xSPI2.raw network_data.xSPI2.bin

REM Convert binary to hex with specified flash memory address
arm-none-eabi-objcopy -I binary network_data.xSPI2.bin --change-addresses 0x71000000 -O ihex network_data.hex
