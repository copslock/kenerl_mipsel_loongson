Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9PHUil20451
	for linux-mips-outgoing; Thu, 25 Oct 2001 10:30:44 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9PHUVD20445;
	Thu, 25 Oct 2001 10:30:31 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9PHUSE0011566;
	Thu, 25 Oct 2001 10:30:28 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9PHUSkM011562;
	Thu, 25 Oct 2001 10:30:28 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Thu, 25 Oct 2001 10:30:28 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: [PATCH] Various diffs that fix things.
Message-ID: <Pine.LNX.4.10.10110251019420.8950-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Some of these patches are need to make the mips tree compile again. Please
apply. Thank you.

--- /tmp/linux-sgi/include/asm-mips/bugs.h	Wed Oct 24 16:25:45 2001
+++ bugs.h	Thu Oct 25 10:15:24 2001
@@ -3,6 +3,7 @@
  * Copyright (C) 1997, 1999  Ralf Baechle
  */
 #include <asm/bootinfo.h>
+#include <asm/processor.h>
 #include <asm/cpu.h>
 
 /*
--- /tmp/linux-sgi/include/asm-mips/processor.h	Fri Oct 19 13:51:06 2001
+++ processor.h	Thu Oct 25 10:15:24 2001
@@ -40,6 +40,7 @@
  * System setup and hardware flags..
  */
 extern void (*cpu_wait)(void);	/* only available on R4[26]00 and R3081 */
+extern void r39xx_wait(void);
 extern void r3081_wait(void);
 extern void r4k_wait(void);
 extern char cyclecounter_available;	/* only available from R4000 upwards. */
--- linux-sgi/drivers/i2c/Config.in	Fri Oct 19 11:47:49 2001
+++ linux-mips/drivers/i2c/Config.in	Thu Jun 21 19:29:32 2001
@@ -27,13 +27,6 @@
       fi
    fi
 
-   if [ "$CONFIG_MIPS_ITE8172" = "y" ]; then
-      dep_tristate 'ITE I2C Algorithm' CONFIG_ITE_I2C_ALGO $CONFIG_I2C
-      if [ "$CONFIG_ITE_I2C_ALGO" != "n" ]; then
-         dep_tristate '  ITE I2C Adapter' CONFIG_ITE_I2C_ADAP $CONFIG_ITE_I2C_ALGO
-      fi
-   fi
-
 # This is needed for automatic patch generation: sensors code starts here
 # This is needed for automatic patch generation: sensors code ends here
 
--- /tmp/linux-sgi/drivers/char/Config.in	Fri Oct 19 11:12:40 2001
+++ Config.in	Thu Oct 25 10:25:19 2001
@@ -68,6 +68,11 @@
 fi
 if [ "$CONFIG_MIPS_ITE8172" = "y" -o "$CONFIG_MIPS_IVR" = "y" ]; then
    bool 'Enable Qtronix 990P Keyboard Support' CONFIG_QTRONIX_KEYBOARD
+   if [ "$CONFIG_QTRONIX_KEYBOARD" = "y" ]; then
+     define_bool CONFIG_IT8172_CIR y
+   else
+     bool '    Enable PS2 Keyboard Support' CONFIG_PC_KEYB
+   fi
    bool 'Enable Smart Card Reader 0 Support ' CONFIG_IT8172_SCR0
    bool 'Enable Smart Card Reader 1 Support ' CONFIG_IT8172_SCR1
 fi
@@ -82,24 +87,6 @@
       fi
       bool '  Console on DC21285 serial port' CONFIG_SERIAL_21285_CONSOLE
    fi
-   if [ "$CONFIG_MIPS" = "y" ]; then
-     bool '  TMPTX3912/PR31700 serial port support' CONFIG_SERIAL_TX3912
-     dep_bool '     Console on TMPTX3912/PR31700 serial port' CONFIG_SERIAL_TX3912_CONSOLE $CONFIG_SERIAL_TX3912
-     bool '  Enable Au1000 UART Support' CONFIG_AU1000_UART
-     if [ "$CONFIG_AU1000_UART" = "y" ]; then
-         bool '        Enable Au1000 serial console' CONFIG_AU1000_SERIAL_CONSOLE
-     fi
-   fi
-fi
-if [ "$CONFIG_IT8712" = "y" ]; then
-   bool 'Enable Qtronix 990P Keyboard Support' CONFIG_QTRONIX_KEYBOARD
-   if [ "$CONFIG_QTRONIX_KEYBOARD" = "y" ]; then
-     define_bool CONFIG_IT8172_CIR y
-   else
-     bool '    Enable PS2 Keyboard Support' CONFIG_PC_KEYB
-   fi
-   bool 'Enable Smart Card Reader 0 Support ' CONFIG_IT8172_SCR0
-   bool 'Enable Smart Card Reader 1 Support ' CONFIG_IT8172_SCR1
 fi
 bool 'Unix98 PTY support' CONFIG_UNIX98_PTYS
 if [ "$CONFIG_UNIX98_PTYS" = "y" ]; then
@@ -177,6 +164,7 @@
       fi
    fi
    tristate '  ZF MachZ Watchdog' CONFIG_MACHZ_WDT
+   dep_tristate '  NEC VR41xx Watchdog (DSU)' CONFIG_VR41XX_WDT $CONFIG_CPU_VR41XX
 fi
 endmenu
 
