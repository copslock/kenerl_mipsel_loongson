Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Sep 2009 20:16:00 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.152]:49488 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493659AbZI2SPa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Sep 2009 20:15:30 +0200
Received: by fg-out-1718.google.com with SMTP id d23so1694367fga.6
        for <linux-mips@linux-mips.org>; Tue, 29 Sep 2009 11:15:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GQj2XpHL0U9KfMem/DPMTd6qHkGun1+KESZ2BRjB3o4=;
        b=XB6G9LH6lQBkUaMYWqMZ6ojQ8ZFz1zhZ9xLC/8OPu6cfxrEMb3inS2HryCo8fU1V12
         Cks2XhVXsnbtANJeV523dIHO9YaJscT68YLwVoqFIQ/+6rMvY9bvN1ryUtUBisYOu9D7
         JTgmyyLoMKCyEMSQFgjtkhurvzmr4sPG2lyPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NTpvcD7X7GvWkCplq/bB2ydzGNTOoYiPyJImptct4fJbN8LQGTqRUA1w0Xt5ZuGWOr
         tWMfcsjf0jd6GaE5zlUN+S3lpB7/Ap3IKAsYbmqkapdD2c3YVZfkvxy/h37o5ZMh7305
         /G+Rczxl83LSh06OvtPHBFQnH8J+l2TL+XHRg=
Received: by 10.86.229.18 with SMTP id b18mr4548465fgh.34.1254248128453;
        Tue, 29 Sep 2009 11:15:28 -0700 (PDT)
Received: from localhost.localdomain (p5496CA2C.dip.t-dialin.net [84.150.202.44])
        by mx.google.com with ESMTPS id 3sm46061fge.23.2009.09.29.11.15.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Sep 2009 11:15:27 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>,
	linux-pcmcia <linux-pcmcia@lists.infradead.org>
Subject: [PATCH 3/3] Alchemy: new PCMCIA socket driver for devboards.
Date:	Tue, 29 Sep 2009 20:15:14 +0200
Message-Id: <1254248114-4158-4-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc1
In-Reply-To: <1254248114-4158-3-git-send-email-manuel.lauss@gmail.com>
References: <1254248114-4158-1-git-send-email-manuel.lauss@gmail.com>
 <1254248114-4158-2-git-send-email-manuel.lauss@gmail.com>
 <1254248114-4158-3-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

New PCMCIA socket driver for all Db/Pb1xxx boards (except Pb1000)
Notable features:
        - it builds for all supported boards!
        - support for carddetect and statuschange (disabled) IRQs.
        - pcmcia socket mem/io/attr areas and irqs passed through
          platform resource information.
        - doesn't freeze system during card insertion/ejection like
          the old one.
	- boardtype is automatically detected using BCSR ID register.

Also add platform device registration and missing interrupts for all
boards supported by this driver.

The PB1000 has different control register scheme and is not supported
by this driver.

Run-tested on Db1200;  however since all of these boards have an
identical PCMCIA setup (at least electrically;  they differ in
IRQs used) I'm fairly confident that it works on them too.

