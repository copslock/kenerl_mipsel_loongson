Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Oct 2009 14:57:20 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:42791 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492534AbZJDMzn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 Oct 2009 14:55:43 +0200
Received: by ewy10 with SMTP id 10so1846519ewy.33
        for <multiple recipients>; Sun, 04 Oct 2009 05:55:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wYxOGqVaFhWrUnM5OF3u9H4I6WL9VEWm9APBOZOPwFQ=;
        b=HAmwfHoNrhac0PgY1bxD5MseuS8aXCsIy3/y/CKG9K71JP8vS/Lmnz769I+frMyFUD
         hOJCLkD03xe5aq2bZGwE2/81UHH9dHi6jGHr/9+/isLOEJc1OQ27fOSjtk4rluf/DDir
         OFDVR7zaTuiYuhHA52dneLvGc1zJXGXG2+8/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JQG4Pisca0wgogUJAeGHewLtnDCwgCvdx0Dq8SAoLfYG3VPt/r7opXfBg4P7Z/qpWj
         UVv0AIjN7ltbi9OFGrZ1MyHzW2Vj8CtWCo9jr6kx2rPAC0vE5ieZCEpdF+CksRhdXoRV
         tPGdbOqGMA2bWLovH32fR+sHS6XbGIBhPBsIE=
Received: by 10.210.7.21 with SMTP id 21mr1972304ebg.66.1254660938278;
        Sun, 04 Oct 2009 05:55:38 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 28sm1555483eyg.4.2009.10.04.05.55.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Oct 2009 05:55:37 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 5/6] Alchemy: devboards: wire up new PCMCIA driver.
Date:	Sun,  4 Oct 2009 14:55:28 +0200
Message-Id: <1254660929-15453-6-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
In-Reply-To: <1254660929-15453-5-git-send-email-manuel.lauss@gmail.com>
References: <1254660929-15453-1-git-send-email-manuel.lauss@gmail.com>
 <1254660929-15453-2-git-send-email-manuel.lauss@gmail.com>
 <1254660929-15453-3-git-send-email-manuel.lauss@gmail.com>
 <1254660929-15453-4-git-send-email-manuel.lauss@gmail.com>
 <1254660929-15453-5-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Register the PCMCIA driver on all boards supported by it,
get rid of now-unused pcmcia macros in the board headers
(and subsequently empty pb1100/pb1500 ones).

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
V2: split the previous patch in 2 parts; one with the PCMCIA driver,
    the other (this one) to add the socket device registration to the
    various boards.
    Instead of dumping the whole "struct resource" tables for every
    socket into each boards' platform file, they now call a fucntion
    with socket data to setup the whole resource/platform_device stuff;
    saves a lot of lines.

 arch/mips/alchemy/devboards/Makefile             |    2 +-
 arch/mips/alchemy/devboards/db1x00/board_setup.c |    4 +
 arch/mips/alchemy/devboards/db1x00/platform.c    |   84 ++++++++++++++++++++
 arch/mips/alchemy/devboards/pb1100/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1100/platform.c    |   41 ++++++++++
 arch/mips/alchemy/devboards/pb1200/platform.c    |   55 +++++++++++++-
 arch/mips/alchemy/devboards/pb1500/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1500/board_setup.c |    3 +
 arch/mips/alchemy/devboards/pb1500/platform.c    |   41 ++++++++++
 arch/mips/alchemy/devboards/pb1550/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1550/board_setup.c |    8 ++
 arch/mips/alchemy/devboards/pb1550/platform.c    |   63 +++++++++++++++
 arch/mips/alchemy/devboards/platform.c           |   89 ++++++++++++++++++++++
 arch/mips/alchemy/devboards/platform.h           |   18 +++++
 arch/mips/include/asm/mach-db1x00/db1200.h       |   15 ----
 arch/mips/include/asm/mach-db1x00/db1x00.h       |    8 --
 arch/mips/include/asm/mach-pb1x00/pb1100.h       |   36 ---------
 arch/mips/include/asm/mach-pb1x00/pb1200.h       |   14 ----
 arch/mips/include/asm/mach-pb1x00/pb1500.h       |   36 ---------
 arch/mips/include/asm/mach-pb1x00/pb1550.h       |    7 --
 20 files changed, 411 insertions(+), 122 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/db1x00/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1100/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1500/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1550/platform.c
 create mode 100644 arch/mips/alchemy/devboards/platform.c
 create mode 100644 arch/mips/alchemy/devboards/platform.h
 delete mode 100644 arch/mips/include/asm/mach-pb1x00/pb1100.h
 delete mode 100644 arch/mips/include/asm/mach-pb1x00/pb1500.h

diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index adc6717..cfda972 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -2,7 +2,7 @@
 # Alchemy Develboards
 #
 
-obj-y += prom.o bcsr.o
+obj-y += prom.o bcsr.o platform.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_MIPS_PB1000)	+= pb1000/
 obj-$(CONFIG_MIPS_PB1100)	+= pb1100/
diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index 9a619ae..3b228a2 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -187,8 +187,12 @@ static int __init db1x00_init_irq(void)
 #if defined(CONFIG_MIPS_MIRAGE)
 	set_irq_type(AU1000_GPIO_7, IRQF_TRIGGER_RISING); /* TS pendown */
 #elif defined(CONFIG_MIPS_DB1550)
+	set_irq_type(AU1000_GPIO_0, IRQF_TRIGGER_LOW);	/* CD0# */
+	set_irq_type(AU1000_GPIO_1, IRQF_TRIGGER_LOW);	/* CD1# */
 	set_irq_type(AU1000_GPIO_3, IRQF_TRIGGER_LOW);	/* CARD0# */
 	set_irq_type(AU1000_GPIO_5, IRQF_TRIGGER_LOW);	/* CARD1# */
+	set_irq_type(AU1000_GPIO_21, IRQF_TRIGGER_LOW);	/* STSCHG0# */
+	set_irq_type(AU1000_GPIO_22, IRQF_TRIGGER_LOW);	/* STSCHG1# */
 #else
 	set_irq_type(AU1000_GPIO_0, IRQF_TRIGGER_LOW);	/* CD0# */
 	set_irq_type(AU1000_GPIO_3, IRQF_TRIGGER_LOW);	/* CD1# */
diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
new file mode 100644
index 0000000..b762b79
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -0,0 +1,84 @@
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
+#include "../platform.h"
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
+static int __init db1xxx_dev_init(void)
+{
+#ifdef DB1XXX_HAS_PCMCIA
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
+				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
+				    PCMCIA_MEM_PSEUDO_PHYS,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
+				    PCMCIA_IO_PSEUDO_PHYS,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
+				    DB1XXX_PCMCIA_CARD0,
+				    DB1XXX_PCMCIA_CD0,
+				    /*DB1XXX_PCMCIA_STSCHG0*/0,
+				    0,
+				    0);
+
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS + 0x00400000,
+				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00440000 - 1,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00400000,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00440000 - 1,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00400000,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00401000 - 1,
+				    DB1XXX_PCMCIA_CARD1,
+				    DB1XXX_PCMCIA_CD1,
+				    /*DB1XXX_PCMCIA_STSCHG1*/0,
+				    0,
+				    1);
+#endif
+	return 0;
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
index 0000000..8aefecd
--- /dev/null
+++ b/arch/mips/alchemy/devboards/pb1100/platform.c
@@ -0,0 +1,41 @@
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
+
+#include "../platform.h"
+
+static int __init pb1100_dev_init(void)
+{
+	/* PCMCIA. single socket, identical to Pb1500 */
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
+				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
+				    PCMCIA_MEM_PSEUDO_PHYS,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
+				    PCMCIA_IO_PSEUDO_PHYS,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
+				    AU1000_GPIO_11,	 /* card */
+				    AU1000_GPIO_9,	 /* insert */
+				    /*AU1000_GPIO_10*/0, /* stschg */
+				    0,			 /* eject */
+				    0);			 /* id */
+	return 0;
+}
+device_initcall(pb1100_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index dfdaabf..c8b7ae3 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -28,6 +28,8 @@
 #include <asm/mach-au1x00/au1100_mmc.h>
 #include <asm/mach-db1x00/bcsr.h>
 
+#include "../platform.h"
+
 static int mmc_activity;
 
 static void pb1200mmc0_set_power(void *mmc_host, int state)
@@ -170,8 +172,57 @@ static struct platform_device *board_platform_devices[] __initdata = {
 
 static int __init board_register_devices(void)
 {
+#ifdef CONFIG_MIPS_PB1200
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
+				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
+				    PCMCIA_MEM_PSEUDO_PHYS,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
+				    PCMCIA_IO_PSEUDO_PHYS,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
+				    PB1200_PC0_INT,
+				    PB1200_PC0_INSERT_INT,
+				    /*PB1200_PC0_STSCHG_INT*/0,
+				    PB1200_PC0_EJECT_INT,
+				    0);
+
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS + 0x00800000,
+				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00840000 - 1,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00800000,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00840000 - 1,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00800000,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00801000 - 1,
+				    PB1200_PC1_INT,
+				    PB1200_PC1_INSERT_INT,
+				    /*PB1200_PC1_STSCHG_INT*/0,
+				    PB1200_PC1_EJECT_INT,
+				    1);
+#else
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
+				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
+				    PCMCIA_MEM_PSEUDO_PHYS,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
+				    PCMCIA_IO_PSEUDO_PHYS,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
+				    DB1200_PC0_INT,
+				    DB1200_PC0_INSERT_INT,
+				    /*DB1200_PC0_STSCHG_INT*/0,
+				    DB1200_PC0_EJECT_INT,
+				    0);
+
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS + 0x00400000,
+				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00440000 - 1,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00400000,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00440000 - 1,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00400000,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00401000 - 1,
+				    DB1200_PC1_INT,
+				    DB1200_PC1_INSERT_INT,
+				    /*DB1200_PC1_STSCHG_INT*/0,
+				    DB1200_PC1_EJECT_INT,
+				    1);
+#endif
+
 	return platform_add_devices(board_platform_devices,
 				    ARRAY_SIZE(board_platform_devices));
 }
