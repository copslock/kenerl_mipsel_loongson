Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Nov 2008 12:09:43 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:62427 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S23391431AbYKHMIw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Nov 2008 12:08:52 +0000
Received: (qmail 14689 invoked from network); 8 Nov 2008 13:06:29 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 8 Nov 2008 13:06:29 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Florian Fainelli <florian@openwrt.org>,
	Bruno Randolf <bruno.randolf@4g-systems.biz>,
	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 1/3] Alchemy: merge small board files into single files
Date:	Sat,  8 Nov 2008 13:08:48 +0100
Message-Id: <0b1dcd4090411d59e2272ca94da0fb4f5a4bbceb.1226143942.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.3
In-Reply-To: <cover.1226143942.git.mano@roarinelk.homelinux.net>
References: <cover.1226143942.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1226143942.git.mano@roarinelk.homelinux.net>
References: <cover.1226143942.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Most files of the Alchemy boards are very small.  Merge them.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/db1x00/Makefile       |    2 +-
 arch/mips/alchemy/db1x00/board_setup.c  |   92 +++++++++++++++++-
 arch/mips/alchemy/db1x00/init.c         |   62 ------------
 arch/mips/alchemy/db1x00/irqmap.c       |   86 ----------------
 arch/mips/alchemy/mtx-1/Makefile        |    2 +-
 arch/mips/alchemy/mtx-1/board_setup.c   |   52 ++++++++++-
 arch/mips/alchemy/mtx-1/init.c          |   60 -----------
 arch/mips/alchemy/mtx-1/irqmap.c        |   52 ----------
 arch/mips/alchemy/pb1000/Makefile       |    2 +-
 arch/mips/alchemy/pb1000/board_setup.c  |   36 +++++++-
 arch/mips/alchemy/pb1000/init.c         |   57 -----------
 arch/mips/alchemy/pb1000/irqmap.c       |   38 -------
 arch/mips/alchemy/pb1100/Makefile       |    2 +-
 arch/mips/alchemy/pb1100/board_setup.c  |   42 ++++++++-
 arch/mips/alchemy/pb1100/init.c         |   60 -----------
 arch/mips/alchemy/pb1100/irqmap.c       |   40 --------
 arch/mips/alchemy/pb1200/Makefile       |    2 +-
 arch/mips/alchemy/pb1200/board_setup.c  |  162 ++++++++++++++++++++++++++++++-
 arch/mips/alchemy/pb1200/init.c         |   58 -----------
 arch/mips/alchemy/pb1200/irqmap.c       |  160 ------------------------------
 arch/mips/alchemy/pb1500/Makefile       |    2 +-
 arch/mips/alchemy/pb1500/board_setup.c  |   46 +++++++++-
 arch/mips/alchemy/pb1500/init.c         |   58 -----------
 arch/mips/alchemy/pb1500/irqmap.c       |   46 ---------
 arch/mips/alchemy/pb1550/Makefile       |    2 +-
 arch/mips/alchemy/pb1550/board_setup.c  |   41 ++++++++-
 arch/mips/alchemy/pb1550/init.c         |   58 -----------
 arch/mips/alchemy/pb1550/irqmap.c       |   43 --------
 arch/mips/alchemy/xxs1500/Makefile      |    2 +-
 arch/mips/alchemy/xxs1500/board_setup.c |   50 +++++++++-
 arch/mips/alchemy/xxs1500/init.c        |   58 -----------
 arch/mips/alchemy/xxs1500/irqmap.c      |   49 ---------
 32 files changed, 513 insertions(+), 1009 deletions(-)
 delete mode 100644 arch/mips/alchemy/db1x00/init.c
 delete mode 100644 arch/mips/alchemy/db1x00/irqmap.c
 delete mode 100644 arch/mips/alchemy/mtx-1/init.c
 delete mode 100644 arch/mips/alchemy/mtx-1/irqmap.c
 delete mode 100644 arch/mips/alchemy/pb1000/init.c
 delete mode 100644 arch/mips/alchemy/pb1000/irqmap.c
 delete mode 100644 arch/mips/alchemy/pb1100/init.c
 delete mode 100644 arch/mips/alchemy/pb1100/irqmap.c
 delete mode 100644 arch/mips/alchemy/pb1200/init.c
 delete mode 100644 arch/mips/alchemy/pb1200/irqmap.c
 delete mode 100644 arch/mips/alchemy/pb1500/init.c
 delete mode 100644 arch/mips/alchemy/pb1500/irqmap.c
 delete mode 100644 arch/mips/alchemy/pb1550/init.c
 delete mode 100644 arch/mips/alchemy/pb1550/irqmap.c
 delete mode 100644 arch/mips/alchemy/xxs1500/init.c
 delete mode 100644 arch/mips/alchemy/xxs1500/irqmap.c

diff --git a/arch/mips/alchemy/db1x00/Makefile b/arch/mips/alchemy/db1x00/Makefile
index 274db3b..9924aa0 100644
--- a/arch/mips/alchemy/db1x00/Makefile
+++ b/arch/mips/alchemy/db1x00/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor DBAu1xx0 boards.
 #
 
-lib-y := init.o board_setup.o irqmap.o
+lib-y := board_setup.o
diff --git a/arch/mips/alchemy/db1x00/board_setup.c b/arch/mips/alchemy/db1x00/board_setup.c
index 9e5ccbb..507ded2 100644
--- a/arch/mips/alchemy/db1x00/board_setup.c
+++ b/arch/mips/alchemy/db1x00/board_setup.c
@@ -1,7 +1,10 @@
 /*
  *
  * BRIEF MODULE DESCRIPTION
- *	Alchemy Db1x00 board setup.
+ *	Alchemy Db1x00 board support.
+ *
+ * Copyright 2003 Embedded Edge, LLC
+ *		dan@embeddededge.com
  *
  * Copyright 2000, 2008 MontaVista Software Inc.
  * Author: MontaVista Software, Inc. <source@mvista.com>
@@ -28,12 +31,99 @@
  */
 
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <asm/bootinfo.h>
+#include <prom.h>
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/db1x00.h>
 
