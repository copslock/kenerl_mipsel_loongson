Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9JLbJl08130
	for linux-mips-outgoing; Fri, 19 Oct 2001 14:37:19 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9JLbED08127
	for <linux-mips@oss.sgi.com>; Fri, 19 Oct 2001 14:37:14 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9JLb2E0017450;
	Fri, 19 Oct 2001 14:37:02 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9JLb1Sq017441;
	Fri, 19 Oct 2001 14:37:02 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Fri, 19 Oct 2001 14:37:00 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@oss.sgi.com
Subject: [PATCH] various Config.in fixes
In-Reply-To: <20011019225745.B28818@dea.linux-mips.net>
Message-ID: <Pine.LNX.4.10.10110191433540.12625-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Both of these are repeated twice in the config options. Please apply these
patches to remove this.

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
--- linux-sgi/drivers/char/Config.in	Fri Oct 19 11:12:40 2001
+++ linux-mips/drivers/char/Config.in	Fri Oct 19 11:26:32 2001
@@ -82,24 +82,6 @@
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
 