-
-arch_initcall(board_register_devices);
+device_initcall(board_register_devices);
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
index bf8e149..4c4facb 100644
--- a/arch/mips/alchemy/devboards/pb1500/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1500/board_setup.c
@@ -156,6 +156,9 @@ void __init board_setup(void)
 
 static int __init pb1500_init_irq(void)
 {
+	set_irq_type(AU1000_GPIO_9, IRQF_TRIGGER_LOW);	/* CD0# */
+	set_irq_type(AU1000_GPIO_10, IRQF_TRIGGER_LOW);	/* CARD0 */
+	set_irq_type(AU1000_GPIO_11, IRQF_TRIGGER_LOW);	/* STSCHG0# */
 	set_irq_type(AU1500_GPIO_204, IRQF_TRIGGER_HIGH);
 	set_irq_type(AU1500_GPIO_201, IRQF_TRIGGER_LOW);
 	set_irq_type(AU1500_GPIO_202, IRQF_TRIGGER_LOW);
diff --git a/arch/mips/alchemy/devboards/pb1500/platform.c b/arch/mips/alchemy/devboards/pb1500/platform.c
new file mode 100644
index 0000000..beb21e4
--- /dev/null
+++ b/arch/mips/alchemy/devboards/pb1500/platform.c
@@ -0,0 +1,41 @@
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
+
+#include "../platform.h"
+
+static int __init pb1500_dev_init(void)
+{
+	/* PCMCIA. single socket, identical to Pb1500 */
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
+				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
+				    PCMCIA_MEM_PSEUDO_PHYS,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
+				    PCMCIA_IO_PSEUDO_PHYS,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
+				    AU1000_GPIO_11,	 /* card */
+				    AU1000_GPIO_9,	 /* insert */
+				    /*AU1000_GPIO_10*/0, /* stschg */
+				    0,			 /* eject */
+				    0);			 /* id */
+	return 0;
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
index 64f1ff9..64a6fc4 100644
--- a/arch/mips/alchemy/devboards/pb1550/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1550/board_setup.c
@@ -33,6 +33,7 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1550.h>
 #include <asm/mach-db1x00/bcsr.h>
+#include <asm/mach-au1x00/gpio.h>
 
 #include <prom.h>
 
@@ -70,6 +71,8 @@ void __init board_setup(void)
 	}
 #endif
 