+#ifdef CONFIG_MIPS_DB1500
+char irq_tab_alchemy[][5] __initdata = {
+	[12] = { -1, INTA, INTX, INTX, INTX }, /* IDSEL 12 - HPT371   */
+	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot */
+};
+#endif
+
+#ifdef CONFIG_MIPS_BOSPORUS
+char irq_tab_alchemy[][5] __initdata = {
+	[11] = { -1, INTA, INTB, INTX, INTX }, /* IDSEL 11 - miniPCI  */
+	[12] = { -1, INTA, INTX, INTX, INTX }, /* IDSEL 12 - SN1741   */
+	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot */
+};
+#endif
+
+#ifdef CONFIG_MIPS_MIRAGE
+char irq_tab_alchemy[][5] __initdata = {
+	[11] = { -1, INTD, INTX, INTX, INTX }, /* IDSEL 11 - SMI VGX */
+	[12] = { -1, INTX, INTX, INTC, INTX }, /* IDSEL 12 - PNX1300 */
+	[13] = { -1, INTA, INTB, INTX, INTX }, /* IDSEL 13 - miniPCI */
+};
+#endif
+
+#ifdef CONFIG_MIPS_DB1550
+char irq_tab_alchemy[][5] __initdata = {
+	[11] = { -1, INTC, INTX, INTX, INTX }, /* IDSEL 11 - on-board HPT371 */
+	[12] = { -1, INTB, INTC, INTD, INTA }, /* IDSEL 12 - PCI slot 2 (left) */
+	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot 1 (right) */
+};
+#endif
+
+
+struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
+
+#ifndef CONFIG_MIPS_MIRAGE
+#ifdef CONFIG_MIPS_DB1550
+	{ AU1000_GPIO_3, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 IRQ# */
+	{ AU1000_GPIO_5, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 IRQ# */
+#else
+	{ AU1000_GPIO_0, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 Fully_Interted# */
+	{ AU1000_GPIO_1, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 STSCHG# */
+	{ AU1000_GPIO_2, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 IRQ# */
+
+	{ AU1000_GPIO_3, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 Fully_Interted# */
+	{ AU1000_GPIO_4, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 STSCHG# */
+	{ AU1000_GPIO_5, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 IRQ# */
+#endif
+#else
+	{ AU1000_GPIO_7, INTC_INT_RISE_EDGE, 0 }, /* touchscreen pen down */
+#endif
+
+};
+
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
+
 static BCSR * const bcsr = (BCSR *)BCSR_KSEG1_ADDR;
 
+const char *get_system_type(void)
+{
+#ifdef CONFIG_MIPS_BOSPORUS
+	return "Alchemy Bosporus Gateway Reference";
+#else
+	return "Alchemy Db1x00";
+#endif
+}
+
+void __init prom_init(void)
+{
+	unsigned char *memsize_str;
+	unsigned long memsize;
+
+	prom_argc = fw_arg0;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
+
+	prom_init_cmdline();
+
+	memsize_str = prom_getenv("memsize");
+	if (!memsize_str)
+		memsize = 0x04000000;
+	else
+		strict_strtol(memsize_str, 0, &memsize);
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
+
 void board_reset(void)
 {
 	/* Hit BCSR.SW_RESET[RESET] */
diff --git a/arch/mips/alchemy/db1x00/init.c b/arch/mips/alchemy/db1x00/init.c
deleted file mode 100644
index 8474135..0000000
--- a/arch/mips/alchemy/db1x00/init.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	PB1000 board setup
- *
- * Copyright 2001, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-
-#include <asm/bootinfo.h>
-
-#include <prom.h>
-
-const char *get_system_type(void)
-{
-#ifdef CONFIG_MIPS_BOSPORUS
-	return "Alchemy Bosporus Gateway Reference";
-#else
-	return "Alchemy Db1x00";
-#endif
-}
-
-void __init prom_init(void)
-{
-	unsigned char *memsize_str;
-	unsigned long memsize;
-
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
-
-	prom_init_cmdline();
-
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str)
-		memsize = 0x04000000;
-	else
-		strict_strtol(memsize_str, 0, &memsize);
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
-}
diff --git a/arch/mips/alchemy/db1x00/irqmap.c b/arch/mips/alchemy/db1x00/irqmap.c
deleted file mode 100644
index 94c090e..0000000
--- a/arch/mips/alchemy/db1x00/irqmap.c
+++ /dev/null
@@ -1,86 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	Au1xxx irq map table
- *
- * Copyright 2003 Embedded Edge, LLC
- *		dan@embeddededge.com
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
- *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
- *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-
-#include <asm/mach-au1x00/au1000.h>
-
-#ifdef CONFIG_MIPS_DB1500
-char irq_tab_alchemy[][5] __initdata = {
-	[12] = { -1, INTA, INTX, INTX, INTX }, /* IDSEL 12 - HPT371   */
-	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot */
-};
-#endif
-
-#ifdef CONFIG_MIPS_BOSPORUS
-char irq_tab_alchemy[][5] __initdata = {
-	[11] = { -1, INTA, INTB, INTX, INTX }, /* IDSEL 11 - miniPCI  */
-	[12] = { -1, INTA, INTX, INTX, INTX }, /* IDSEL 12 - SN1741   */
-	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot */
-};
-#endif
-
-#ifdef CONFIG_MIPS_MIRAGE
-char irq_tab_alchemy[][5] __initdata = {
-	[11] = { -1, INTD, INTX, INTX, INTX }, /* IDSEL 11 - SMI VGX */
-	[12] = { -1, INTX, INTX, INTC, INTX }, /* IDSEL 12 - PNX1300 */
-	[13] = { -1, INTA, INTB, INTX, INTX }, /* IDSEL 13 - miniPCI */
-};
-#endif
-
-#ifdef CONFIG_MIPS_DB1550
-char irq_tab_alchemy[][5] __initdata = {
-	[11] = { -1, INTC, INTX, INTX, INTX }, /* IDSEL 11 - on-board HPT371 */
-	[12] = { -1, INTB, INTC, INTD, INTA }, /* IDSEL 12 - PCI slot 2 (left) */
-	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot 1 (right) */
-};
-#endif
-
-
-struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-
-#ifndef CONFIG_MIPS_MIRAGE
-#ifdef CONFIG_MIPS_DB1550
-	{ AU1000_GPIO_3, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 IRQ# */
-	{ AU1000_GPIO_5, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 IRQ# */
-#else
-	{ AU1000_GPIO_0, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 Fully_Interted# */
-	{ AU1000_GPIO_1, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 STSCHG# */
-	{ AU1000_GPIO_2, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 0 IRQ# */
-
-	{ AU1000_GPIO_3, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 Fully_Interted# */
-	{ AU1000_GPIO_4, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 STSCHG# */
-	{ AU1000_GPIO_5, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card 1 IRQ# */
-#endif
-#else
-	{ AU1000_GPIO_7, INTC_INT_RISE_EDGE, 0 }, /* touchscreen pen down */
-#endif
-
-};
-
-int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
diff --git a/arch/mips/alchemy/mtx-1/Makefile b/arch/mips/alchemy/mtx-1/Makefile
index 7c67b3d..f011b2d 100644
--- a/arch/mips/alchemy/mtx-1/Makefile
+++ b/arch/mips/alchemy/mtx-1/Makefile
@@ -6,7 +6,7 @@
 # Makefile for 4G Systems MTX-1 board.
 #
 
-lib-y := init.o board_setup.o irqmap.o
+lib-y := board_setup.o
 obj-y := platform.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
index 3f80791..2e26465 100644
--- a/arch/mips/alchemy/mtx-1/board_setup.c
+++ b/arch/mips/alchemy/mtx-1/board_setup.c
@@ -29,12 +29,61 @@
  */
 
 #include <linux/init.h>
-
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <asm/bootinfo.h>
 #include <asm/mach-au1x00/au1000.h>
+#include <prom.h>
 
 extern int (*board_pci_idsel)(unsigned int devsel, int assert);
 int mtx1_pci_idsel(unsigned int devsel, int assert);
 
+char irq_tab_alchemy[][5] __initdata = {
+	[0] = { -1, INTA, INTA, INTX, INTX }, /* IDSEL 00 - AdapterA-Slot0 (top) */
+	[1] = { -1, INTB, INTA, INTX, INTX }, /* IDSEL 01 - AdapterA-Slot1 (bottom) */
+	[2] = { -1, INTC, INTD, INTX, INTX }, /* IDSEL 02 - AdapterB-Slot0 (top) */
+	[3] = { -1, INTD, INTC, INTX, INTX }, /* IDSEL 03 - AdapterB-Slot1 (bottom) */
+	[4] = { -1, INTA, INTB, INTX, INTX }, /* IDSEL 04 - AdapterC-Slot0 (top) */
+	[5] = { -1, INTB, INTA, INTX, INTX }, /* IDSEL 05 - AdapterC-Slot1 (bottom) */
+	[6] = { -1, INTC, INTD, INTX, INTX }, /* IDSEL 06 - AdapterD-Slot0 (top) */
+	[7] = { -1, INTD, INTC, INTX, INTX }, /* IDSEL 07 - AdapterD-Slot1 (bottom) */
+};
+
+struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
+	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1500_GPIO_203, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1500_GPIO_205, INTC_INT_LOW_LEVEL, 0 },
+};
+
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
+
+
+const char *get_system_type(void)
+{
+	return "MTX-1";
+}
+
+void __init prom_init(void)
+{
+	unsigned char *memsize_str;
+	unsigned long memsize;
+
+	prom_argc = fw_arg0;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
+
+	prom_init_cmdline();
+
+	memsize_str = prom_getenv("memsize");
+	if (!memsize_str)
+		memsize = 0x04000000;
+	else
+		strict_strtol(memsize_str, 0, &memsize);
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
+
 void board_reset(void)
 {
 	/* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
@@ -95,4 +144,3 @@ mtx1_pci_idsel(unsigned int devsel, int assert)
 	au_sync_udelay(1);
 	return 1;
 }
-
diff --git a/arch/mips/alchemy/mtx-1/init.c b/arch/mips/alchemy/mtx-1/init.c
deleted file mode 100644
index 3bae13c..0000000
--- a/arch/mips/alchemy/mtx-1/init.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- *
- * BRIEF MODULE DESCRIPTION
- *	4G Systems MTX-1 board setup
- *
- * Copyright 2003, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *         Bruno Randolf <bruno.randolf@4g-systems.biz>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-
-#include <asm/bootinfo.h>
-
-#include <prom.h>
-
-const char *get_system_type(void)
-{
-	return "MTX-1";
-}
-
-void __init prom_init(void)
-{
-	unsigned char *memsize_str;
-	unsigned long memsize;
-
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
-
-	prom_init_cmdline();
-
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str)
-		memsize = 0x04000000;
-	else
-		strict_strtol(memsize_str, 0, &memsize);
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
-}
diff --git a/arch/mips/alchemy/mtx-1/irqmap.c b/arch/mips/alchemy/mtx-1/irqmap.c
deleted file mode 100644
index f2bf029..0000000
--- a/arch/mips/alchemy/mtx-1/irqmap.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	Au1xxx irq map table
- *
- * Copyright 2003 Embedded Edge, LLC
- *		dan@embeddededge.com
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
- *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
- *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-
-#include <asm/mach-au1x00/au1000.h>
-
-char irq_tab_alchemy[][5] __initdata = {
-	[0] = { -1, INTA, INTA, INTX, INTX }, /* IDSEL 00 - AdapterA-Slot0 (top) */
-	[1] = { -1, INTB, INTA, INTX, INTX }, /* IDSEL 01 - AdapterA-Slot1 (bottom) */
-	[2] = { -1, INTC, INTD, INTX, INTX }, /* IDSEL 02 - AdapterB-Slot0 (top) */
-	[3] = { -1, INTD, INTC, INTX, INTX }, /* IDSEL 03 - AdapterB-Slot1 (bottom) */
-	[4] = { -1, INTA, INTB, INTX, INTX }, /* IDSEL 04 - AdapterC-Slot0 (top) */
-	[5] = { -1, INTB, INTA, INTX, INTX }, /* IDSEL 05 - AdapterC-Slot1 (bottom) */
-	[6] = { -1, INTC, INTD, INTX, INTX }, /* IDSEL 06 - AdapterD-Slot0 (top) */
-	[7] = { -1, INTD, INTC, INTX, INTX }, /* IDSEL 07 - AdapterD-Slot1 (bottom) */
-};
-
-struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-       { AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0 },
-       { AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
-       { AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
-       { AU1500_GPIO_203, INTC_INT_LOW_LEVEL, 0 },
-       { AU1500_GPIO_205, INTC_INT_LOW_LEVEL, 0 },
-};
-
-int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
diff --git a/arch/mips/alchemy/pb1000/Makefile b/arch/mips/alchemy/pb1000/Makefile
index 99bbec0..4377ab3 100644
--- a/arch/mips/alchemy/pb1000/Makefile
+++ b/arch/mips/alchemy/pb1000/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor Pb1000 board.
 #
 
-lib-y := init.o board_setup.o irqmap.o
+lib-y := board_setup.o
diff --git a/arch/mips/alchemy/pb1000/board_setup.c b/arch/mips/alchemy/pb1000/board_setup.c
index 25df167..bd0b6f4 100644
--- a/arch/mips/alchemy/pb1000/board_setup.c
+++ b/arch/mips/alchemy/pb1000/board_setup.c
@@ -23,11 +23,43 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/init.h>
 #include <linux/delay.h>
-
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <asm/bootinfo.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1000.h>
+#include <prom.h>
+
+struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
+	{ AU1000_GPIO_15, INTC_INT_LOW_LEVEL, 0 },
+};
+
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
+
+const char *get_system_type(void)
+{
+	return "Alchemy Pb1000";
+}
+
+void __init prom_init(void)
+{
+	unsigned char *memsize_str;
+	unsigned long memsize;
+
+	prom_argc = (int)fw_arg0;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
+
+	prom_init_cmdline();
+	memsize_str = prom_getenv("memsize");
+	if (!memsize_str)
+		memsize = 0x04000000;
+	else
+		strict_strtol(memsize_str, 0, &memsize);
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
 
 void board_reset(void)
 {
diff --git a/arch/mips/alchemy/pb1000/init.c b/arch/mips/alchemy/pb1000/init.c
deleted file mode 100644
index 8a9c7d5..0000000
--- a/arch/mips/alchemy/pb1000/init.c
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	Pb1000 board setup
- *
- * Copyright 2001, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-
-#include <asm/bootinfo.h>
-
-#include <prom.h>
-
-const char *get_system_type(void)
-{
-	return "Alchemy Pb1000";
-}
-
-void __init prom_init(void)
-{
-	unsigned char *memsize_str;
-	unsigned long memsize;
-
-	prom_argc = (int)fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
-
-	prom_init_cmdline();
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str)
-		memsize = 0x04000000;
-	else
-		strict_strtol(memsize_str, 0, &memsize);
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
-}
diff --git a/arch/mips/alchemy/pb1000/irqmap.c b/arch/mips/alchemy/pb1000/irqmap.c
deleted file mode 100644
index b3d56b0..0000000
--- a/arch/mips/alchemy/pb1000/irqmap.c
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	Au1xxx irq map table
- *
- * Copyright 2003 Embedded Edge, LLC
- *		dan@embeddededge.com
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
- *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
- *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/interrupt.h>
-
-#include <asm/mach-au1x00/au1000.h>
-
-struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1000_GPIO_15, INTC_INT_LOW_LEVEL, 0 },
-};
-
-int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
diff --git a/arch/mips/alchemy/pb1100/Makefile b/arch/mips/alchemy/pb1100/Makefile
index 793e97c..627a75c 100644
--- a/arch/mips/alchemy/pb1100/Makefile
+++ b/arch/mips/alchemy/pb1100/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor Pb1100 board.
 #
 
-lib-y := init.o board_setup.o irqmap.o
+lib-y := board_setup.o
diff --git a/arch/mips/alchemy/pb1100/board_setup.c b/arch/mips/alchemy/pb1100/board_setup.c
index c0bfd59..87da4a5 100644
--- a/arch/mips/alchemy/pb1100/board_setup.c
+++ b/arch/mips/alchemy/pb1100/board_setup.c
@@ -23,11 +23,49 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/init.h>
 #include <linux/delay.h>
-
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <asm/bootinfo.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1100.h>
+#include <prom.h>
+
+struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
+	{ AU1000_GPIO_9,  INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card Fully_Inserted# */
+	{ AU1000_GPIO_10, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card STSCHG# */
+	{ AU1000_GPIO_11, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card IRQ# */
+	{ AU1000_GPIO_13, INTC_INT_LOW_LEVEL, 0 }, /* DC_IRQ# */
+};
+
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
+
+
+const char *get_system_type(void)
+{
+	return "Alchemy Pb1100";
+}
+
+void __init prom_init(void)
+{
+	unsigned char *memsize_str;
+	unsigned long memsize;
+
+	prom_argc = fw_arg0;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg3;
+
+	prom_init_cmdline();
+
+	memsize_str = prom_getenv("memsize");
+	if (!memsize_str)
+		memsize = 0x04000000;
+	else
+		strict_strtol(memsize_str, 0, &memsize);
+
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
 
 void board_reset(void)
 {
diff --git a/arch/mips/alchemy/pb1100/init.c b/arch/mips/alchemy/pb1100/init.c
deleted file mode 100644
index 7c67923..0000000
--- a/arch/mips/alchemy/pb1100/init.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- *
- * BRIEF MODULE DESCRIPTION
- *	Pb1100 board setup
- *
- * Copyright 2002, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-
-#include <asm/bootinfo.h>
-
-#include <prom.h>
-
-const char *get_system_type(void)
-{
-	return "Alchemy Pb1100";
-}
-
-void __init prom_init(void)
-{
-	unsigned char *memsize_str;
-	unsigned long memsize;
-
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg3;
-
-	prom_init_cmdline();
-
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str)
-		memsize = 0x04000000;
-	else
-		strict_strtol(memsize_str, 0, &memsize);
-
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
-}
diff --git a/arch/mips/alchemy/pb1100/irqmap.c b/arch/mips/alchemy/pb1100/irqmap.c
deleted file mode 100644
index 9b7dd8b..0000000
--- a/arch/mips/alchemy/pb1100/irqmap.c
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	Au1xx0 IRQ map table
- *
- * Copyright 2003 Embedded Edge, LLC
- *		dan@embeddededge.com
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
- *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
- *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-
-#include <asm/mach-au1x00/au1000.h>
-
-struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1000_GPIO_9,  INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card Fully_Inserted# */
-	{ AU1000_GPIO_10, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card STSCHG# */
-	{ AU1000_GPIO_11, INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card IRQ# */
-	{ AU1000_GPIO_13, INTC_INT_LOW_LEVEL, 0 }, /* DC_IRQ# */
-};
-
-int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
diff --git a/arch/mips/alchemy/pb1200/Makefile b/arch/mips/alchemy/pb1200/Makefile
index d678adf..e9b9d27 100644
--- a/arch/mips/alchemy/pb1200/Makefile
+++ b/arch/mips/alchemy/pb1200/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the Alchemy Semiconductor Pb1200/DBAu1200 boards.
 #
 
-lib-y := init.o board_setup.o irqmap.o
+lib-y := board_setup.o
 obj-y += platform.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/alchemy/pb1200/board_setup.c b/arch/mips/alchemy/pb1200/board_setup.c
index 6cb2115..a336a7a 100644
--- a/arch/mips/alchemy/pb1200/board_setup.c
+++ b/arch/mips/alchemy/pb1200/board_setup.c
@@ -25,14 +25,168 @@
  */
 
 #include <linux/init.h>
-#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <asm/bootinfo.h>
+#include <asm/mach-au1x00/au1000.h>
+
+#ifdef CONFIG_MIPS_PB1200
+#include <asm/mach-pb1x00/pb1200.h>
+#endif
+
+#ifdef CONFIG_MIPS_DB1200
+#include <asm/mach-db1x00/db1200.h>
+#define PB1200_INT_BEGIN DB1200_INT_BEGIN
+#define PB1200_INT_END DB1200_INT_END
+#endif
 
 #include <prom.h>
-#include <au1xxx.h>
 
-extern void _board_init_irq(void);
 extern void (*board_init_irq)(void);
 
+struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
+	/* This is external interrupt cascade */
+	{ AU1000_GPIO_7, INTC_INT_LOW_LEVEL, 0 },
+};
+
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
+
+/*
+ * Support for External interrupts on the Pb1200 Development platform.
+ */
+static volatile int pb1200_cascade_en;
+
+irqreturn_t pb1200_cascade_handler(int irq, void *dev_id)
+{
+	unsigned short bisr = bcsr->int_status;
+	int extirq_nr = 0;
+
+	/* Clear all the edge interrupts. This has no effect on level. */
+	bcsr->int_status = bisr;
+	for ( ; bisr; bisr &= bisr - 1) {
+		extirq_nr = PB1200_INT_BEGIN + __ffs(bisr);
+		/* Ack and dispatch IRQ */
+		do_IRQ(extirq_nr);
+	}
+
+	return IRQ_RETVAL(1);
+}
+
+inline void pb1200_enable_irq(unsigned int irq_nr)
+{
+	bcsr->intset_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
+	bcsr->intset = 1 << (irq_nr - PB1200_INT_BEGIN);
+}
+
+inline void pb1200_disable_irq(unsigned int irq_nr)
+{
+	bcsr->intclr_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
+	bcsr->intclr = 1 << (irq_nr - PB1200_INT_BEGIN);
+}
+
+static unsigned int pb1200_setup_cascade(void)
+{
+	return request_irq(AU1000_GPIO_7, &pb1200_cascade_handler,
+			   0, "Pb1200 Cascade", &pb1200_cascade_handler);
+}
+
+static unsigned int pb1200_startup_irq(unsigned int irq)
+{
+	if (++pb1200_cascade_en == 1) {
+		int res;
+
+		res = pb1200_setup_cascade();
+		if (res)
+			return res;
+	}
+
+	pb1200_enable_irq(irq);
+
+	return 0;
+}
+
+static void pb1200_shutdown_irq(unsigned int irq)
+{
+	pb1200_disable_irq(irq);
+	if (--pb1200_cascade_en == 0)
+		free_irq(AU1000_GPIO_7, &pb1200_cascade_handler);
+}
+
+static struct irq_chip external_irq_type = {
+#ifdef CONFIG_MIPS_PB1200
+	.name = "Pb1200 Ext",
+#endif
+#ifdef CONFIG_MIPS_DB1200
+	.name = "Db1200 Ext",
+#endif
+	.startup  = pb1200_startup_irq,
+	.shutdown = pb1200_shutdown_irq,
+	.ack      = pb1200_disable_irq,
+	.mask     = pb1200_disable_irq,
+	.mask_ack = pb1200_disable_irq,
+	.unmask   = pb1200_enable_irq,
+};
+
+static void pb1200_init_irq(void)
+{
+	unsigned int irq;
+
+#ifdef CONFIG_MIPS_PB1200
+	/* We have a problem with CPLD rev 3. */
+	if (((bcsr->whoami & BCSR_WHOAMI_CPLD) >> 4) <= 3) {
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "Pb1200 must be at CPLD rev 4. Please have Pb1200\n");
+		printk(KERN_ERR "updated to latest revision. This software will\n");
+		printk(KERN_ERR "not work on anything less than CPLD rev 4.\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		panic("Game over.  Your score is 0.");
+	}
+#endif
+
+	for (irq = PB1200_INT_BEGIN; irq <= PB1200_INT_END; irq++) {
+		set_irq_chip_and_handler(irq, &external_irq_type,
+					 handle_level_irq);
+		pb1200_disable_irq(irq);
+	}
+
+	/*
+	 * GPIO_7 can not be hooked here, so it is hooked upon first
+	 * request of any source attached to the cascade.
+	 */
+}
+
+const char *get_system_type(void)
+{
+	return "Alchemy Pb1200";
+}
+
+void __init prom_init(void)
+{
+	unsigned char *memsize_str;
+	unsigned long memsize;
+
+	prom_argc = (int)fw_arg0;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
+
+	prom_init_cmdline();
+	memsize_str = prom_getenv("memsize");
+	if (!memsize_str)
+		memsize = 0x08000000;
+	else
+		strict_strtol(memsize_str, 0, &memsize);
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
+
 void board_reset(void)
 {
 	bcsr->resets = 0;
@@ -126,7 +280,7 @@ void __init board_setup(void)
 #endif
 
 	/* Setup Pb1200 External Interrupt Controller */
-	board_init_irq = _board_init_irq;
+	board_init_irq = pb1200_init_irq;
 }
 
 int board_au1200fb_panel(void)
diff --git a/arch/mips/alchemy/pb1200/init.c b/arch/mips/alchemy/pb1200/init.c
deleted file mode 100644
index e9b2a0f..0000000
--- a/arch/mips/alchemy/pb1200/init.c
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- *
- * BRIEF MODULE DESCRIPTION
- *	PB1200 board setup
- *
- * Copyright 2001, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-
-#include <asm/bootinfo.h>
-
-#include <prom.h>
-
-const char *get_system_type(void)
-{
-	return "Alchemy Pb1200";
-}
-
-void __init prom_init(void)
-{
-	unsigned char *memsize_str;
-	unsigned long memsize;
-
-	prom_argc = (int)fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
-
-	prom_init_cmdline();
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str)
-		memsize = 0x08000000;
-	else
-		strict_strtol(memsize_str, 0, &memsize);
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
-}
diff --git a/arch/mips/alchemy/pb1200/irqmap.c b/arch/mips/alchemy/pb1200/irqmap.c
deleted file mode 100644
index 2a505ad..0000000
--- a/arch/mips/alchemy/pb1200/irqmap.c
+++ /dev/null
@@ -1,160 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	Au1xxx irq map table
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
- *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
- *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/interrupt.h>
-
-#include <asm/mach-au1x00/au1000.h>
-
-#ifdef CONFIG_MIPS_PB1200
-#include <asm/mach-pb1x00/pb1200.h>
-#endif
-
-#ifdef CONFIG_MIPS_DB1200
-#include <asm/mach-db1x00/db1200.h>
-#define PB1200_INT_BEGIN DB1200_INT_BEGIN
-#define PB1200_INT_END DB1200_INT_END
-#endif
-
-struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	/* This is external interrupt cascade */
-	{ AU1000_GPIO_7, INTC_INT_LOW_LEVEL, 0 },
-};
-
-int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
-
-/*
- * Support for External interrupts on the Pb1200 Development platform.
- */
-static volatile int pb1200_cascade_en;
-
-irqreturn_t pb1200_cascade_handler(int irq, void *dev_id)
-{
-	unsigned short bisr = bcsr->int_status;
-	int extirq_nr = 0;
-
-	/* Clear all the edge interrupts. This has no effect on level. */
-	bcsr->int_status = bisr;
-	for ( ; bisr; bisr &= bisr - 1) {
-		extirq_nr = PB1200_INT_BEGIN + __ffs(bisr);
-		/* Ack and dispatch IRQ */
-		do_IRQ(extirq_nr);
-	}
-
-	return IRQ_RETVAL(1);
-}
-
-inline void pb1200_enable_irq(unsigned int irq_nr)
-{
-	bcsr->intset_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
-	bcsr->intset = 1 << (irq_nr - PB1200_INT_BEGIN);
-}
-
-inline void pb1200_disable_irq(unsigned int irq_nr)
-{
-	bcsr->intclr_mask = 1 << (irq_nr - PB1200_INT_BEGIN);
-	bcsr->intclr = 1 << (irq_nr - PB1200_INT_BEGIN);
-}
-
-static unsigned int pb1200_setup_cascade(void)
-{
-	return request_irq(AU1000_GPIO_7, &pb1200_cascade_handler,
-			   0, "Pb1200 Cascade", &pb1200_cascade_handler);
-}
-
-static unsigned int pb1200_startup_irq(unsigned int irq)
-{
-	if (++pb1200_cascade_en == 1) {
-		int res;
-
-		res = pb1200_setup_cascade();
-		if (res)
-			return res;
-	}
-
-	pb1200_enable_irq(irq);
-
-	return 0;
-}
-
-static void pb1200_shutdown_irq(unsigned int irq)
-{
-	pb1200_disable_irq(irq);
-	if (--pb1200_cascade_en == 0)
-		free_irq(AU1000_GPIO_7, &pb1200_cascade_handler);
-}
-
-static struct irq_chip external_irq_type = {
-#ifdef CONFIG_MIPS_PB1200
-	.name = "Pb1200 Ext",
-#endif
-#ifdef CONFIG_MIPS_DB1200
-	.name = "Db1200 Ext",
-#endif
-	.startup  = pb1200_startup_irq,
-	.shutdown = pb1200_shutdown_irq,
-	.ack      = pb1200_disable_irq,
-	.mask     = pb1200_disable_irq,
-	.mask_ack = pb1200_disable_irq,
-	.unmask   = pb1200_enable_irq,
-};
-
-void _board_init_irq(void)
-{
-	unsigned int irq;
-
-#ifdef CONFIG_MIPS_PB1200
-	/* We have a problem with CPLD rev 3. */
-	if (((bcsr->whoami & BCSR_WHOAMI_CPLD) >> 4) <= 3) {
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "Pb1200 must be at CPLD rev 4. Please have Pb1200\n");
-		printk(KERN_ERR "updated to latest revision. This software will\n");
-		printk(KERN_ERR "not work on anything less than CPLD rev 4.\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		panic("Game over.  Your score is 0.");
-	}
-#endif
-
-	for (irq = PB1200_INT_BEGIN; irq <= PB1200_INT_END; irq++) {
-		set_irq_chip_and_handler(irq, &external_irq_type,
-					 handle_level_irq);
-		pb1200_disable_irq(irq);
-	}
-
-	/*
-	 * GPIO_7 can not be hooked here, so it is hooked upon first
-	 * request of any source attached to the cascade.
-	 */
-}
diff --git a/arch/mips/alchemy/pb1500/Makefile b/arch/mips/alchemy/pb1500/Makefile
index 602f38d..4664d61 100644
--- a/arch/mips/alchemy/pb1500/Makefile
+++ b/arch/mips/alchemy/pb1500/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor Pb1500 board.
 #
 
-lib-y := init.o board_setup.o irqmap.o
+lib-y := board_setup.o
diff --git a/arch/mips/alchemy/pb1500/board_setup.c b/arch/mips/alchemy/pb1500/board_setup.c
index 035771c..1be1afc 100644
--- a/arch/mips/alchemy/pb1500/board_setup.c
+++ b/arch/mips/alchemy/pb1500/board_setup.c
@@ -23,11 +23,53 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/init.h>
 #include <linux/delay.h>
-
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <asm/bootinfo.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1500.h>
+#include <prom.h>
+
+char irq_tab_alchemy[][5] __initdata = {
+	[12] = { -1, INTA, INTX, INTX, INTX },   /* IDSEL 12 - HPT370	*/
+	[13] = { -1, INTA, INTB, INTC, INTD },   /* IDSEL 13 - PCI slot */
+};
+
+struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
+	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1500_GPIO_203, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1500_GPIO_205, INTC_INT_LOW_LEVEL, 0 },
+};
+
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
+
+
+const char *get_system_type(void)
+{
+	return "Alchemy Pb1500";
+}
+
+void __init prom_init(void)
+{
+	unsigned char *memsize_str;
+	unsigned long memsize;
+
+	prom_argc = (int)fw_arg0;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
+
+	prom_init_cmdline();
+	memsize_str = prom_getenv("memsize");
+	if (!memsize_str)
+		memsize = 0x04000000;
+	else
+		strict_strtol(memsize_str, 0, &memsize);
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
 
 void board_reset(void)
 {
diff --git a/arch/mips/alchemy/pb1500/init.c b/arch/mips/alchemy/pb1500/init.c
deleted file mode 100644
index 3b6e395..0000000
--- a/arch/mips/alchemy/pb1500/init.c
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- *
- * BRIEF MODULE DESCRIPTION
- *	Pb1500 board setup
- *
- * Copyright 2001, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-
-#include <asm/bootinfo.h>
-
-#include <prom.h>
-
-const char *get_system_type(void)
-{
-	return "Alchemy Pb1500";
-}
-
-void __init prom_init(void)
-{
-	unsigned char *memsize_str;
-	unsigned long memsize;
-
-	prom_argc = (int)fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
-
-	prom_init_cmdline();
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str)
-		memsize = 0x04000000;
-	else
-		strict_strtol(memsize_str, 0, &memsize);
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
-}
diff --git a/arch/mips/alchemy/pb1500/irqmap.c b/arch/mips/alchemy/pb1500/irqmap.c
deleted file mode 100644
index 39c4682..0000000
--- a/arch/mips/alchemy/pb1500/irqmap.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	Au1xxx irq map table
- *
- * Copyright 2003 Embedded Edge, LLC
- *		dan@embeddededge.com
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
- *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
- *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-
-#include <asm/mach-au1x00/au1000.h>
-
-char irq_tab_alchemy[][5] __initdata = {
-	[12] = { -1, INTA, INTX, INTX, INTX },   /* IDSEL 12 - HPT370	*/
-	[13] = { -1, INTA, INTB, INTC, INTD },   /* IDSEL 13 - PCI slot */
-};
-
-struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1500_GPIO_203, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1500_GPIO_205, INTC_INT_LOW_LEVEL, 0 },
-};
-
-int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
diff --git a/arch/mips/alchemy/pb1550/Makefile b/arch/mips/alchemy/pb1550/Makefile
index 7d8beca..7e6453d 100644
--- a/arch/mips/alchemy/pb1550/Makefile
+++ b/arch/mips/alchemy/pb1550/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor Pb1550 board.
 #
 
-lib-y := init.o board_setup.o irqmap.o
+lib-y := board_setup.o
diff --git a/arch/mips/alchemy/pb1550/board_setup.c b/arch/mips/alchemy/pb1550/board_setup.c
index 0ed76b6..e844484 100644
--- a/arch/mips/alchemy/pb1550/board_setup.c
+++ b/arch/mips/alchemy/pb1550/board_setup.c
@@ -28,9 +28,48 @@
  */
 
 #include <linux/init.h>
-
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <asm/bootinfo.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1550.h>
+#include <prom.h>
+
+char irq_tab_alchemy[][5] __initdata = {
+	[12] = { -1, INTB, INTC, INTD, INTA }, /* IDSEL 12 - PCI slot 2 (left)  */
+	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot 1 (right) */
+};
+
+struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
+	{ AU1000_GPIO_0, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1000_GPIO_1, INTC_INT_LOW_LEVEL, 0 },
+};
+
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
+
+
+const char *get_system_type(void)
+{
+	return "Alchemy Pb1550";
+}
+
+void __init prom_init(void)
+{
+	unsigned char *memsize_str;
+	unsigned long memsize;
+
+	prom_argc = (int)fw_arg0;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
+
+	prom_init_cmdline();
+	memsize_str = prom_getenv("memsize");
+	if (!memsize_str)
+		memsize = 0x08000000;
+	else
+		strict_strtol(memsize_str, 0, &memsize);
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
 
 void board_reset(void)
 {
diff --git a/arch/mips/alchemy/pb1550/init.c b/arch/mips/alchemy/pb1550/init.c
deleted file mode 100644
index e1055a1..0000000
--- a/arch/mips/alchemy/pb1550/init.c
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- *
- * BRIEF MODULE DESCRIPTION
- *	Pb1550 board setup
- *
- * Copyright 2001, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-
-#include <asm/bootinfo.h>
-
-#include <prom.h>
-
-const char *get_system_type(void)
-{
-	return "Alchemy Pb1550";
-}
-
-void __init prom_init(void)
-{
-	unsigned char *memsize_str;
-	unsigned long memsize;
-
-	prom_argc = (int)fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
-
-	prom_init_cmdline();
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str)
-		memsize = 0x08000000;
-	else
-		strict_strtol(memsize_str, 0, &memsize);
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
-}
diff --git a/arch/mips/alchemy/pb1550/irqmap.c b/arch/mips/alchemy/pb1550/irqmap.c
deleted file mode 100644
index a02a4d1..0000000
--- a/arch/mips/alchemy/pb1550/irqmap.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	Au1xx0 IRQ map table
- *
- * Copyright 2003 Embedded Edge, LLC
- *		dan@embeddededge.com
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
- *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
- *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-
-#include <asm/mach-au1x00/au1000.h>
-
-char irq_tab_alchemy[][5] __initdata = {
-	[12] = { -1, INTB, INTC, INTD, INTA }, /* IDSEL 12 - PCI slot 2 (left)  */
-	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot 1 (right) */
-};
-
-struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1000_GPIO_0, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_GPIO_1, INTC_INT_LOW_LEVEL, 0 },
-};
-
-int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
diff --git a/arch/mips/alchemy/xxs1500/Makefile b/arch/mips/alchemy/xxs1500/Makefile
index db3c526..9ec3b54 100644
--- a/arch/mips/alchemy/xxs1500/Makefile
+++ b/arch/mips/alchemy/xxs1500/Makefile
@@ -5,4 +5,4 @@
 # Makefile for MyCable XXS1500 board.
 #
 
-lib-y := init.o board_setup.o irqmap.o
+lib-y := board_setup.o
diff --git a/arch/mips/alchemy/xxs1500/board_setup.c b/arch/mips/alchemy/xxs1500/board_setup.c
index 4c587ac..813668f 100644
--- a/arch/mips/alchemy/xxs1500/board_setup.c
+++ b/arch/mips/alchemy/xxs1500/board_setup.c
@@ -23,10 +23,56 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/init.h>
 #include <linux/delay.h>
-
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <asm/bootinfo.h>
 #include <asm/mach-au1x00/au1000.h>
+#include <prom.h>
+
+struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
+	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0 },
+	{ AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1500_GPIO_203, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1500_GPIO_205, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1500_GPIO_207, INTC_INT_LOW_LEVEL, 0 },
+
+	{ AU1000_GPIO_0, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1000_GPIO_1, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1000_GPIO_2, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1000_GPIO_3, INTC_INT_LOW_LEVEL, 0 },
+	{ AU1000_GPIO_4, INTC_INT_LOW_LEVEL, 0 }, /* CF interrupt */
+	{ AU1000_GPIO_5, INTC_INT_LOW_LEVEL, 0 },
+};
+
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
+
+
+const char *get_system_type(void)
+{
+	return "XXS1500";
+}
+
+void __init prom_init(void)
+{
+	unsigned char *memsize_str;
+	unsigned long memsize;
+
+	prom_argc = fw_arg0;
+	prom_argv = (char **)fw_arg1;
+	prom_envp = (char **)fw_arg2;
+
+	prom_init_cmdline();
+
+	memsize_str = prom_getenv("memsize");
+	if (!memsize_str)
+		memsize = 0x04000000;
+	else
+		strict_strtol(memsize_str, 0, &memsize);
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
 
 void board_reset(void)
 {
diff --git a/arch/mips/alchemy/xxs1500/init.c b/arch/mips/alchemy/xxs1500/init.c
deleted file mode 100644
index 7516434..0000000
--- a/arch/mips/alchemy/xxs1500/init.c
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	XXS1500 board setup
- *
- * Copyright 2003, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-
-#include <asm/bootinfo.h>
-
-#include <prom.h>
-
-const char *get_system_type(void)
-{
-	return "XXS1500";
-}
-
-void __init prom_init(void)
-{
-	unsigned char *memsize_str;
-	unsigned long memsize;
-
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
-
-	prom_init_cmdline();
-
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str)
-		memsize = 0x04000000;
-	else
-		strict_strtol(memsize_str, 0, &memsize);
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
-}
diff --git a/arch/mips/alchemy/xxs1500/irqmap.c b/arch/mips/alchemy/xxs1500/irqmap.c
deleted file mode 100644
index edf06ed..0000000
--- a/arch/mips/alchemy/xxs1500/irqmap.c
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	Au1xxx irq map table
- *
- * Copyright 2003 Embedded Edge, LLC
- *		dan@embeddededge.com
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
- *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
- *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-
-#include <asm/mach-au1x00/au1000.h>
-
-struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0 },
-	{ AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1500_GPIO_203, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1500_GPIO_205, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1500_GPIO_207, INTC_INT_LOW_LEVEL, 0 },
-
-	{ AU1000_GPIO_0, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_GPIO_1, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_GPIO_2, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_GPIO_3, INTC_INT_LOW_LEVEL, 0 },
-	{ AU1000_GPIO_4, INTC_INT_LOW_LEVEL, 0 }, /* CF interrupt */
-	{ AU1000_GPIO_5, INTC_INT_LOW_LEVEL, 0 },
-};
-
-int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
-- 
1.6.0.3
