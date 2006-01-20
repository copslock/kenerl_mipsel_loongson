Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 14:45:04 +0000 (GMT)
Received: from p549F7826.dip.t-dialin.net ([84.159.120.38]:39286 "EHLO
	mail.linux-mips.net") by ftp.linux-mips.org with ESMTP
	id S3686579AbWATOod (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 14:44:33 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.4/8.13.1) with ESMTP id k0KElFAc032751;
	Fri, 20 Jan 2006 15:47:15 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.4/8.13.4/Submit) id k0KElAgw032749;
	Fri, 20 Jan 2006 15:47:10 +0100
Date:	Fri, 20 Jan 2006 15:47:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Crash on Cobalt with CONFIG_SERIO=y
Message-ID: <20060120144710.GA30415@linux-mips.org>
References: <20060120004208.GA18327@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120004208.GA18327@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 20, 2006 at 12:42:08AM +0000, Martin Michlmayr wrote:

> I get the following crash on Cobalt when CONFIG_SERIO=y is set.
> I realize that this option is not really necessary on Cobalt but the
> kernel should neverless not crash if it is enabled.
> 
> 
>  Activating ISA DMA hang workarounds.
>  rtc: Digital UNIX epoch (1952) detected
>  Real Time Clock Driver v1.12a
>  Cobalt LCD Driver v2.10
>  i8042.c: i8042 controller self test timeout.
>  Unhandled kernel unaligned access[#1]:

The i8042 error message is a little surprising.  The Cobalt boards afair
have some sort of SuperIO chip on the board which includes PS/2 keyboard
even though that has not been wired.  I wonder if anybody can take a
look at the board what type of SuperIO is there?

Anyway, the kernel code seems to be correct at a glance so I have to
assume the PS/2 hardware really doesn't work and I propose below patch.

  Ralf

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4ca93ff..d5b175b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -251,6 +251,7 @@ config LASAT
 	select MIPS_GT64120
 	select MIPS_NILE4
 	select R5000_CPU_SCACHE
+	select SERIO_I8042
 	select SYS_HAS_CPU_R5000
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
@@ -438,6 +439,7 @@ config MIPS_XXS1500
 config PNX8550_V2PCI
 	bool "Support for Philips PNX8550 based Viper2-PCI board"
 	select PNX8550
+	select SERIO_I8042
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config PNX8550_JBS
@@ -550,6 +552,7 @@ config SGI_IP22
 	select HW_HAS_EISA
 	select IP22_CPU_SCACHE
 	select IRQ_CPU
+	select SERIO_I8042
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_R4X00
 	select SYS_HAS_CPU_R5000
@@ -713,6 +716,7 @@ config SNI_RM200_PCI
 	select HW_HAS_PCI
 	select I8259
 	select ISA
+	select SERIO_I8042
 	select SYS_HAS_CPU_R4X00
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
@@ -762,6 +766,7 @@ config TOSHIBA_RBTX4938
 	select HW_HAS_PCI
 	select I8259
 	select ISA
+	select SERIO_I8042
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_TX49XX
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/configs/atlas_defconfig b/arch/mips/configs/atlas_defconfig
index 85e08aa..abfe9c0 100644
--- a/arch/mips/configs/atlas_defconfig
+++ b/arch/mips/configs/atlas_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:26 2006
+# Fri Jan 20 14:16:02 2006
 #
 CONFIG_MIPS=y
 
@@ -903,7 +903,6 @@ CONFIG_MOUSE_SERIAL=m
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 CONFIG_SERIO_LIBPS2=y
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index 75db2a9..86de8fc 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:27 2006
+# Fri Jan 20 14:16:03 2006
 #
 CONFIG_MIPS=y
 
@@ -535,7 +535,6 @@ CONFIG_NET_SB1250_MAC=y
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/cobalt_defconfig b/arch/mips/configs/cobalt_defconfig
index adea137..0700da4 100644
--- a/arch/mips/configs/cobalt_defconfig
+++ b/arch/mips/configs/cobalt_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:27 2006
+# Fri Jan 20 14:16:05 2006
 #
 CONFIG_MIPS=y
 
@@ -530,7 +530,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/db1000_defconfig b/arch/mips/configs/db1000_defconfig
index 75c3e35..dbc91ef 100644
--- a/arch/mips/configs/db1000_defconfig
+++ b/arch/mips/configs/db1000_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:27 2006
+# Fri Jan 20 14:16:06 2006
 #
 CONFIG_MIPS=y
 
@@ -604,7 +604,6 @@ CONFIG_INPUT_EVDEV=y
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_LIBPS2 is not set
 CONFIG_SERIO_RAW=m
diff --git a/arch/mips/configs/db1100_defconfig b/arch/mips/configs/db1100_defconfig
index 89ac1aa..95326df 100644
--- a/arch/mips/configs/db1100_defconfig
+++ b/arch/mips/configs/db1100_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:27 2006
+# Fri Jan 20 14:16:07 2006
 #
 CONFIG_MIPS=y
 
@@ -580,7 +580,6 @@ CONFIG_INPUT_EVDEV=y
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 CONFIG_SERIO_LIBPS2=m
 CONFIG_SERIO_RAW=m
diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index e7cd15e..6ae4bdf 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:28 2006
+# Fri Jan 20 14:16:08 2006
 #
 CONFIG_MIPS=y
 
@@ -645,7 +645,6 @@ CONFIG_INPUT_EVDEV=y
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_LIBPS2 is not set
 CONFIG_SERIO_RAW=y
diff --git a/arch/mips/configs/db1500_defconfig b/arch/mips/configs/db1500_defconfig
index 03f1364..52551e9 100644
--- a/arch/mips/configs/db1500_defconfig
+++ b/arch/mips/configs/db1500_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:28 2006
+# Fri Jan 20 14:16:10 2006
 #
 CONFIG_MIPS=y
 
@@ -671,7 +671,6 @@ CONFIG_INPUT_EVDEV=y
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/db1550_defconfig b/arch/mips/configs/db1550_defconfig
index de88f39..016530d 100644
--- a/arch/mips/configs/db1550_defconfig
+++ b/arch/mips/configs/db1550_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:28 2006
+# Fri Jan 20 14:16:11 2006
 #
 CONFIG_MIPS=y
 
@@ -711,7 +711,6 @@ CONFIG_INPUT_EVDEV=y
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/ddb5476_defconfig b/arch/mips/configs/ddb5476_defconfig
index d885993..0c85a90 100644
--- a/arch/mips/configs/ddb5476_defconfig
+++ b/arch/mips/configs/ddb5476_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:28 2006
+# Fri Jan 20 14:16:12 2006
 #
 CONFIG_MIPS=y
 
@@ -546,7 +546,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/ddb5477_defconfig b/arch/mips/configs/ddb5477_defconfig
index 108f8e2..bca51f7 100644
--- a/arch/mips/configs/ddb5477_defconfig
+++ b/arch/mips/configs/ddb5477_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:29 2006
+# Fri Jan 20 14:16:13 2006
 #
 CONFIG_MIPS=y
 
@@ -531,7 +531,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/e55_defconfig b/arch/mips/configs/e55_defconfig
index f3db69e..07372d6 100644
--- a/arch/mips/configs/e55_defconfig
+++ b/arch/mips/configs/e55_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:29 2006
+# Fri Jan 20 14:16:15 2006
 #
 CONFIG_MIPS=y
 
@@ -511,7 +511,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=240
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_LIBPS2 is not set
 CONFIG_SERIO_RAW=m
diff --git a/arch/mips/configs/ev64120_defconfig b/arch/mips/configs/ev64120_defconfig
index 20e1316..048e1ce 100644
--- a/arch/mips/configs/ev64120_defconfig
+++ b/arch/mips/configs/ev64120_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:29 2006
+# Fri Jan 20 14:16:17 2006
 #
 CONFIG_MIPS=y
 
@@ -525,7 +525,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/ev96100_defconfig b/arch/mips/configs/ev96100_defconfig
index 159d5fe..edb0876 100644
--- a/arch/mips/configs/ev96100_defconfig
+++ b/arch/mips/configs/ev96100_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:29 2006
+# Fri Jan 20 14:16:18 2006
 #
 CONFIG_MIPS=y
 
@@ -478,7 +478,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_LIBPS2 is not set
 CONFIG_SERIO_RAW=m
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 90ec84f..ebb602e 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:30 2006
+# Fri Jan 20 14:16:20 2006
 #
 CONFIG_MIPS=y
 
@@ -633,7 +633,6 @@ CONFIG_SGI_IOC3_ETH_HW_TX_CSUM=y
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 CONFIG_SERIO_LIBPS2=m
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index 23dcecc..391695d 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Thu Jan 19 14:38:42 2006
+# Fri Jan 20 14:16:21 2006
 #
 CONFIG_MIPS=y
 
@@ -591,7 +591,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_MACEPS2 is not set
diff --git a/arch/mips/configs/it8172_defconfig b/arch/mips/configs/it8172_defconfig
index 128a3b1..dec0e18 100644
--- a/arch/mips/configs/it8172_defconfig
+++ b/arch/mips/configs/it8172_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:30 2006
+# Fri Jan 20 14:16:22 2006
 #
 CONFIG_MIPS=y
 
@@ -571,7 +571,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_LIBPS2 is not set
 CONFIG_SERIO_RAW=m
diff --git a/arch/mips/configs/ivr_defconfig b/arch/mips/configs/ivr_defconfig
index 09709b0..1faf00b 100644
--- a/arch/mips/configs/ivr_defconfig
+++ b/arch/mips/configs/ivr_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:31 2006
+# Fri Jan 20 14:16:24 2006
 #
 CONFIG_MIPS=y
 
@@ -537,7 +537,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index 9b6d676..4241657 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:31 2006
+# Fri Jan 20 14:16:28 2006
 #
 CONFIG_MIPS=y
 
@@ -508,7 +508,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 86a7f50..2c6e0c3 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:31 2006
+# Fri Jan 20 14:16:31 2006
 #
 CONFIG_MIPS=y
 
@@ -938,7 +938,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/mipssim_defconfig b/arch/mips/configs/mipssim_defconfig
index 7c1872b..3db9a72 100644
--- a/arch/mips/configs/mipssim_defconfig
+++ b/arch/mips/configs/mipssim_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:32 2006
+# Fri Jan 20 14:16:32 2006
 #
 CONFIG_MIPS=y
 
@@ -509,7 +509,6 @@ CONFIG_INPUT=y
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_LIBPS2 is not set
 # CONFIG_SERIO_RAW is not set
diff --git a/arch/mips/configs/mpc30x_defconfig b/arch/mips/configs/mpc30x_defconfig
index 804aeda..13afef3 100644
--- a/arch/mips/configs/mpc30x_defconfig
+++ b/arch/mips/configs/mpc30x_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:32 2006
+# Fri Jan 20 14:16:33 2006
 #
 CONFIG_MIPS=y
 
@@ -584,7 +584,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/ocelot_3_defconfig b/arch/mips/configs/ocelot_3_defconfig
index d3cc3dc..dc43187 100644
--- a/arch/mips/configs/ocelot_3_defconfig
+++ b/arch/mips/configs/ocelot_3_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:32 2006
+# Fri Jan 20 14:16:34 2006
 #
 CONFIG_MIPS=y
 
@@ -650,7 +650,6 @@ CONFIG_INPUT=y
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 # CONFIG_SERIO_SERPORT is not set
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/ocelot_c_defconfig b/arch/mips/configs/ocelot_c_defconfig
index bbb5316..fbb63d9 100644
--- a/arch/mips/configs/ocelot_c_defconfig
+++ b/arch/mips/configs/ocelot_c_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:32 2006
+# Fri Jan 20 14:16:35 2006
 #
 CONFIG_MIPS=y
 
@@ -518,7 +518,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/ocelot_defconfig b/arch/mips/configs/ocelot_defconfig
index 2d1c73e..791a1fe 100644
--- a/arch/mips/configs/ocelot_defconfig
+++ b/arch/mips/configs/ocelot_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:33 2006
+# Fri Jan 20 14:16:37 2006
 #
 CONFIG_MIPS=y
 
@@ -474,7 +474,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_LIBPS2 is not set
 CONFIG_SERIO_RAW=y
diff --git a/arch/mips/configs/ocelot_g_defconfig b/arch/mips/configs/ocelot_g_defconfig
index 062e0e6..5e636cf 100644
--- a/arch/mips/configs/ocelot_g_defconfig
+++ b/arch/mips/configs/ocelot_g_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:33 2006
+# Fri Jan 20 14:16:38 2006
 #
 CONFIG_MIPS=y
 
@@ -521,7 +521,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/pb1100_defconfig b/arch/mips/configs/pb1100_defconfig
index f8e9bbf..075541d 100644
--- a/arch/mips/configs/pb1100_defconfig
+++ b/arch/mips/configs/pb1100_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:33 2006
+# Fri Jan 20 14:16:39 2006
 #
 CONFIG_MIPS=y
 
@@ -598,7 +598,6 @@ CONFIG_INPUT_EVDEV=y
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_LIBPS2 is not set
 CONFIG_SERIO_RAW=m
diff --git a/arch/mips/configs/pb1500_defconfig b/arch/mips/configs/pb1500_defconfig
index b05c510..4e0ea12 100644
--- a/arch/mips/configs/pb1500_defconfig
+++ b/arch/mips/configs/pb1500_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:33 2006
+# Fri Jan 20 14:16:40 2006
 #
 CONFIG_MIPS=y
 
@@ -707,7 +707,6 @@ CONFIG_INPUT_EVDEV=y
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/pb1550_defconfig b/arch/mips/configs/pb1550_defconfig
index dd4a635..8753202 100644
--- a/arch/mips/configs/pb1550_defconfig
+++ b/arch/mips/configs/pb1550_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:34 2006
+# Fri Jan 20 14:16:41 2006
 #
 CONFIG_MIPS=y
 
@@ -699,7 +699,6 @@ CONFIG_INPUT_EVDEV=y
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/pnx8550-jbs_defconfig b/arch/mips/configs/pnx8550-jbs_defconfig
index dcd88a5..af8a7c2 100644
--- a/arch/mips/configs/pnx8550-jbs_defconfig
+++ b/arch/mips/configs/pnx8550-jbs_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:34 2006
+# Fri Jan 20 14:16:43 2006
 #
 CONFIG_MIPS=y
 
@@ -643,7 +643,6 @@ CONFIG_INPUT=y
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 # CONFIG_SERIO_SERPORT is not set
 # CONFIG_SERIO_PCIPS2 is not set
 CONFIG_SERIO_LIBPS2=y
diff --git a/arch/mips/configs/sb1250-swarm_defconfig b/arch/mips/configs/sb1250-swarm_defconfig
index bc79f49..7e0d3b8 100644
--- a/arch/mips/configs/sb1250-swarm_defconfig
+++ b/arch/mips/configs/sb1250-swarm_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:35 2006
+# Fri Jan 20 14:16:48 2006
 #
 CONFIG_MIPS=y
 
@@ -549,7 +549,6 @@ CONFIG_NET_SB1250_MAC=y
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
diff --git a/arch/mips/configs/workpad_defconfig b/arch/mips/configs/workpad_defconfig
index 74eb1de..a081c5f 100644
--- a/arch/mips/configs/workpad_defconfig
+++ b/arch/mips/configs/workpad_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 
-# Wed Jan 11 17:48:36 2006
+# Fri Jan 20 14:16:53 2006
 #
 CONFIG_MIPS=y
 
@@ -536,7 +536,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_LIBPS2 is not set
 CONFIG_SERIO_RAW=m
diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index 98acf17..109913f 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -21,7 +21,7 @@ if SERIO
 config SERIO_I8042
 	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
 	default y
-	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && !M68K
+	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && !M68K && !MIPS
 	---help---
 	  i8042 is the chip over which the standard AT keyboard and PS/2
 	  mouse are connected to the computer. If you use these devices,
