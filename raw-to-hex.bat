@echo off
REM Convert network weights binary to hex format

copy network_atonbuf.xSPI2.raw network_data.xSPI2.bin
arm-none-eabi-objcopy -I binary network_data.xSPI2.bin --change-addresses 0x71000000 -O ihex network_data.hex
exit
