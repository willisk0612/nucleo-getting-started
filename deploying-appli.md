## 5. Deploying the application

### 5.1 Sign binary files with Signing Tool

Embedded systems that implement security features such as TrustZone®, as in the STM32N6, require firmware authentication. The STM32-SignTool is a key utility that ensures a secure platform by signing binary images using ECC keys. These signed binaries are used during the STM32 secure boot process to establish a trusted boot chain. This process ensures authentication and integrity checks of the loaded images.

In short, you must sign the generated binaries before flashing them to the N6.

The Signing Tool executable is located in your STM32CubeProgrammer installation directory (by default: C:/Program Files/STMicroelectronics/STM32Cube/STM32Cube Programmer/bin). To run the commands shown below, you can add the ‘bin‘ folder to your environment variables so that you can execute them from any directory.
Otherwise, run the command directly from the bin folder, specifying the full path to the binary file

```
STM32_SigningTool_CLI.exe -bin <your_project>.bin -nk -of 0x80000000 -t fsbl -o <your_project>-trusted.bin -hv 2.3 -dump <your_project>-trusted.bin
```

In our case, you want to sign two files:

* Your\_Project\_Folder/FSBL/Debug/<Your\_Project\_Name>\_FSBL.bin
* Your\_Project\_Folder/Appli/Debug/<Your\_Project\_Name>\_Appli.bin

And you should end up with 2 new files:

* <Your\_Project\_Name>\_FSBL-trusted.bin
* <Your\_Project\_Name>\_Appli-trusted.bin

For reference, the terminal output should look like:

![JulianE_1-1753437027156.png](https://community.st.com/t5/image/serverpage/image-id/114663i755DFC6E90006D66/image-dimensions/769x675/is-moderation-mode/true?v=v2 "JulianE_1-1753437027156.png")

### 5.2 Generate model weights binary image

In your project folder, you can find at the root a file named *network\_data.xSPI2.raw* that contains the weights of your model. This file results from X-CUBE-AI and in particular is the result of the ST Edge AI Core command running behind it:

```
stedgeai generate --model Model_File.tflite --target stm32n6 --st-neural-art

```

Documentation: <https://stedgeai-dc.st.com/assets/embedded-docs/index.html>

In our case, we want to rename and convert this file to network\_data.xSPI2.bin:

```
cp network_atonbuf.xSPI2.raw network_data.xSPI2.bin
```

Next, add the path to ‘arm-none-eabi-objcopy‘ to your environment variables. You can find it in your STM32CubeIDE installation, typically under: C:/ST/STM32CubeIDE\_<version>/STM32CubeIDE/plugins/ com.st.stm32cube. ide.mcu.externaltools.gnu-tools-for-stm32.13.3.rel1.win32\_1.0.0.202411081344/ tools/bin. This tool allows you to convert the ‘.bin‘ file into a ‘.hex‘ file with a specified flash memory address:

```
arm-none-eabi-objcopy -I binary network_data.xSPI2.bin --change-addresses 0x71000000 -O ihex network_data.hex

```

 You now have the hexadecimal file containing fixed weights and parameters ready for flashing.