+	alchemy_gpio2_enable();
+
 	/*
 	 * Enable PSC1 SYNC for AC'97.  Normaly done in audio driver,
 	 * but it is board specific code, so put it here.
@@ -88,6 +91,11 @@ static int __init pb1550_init_irq(void)
 {
 	set_irq_type(AU1000_GPIO_0, IRQF_TRIGGER_LOW);
 	set_irq_type(AU1000_GPIO_1, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO_201_205, IRQF_TRIGGER_HIGH);
+
+	/* enable both PCMCIA card irqs in the shared line */
+	alchemy_gpio2_enable_int(201);
+	alchemy_gpio2_enable_int(202);
 
 	return 0;
 }
diff --git a/arch/mips/alchemy/devboards/pb1550/platform.c b/arch/mips/alchemy/devboards/pb1550/platform.c
new file mode 100644
index 0000000..aa5016c
--- /dev/null
+++ b/arch/mips/alchemy/devboards/pb1550/platform.c
@@ -0,0 +1,63 @@
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
+#include <linux/init.h>
+
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-pb1x00/pb1550.h>
+
+#include "../platform.h"
+
+static int __init pb1550_dev_init(void)
+{
+	/* Pb1550, like all others, also has statuschange irqs; however they're
+	* wired up on one of the Au1550's shared GPIO201_205 line, which also
+	* services the PCMCIA card interrupts.  So we ignore statuschange and
+	* use the GPIO201_205 exclusively for card interrupts, since a) pcmcia
+	* drivers are used to shared irqs and b) statuschange isn't really use-
+	* ful anyway.
+	*/
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
+				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
+				    PCMCIA_MEM_PSEUDO_PHYS,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
+				    PCMCIA_IO_PSEUDO_PHYS,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
+				    AU1500_GPIO_201_205,
+				    AU1000_GPIO_0,
+				    0,
+				    0,
+				    0);
+
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS + 0x00800000,
+				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00840000 - 1,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00800000,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00840000 - 1,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00800000,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00801000 - 1,
+				    AU1500_GPIO_201_205,
+				    AU1000_GPIO_1,
+				    0,
+				    0,
+				    1);
+
+	return 0;
+}
+device_initcall(pb1550_dev_init);
diff --git a/arch/mips/alchemy/devboards/platform.c b/arch/mips/alchemy/devboards/platform.c
new file mode 100644
index 0000000..48c537c
--- /dev/null
+++ b/arch/mips/alchemy/devboards/platform.c
@@ -0,0 +1,89 @@
+/*
+ * devoard misc stuff.
+ */
+
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+
+/* register a pcmcia socket */
+int __init db1x_register_pcmcia_socket(unsigned long pseudo_attr_start,
+				       unsigned long pseudo_attr_end,
+				       unsigned long pseudo_mem_start,
+				       unsigned long pseudo_mem_end,
+				       unsigned long pseudo_io_start,
+				       unsigned long pseudo_io_end,
+				       int card_irq,
+				       int cd_irq,
+				       int stschg_irq,
+				       int eject_irq,
+				       int id)
+{
+	int cnt, i, ret;
+	struct resource *sr;
+	struct platform_device *pd;
+
+	cnt = 5;
+	if (eject_irq)
+		cnt++;
+	if (stschg_irq)
+		cnt++;
+
+	sr = kzalloc(sizeof(struct resource) * cnt, GFP_KERNEL);
+	if (!sr)
+		return -ENOMEM;
+
+	pd = platform_device_alloc("db1xxx_pcmcia", id);
+	if (!pd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	sr[0].name	= "pseudo-attr";
+	sr[0].flags	= IORESOURCE_MEM;
+	sr[0].start	= pseudo_attr_start;
+	sr[0].end	= pseudo_attr_end;
+
+	sr[1].name	= "pseudo-mem";
+	sr[1].flags	= IORESOURCE_MEM;
+	sr[1].start	= pseudo_mem_start;
+	sr[1].end	= pseudo_mem_end;
+
+	sr[2].name	= "pseudo-io";
+	sr[2].flags	= IORESOURCE_MEM;
+	sr[2].start	= pseudo_io_start;
+	sr[2].end	= pseudo_io_end;
+
+	sr[3].name	= "insert";
+	sr[3].flags	= IORESOURCE_IRQ;
+	sr[3].start = sr[3].end = cd_irq;
+
+	sr[4].name	= "card";
+	sr[4].flags	= IORESOURCE_IRQ;
+	sr[4].start = sr[4].end = card_irq;
+
+	i = 5;
+	if (stschg_irq) {
+		sr[i].name	= "insert";
+		sr[i].flags	= IORESOURCE_IRQ;
+		sr[i].start = sr[i].end = cd_irq;
+		i++;
+	}
+	if (eject_irq) {
+		sr[i].name	= "eject";
+		sr[i].flags	= IORESOURCE_IRQ;
+		sr[i].start = sr[i].end = eject_irq;
+	}
+
+	pd->resource = sr;
+	pd->num_resources = cnt;
+
+	ret = platform_device_add(pd);
+	if (!ret)
+		return 0;
+
+	platform_device_put(pd);
+out:
+	kfree(sr);
+	return ret;
+}
diff --git a/arch/mips/alchemy/devboards/platform.h b/arch/mips/alchemy/devboards/platform.h
new file mode 100644
index 0000000..55ecf7e
--- /dev/null
+++ b/arch/mips/alchemy/devboards/platform.h
@@ -0,0 +1,18 @@
+#ifndef _DEVBOARD_PLATFORM_H_
+#define _DEVBOARD_PLATFORM_H_
+
+#include <linux/init.h>
+
+int __init db1x_register_pcmcia_socket(unsigned long pseudo_attr_start,
+				       unsigned long pseudo_attr_len,
+				       unsigned long pseudo_mem_start,
+				       unsigned long pseudo_mem_end,
+				       unsigned long pseudo_io_start,
+				       unsigned long pseudo_io_end,
+				       int card_irq,
+				       int cd_irq,
+				       int stschg_irq,
+				       int eject_irq,
+				       int id);
+
+#endif
diff --git a/arch/mips/include/asm/mach-db1x00/db1200.h b/arch/mips/include/asm/mach-db1x00/db1200.h
index b7f18e1..52b1d84 100644
--- a/arch/mips/include/asm/mach-db1x00/db1200.h
+++ b/arch/mips/include/asm/mach-db1x00/db1200.h
@@ -103,21 +103,6 @@ enum external_pb1200_ints {
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
deleted file mode 100644
index f2bf73a..0000000
--- a/arch/mips/include/asm/mach-pb1x00/pb1100.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * Alchemy Semi Pb1100 Referrence Board
- *
- * Copyright 2001, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
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
-#ifndef __ASM_PB1100_H
-#define __ASM_PB1100_H
-
-/* PCMCIA Pb1100 specific defines */
-#define PCMCIA_MAX_SOCK  0
-#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
-
-/* VPP/VCC */
-#define SET_VCC_VPP(VCC, VPP) (((VCC) << 2) | ((VPP) << 0))
-
-#endif /* __ASM_PB1100_H */
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1200.h b/arch/mips/include/asm/mach-pb1x00/pb1200.h
index 2458eb4..962eb55 100644
--- a/arch/mips/include/asm/mach-pb1x00/pb1200.h
+++ b/arch/mips/include/asm/mach-pb1x00/pb1200.h
@@ -135,20 +135,6 @@ enum external_pb1200_ints {
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
deleted file mode 100644
index 82431a7..0000000
--- a/arch/mips/include/asm/mach-pb1x00/pb1500.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * Alchemy Semi Pb1500 Referrence Board
- *
- * Copyright 2001, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
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
-#ifndef __ASM_PB1500_H
-#define __ASM_PB1500_H
-
-/* PCMCIA Pb1500 specific defines */
-#define PCMCIA_MAX_SOCK  0
-#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK + 1)
-
-/* VPP/VCC */
-#define SET_VCC_VPP(VCC, VPP) (((VCC) << 2) | ((VPP) << 0))
-
-#endif /* __ASM_PB1500_H */
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
-- 
1.6.5.rc2
