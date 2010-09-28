Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 12:38:20 +0200 (CEST)
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:59210 "EHLO
        eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491958Ab0I1KgM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Sep 2010 12:36:12 +0200
Received: from source ([164.129.1.35]) (using TLSv1) by eu1sys200aob103.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKHFD0RwNLFhcejHSK1LG8rkfjd7Nsrm@postini.com; Tue, 28 Sep 2010 10:36:12 UTC
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 89E3677;
        Tue, 28 Sep 2010 10:35:58 +0000 (GMT)
Received: from relay2.stm.gmessaging.net (unknown [10.230.100.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2D83B21F3;
        Tue, 28 Sep 2010 10:35:58 +0000 (GMT)
Received: from exdcvycastm022.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm022", Issuer "exdcvycastm022" (not verified))
        by relay2.stm.gmessaging.net (Postfix) with ESMTPS id 5A7CDA8095;
        Tue, 28 Sep 2010 12:35:52 +0200 (CEST)
Received: from localhost (10.201.54.119) by exdcvycastm022.EQ1STM.local
 (10.230.100.30) with Microsoft SMTP Server (TLS) id 8.1.393.1; Tue, 28 Sep
 2010 12:35:56 +0200
From:   Arun Murthy <arun.murthy@stericsson.com>
To:     <lars@metafoo.de>, <akpm@linux-foundation.org>,
        <kernel@pengutronix.de>, <philipp.zabel@gmail.com>,
        <robert.jarzmik@free.fr>, <marek.vasut@gmail.com>,
        <eric.y.miao@gmail.com>, <rpurdie@rpsys.net>,
        <sameo@linux.intel.com>, <kgene.kim@samsung.com>,
        <linux-omap@vger.kernel.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <arun.murthy@stericsson.com>,
        <STEricsson_nomadik_linux@list.st.com>
Subject: [PATCH 6/7] pwm: move existing pwm driver to drivers/pwm
Date:   Tue, 28 Sep 2010 16:05:33 +0530
Message-ID: <1285670134-18063-7-git-send-email-arun.murthy@stericsson.com>
X-Mailer: git-send-email 1.7.2.dirty
In-Reply-To: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com>
References: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
X-archive-position: 27867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22267

As of now only ab8500 and twl6030 are moved.

Signed-off-by: Arun Murthy <arun.murthy@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mfd/Kconfig                              |    9 ---------
 drivers/mfd/Makefile                             |    1 -
 drivers/misc/Kconfig                             |    9 ---------
 drivers/misc/Makefile                            |    1 -
 drivers/pwm/Kconfig                              |   18 ++++++++++++++++++
 drivers/pwm/Makefile                             |    3 +++
 drivers/{misc/ab8500-pwm.c => pwm/pwm-ab8500.c}  |    0
 drivers/{mfd/twl6030-pwm.c => pwm/pwm-twl6040.c} |    0
 8 files changed, 21 insertions(+), 20 deletions(-)
 rename drivers/{misc/ab8500-pwm.c => pwm/pwm-ab8500.c} (100%)
 rename drivers/{mfd/twl6030-pwm.c => pwm/pwm-twl6040.c} (100%)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 256fabd..ab1d376 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -186,15 +186,6 @@ config TWL4030_CODEC
 	select MFD_CORE
 	default n
 
-config TWL6030_PWM
-	tristate "TWL6030 PWM (Pulse Width Modulator) Support"
-	depends on TWL4030_CORE
-	select HAVE_PWM
-	default n
-	help
-	  Say yes here if you want support for TWL6030 PWM.
-	  This is used to control charging LED brightness.
-
 config MFD_STMPE
 	bool "Support STMicroelectronics STMPE"
 	depends on I2C=y && GENERIC_HARDIRQS
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index d5968cd..1a89dbf 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -37,7 +37,6 @@ obj-$(CONFIG_MENELAUS)		+= menelaus.o
 obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o twl6030-irq.o
 obj-$(CONFIG_TWL4030_POWER)    += twl4030-power.o
 obj-$(CONFIG_TWL4030_CODEC)	+= twl4030-codec.o
-obj-$(CONFIG_TWL6030_PWM)	+= twl6030-pwm.o
 
 obj-$(CONFIG_MFD_MC13783)	+= mc13783-core.o
 
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ff8ea55..2c38d4e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -62,15 +62,6 @@ config ATMEL_PWM
 	  purposes including software controlled power-efficient backlights
 	  on LCD displays, motor control, and waveform generation.
 
-config AB8500_PWM
-	bool "AB8500 PWM support"
-	depends on AB8500_CORE
-	select HAVE_PWM
-	help
-	  This driver exports functions to enable/disble/config/free Pulse
-	  Width Modulation in the Analog Baseband Chip AB8500.
-	  It is used by led and backlight driver to control the intensity.
-
 config ATMEL_TCLIB
 	bool "Atmel AT32/AT91 Timer/Counter Library"
 	depends on (AVR32 || ARCH_AT91)
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 5da82965..21b4761 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -35,5 +35,4 @@ obj-y				+= eeprom/
 obj-y				+= cb710/
 obj-$(CONFIG_VMWARE_BALLOON)	+= vmware_balloon.o
 obj-$(CONFIG_ARM_CHARLCD)	+= arm-charlcd.o
-obj-$(CONFIG_AB8500_PWM)	+= ab8500-pwm.o
 obj-$(CONFIG_PCH_PHUB)		+= pch_phub.o
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a88640c..e347365 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -14,4 +14,22 @@ menuconfig PWM_DEVICES
 
 if PWM_DEVICES
 
+config AB8500_PWM
+	bool "AB8500 PWM support"
+	depends on AB8500_CORE
+	select HAVE_PWM
+	help
+	  This driver exports functions to enable/disble/config/free Pulse
+	  Width Modulation in the Analog Baseband Chip AB8500.
+	  It is used by led and backlight driver to control the intensity.
+
+config TWL6030_PWM
+	tristate "TWL6030 PWM (Pulse Width Modulator) Support"
+	depends on TWL4030_CORE
+	select HAVE_PWM
+	default n
+	help
+	  Say yes here if you want support for TWL6030 PWM.
+	  This is used to control charging LED brightness.
+
 endif # PWM_DEVICES
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 552f969..f35afb4 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -1 +1,4 @@
 obj-$(CONFIG_PWM_DEVICES)	+= pwm-core.o
+
+obj-$(CONFIG_AB8500_PWM)	+= pwm-ab8500.o
+obj-$(CONFIG_TWL6030_PWM)	+= pwm-twl6030.o
diff --git a/drivers/misc/ab8500-pwm.c b/drivers/pwm/pwm-ab8500.c
similarity index 100%
rename from drivers/misc/ab8500-pwm.c
rename to drivers/pwm/pwm-ab8500.c
diff --git a/drivers/mfd/twl6030-pwm.c b/drivers/pwm/pwm-twl6040.c
similarity index 100%
rename from drivers/mfd/twl6030-pwm.c
rename to drivers/pwm/pwm-twl6040.c
-- 
1.7.2.dirty