Cc: linux-pcmcia <linux-pcmcia@lists.infradead.org>
Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/platform.c              |    6 -
 arch/mips/alchemy/common/setup.c                 |    3 +-
 arch/mips/alchemy/devboards/db1x00/Makefile      |    3 +-
 arch/mips/alchemy/devboards/db1x00/irqmap.c      |   18 +-
 arch/mips/alchemy/devboards/db1x00/platform.c    |  164 ++++++
 arch/mips/alchemy/devboards/pb1100/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1100/platform.c    |   83 +++
 arch/mips/alchemy/devboards/pb1200/platform.c    |  215 +++++++-
 arch/mips/alchemy/devboards/pb1500/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1500/board_setup.c |    3 +
 arch/mips/alchemy/devboards/pb1500/platform.c    |   83 +++
 arch/mips/alchemy/devboards/pb1550/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1550/board_setup.c |    6 +
 arch/mips/alchemy/devboards/pb1550/platform.c    |  126 +++++
 arch/mips/include/asm/mach-au1x00/au1000.h       |   14 +
 arch/mips/include/asm/mach-db1x00/db1200.h       |   15 -
 arch/mips/include/asm/mach-db1x00/db1x00.h       |    8 -
 arch/mips/include/asm/mach-pb1x00/pb1100.h       |    7 -
 arch/mips/include/asm/mach-pb1x00/pb1200.h       |   14 -
 arch/mips/include/asm/mach-pb1x00/pb1500.h       |    7 -
 arch/mips/include/asm/mach-pb1x00/pb1550.h       |    7 -
 drivers/pcmcia/Kconfig                           |   17 +-
 drivers/pcmcia/Makefile                          |    9 +-
 drivers/pcmcia/au1000_db1x00.c                   |  307 ----------
 drivers/pcmcia/db1xxx_ss.c                       |  649 ++++++++++++++++++++++
 25 files changed, 1376 insertions(+), 397 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/db1x00/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1100/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1500/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1550/platform.c
 delete mode 100644 drivers/pcmcia/au1000_db1x00.c
 create mode 100644 drivers/pcmcia/db1xxx_ss.c

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 117f99f..2b76a57 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -308,11 +308,6 @@ static struct platform_device au1200_mmc1_device = {
 #endif /* #ifndef CONFIG_MIPS_DB1200 */
 #endif /* #ifdef CONFIG_SOC_AU1200 */
 
-static struct platform_device au1x00_pcmcia_device = {
-	.name 		= "au1x00-pcmcia",
-	.id 		= 0,
-};
-
 /* All Alchemy demoboards with I2C have this #define in their headers */
 #ifdef SMBUS_PSC_BASE
 static struct resource pbdb_smbus_resources[] = {
@@ -334,7 +329,6 @@ static struct platform_device pbdb_smbus_device = {
 static struct platform_device *au1xxx_platform_devices[] __initdata = {
 	&au1xx0_uart_device,
 	&au1xxx_usb_ohci_device,
-	&au1x00_pcmcia_device,
 #ifdef CONFIG_FB_AU1100
 	&au1100_lcd_device,
 #endif
diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 6184baa..375984e 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -107,7 +107,8 @@ phys_t __fixup_bigphys_addr(phys_t phys_addr, phys_t size)
 	 * The pseudo address we use is 0xF400 0000. Any address over
 	 * 0xF400 0000 is a PCMCIA pseudo address.
 	 */
-	if ((phys_addr >= 0xF4000000) && (phys_addr < 0xFFFFFFFF))
+	if ((phys_addr >= PCMCIA_ATTR_PSEUDO_PHYS) &&
+	    (phys_addr < PCMCIA_PSEUDO_END))
 		return (phys_t)(phys_addr << 4);
 
 	/* default nop */
diff --git a/arch/mips/alchemy/devboards/db1x00/Makefile b/arch/mips/alchemy/devboards/db1x00/Makefile
index 432241a..5024d16 100644
--- a/arch/mips/alchemy/devboards/db1x00/Makefile
+++ b/arch/mips/alchemy/devboards/db1x00/Makefile
@@ -5,4 +5,5 @@
 # Makefile for the Alchemy Semiconductor DBAu1xx0 boards.
 #
 
-obj-y := board_setup.o irqmap.o
+obj-y := board_setup.o irqmap.o platform.o
+
diff --git a/arch/mips/alchemy/devboards/db1x00/irqmap.c b/arch/mips/alchemy/devboards/db1x00/irqmap.c
index 0b09025..70b5a9c 100644
--- a/arch/mips/alchemy/devboards/db1x00/irqmap.c
+++ b/arch/mips/alchemy/devboards/db1x00/irqmap.c
@@ -65,23 +65,23 @@ char irq_tab_alchemy[][5] __initdata = {
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
 
-#ifndef CONFIG_MIPS_MIRAGE
-#ifdef CONFIG_MIPS_DB1550
-	{ AU1000_GPIO_3, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 0 IRQ# */
-	{ AU1000_GPIO_5, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 1 IRQ# */
+#if defined(CONFIG_MIPS_MIRAGE)
+	{ AU1000_GPIO_7,  IRQF_TRIGGER_RISING, 0 }, /* touchscreen pen down */
+#elif defined(CONFIG_MIPS_DB1550)
+	{ AU1000_GPIO_0,  IRQF_TRIGGER_LOW, 0 }, /* PCMCIA CD0# */
+	{ AU1000_GPIO_1,  IRQF_TRIGGER_LOW, 0 }, /* PCMCIA CD1# */
+	{ AU1000_GPIO_3,  IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 0 IRQ# */
+	{ AU1000_GPIO_5,  IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 1 IRQ# */
+	{ AU1500_GPIO_21, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA STSCHG0# */
+	{ AU1500_GPIO_22, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA STSCHG1# */
 #else
 	{ AU1000_GPIO_0, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 0 Fully_Interted# */
 	{ AU1000_GPIO_1, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 0 STSCHG# */
 	{ AU1000_GPIO_2, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 0 IRQ# */
-
 	{ AU1000_GPIO_3, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 1 Fully_Interted# */
 	{ AU1000_GPIO_4, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 1 STSCHG# */
 	{ AU1000_GPIO_5, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 1 IRQ# */
 #endif
-#else
-	{ AU1000_GPIO_7, IRQF_TRIGGER_RISING, 0 }, /* touchscreen pen down */
-#endif
-
 };
 
 void __init board_init_irq(void)
diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
new file mode 100644
index 0000000..de46243
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -0,0 +1,164 @@
+/*
+ * DBAu1xxx board platform device registration
+ *
+ * Copyright (C) 2009 Manuel Lauss
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-au1x00/au1xxx.h>
+
+#if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100) || \
+    defined(CONFIG_MIPS_DB1500) || defined(CONFIG_MIPS_DB1550)
+#define DB1XXX_HAS_PCMCIA
+#endif
+
+/* DB1xxx PCMCIA interrupt sources:
+ * CD0/1 	GPIO0/3
+ * STSCHG0/1	GPIO1/4
+ * CARD0/1	GPIO2/5
+ * Db1550:	0/1, 21/22, 3/5
+ */
+#ifndef CONFIG_MIPS_DB1550
+/* Db1000, Db1100, Db1500 */
+#define DB1XXX_PCMCIA_CD0	AU1000_GPIO_0
+#define DB1XXX_PCMCIA_STSCHG0	AU1000_GPIO_1
+#define DB1XXX_PCMCIA_CARD0	AU1000_GPIO_2
+#define DB1XXX_PCMCIA_CD1	AU1000_GPIO_3
+#define DB1XXX_PCMCIA_STSCHG1	AU1000_GPIO_4
+#define DB1XXX_PCMCIA_CARD1	AU1000_GPIO_5
+#else
+#define DB1XXX_PCMCIA_CD0	AU1000_GPIO_0
+#define DB1XXX_PCMCIA_STSCHG0	AU1500_GPIO_21
+#define DB1XXX_PCMCIA_CARD0	AU1000_GPIO_3
+#define DB1XXX_PCMCIA_CD1	AU1000_GPIO_1
+#define DB1XXX_PCMCIA_STSCHG1	AU1500_GPIO_22
+#define DB1XXX_PCMCIA_CARD1	AU1000_GPIO_5
+#endif
+
+#ifdef DB1XXX_HAS_PCMCIA
+static struct resource db1xxx_pcmcia0_res[] = {
+	{
+		.name	= "pseudo-attr",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_ATTR_PSEUDO_PHYS,
+		.end	= PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
+	},
+	{
+		.name	= "pseudo-mem",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_MEM_PSEUDO_PHYS,
+		.end	= PCMCIA_MEM_PSEUDO_PHYS + 0x00040000 - 1,
+	},
+	{
+		.name	= "pseudo-io",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_IO_PSEUDO_PHYS,
+		.end	= PCMCIA_IO_PSEUDO_PHYS + 0x0001000 - 1,
+	},
+	{
+		.name	= "insert",
+		.flags	= IORESOURCE_IRQ,
+		.start	= DB1XXX_PCMCIA_CD0,
+		.end	= DB1XXX_PCMCIA_CD0,
+	},
+#if 0 /* more trouble than it's worth */
+	{
+		.name	= "stschg",
+		.flags	= IORESOURCE_IRQ,
+		.start	= DB1XXX_PCMCIA_STSCHG0,
+		.end	= DB1XXX_PCMCIA_STSCHG0,
+	},
+#endif
+	{
+		.name	= "card",
+		.flags	= IORESOURCE_IRQ,
+		.start	= DB1XXX_PCMCIA_CARD0,
+		.end	= DB1XXX_PCMCIA_CARD0,
+	},
+};
+
+static struct platform_device db1xxx_pcmcia0_dev = {
+	.name		= "db1xxx_pcmcia",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(db1xxx_pcmcia0_res),
+	.resource	= db1xxx_pcmcia0_res,
+};
+
+/* mem/io resources of 2nd socket at offset 0x00400000 from 1st */
+static struct resource db1xxx_pcmcia1_res[] = {
+	{
+		.name	= "pseudo-attr",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_ATTR_PSEUDO_PHYS + 0x00400000,
+		.end	= PCMCIA_ATTR_PSEUDO_PHYS + 0x00440000 - 1,
+	},
+	{
+		.name	= "pseudo-mem",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_MEM_PSEUDO_PHYS + 0x00400000,
+		.end	= PCMCIA_MEM_PSEUDO_PHYS + 0x00440000 - 1,
+	},
+	{
+		.name	= "pseudo-io",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_IO_PSEUDO_PHYS + 0x00400000,
+		.end	= PCMCIA_IO_PSEUDO_PHYS + 0x00401000 - 1,
+	},
+	{
+		.name	= "insert",
+		.flags	= IORESOURCE_IRQ,
+		.start	= DB1XXX_PCMCIA_CD1,
+		.end	= DB1XXX_PCMCIA_CD1,
+	},
+#if 0 /* more trouble than it's worth */
+	{
+		.name	= "stschg",
+		.flags	= IORESOURCE_IRQ,
+		.start	= DB1XXX_PCMCIA_STSCHG1,
+		.end	= DB1XXX_PCMCIA_STSCHG1,
+	},
+#endif
+	{
+		.name	= "card",
+		.flags	= IORESOURCE_IRQ,
+		.start	= DB1XXX_PCMCIA_CARD1,
+		.end	= DB1XXX_PCMCIA_CARD1,
+	},
+};
+
+static struct platform_device db1xxx_pcmcia1_dev = {
+	.name		= "db1xxx_pcmcia",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(db1xxx_pcmcia1_res),
+	.resource	= db1xxx_pcmcia1_res,
+};
+#endif
+
+static struct platform_device *db1xxx_devs[] __initdata = {
+#ifdef DB1XXX_HAS_PCMCIA
+	&db1xxx_pcmcia0_dev,
+	&db1xxx_pcmcia1_dev,
+#endif
+};
+
+static int __init db1xxx_dev_init(void)
+{
+	return platform_add_devices(db1xxx_devs, ARRAY_SIZE(db1xxx_devs));
+}
+device_initcall(db1xxx_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1100/Makefile b/arch/mips/alchemy/devboards/pb1100/Makefile
index c586dd7..60cf5b9 100644
--- a/arch/mips/alchemy/devboards/pb1100/Makefile
+++ b/arch/mips/alchemy/devboards/pb1100/Makefile
@@ -5,4 +5,5 @@
 # Makefile for the Alchemy Semiconductor Pb1100 board.
 #
 
-obj-y := board_setup.o
+obj-y := board_setup.o platform.o
+
diff --git a/arch/mips/alchemy/devboards/pb1100/platform.c b/arch/mips/alchemy/devboards/pb1100/platform.c
new file mode 100644
index 0000000..a579925
--- /dev/null
+++ b/arch/mips/alchemy/devboards/pb1100/platform.c
@@ -0,0 +1,83 @@
+/*
+ * Pb1100 board platform device registration
+ *
+ * Copyright (C) 2009 Manuel Lauss
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-au1x00/au1xxx.h>
+
+/* PCMCIA. single socket, identical to Pb1500 */
+static struct resource pb1100_pcmcia_res[] = {
+	{
+		.name	= "pseudo-attr",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_ATTR_PSEUDO_PHYS,
+		.end	= PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
+	},
+	{
+		.name	= "pseudo-mem",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_MEM_PSEUDO_PHYS,
+		.end	= PCMCIA_MEM_PSEUDO_PHYS + 0x00040000 - 1,
+	},
+	{
+		.name	= "pseudo-io",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_IO_PSEUDO_PHYS,
+		.end	= PCMCIA_IO_PSEUDO_PHYS + 0x0001000 - 1,
+	},
+	{
+		.name	= "insert",
+		.flags	= IORESOURCE_IRQ,
+		.start	= AU1000_GPIO_9,
+		.end	= AU1000_GPIO_9,
+	},
+#if 0	/* more trouble than it's worth */
+	{
+		.name	= "stschg",
+		.flags	= IORESOURCE_IRQ,
+		.start	= AU1000_GPIO_10,
+		.end	= AU1000_GPIO_10,
+	},
+#endif
+	{
+		.name	= "card",
+		.flags	= IORESOURCE_IRQ,
+		.start	= AU1000_GPIO_11,
+		.end	= AU1000_GPIO_11,
+	},
+};
+
+static struct platform_device pb1100_pcmcia_dev = {
+	.name		= "db1xxx_pcmcia",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(pb1100_pcmcia_res),
+	.resource	= pb1100_pcmcia_res,
+};
+
+static struct platform_device *pb1100_devs[] __initdata = {
+	&pb1100_pcmcia_dev,
+};
+
+static int __init pb1100_dev_init(void)
+{
+	return platform_add_devices(pb1100_devs, ARRAY_SIZE(pb1100_devs));
+}
+device_initcall(pb1100_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index dfdaabf..7abd6a9 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -163,9 +163,222 @@ static struct platform_device smc91c111_device = {
 	.resource	= smc91c111_resources
 };
 
+/*
+ * PCMCIA socket resources
+ */
+#ifdef CONFIG_MIPS_PB1200
+static struct resource pb1200_pcmcia0_res[] = {
+	{
+		.name	= "pseudo-attr",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_ATTR_PSEUDO_PHYS,
+		.end	= PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
+	},
+	{
+		.name	= "pseudo-mem",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_MEM_PSEUDO_PHYS,
+		.end	= PCMCIA_MEM_PSEUDO_PHYS + 0x00040000 - 1,
+	},
+	{
+		.name	= "pseudo-io",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_IO_PSEUDO_PHYS,
+		.end	= PCMCIA_IO_PSEUDO_PHYS + 0x0001000 - 1,
+	},
+	{
+		.name	= "card",
+		.flags	= IORESOURCE_IRQ,
+		.start	= PB1200_PC0_INT,
+		.end	= PB1200_PC0_INT,
+	},
+#if 0 /* more trouble than what it's worth */
+	{
+		.name	= "stschg",
+		.flags	= IORESOURCE_IRQ,
+		.start	= PB1200_PC0_STSCHG_INT,
+		.end	= PB1200_PC0_STSCHG_INT,
+	},
+#endif
+	{
+		.name	= "insert",
+		.flags	= IORESOURCE_IRQ,
+		.start	= PB1200_PC0_INSERT_INT,
+		.end	= PB1200_PC0_INSERT_INT,
+	},
+	{
+		.name	= "eject",
+		.flags	= IORESOURCE_IRQ,
+		.start	= PB1200_PC0_EJECT_INT,
+		.end	= PB1200_PC0_EJECT_INT,
+	},
+};
+
+/* mem/io resources of 2nd socket at offset 0x00800000 from 1st */
+static struct resource pb1200_pcmcia1_res[] = {
+	{
+		.name	= "pseudo-attr",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_ATTR_PSEUDO_PHYS + 0x00800000,
+		.end	= PCMCIA_ATTR_PSEUDO_PHYS + 0x00840000 - 1,
+	},
+	{
+		.name	= "pseudo-mem",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_MEM_PSEUDO_PHYS + 0x00800000,
+		.end	= PCMCIA_MEM_PSEUDO_PHYS + 0x00840000 - 1,
+	},
+	{
+		.name	= "pseudo-io",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_IO_PSEUDO_PHYS + 0x00800000,
+		.end	= PCMCIA_IO_PSEUDO_PHYS + 0x00801000 - 1,
+	},
+	{
+		.name	= "card",
+		.flags	= IORESOURCE_IRQ,
+		.start	= PB1200_PC1_INT,
+		.end	= PB1200_PC1_INT,
+	},
+#if 0	/* too much trouble than what it's worth */
+	{
+		.name	= "stschg",
+		.flags	= IORESOURCE_IRQ,
+		.start	= PB1200_PC1_STSCHG_INT,
+		.end	= PB1200_PC1_STSCHG_INT,
+	},
+#endif
+	{
+		.name	= "insert",
+		.flags	= IORESOURCE_IRQ,
+		.start	= PB1200_PC1_INSERT_INT,
+		.end	= PB1200_PC1_INSERT_INT,
+	},
+	{
+		.name	= "eject",
+		.flags	= IORESOURCE_IRQ,
+		.start	= PB1200_PC1_EJECT_INT,
+		.end	= PB1200_PC1_EJECT_INT,
+	},
+};
+
+#else	/* must be DB1200 */
+
+static struct resource pb1200_pcmcia0_res[] = {	/* DB1200 socket 0 */
+	{
+		.name	= "pseudo-attr",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_ATTR_PSEUDO_PHYS,
+		.end	= PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
+	},
+	{
+		.name	= "pseudo-mem",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_MEM_PSEUDO_PHYS,
+		.end	= PCMCIA_MEM_PSEUDO_PHYS + 0x00040000 - 1,
+	},
+	{
+		.name	= "pseudo-io",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_IO_PSEUDO_PHYS,
+		.end	= PCMCIA_IO_PSEUDO_PHYS + 0x0001000 - 1,
+	},
+	{
+		.name	= "card",
+		.flags	= IORESOURCE_IRQ,
+		.start	= DB1200_PC0_INT,
+		.end	= DB1200_PC0_INT,
+	},
+#if 0 /* more trouble than it's worth */
+	{
+		.name	= "stschg",
+		.flags	= IORESOURCE_IRQ,
+		.start	= DB1200_PC0_STSCHG_INT,
+		.end	= DB1200_PC0_STSCHG_INT,
+	},
+#endif
+	{
+		.name	= "insert",
+		.flags	= IORESOURCE_IRQ,
+		.start	= DB1200_PC0_INSERT_INT,
+		.end	= DB1200_PC0_INSERT_INT,
+	},
+	{
+		.name	= "eject",
+		.flags	= IORESOURCE_IRQ,
+		.start	= DB1200_PC0_EJECT_INT,
+		.end	= DB1200_PC0_EJECT_INT,
+	},
+};
+
+/* mem/io resources of 2nd socket at offset 0x00400000 from 1st */
+static struct resource pb1200_pcmcia1_res[] = {
+	{
+		.name	= "pseudo-attr",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_ATTR_PSEUDO_PHYS + 0x00400000,
+		.end	= PCMCIA_ATTR_PSEUDO_PHYS + 0x00440000 - 1,
+	},
+	{
+		.name	= "pseudo-mem",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_MEM_PSEUDO_PHYS + 0x00400000,
+		.end	= PCMCIA_MEM_PSEUDO_PHYS + 0x00440000 - 1,
+	},
+	{
+		.name	= "pseudo-io",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_IO_PSEUDO_PHYS + 0x00400000,
+		.end	= PCMCIA_IO_PSEUDO_PHYS + 0x00401000 - 1,
+	},
+	{
+		.name	= "card",
+		.flags	= IORESOURCE_IRQ,
+		.start	= DB1200_PC1_INT,
+		.end	= DB1200_PC1_INT,
+	},
+#if 0 /* more trouble than it's worth */
+	{
+		.name	= "stschg",
+		.flags	= IORESOURCE_IRQ,
+		.start	= DB1200_PC1_STSCHG_INT,
+		.end	= DB1200_PC1_STSCHG_INT,
+	},
+#endif
+	{
+		.name	= "insert",
+		.flags	= IORESOURCE_IRQ,
+		.start	= DB1200_PC1_INSERT_INT,
+		.end	= DB1200_PC1_INSERT_INT,
+	},
+	{
+		.name	= "eject",
+		.flags	= IORESOURCE_IRQ,
+		.start	= DB1200_PC1_EJECT_INT,
+		.end	= DB1200_PC1_EJECT_INT,
+	},
+};
+#endif
+
+static struct platform_device pb1200_pcmcia0_dev = {
+	.name		= "db1xxx_pcmcia",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(pb1200_pcmcia0_res),
+	.resource	= pb1200_pcmcia0_res,
+};
+
+static struct platform_device pb1200_pcmcia1_dev = {
+	.name		= "db1xxx_pcmcia",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(pb1200_pcmcia1_res),
+	.resource	= pb1200_pcmcia1_res,
+};
+
 static struct platform_device *board_platform_devices[] __initdata = {
 	&ide_device,
-	&smc91c111_device
+	&smc91c111_device,
+	&pb1200_pcmcia0_dev,
+	&pb1200_pcmcia1_dev
 };
 
 static int __init board_register_devices(void)
diff --git a/arch/mips/alchemy/devboards/pb1500/Makefile b/arch/mips/alchemy/devboards/pb1500/Makefile
index 173b419..c29545d 100644
--- a/arch/mips/alchemy/devboards/pb1500/Makefile
+++ b/arch/mips/alchemy/devboards/pb1500/Makefile
@@ -5,4 +5,5 @@
 # Makefile for the Alchemy Semiconductor Pb1500 board.
 #
 
-obj-y := board_setup.o
+obj-y := board_setup.o platform.o
+
diff --git a/arch/mips/alchemy/devboards/pb1500/board_setup.c b/arch/mips/alchemy/devboards/pb1500/board_setup.c
index c5389e5..7439303 100644
--- a/arch/mips/alchemy/devboards/pb1500/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1500/board_setup.c
@@ -41,6 +41,9 @@ char irq_tab_alchemy[][5] __initdata = {
 };
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
+	{ AU1000_GPIO_9,   IRQF_TRIGGER_LOW, 0 },
+	{ AU1000_GPIO_10,  IRQF_TRIGGER_LOW, 0 },
+	{ AU1000_GPIO_11,  IRQF_TRIGGER_LOW, 0 },
 	{ AU1500_GPIO_204, IRQF_TRIGGER_HIGH, 0 },
 	{ AU1500_GPIO_201, IRQF_TRIGGER_LOW, 0 },
 	{ AU1500_GPIO_202, IRQF_TRIGGER_LOW, 0 },
diff --git a/arch/mips/alchemy/devboards/pb1500/platform.c b/arch/mips/alchemy/devboards/pb1500/platform.c
new file mode 100644
index 0000000..4bd1ee1
--- /dev/null
+++ b/arch/mips/alchemy/devboards/pb1500/platform.c
@@ -0,0 +1,83 @@
+/*
+ * Pb1500 board platform device registration
+ *
+ * Copyright (C) 2009 Manuel Lauss
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-au1x00/au1xxx.h>
+
+/* PCMCIA: single socket, identical to PB1100 */
+static struct resource pb1500_pcmcia_res[] = {
+	{
+		.name	= "pseudo-attr",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_ATTR_PSEUDO_PHYS,
+		.end	= PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
+	},
+	{
+		.name	= "pseudo-mem",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_MEM_PSEUDO_PHYS,
+		.end	= PCMCIA_MEM_PSEUDO_PHYS + 0x00040000 - 1,
+	},
+	{
+		.name	= "pseudo-io",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_IO_PSEUDO_PHYS,
+		.end	= PCMCIA_IO_PSEUDO_PHYS + 0x0001000 - 1,
+	},
+	{
+		.name	= "insert",
+		.flags	= IORESOURCE_IRQ,
+		.start	= AU1000_GPIO_9,
+		.end	= AU1000_GPIO_9,
+	},
+#if 0 /* more trouble than it's worth */
+	{
+		.name	= "stschg",
+		.flags	= IORESOURCE_IRQ,
+		.start	= AU1000_GPIO_10,
+		.end	= AU1000_GPIO_10,
+	},
+#endif
+	{
+		.name	= "card",
+		.flags	= IORESOURCE_IRQ,
+		.start	= AU1000_GPIO_11,
+		.end	= AU1000_GPIO_11,
+	},
+};
+
+static struct platform_device pb1500_pcmcia_dev = {
+	.name		= "db1xxx_pcmcia",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(pb1500_pcmcia_res),
+	.resource	= pb1500_pcmcia_res,
+};
+
+static struct platform_device *pb1500_devs[] __initdata = {
+	&pb1500_pcmcia_dev,
+};
+
+static int __init pb1500_dev_init(void)
+{
+	return platform_add_devices(pb1500_devs, ARRAY_SIZE(pb1500_devs));
+}
+device_initcall(pb1500_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1550/Makefile b/arch/mips/alchemy/devboards/pb1550/Makefile
index cff95bc..86b410b 100644
--- a/arch/mips/alchemy/devboards/pb1550/Makefile
+++ b/arch/mips/alchemy/devboards/pb1550/Makefile
@@ -5,4 +5,5 @@
 # Makefile for the Alchemy Semiconductor Pb1550 board.
 #
 
-obj-y := board_setup.o
+obj-y := board_setup.o platform.o
+
diff --git a/arch/mips/alchemy/devboards/pb1550/board_setup.c b/arch/mips/alchemy/devboards/pb1550/board_setup.c
index af7a1b5..957e3ae 100644
--- a/arch/mips/alchemy/devboards/pb1550/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1550/board_setup.c
@@ -33,6 +33,7 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1550.h>
 #include <asm/mach-db1x00/bcsr.h>
+#include <asm/mach-au1x00/gpio.h>
 
 #include <prom.h>
 
@@ -45,6 +46,7 @@ char irq_tab_alchemy[][5] __initdata = {
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
 	{ AU1000_GPIO_0, IRQF_TRIGGER_LOW, 0 },
 	{ AU1000_GPIO_1, IRQF_TRIGGER_LOW, 0 },
+	{ AU1500_GPIO_201_205, IRQF_TRIGGER_LOW, 0 },
 };
 
 const char *get_system_type(void)
@@ -59,6 +61,8 @@ void board_reset(void)
 
 void __init board_init_irq(void)
 {
+	alchemy_gpio2_enable_int(201);
+	alchemy_gpio2_enable_int(202);
 	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
 }
 
@@ -80,6 +84,8 @@ void __init board_setup(void)
 	}
 #endif
 
+	alchemy_gpio2_enable();
+
 	/*
 	 * Enable PSC1 SYNC for AC'97.  Normaly done in audio driver,
 	 * but it is board specific code, so put it here.
diff --git a/arch/mips/alchemy/devboards/pb1550/platform.c b/arch/mips/alchemy/devboards/pb1550/platform.c
new file mode 100644
index 0000000..30170f4
--- /dev/null
+++ b/arch/mips/alchemy/devboards/pb1550/platform.c
@@ -0,0 +1,126 @@
+/*
+ * Pb1550 board platform device registration
+ *
+ * Copyright (C) 2009 Manuel Lauss
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-pb1x00/pb1550.h>
+
+/* Pb1550, like all others, also has statuschange irqs; however they're
+ * wired up on one of the Au1550's shared GPIO201_205 line, which also
+ * services the PCMCIA card interrupts.  So we ignore statuschange and
+ * use the GPIO201_205 exclusively for card interrupts, since a) pcmcia
+ * drivers are used to shared irqs and b) statuschange isn't really use-
+ * ful anyway.
+ */
+static struct resource pb1550_pcmcia0_res[] = {
+	{
+		.name	= "pseudo-attr",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_ATTR_PSEUDO_PHYS,
+		.end	= PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
+	},
+	{
+		.name	= "pseudo-mem",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_MEM_PSEUDO_PHYS,
+		.end	= PCMCIA_MEM_PSEUDO_PHYS + 0x00040000 - 1,
+	},
+	{
+		.name	= "pseudo-io",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_IO_PSEUDO_PHYS,
+		.end	= PCMCIA_IO_PSEUDO_PHYS + 0x0001000 - 1,
+	},
+	{
+		.name	= "insert",
+		.flags	= IORESOURCE_IRQ,
+		.start	= AU1000_GPIO_0,
+		.end	= AU1000_GPIO_0,
+	},
+	{ /* is GPIO_201, but this one shares an IRQ with 201-205 */
+		.name	= "card",
+		.flags	= IORESOURCE_IRQ,
+		.start	= AU1500_GPIO_201_205,
+		.end	= AU1500_GPIO_201_205,
+	},
+};
+
+static struct platform_device pb1550_pcmcia0_dev = {
+	.name		= "db1xxx_pcmcia",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(pb1550_pcmcia0_res),
+	.resource	= pb1550_pcmcia0_res,
+};
+
+/* mem/io resources of 2nd socket at offset 0x00800000 from 1st */
+static struct resource pb1550_pcmcia1_res[] = {
+	{
+		.name	= "pseudo-attr",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_ATTR_PSEUDO_PHYS + 0x00800000,
+		.end	= PCMCIA_ATTR_PSEUDO_PHYS + 0x00840000 - 1,
+	},
+	{
+		.name	= "pseudo-mem",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_MEM_PSEUDO_PHYS + 0x00800000,
+		.end	= PCMCIA_MEM_PSEUDO_PHYS + 0x00840000 - 1,
+	},
+	{
+		.name	= "pseudo-io",
+		.flags	= IORESOURCE_MEM,
+		.start	= PCMCIA_IO_PSEUDO_PHYS + 0x00800000,
+		.end	= PCMCIA_IO_PSEUDO_PHYS + 0x00801000 - 1,
+	},
+	{
+		.name	= "insert",
+		.flags	= IORESOURCE_IRQ,
+		.start	= AU1000_GPIO_1,
+		.end	= AU1000_GPIO_1,
+	},
+	{ /* is GPIO_202, but this one shares an IRQ with 201-205 */
+		.name	= "card",
+		.flags	= IORESOURCE_IRQ,
+		.start	= AU1500_GPIO_201_205,
+		.end	= AU1500_GPIO_201_205,
+	},
+};
+
+static struct platform_device pb1550_pcmcia1_dev = {
+	.name		= "db1xxx_pcmcia",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(pb1550_pcmcia1_res),
+	.resource	= pb1550_pcmcia1_res,
+};
+
+static struct platform_device *pb1550_devs[] __initdata = {
+	&pb1550_pcmcia0_dev,
+	&pb1550_pcmcia1_dev
+};
+
+static int __init pb1550_dev_init(void)
+{
+	return platform_add_devices(pb1550_devs,
+				    ARRAY_SIZE(pb1550_devs));
+}
+device_initcall(pb1550_dev_init);
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 854e95f..df04e91 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -1739,6 +1739,20 @@ enum soc_au1200_ints {
 
 #endif
 
+/*
+ * All Au1xx0 SOCs have a PCMCIA controller.
+ * We setup our 32-bit pseudo addresses to be equal to the
+ * 36-bit addr >> 4, to make it easier to check the address
+ * and fix it.
+ * The PCMCIA socket 0 physical attribute address is 0xF 4000 0000.
+ * The pseudo address we use is 0xF400 0000. Any address over
+ * 0xF400 0000 is a PCMCIA pseudo address.
+ */
+#define PCMCIA_IO_PSEUDO_PHYS	(PCMCIA_IO_PHYS_ADDR >> 4)
+#define PCMCIA_ATTR_PSEUDO_PHYS	(PCMCIA_ATTR_PHYS_ADDR >> 4)
+#define PCMCIA_MEM_PSEUDO_PHYS	(PCMCIA_MEM_PHYS_ADDR >> 4)
+#define PCMCIA_PSEUDO_END	(0xffffffff)
+
 #ifndef _LANGUAGE_ASSEMBLY
 typedef volatile struct {
 	/* 0x0000 */ u32 toytrim;
diff --git a/arch/mips/include/asm/mach-db1x00/db1200.h b/arch/mips/include/asm/mach-db1x00/db1200.h
index 2909b83..1fbcca4 100644
--- a/arch/mips/include/asm/mach-db1x00/db1200.h
+++ b/arch/mips/include/asm/mach-db1x00/db1200.h
@@ -102,21 +102,6 @@ enum external_pb1200_ints {
 	DB1200_INT_END		= DB1200_INT_BEGIN + 15,
 };
 
-
-/*
- * DBAu1200 specific PCMCIA defines for drivers/pcmcia/au1000_db1x00.c
- */
-#define PCMCIA_MAX_SOCK  1
-#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
-
-/* VPP/VCC */
-#define SET_VCC_VPP(VCC, VPP, SLOT) \
-	((((VCC) << 2) | ((VPP) << 0)) << ((SLOT) * 8))
-
-#define BOARD_PC0_INT	DB1200_PC0_INT
-#define BOARD_PC1_INT	DB1200_PC1_INT
-#define BOARD_CARD_INSERTED(SOCKET) (bcsr_read(BCSR_SIGSTAT) & (1 << (8 + (2 * SOCKET))))
-
 /* NAND chip select */
 #define NAND_CS 1
 
diff --git a/arch/mips/include/asm/mach-db1x00/db1x00.h b/arch/mips/include/asm/mach-db1x00/db1x00.h
index cfa6429..a919dac 100644
--- a/arch/mips/include/asm/mach-db1x00/db1x00.h
+++ b/arch/mips/include/asm/mach-db1x00/db1x00.h
@@ -45,14 +45,6 @@
 
 #endif
 
-/* PCMCIA DBAu1x00 specific defines */
-#define PCMCIA_MAX_SOCK  1
-#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
-
-/* VPP/VCC */
-#define SET_VCC_VPP(VCC, VPP, SLOT)\
-	((((VCC) << 2) | ((VPP) << 0)) << ((SLOT) * 8))
-
 /*
  * NAND defines
  *
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1100.h b/arch/mips/include/asm/mach-pb1x00/pb1100.h
index f2bf73a..d75fbbd 100644
--- a/arch/mips/include/asm/mach-pb1x00/pb1100.h
+++ b/arch/mips/include/asm/mach-pb1x00/pb1100.h
@@ -26,11 +26,4 @@
 #ifndef __ASM_PB1100_H
 #define __ASM_PB1100_H
 
-/* PCMCIA Pb1100 specific defines */
-#define PCMCIA_MAX_SOCK  0
-#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
-
-/* VPP/VCC */
-#define SET_VCC_VPP(VCC, VPP) (((VCC) << 2) | ((VPP) << 0))
-
 #endif /* __ASM_PB1100_H */
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1200.h b/arch/mips/include/asm/mach-pb1x00/pb1200.h
index a51512c..07ad170 100644
--- a/arch/mips/include/asm/mach-pb1x00/pb1200.h
+++ b/arch/mips/include/asm/mach-pb1x00/pb1200.h
@@ -134,20 +134,6 @@ enum external_pb1200_ints {
 	PB1200_INT_END		= PB1200_INT_BEGIN + 15
 };
 
-/*
- * Pb1200 specific PCMCIA defines for drivers/pcmcia/au1000_db1x00.c
- */
-#define PCMCIA_MAX_SOCK  1
-#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
-
-/* VPP/VCC */
-#define SET_VCC_VPP(VCC, VPP, SLOT) \
-	((((VCC) << 2) | ((VPP) << 0)) << ((SLOT) * 8))
-
-#define BOARD_PC0_INT	PB1200_PC0_INT
-#define BOARD_PC1_INT	PB1200_PC1_INT
-#define BOARD_CARD_INSERTED(SOCKET) (bcsr_read(BCSR_SIGSTAT & (1 << (8 + (2 * SOCKET))))
-
 /* NAND chip select */
 #define NAND_CS 1
 
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1500.h b/arch/mips/include/asm/mach-pb1x00/pb1500.h
index 82431a7..ade9071 100644
--- a/arch/mips/include/asm/mach-pb1x00/pb1500.h
+++ b/arch/mips/include/asm/mach-pb1x00/pb1500.h
@@ -26,11 +26,4 @@
 #ifndef __ASM_PB1500_H
 #define __ASM_PB1500_H
 
-/* PCMCIA Pb1500 specific defines */
-#define PCMCIA_MAX_SOCK  0
-#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
-
-/* VPP/VCC */
-#define SET_VCC_VPP(VCC, VPP) (((VCC) << 2) | ((VPP) << 0))
-
 #endif /* __ASM_PB1500_H */
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1550.h b/arch/mips/include/asm/mach-pb1x00/pb1550.h
index 306d584..5879641 100644
--- a/arch/mips/include/asm/mach-pb1x00/pb1550.h
+++ b/arch/mips/include/asm/mach-pb1x00/pb1550.h
@@ -40,13 +40,6 @@
 #define SMBUS_PSC_BASE		PSC2_BASE_ADDR
 #define I2S_PSC_BASE		PSC3_BASE_ADDR
 
-#define PCMCIA_MAX_SOCK  1
-#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
-
-/* VPP/VCC */
-#define SET_VCC_VPP(VCC, VPP, SLOT) \
-	((((VCC) << 2) | ((VPP) << 0)) << ((SLOT) * 8))
-
 #if defined(CONFIG_MTD_PB1550_BOOT) && defined(CONFIG_MTD_PB1550_USER)
 #define PB1550_BOTH_BANKS
 #elif defined(CONFIG_MTD_PB1550_BOOT) && !defined(CONFIG_MTD_PB1550_USER)
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index fbf965b..58e4277 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -82,7 +82,7 @@ config PCMCIA_IOCTL
 	  If unsure, say Y.
 
 config CARDBUS
-	bool "32-bit CardBus support"	
+	bool "32-bit CardBus support"
 	depends on PCI
 	default y
 	---help---
@@ -105,8 +105,8 @@ config YENTA
 	select PCCARD_NONSTATIC
 	---help---
 	  This option enables support for CardBus host bridges.  Virtually
-	  all modern PCMCIA bridges are CardBus compatible.  A "bridge" is 
-	  the hardware inside your computer that PCMCIA cards are plugged 
+	  all modern PCMCIA bridges are CardBus compatible.  A "bridge" is
+	  the hardware inside your computer that PCMCIA cards are plugged
 	  into.
 
 	  To compile this driver as modules, choose M here: the
@@ -192,6 +192,17 @@ config PCMCIA_AU1X00
 	tristate "Au1x00 pcmcia support"
 	depends on SOC_AU1X00 && PCMCIA
 
+config PCMCIA_ALCHEMY_DEVBOARD
+	tristate "Alchemy Db/Pb1xxx PCMCIA socket services"
+	depends on SOC_AU1X00 && PCMCIA
+	select 64BIT_PHYS_ADDR
+	help
+	  Enable this driver of you want PCMCIA support on your Alchemy
+	  Db1000, Db/Pb1100, Db/Pb1500, Db/Pb1550, Db/Pb1200 board.
+	  NOT suitable for the PB1000!
+
+	  This driver is also available as a module called db1xxx_ss.ko
+
 config PCMCIA_SA1100
 	tristate "SA1100 support"
 	depends on ARM && ARCH_SA1100 && PCMCIA
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index 3247828..f188912 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -33,20 +33,13 @@ obj-$(CONFIG_OMAP_CF)				+= omap_cf.o
 obj-$(CONFIG_BFIN_CFPCMCIA)			+= bfin_cf_pcmcia.o
 obj-$(CONFIG_AT91_CF)				+= at91_cf.o
 obj-$(CONFIG_ELECTRA_CF)			+= electra_cf.o
+obj-$(CONFIG_PCMCIA_ALCHEMY_DEVBOARD)		+= db1xxx_ss.o
 
 sa11xx_core-y					+= soc_common.o sa11xx_base.o
 pxa2xx_core-y					+= soc_common.o pxa2xx_base.o
 
 au1x00_ss-y					+= au1000_generic.o
 au1x00_ss-$(CONFIG_MIPS_PB1000)			+= au1000_pb1x00.o
-au1x00_ss-$(CONFIG_MIPS_PB1100)			+= au1000_pb1x00.o
-au1x00_ss-$(CONFIG_MIPS_PB1200)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_PB1500)			+= au1000_pb1x00.o
-au1x00_ss-$(CONFIG_MIPS_DB1000)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_DB1100)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_DB1200)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_DB1500)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_DB1550)			+= au1000_db1x00.o
 au1x00_ss-$(CONFIG_MIPS_XXS1500)		+= au1000_xxs1500.o
 
 sa1111_cs-y					+= sa1111_generic.o
diff --git a/drivers/pcmcia/au1000_db1x00.c b/drivers/pcmcia/au1000_db1x00.c
deleted file mode 100644
index 6832254..0000000
--- a/drivers/pcmcia/au1000_db1x00.c
+++ /dev/null
@@ -1,307 +0,0 @@
-/*
- *
- * Alchemy Semi Db1x00 boards specific pcmcia routines.
- *
- * Copyright 2002 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
- *
- * Copyright 2004 Pete Popov, updated the driver to 2.6.
- * Followed the sa11xx API and largely copied many of the hardware
- * independent functions.
- *
- * ########################################################################
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * ########################################################################
- *
- *
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/init.h>
-
-#include <asm/irq.h>
-#include <asm/signal.h>
-#include <asm/mach-au1x00/au1000.h>
-
-#if defined(CONFIG_MIPS_DB1200)
-	#include <db1200.h>
-#elif defined(CONFIG_MIPS_PB1200)
-	#include <pb1200.h>
-#else
-	#include <asm/mach-db1x00/db1x00.h>
-#endif
-
-#include <asm/mach-db1x00/bcsr.h>
-#include "au1000_generic.h"
-
-#if 0
-#define debug(x,args...) printk(KERN_DEBUG "%s: " x, __func__ , ##args)
-#else
-#define debug(x,args...)
-#endif
-
-
-struct au1000_pcmcia_socket au1000_pcmcia_socket[PCMCIA_NUM_SOCKS];
-extern int au1x00_pcmcia_socket_probe(struct device *, struct pcmcia_low_level *, int, int);
-
-static int db1x00_pcmcia_hw_init(struct au1000_pcmcia_socket *skt)
-{
-#ifdef CONFIG_MIPS_DB1550
-	skt->irq = skt->nr ? AU1000_GPIO_5 : AU1000_GPIO_3;
-#elif defined(CONFIG_MIPS_DB1200) || defined(CONFIG_MIPS_PB1200)
-	skt->irq = skt->nr ? BOARD_PC1_INT : BOARD_PC0_INT;
-#else
-	skt->irq = skt->nr ? AU1000_GPIO_5 : AU1000_GPIO_2;
-#endif
-	return 0;
-}
-
-static void db1x00_pcmcia_shutdown(struct au1000_pcmcia_socket *skt)
-{
-	bcsr_write(BCSR_PCMCIA, 0);	/* turn off power */
-	msleep(2);
-}
-
-static void
-db1x00_pcmcia_socket_state(struct au1000_pcmcia_socket *skt, struct pcmcia_state *state)
-{
-	u32 inserted;
-	unsigned char vs;
-
-	state->ready = 0;
-	state->vs_Xv = 0;
-	state->vs_3v = 0;
-	state->detect = 0;
-
-	switch (skt->nr) {
-	case 0:
-		vs = bcsr_read(BCSR_STATUS) & 0x3;
-#if defined(CONFIG_MIPS_DB1200) || defined(CONFIG_MIPS_PB1200)
-		inserted = BOARD_CARD_INSERTED(0);
-#else
-		inserted = !(bcsr_read(BCSR_STATUS) & (1 << 4));
-#endif
-		break;
-	case 1:
-		vs = (bcsr_read(BCSR_STATUS) & 0xC) >> 2;
-#if defined(CONFIG_MIPS_DB1200) || defined(CONFIG_MIPS_PB1200)
-		inserted = BOARD_CARD_INSERTED(1);
-#else
-		inserted = !(bcsr_read(BCSR_STATUS) & (1<<5));
-#endif
-		break;
-	default:/* should never happen */
-		return;
-	}
-
-	if (inserted)
-		debug("db1x00 socket %d: inserted %d, vs %d pcmcia %x\n",
-				skt->nr, inserted, vs, bcsr_read(BCSR_PCMCIA));
-
-	if (inserted) {
-		switch (vs) {
-			case 0:
-			case 2:
-				state->vs_3v=1;
-				break;
-			case 3: /* 5V */
-				break;
-			default:
-				/* return without setting 'detect' */
-				printk(KERN_ERR "db1x00 bad VS (%d)\n",
-						vs);
-		}
-		state->detect = 1;
-		state->ready = 1;
-	}
-	else {
-		/* if the card was previously inserted and then ejected,
-		 * we should turn off power to it
-		 */
-		if ((skt->nr == 0) &&
-		    (bcsr_read(BCSR_PCMCIA) & BCSR_PCMCIA_PC0RST)) {
-			bcsr_mod(BCSR_PCMCIA, BCSR_PCMCIA_PC0RST   |
-					      BCSR_PCMCIA_PC0DRVEN |
-					      BCSR_PCMCIA_PC0VPP   |
-					      BCSR_PCMCIA_PC0VCC, 0);
-			msleep(10);
-		}
-		else if ((skt->nr == 1) &&
-			 (bcsr_read(BCSR_PCMCIA) & BCSR_PCMCIA_PC1RST)) {
-			bcsr_mod(BCSR_PCMCIA, BCSR_PCMCIA_PC1RST   |
-					      BCSR_PCMCIA_PC1DRVEN |
-					      BCSR_PCMCIA_PC1VPP   |
-					      BCSR_PCMCIA_PC1VCC, 0);
-			msleep(10);
-		}
-	}
-
-	state->bvd1=1;
-	state->bvd2=1;
-	state->wrprot=0;
-}
-
-static int
-db1x00_pcmcia_configure_socket(struct au1000_pcmcia_socket *skt, struct socket_state_t *state)
-{
-	u16 pwr;
-	int sock = skt->nr;
-
-	debug("config_skt %d Vcc %dV Vpp %dV, reset %d\n",
-			sock, state->Vcc, state->Vpp,
-			state->flags & SS_RESET);
-
-	/* pcmcia reg was set to zero at init time. Be careful when
-	 * initializing a socket not to wipe out the settings of the
-	 * other socket.
-	 */
-	pwr = bcsr_read(BCSR_PCMCIA);
-	pwr &= ~(0xf << sock*8); /* clear voltage settings */
-
-	state->Vpp = 0;
-	switch(state->Vcc){
-		case 0:  /* Vcc 0 */
-			pwr |= SET_VCC_VPP(0,0,sock);
-			break;
-		case 50: /* Vcc 5V */
-			switch(state->Vpp) {
-				case 0:
-					pwr |= SET_VCC_VPP(2,0,sock);
-					break;
-				case 50:
-					pwr |= SET_VCC_VPP(2,1,sock);
-					break;
-				case 12:
-					pwr |= SET_VCC_VPP(2,2,sock);
-					break;
-				case 33:
-				default:
-					pwr |= SET_VCC_VPP(0,0,sock);
-					printk("%s: bad Vcc/Vpp (%d:%d)\n",
-							__func__,
-							state->Vcc,
-							state->Vpp);
-					break;
-			}
-			break;
-		case 33: /* Vcc 3.3V */
-			switch(state->Vpp) {
-				case 0:
-					pwr |= SET_VCC_VPP(1,0,sock);
-					break;
-				case 12:
-					pwr |= SET_VCC_VPP(1,2,sock);
-					break;
-				case 33:
-					pwr |= SET_VCC_VPP(1,1,sock);
-					break;
-				case 50:
-				default:
-					pwr |= SET_VCC_VPP(0,0,sock);
-					printk("%s: bad Vcc/Vpp (%d:%d)\n",
-							__func__,
-							state->Vcc,
-							state->Vpp);
-					break;
-			}
-			break;
-		default: /* what's this ? */
-			pwr |= SET_VCC_VPP(0,0,sock);
-			printk(KERN_ERR "%s: bad Vcc %d\n",
-					__func__, state->Vcc);
-			break;
-	}
-
-	bcsr_write(BCSR_PCMCIA, pwr);
-	msleep(3);
-
-	if (sock == 0) {
-		if (!(state->flags & SS_RESET)) {
-			pwr |= BCSR_PCMCIA_PC0DRVEN;
-			bcsr_write(BCSR_PCMCIA, pwr);
-			msleep(300);
-			pwr |= BCSR_PCMCIA_PC0RST;
-			bcsr_write(BCSR_PCMCIA, pwr);
-			msleep(100);
-		}
-		else {
-			pwr &= ~(BCSR_PCMCIA_PC0RST | BCSR_PCMCIA_PC0DRVEN);
-			bcsr_write(BCSR_PCMCIA, pwr);
-			msleep(100);
-		}
-	}
-	else {
-		if (!(state->flags & SS_RESET)) {
-			pwr |= BCSR_PCMCIA_PC1DRVEN;
-			bcsr_write(BCSR_PCMCIA, pwr);
-			msleep(300);
-			pwr |= BCSR_PCMCIA_PC1RST;
-			bcsr_write(BCSR_PCMCIA, pwr);
-			msleep(100);
-		}
-		else {
-			pwr &= ~(BCSR_PCMCIA_PC1RST | BCSR_PCMCIA_PC1DRVEN);
-			bcsr_write(BCSR_PCMCIA, pwr);
-			msleep(100);
-		}
-	}
-	return 0;
-}
-
-/*
- * Enable card status IRQs on (re-)initialisation.  This can
- * be called at initialisation, power management event, or
- * pcmcia event.
- */
-void db1x00_socket_init(struct au1000_pcmcia_socket *skt)
-{
-	/* nothing to do for now */
-}
-
-/*
- * Disable card status IRQs and PCMCIA bus on suspend.
- */
-void db1x00_socket_suspend(struct au1000_pcmcia_socket *skt)
-{
-	/* nothing to do for now */
-}
-
-struct pcmcia_low_level db1x00_pcmcia_ops = {
-	.owner			= THIS_MODULE,
-
-	.hw_init 		= db1x00_pcmcia_hw_init,
-	.hw_shutdown		= db1x00_pcmcia_shutdown,
-
-	.socket_state		= db1x00_pcmcia_socket_state,
-	.configure_socket	= db1x00_pcmcia_configure_socket,
-
-	.socket_init		= db1x00_socket_init,
-	.socket_suspend		= db1x00_socket_suspend
-};
-
-int au1x_board_init(struct device *dev)
-{
-	int ret = -ENODEV;
-	bcsr_write(BCSR_PCMCIA, 0); /* turn off power, if it's not already off */
-	msleep(2);
-	ret = au1x00_pcmcia_socket_probe(dev, &db1x00_pcmcia_ops, 0, 2);
-	return ret;
-}
diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
new file mode 100644
index 0000000..349f86c
--- /dev/null
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -0,0 +1,649 @@
+/*
+ * PCMCIA socket code for the Alchemy Db1xxx/Pb1xxx boards.
+ *
+ * Copyright (c) 2009 Manuel Lauss <manuel.lauss@gmail.com>
+ *
+ */
+
+/* This is a fairly generic PCMCIA socket driver suitable for the
+ * following Alchemy Development boards:
+ *  Db1000, Db/Pb1500, Db/Pb1100, Db/Pb1550, Db/Pb1200.
+ *
+ * The PB1000 is rather ... special... and not yet supported.
+ *
+ * The Db1000 is used as a reference:  Per-socket card-, carddetect- and
+ *  statuschange IRQs connected to SoC GPIOs, control and status register
+ *  bits arranged in per-socket groups in an external PLD.  All boards
+ *  listed here use this layout, including bit positions and meanings.
+ *  Of course there are exceptions in later boards:
+ *
+ *	- Pb1100/Pb1500:  single socket only; voltage key bits VS are
+ *			  at STATUS[5:4] (instead of STATUS[1:0]).
+ *	- Au1550-based:   control regs are at different base address.
+ *	- Au1200-based:   control regs are at different base address,
+ *			  additional card-eject irqs, irqs not gpios!
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/mm.h>
+#include <linux/pm.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/spinlock.h>
+
+#include <pcmcia/cs_types.h>
+#include <pcmcia/cs.h>
+#include <pcmcia/ss.h>
+#include <pcmcia/cistpl.h>
+
+#include <asm/irq.h>
+#include <asm/system.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-db1x00/bcsr.h>
+
+#define MEM_MAP_SIZE	0x400000
+#define IO_MAP_SIZE	0x1000
+
+struct db1x_pcmcia_sock {
+	struct pcmcia_socket	socket;
+	int		nr;		/* socket number */
+	void		*virt_io;
+
+	/* the "pseudo" addresses of the PCMCIA space. */
+	unsigned long	phys_io;
+	unsigned long	phys_attr;
+	unsigned long	phys_mem;
+
+	/* previous flags for set_socket() */
+	unsigned int old_flags;
+
+	/* interrupt sources.  Real linux irq numbers, NOT the GPIO pins! */
+	int	insert_irq;	/* default carddetect irq */
+	int	stschg_irq;	/* card-status-change irq */
+	int	card_irq;	/* card irq */
+	int	eject_irq;	/* db1200/pb1200 have these */
+
+#define BOARD_TYPE_DEFAULT	0	/* most Db1x boards */
+#define BOARD_TYPE_DB1200	1	/* IRQs aren't gpios */
+#define BOARD_TYPE_PB1100	2	/* VS bits slightly different */
+	int	board_type;
+};
+
+#define to_db1x_socket(x) container_of(x, struct db1x_pcmcia_sock, socket)
+
+/*
+ * card in socket for DB1200/PB1200:  Check CPLD SigStatus register;
+ * bits 10/12 are 1 if a card is in the socket (0/1)
+ */
+static int db1200_card_inserted(struct db1x_pcmcia_sock *sock)
+{
+	unsigned short sigstat;
+
+	sigstat = bcsr_read(BCSR_SIGSTAT);
+	return sigstat & 1 << (8 + 2 * sock->nr);
+}
+
+/*
+ * Check the carddetect-gpio: if it's low, then there's a card.
+ */
+static int db1000_card_inserted(struct db1x_pcmcia_sock *sock)
+{
+	return !gpio_get_value(irq_to_gpio(sock->insert_irq));
+}
+
+static int db1x_card_inserted(struct db1x_pcmcia_sock *sock)
+{
+	switch (sock->board_type) {
+	case BOARD_TYPE_DB1200:
+		return db1200_card_inserted(sock);
+	default:
+		return db1000_card_inserted(sock);
+	}
+}
+
+/* STSCHG tends to bounce heavily when cards are inserted/ejected.
+ * To avoid this, the interrupt is normally disabled and only enabled
+ * after reset to a card has been de-asserted.
+ */
+static inline void set_stschg(struct db1x_pcmcia_sock *sock, int en)
+{
+	if (sock->stschg_irq != -1) {
+		if (en)
+			enable_irq(sock->stschg_irq);
+		else
+			disable_irq(sock->stschg_irq);
+	}
+}
+
+static irqreturn_t db1000_pcmcia_cdirq(int irq, void *data)
+{
+	struct db1x_pcmcia_sock *sock = data;
+
+	pcmcia_parse_events(&sock->socket, SS_DETECT);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t db1000_pcmcia_stschgirq(int irq, void *data)
+{
+	struct db1x_pcmcia_sock *sock = data;
+
+	pcmcia_parse_events(&sock->socket, SS_STSCHG);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t db1200_pcmcia_cdirq(int irq, void *data)
+{
+	struct db1x_pcmcia_sock *sock = data;
+
+	/* Db/Pb1200 have separate per-socket insertion and ejection
+	 * interrupts which stay asserted as long as the card is
+	 * inserted/missing.  The one which caused us to be called
+	 * needs to be disabled and the other one enabled.
+	 */
+	if (irq == sock->insert_irq) {
+		disable_irq_nosync(sock->insert_irq);
+		enable_irq(sock->eject_irq);
+	} else {
+		disable_irq_nosync(sock->eject_irq);
+		enable_irq(sock->insert_irq);
+	}
+
+	pcmcia_parse_events(&sock->socket, SS_DETECT);
+
+	return IRQ_HANDLED;
+}
+
+static int db1x_pcmcia_setup_irqs(struct db1x_pcmcia_sock *sock)
+{
+	int ret;
+	unsigned long flags;
+
+	if (sock->stschg_irq != -1) {
+		ret = request_irq(sock->stschg_irq, db1000_pcmcia_stschgirq,
+				  0, "pcmcia_stschg", sock);
+		if (ret)
+			return ret;
+	}
+
+	/* Db/Pb1200 have separate per-socket insertion and ejection
+	 * interrupts.  The manual says they're supposed to be edge, but
+	 * they ejection/insertion IRQ stay asserted as long as a card
+	 * is missing/inserted.  The IRQ handler disables the one
+	 * which triggered and unmasks its companion, however this can
+	 * cause "unbalanced enable_irq()" messages as it enables the
+	 * one IRQ currently not requested.  So IRQs are disabled until
+	 * both have been requested.
+	 */
+	if (sock->board_type == BOARD_TYPE_DB1200) {
+		local_irq_save(flags);
+
+		ret = request_irq(sock->insert_irq, db1200_pcmcia_cdirq,
+				  IRQF_DISABLED, "pcmcia_insert", sock);
+		if (ret)
+			goto out1;
+
+		ret = request_irq(sock->eject_irq, db1200_pcmcia_cdirq,
+				  IRQF_DISABLED, "pcmcia_eject", sock);
+		if (ret) {
+			free_irq(sock->insert_irq, sock);
+			local_irq_restore(flags);
+			goto out1;
+		}
+
+		/* disable the currently active one */
+		if (db1200_card_inserted(sock))
+			disable_irq_nosync(sock->insert_irq);
+		else
+			disable_irq_nosync(sock->eject_irq);
+
+		local_irq_restore(flags);
+	} else {
+		/* all other (older) Db1x00 boards use a GPIO to show
+		 * card detection status: neat for both-edge irq type.
+		 */
+		set_irq_type(sock->insert_irq, IRQ_TYPE_EDGE_BOTH);
+		ret = request_irq(sock->insert_irq, db1000_pcmcia_cdirq,
+				  0, "pcmcia_carddetect", sock);
+
+		if (ret)
+			goto out1;
+	}
+
+	return 0;	/* all done */
+
+out1:
+	if (sock->stschg_irq != -1)
+		free_irq(sock->stschg_irq, sock);
+
+	return ret;
+}
+
+static void db1x_pcmcia_free_irqs(struct db1x_pcmcia_sock *sock)
+{
+	if (sock->stschg_irq != -1)
+		free_irq(sock->stschg_irq, sock);
+
+	free_irq(sock->insert_irq, sock);
+	if (sock->eject_irq != -1)
+		free_irq(sock->eject_irq, sock);
+}
+
+/*
+ * configure a PCMCIA socket on the Db1x00 series of boards (and
+ * compatibles).
+ *
+ * 2 external registers are involved:
+ *   pcmcia_status (offset 0x04): bits [0:1/2:3]: read card voltage id
+ *   pcmcia_control(offset 0x10):
+ *	bits[0:1] set vcc for card
+ *	bits[2:3] set vpp for card
+ *	bit 4:	enable data buffers
+ *	bit 7:	reset# for card
+ *	add 8 for second socket.
+ */
+static int db1x_pcmcia_configure(struct pcmcia_socket *skt,
+				 struct socket_state_t *state)
+{
+	struct db1x_pcmcia_sock *sock = to_db1x_socket(skt);
+	unsigned short cr;
+	unsigned int changed;
+	int v, p, ret;
+
+	/*
+	 * card voltage setup
+	 */
+	cr = bcsr_read(BCSR_PCMCIA);
+	cr &= ~(0xf << (sock->nr * 8));	/* clear voltage settings */
+	v = p = ret = 0;
+
+	switch (state->Vcc) {
+	case 50:
+		++v;
+	case 33:
+		++v;
+	case 0:
+		break;
+	default:
+		printk(KERN_INFO "pcmcia%d unsupported Vcc %d\n",
+			sock->nr, state->Vcc);
+	}
+
+	switch (state->Vpp) {
+	case 12:
+		++p;
+	case 33:
+	case 50:
+		++p;
+	case 0:
+		break;
+	default:
+		printk(KERN_INFO "pcmcia%d unsupported Vpp %d\n",
+			sock->nr, state->Vpp);
+	}
+
+	/* sanity check: Vpp must be 0, 12, or Vcc */
+	if (((state->Vcc == 33) && (state->Vpp == 50)) ||
+	    ((state->Vcc == 50) && (state->Vpp == 33))) {
+		printk(KERN_INFO "pcmcia%d bad Vcc/Vpp combo (%d %d)\n",
+			sock->nr, state->Vcc, state->Vpp);
+		v = p = 0;
+		ret = -EINVAL;
+	}
+
+	/* create new voltage code */
+	cr |= ((v << 2) | p) << (sock->nr * 8);
+
+	changed = state->flags ^ sock->old_flags;
+
+	if (changed & SS_RESET) {
+		if (state->flags & SS_RESET) {
+			set_stschg(sock, 0);
+			/* assert reset, disable io buffers */
+			cr &= ~(1 << (7 + (sock->nr * 8)));
+			cr &= ~(1 << (4 + (sock->nr * 8)));
+		} else {
+			/* de-assert reset, enable io buffers */
+			cr |= 1 << (7 + (sock->nr * 8));
+			cr |= 1 << (4 + (sock->nr * 8));
+		}
+	}
+
+	bcsr_write(BCSR_PCMCIA, cr);
+
+	sock->old_flags = state->flags;
+
+	/* reset was taken away: give card time to initialize properly */
+	if ((changed & SS_RESET) && !(state->flags & SS_RESET)) {
+		msleep(500);
+		set_stschg(sock, 1);
+	}
+
+	return ret;
+}
+
+/* VCC bits at [3:2]/[11:10] */
+#define GET_VCC(cr, socknr)		\
+	((((cr) >> 2) >> ((socknr) * 8)) & 3)
+
+/* VS bits at [0:1]/[3:2] */
+#define GET_VS(sr, socknr)		\
+	(((sr) >> (2 * (socknr))) & 3)
+
+/* reset bits at [7]/[15] */
+#define GET_RESET(cr, socknr)		\
+	((cr) & (1 << (7 + (8 * (socknr)))))
+
+static int db1x_pcmcia_get_status(struct pcmcia_socket *skt,
+				  unsigned int *value)
+{
+	struct db1x_pcmcia_sock *sock = to_db1x_socket(skt);
+	unsigned short cr, sr;
+	unsigned int status;
+
+	status = db1x_card_inserted(sock) ? SS_DETECT : 0;
+
+	cr = bcsr_read(BCSR_PCMCIA);
+	sr = bcsr_read(BCSR_STATUS);
+
+	/* PB1100/PB1500: voltage key bits are at [5:4] */
+	if (sock->board_type == BOARD_TYPE_PB1100)
+		sr >>= 4;
+
+	/* determine card type */
+	switch (GET_VS(sr, sock->nr)) {
+	case 0:
+	case 2:
+		status |= SS_3VCARD;	/* 3V card */
+	case 3:
+		break;			/* 5V card: set nothing */
+	default:
+		status |= SS_XVCARD;	/* treated as unsupported in core */
+	}
+
+	/* if Vcc is not zero, we have applied power to a card */
+	status |= GET_VCC(cr, sock->nr) ? SS_POWERON : 0;
+
+	/* reset de-asserted? then we're ready */
+	status |= (GET_RESET(cr, sock->nr)) ? SS_READY : SS_RESET;
+
+	*value = status;
+
+	return 0;
+}
+
+static int db1x_pcmcia_sock_init(struct pcmcia_socket *skt)
+{
+	return 0;
+}
+
+static int db1x_pcmcia_sock_suspend(struct pcmcia_socket *skt)
+{
+	return 0;
+}
+
+static int au1x00_pcmcia_set_io_map(struct pcmcia_socket *skt,
+				    struct pccard_io_map *map)
+{
+	struct db1x_pcmcia_sock *sock = to_db1x_socket(skt);
+
+	map->start = (u32)sock->virt_io;
+	map->stop = map->start + IO_MAP_SIZE;
+
+	return 0;
+}
+
+static int au1x00_pcmcia_set_mem_map(struct pcmcia_socket *skt,
+				     struct pccard_mem_map *map)
+{
+	struct db1x_pcmcia_sock *sock = to_db1x_socket(skt);
+
+	if (map->flags & MAP_ATTRIB)
+		map->static_start = sock->phys_attr + map->card_start;
+	else
+		map->static_start = sock->phys_mem + map->card_start;
+
+	return 0;
+}
+
+static struct pccard_operations db1x_pcmcia_operations = {
+	.init			= db1x_pcmcia_sock_init,
+	.suspend		= db1x_pcmcia_sock_suspend,
+	.get_status		= db1x_pcmcia_get_status,
+	.set_socket		= db1x_pcmcia_configure,
+	.set_io_map		= au1x00_pcmcia_set_io_map,
+	.set_mem_map		= au1x00_pcmcia_set_mem_map,
+};
+
+static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
+{
+	struct db1x_pcmcia_sock *sock;
+	struct resource *r;
+	phys_t physio;
+	int ret, bid;
+
+	sock = kzalloc(sizeof(struct db1x_pcmcia_sock), GFP_KERNEL);
+	if (!sock)
+		return -ENOMEM;
+
+	sock->nr = pdev->id;
+
+	bid = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
+	switch (bid) {
+	case BCSR_WHOAMI_PB1500:
+	case BCSR_WHOAMI_PB1500R2:
+	case BCSR_WHOAMI_PB1100:
+		sock->board_type = BOARD_TYPE_PB1100;
+		break;
+	case BCSR_WHOAMI_DB1000 ... BCSR_WHOAMI_PB1550_SDR:
+		sock->board_type = BOARD_TYPE_DEFAULT;
+		break;
+	case BCSR_WHOAMI_PB1200 ... BCSR_WHOAMI_DB1200:
+		sock->board_type = BOARD_TYPE_DB1200;
+		break;
+	default:
+		printk(KERN_INFO "db1xxx-ss: unknown board %d!\n", bid);
+		ret = -ENODEV;
+		goto out0;
+	};
+
+	/*
+	 * gather resources necessary and optional nice-to-haved to
+	 * operate a socket.
+	 * This includes IRQs for Carddetection/ejection, the card
+	 *  itself and optional status change detection.
+	 * Also, the memory areas covered by a socket.  For these
+	 *  we require the 32bit "pseudo" addresses (see the au1000.h
+	 *  header for more information).
+	 */
+
+	/* card: irq assigned to the card itself. */
+	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "card");
+	sock->card_irq = r ? r->start : 0;
+
+	/* insert: irq which triggers on card insertion/ejection */
+	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "insert");
+	sock->insert_irq = r ? r->start : -1;
+
+	/* stschg: irq which trigger on card status change (optional) */
+	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "stschg");
+	sock->stschg_irq = r ? r->start : -1;
+
+	/* eject: irq which triggers on ejection (DB1200/PB1200 only) */
+	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "eject");
+	sock->eject_irq = r ? r->start : -1;
+
+	ret = -ENODEV;
+
+	/*
+	 * pseudo-attr:  The 32bit address of the PCMCIA attribute space
+	 * for this socket (usually the 36bit address shifted 4 to the
+	 * right).
+	 */
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pseudo-attr");
+	if (!r) {
+		printk(KERN_ERR "pcmcia%d has no 'pseudo-attr' resource!\n",
+			sock->nr);
+		goto out0;
+	}
+	sock->phys_attr = r->start;
+
+	/*
+	 * pseudo-mem:  The 32bit address of the PCMCIA memory space for
+	 * this socket (usually the 36bit address shifted 4 to the right)
+	 */
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pseudo-mem");
+	if (!r) {
+		printk(KERN_ERR "pcmcia%d has no 'pseudo-mem' resource!\n",
+			sock->nr);
+		goto out0;
+	}
+	sock->phys_mem = r->start;
+
+	/*
+	 * pseudo-io:  The 32bit address of the PCMCIA IO space for this
+	 * socket (usually the 36bit address shifted 4 to the right).
+	 */
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pseudo-io");
+	if (!r) {
+		printk(KERN_ERR "pcmcia%d has no 'pseudo-io' resource!\n",
+			sock->nr);
+		goto out0;
+	}
+	sock->phys_io = r->start;
+
+
+	/* for io must remap the full 36bit address (for reference see
+	 * alchemy/common/setup.c::__fixup_bigphys_addr)
+	 */
+	physio = ((phys_t)sock->phys_io) << 4;
+
+	/*
+	 * PCMCIA client drivers use the inb/outb macros to access
+	 * the IO registers.  Since mips_io_port_base is added
+	 * to the access address of the mips implementation of
+	 * inb/outb, we need to subtract it here because we want
+	 * to access the I/O or MEM address directly, without
+	 * going through this "mips_io_port_base" mechanism.
+	 */
+	sock->virt_io = (void *)(ioremap(physio, IO_MAP_SIZE) -
+				 mips_io_port_base);
+
+	if (!sock->virt_io) {
+		printk(KERN_ERR "pcmcia%d: cannot remap IO area\n",
+			sock->nr);
+		ret = -ENOMEM;
+		goto out0;
+	}
+
+	sock->socket.ops	= &db1x_pcmcia_operations;
+	sock->socket.owner	= THIS_MODULE;
+	sock->socket.pci_irq	= sock->card_irq;
+	sock->socket.features	= SS_CAP_STATIC_MAP | SS_CAP_PCCARD;
+	sock->socket.map_size	= MEM_MAP_SIZE;
+	sock->socket.io_offset	= (unsigned long)sock->virt_io;
+	sock->socket.dev.parent	= &pdev->dev;
+	sock->socket.resource_ops = &pccard_static_ops;
+
+	platform_set_drvdata(pdev, sock);
+
+	ret = db1x_pcmcia_setup_irqs(sock);
+	if (ret) {
+		printk(KERN_ERR "pcmcia%d cannot setup interrupts\n",
+			sock->nr);
+		goto out1;
+	}
+
+	set_stschg(sock, 0);
+
+	ret = pcmcia_register_socket(&sock->socket);
+	if (ret) {
+		printk(KERN_ERR "pcmcia%d failed to register\n", sock->nr);
+		goto out2;
+	}
+
+	printk(KERN_INFO "Alchemy Db/Pb1xxx pcmcia%d @ io/attr/mem %08lx"
+		"(%p) %08lx %08lx  card/insert/stschg/eject irqs @ %d "
+		"%d %d %d\n", sock->nr, sock->phys_io, sock->virt_io,
+		sock->phys_attr, sock->phys_mem, sock->card_irq,
+		sock->insert_irq, sock->stschg_irq, sock->eject_irq);
+
+	return 0;
+
+out2:
+	db1x_pcmcia_free_irqs(sock);
+out1:
+	iounmap((void *)(sock->virt_io + (u32)mips_io_port_base));
+out0:
+	kfree(sock);
+	return ret;
+}
+
+static int __devexit db1x_pcmcia_socket_remove(struct platform_device *pdev)
+{
+	struct db1x_pcmcia_sock *sock = platform_get_drvdata(pdev);
+
+	pcmcia_unregister_socket(&sock->socket);
+	db1x_pcmcia_free_irqs(sock);
+	iounmap((void *)(sock->virt_io + (u32)mips_io_port_base));
+	kfree(sock);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int db1x_pcmcia_suspend(struct device *dev)
+{
+	/* REVISIT: 2nd parameter is currently ignored but required */
+	return pcmcia_socket_dev_suspend(dev, PMSG_SUSPEND);
+}
+
+static int db1x_pcmcia_resume(struct device *dev)
+{
+	return pcmcia_socket_dev_resume(dev);
+}
+
+static struct dev_pm_ops db1x_pcmcia_pmops = {
+	.resume		= db1x_pcmcia_resume,
+	.suspend	= db1x_pcmcia_suspend,
+};
+
+#define DB1XXX_SS_PMOPS &db1x_pcmcia_pmops
+
+#else
+
+#define DB1XXX_SS_PMOPS NULL
+
+#endif
+
+static struct platform_driver db1x_pcmcia_socket_driver = {
+	.driver	= {
+		.name	= "db1xxx_pcmcia",
+		.owner	= THIS_MODULE,
+		.pm	= DB1XXX_SS_PMOPS
+	},
+	.probe		= db1x_pcmcia_socket_probe,
+	.remove		= __devexit_p(db1x_pcmcia_socket_remove),
+};
+
+int __init db1x_pcmcia_socket_load(void)
+{
+	return platform_driver_register(&db1x_pcmcia_socket_driver);
+}
+
+void  __exit db1x_pcmcia_socket_unload(void)
+{
+	platform_driver_unregister(&db1x_pcmcia_socket_driver);
+}
+
+module_init(db1x_pcmcia_socket_load);
+module_exit(db1x_pcmcia_socket_unload);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PCMCIA Socket Services for Alchemy Db/Pb1x00 boards");
+MODULE_AUTHOR("Manuel Lauss");
-- 
1.6.5.rc1
