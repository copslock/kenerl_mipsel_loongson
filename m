Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 08:27:09 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:34531 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S22774218AbYLUI03 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 Dec 2008 08:26:29 +0000
Received: (qmail 3946 invoked from network); 21 Dec 2008 09:24:57 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 21 Dec 2008 09:24:57 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 02/14] Alchemy: devboards: consolidate files
Date:	Sun, 21 Dec 2008 09:26:15 +0100
Message-Id: <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
 <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1229846410.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Share some code and merge small files:
- Extract the prom init code from all devboard files (they only differ in
  memory configuration).
- Merge the irq configuration into board setup code.
- Merge smaller files into board setup code.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/devboards/Makefile             |    1 +
 arch/mips/alchemy/devboards/db1x00/Makefile      |    2 +-
 arch/mips/alchemy/devboards/db1x00/board_setup.c |    9 +++
 arch/mips/alchemy/devboards/db1x00/init.c        |   62 ----------------------
 arch/mips/alchemy/devboards/pb1000/Makefile      |    2 +-
 arch/mips/alchemy/devboards/pb1000/board_setup.c |   17 +++++-
 arch/mips/alchemy/devboards/pb1000/init.c        |   57 --------------------
 arch/mips/alchemy/devboards/pb1000/irqmap.c      |   38 -------------
 arch/mips/alchemy/devboards/pb1100/Makefile      |    2 +-
 arch/mips/alchemy/devboards/pb1100/board_setup.c |   16 ++++++
 arch/mips/alchemy/devboards/pb1100/init.c        |   60 ---------------------
 arch/mips/alchemy/devboards/pb1100/irqmap.c      |   40 --------------
 arch/mips/alchemy/devboards/pb1200/Makefile      |    3 +-
 arch/mips/alchemy/devboards/pb1200/board_setup.c |    5 ++
 arch/mips/alchemy/devboards/pb1200/init.c        |   58 --------------------
 arch/mips/alchemy/devboards/pb1500/Makefile      |    2 +-
 arch/mips/alchemy/devboards/pb1500/board_setup.c |   22 ++++++++
 arch/mips/alchemy/devboards/pb1500/init.c        |   58 --------------------
 arch/mips/alchemy/devboards/pb1500/irqmap.c      |   46 ----------------
 arch/mips/alchemy/devboards/pb1550/Makefile      |    2 +-
 arch/mips/alchemy/devboards/pb1550/board_setup.c |   19 +++++++
 arch/mips/alchemy/devboards/pb1550/init.c        |   58 --------------------
 arch/mips/alchemy/devboards/pb1550/irqmap.c      |   43 ---------------
 arch/mips/alchemy/devboards/prom.c               |   62 ++++++++++++++++++++++
 24 files changed, 155 insertions(+), 529 deletions(-)
 delete mode 100644 arch/mips/alchemy/devboards/db1x00/init.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1000/init.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1000/irqmap.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1100/init.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1100/irqmap.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1200/init.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1500/init.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1500/irqmap.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1550/init.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1550/irqmap.c
 create mode 100644 arch/mips/alchemy/devboards/prom.c

diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index a98126b..c0eb87a 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -2,6 +2,7 @@
 # Alchemy Develboards
 #
 
+obj-y += prom.o
 obj-$(CONFIG_MIPS_PB1000)	+= pb1000/
 obj-$(CONFIG_MIPS_PB1100)	+= pb1100/
 obj-$(CONFIG_MIPS_PB1200)	+= pb1200/
diff --git a/arch/mips/alchemy/devboards/db1x00/Makefile b/arch/mips/alchemy/devboards/db1x00/Makefile
index 274db3b..432241a 100644
--- a/arch/mips/alchemy/devboards/db1x00/Makefile
+++ b/arch/mips/alchemy/devboards/db1x00/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor DBAu1xx0 boards.
 #
 
-lib-y := init.o board_setup.o irqmap.o
+obj-y := board_setup.o irqmap.o
diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index 9e5ccbb..427f799 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -34,6 +34,15 @@
 
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
 void board_reset(void)
 {
 	/* Hit BCSR.SW_RESET[RESET] */
diff --git a/arch/mips/alchemy/devboards/db1x00/init.c b/arch/mips/alchemy/devboards/db1x00/init.c
deleted file mode 100644
index 8474135..0000000
--- a/arch/mips/alchemy/devboards/db1x00/init.c
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
diff --git a/arch/mips/alchemy/devboards/pb1000/Makefile b/arch/mips/alchemy/devboards/pb1000/Makefile
index 99bbec0..97c6615 100644
--- a/arch/mips/alchemy/devboards/pb1000/Makefile
+++ b/arch/mips/alchemy/devboards/pb1000/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor Pb1000 board.
 #
 
-lib-y := init.o board_setup.o irqmap.o
+obj-y := board_setup.o
diff --git a/arch/mips/alchemy/devboards/pb1000/board_setup.c b/arch/mips/alchemy/devboards/pb1000/board_setup.c
index 25df167..b75e487 100644
--- a/arch/mips/alchemy/devboards/pb1000/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1000/board_setup.c
@@ -23,12 +23,25 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/init.h>
 #include <linux/delay.h>
-
+#include <linux/init.h>
+#include <linux/interrupt.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1000.h>
 
+
+struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
+	{ AU1000_GPIO_15, INTC_INT_LOW_LEVEL, 0 },
+};
+
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
+
+
+const char *get_system_type(void)
+{
+	return "Alchemy Pb1000";
+}
+
 void board_reset(void)
 {
 }
diff --git a/arch/mips/alchemy/devboards/pb1000/init.c b/arch/mips/alchemy/devboards/pb1000/init.c
deleted file mode 100644
index 8a9c7d5..0000000
--- a/arch/mips/alchemy/devboards/pb1000/init.c
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
diff --git a/arch/mips/alchemy/devboards/pb1000/irqmap.c b/arch/mips/alchemy/devboards/pb1000/irqmap.c
deleted file mode 100644
index b3d56b0..0000000
--- a/arch/mips/alchemy/devboards/pb1000/irqmap.c
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
diff --git a/arch/mips/alchemy/devboards/pb1100/Makefile b/arch/mips/alchemy/devboards/pb1100/Makefile
index 793e97c..c586dd7 100644
--- a/arch/mips/alchemy/devboards/pb1100/Makefile
+++ b/arch/mips/alchemy/devboards/pb1100/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor Pb1100 board.
 #
 
-lib-y := init.o board_setup.o irqmap.o
+obj-y := board_setup.o
diff --git a/arch/mips/alchemy/devboards/pb1100/board_setup.c b/arch/mips/alchemy/devboards/pb1100/board_setup.c
index c0bfd59..9daab7e 100644
--- a/arch/mips/alchemy/devboards/pb1100/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1100/board_setup.c
@@ -29,6 +29,22 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1100.h>
 
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
 void board_reset(void)
 {
 	/* Hit BCSR.RST_VDDI[SOFT_RESET] */
diff --git a/arch/mips/alchemy/devboards/pb1100/init.c b/arch/mips/alchemy/devboards/pb1100/init.c
deleted file mode 100644
index 7c67923..0000000
--- a/arch/mips/alchemy/devboards/pb1100/init.c
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
diff --git a/arch/mips/alchemy/devboards/pb1100/irqmap.c b/arch/mips/alchemy/devboards/pb1100/irqmap.c
deleted file mode 100644
index 9b7dd8b..0000000
--- a/arch/mips/alchemy/devboards/pb1100/irqmap.c
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
diff --git a/arch/mips/alchemy/devboards/pb1200/Makefile b/arch/mips/alchemy/devboards/pb1200/Makefile
index d678adf..c8c3a99 100644
--- a/arch/mips/alchemy/devboards/pb1200/Makefile
+++ b/arch/mips/alchemy/devboards/pb1200/Makefile
@@ -2,7 +2,6 @@
 # Makefile for the Alchemy Semiconductor Pb1200/DBAu1200 boards.
 #
 
-lib-y := init.o board_setup.o irqmap.o
-obj-y += platform.o
+obj-y := board_setup.o irqmap.o platform.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/alchemy/devboards/pb1200/board_setup.c b/arch/mips/alchemy/devboards/pb1200/board_setup.c
index 6cb2115..8f03dc8 100644
--- a/arch/mips/alchemy/devboards/pb1200/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1200/board_setup.c
@@ -33,6 +33,11 @@
 extern void _board_init_irq(void);
 extern void (*board_init_irq)(void);
 
+const char *get_system_type(void)
+{
+	return "Alchemy Pb1200";
+}
+
 void board_reset(void)
 {
 	bcsr->resets = 0;
diff --git a/arch/mips/alchemy/devboards/pb1200/init.c b/arch/mips/alchemy/devboards/pb1200/init.c
deleted file mode 100644
index e9b2a0f..0000000
--- a/arch/mips/alchemy/devboards/pb1200/init.c
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
diff --git a/arch/mips/alchemy/devboards/pb1500/Makefile b/arch/mips/alchemy/devboards/pb1500/Makefile
index 602f38d..173b419 100644
--- a/arch/mips/alchemy/devboards/pb1500/Makefile
+++ b/arch/mips/alchemy/devboards/pb1500/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor Pb1500 board.
 #
 
-lib-y := init.o board_setup.o irqmap.o
+obj-y := board_setup.o
diff --git a/arch/mips/alchemy/devboards/pb1500/board_setup.c b/arch/mips/alchemy/devboards/pb1500/board_setup.c
index 035771c..47173f1 100644
--- a/arch/mips/alchemy/devboards/pb1500/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1500/board_setup.c
@@ -29,6 +29,28 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1500.h>
 
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
 void board_reset(void)
 {
 	/* Hit BCSR.RST_VDDI[SOFT_RESET] */
diff --git a/arch/mips/alchemy/devboards/pb1500/init.c b/arch/mips/alchemy/devboards/pb1500/init.c
deleted file mode 100644
index 3b6e395..0000000
--- a/arch/mips/alchemy/devboards/pb1500/init.c
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
diff --git a/arch/mips/alchemy/devboards/pb1500/irqmap.c b/arch/mips/alchemy/devboards/pb1500/irqmap.c
deleted file mode 100644
index 39c4682..0000000
--- a/arch/mips/alchemy/devboards/pb1500/irqmap.c
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
diff --git a/arch/mips/alchemy/devboards/pb1550/Makefile b/arch/mips/alchemy/devboards/pb1550/Makefile
index 7d8beca..cff95bc 100644
--- a/arch/mips/alchemy/devboards/pb1550/Makefile
+++ b/arch/mips/alchemy/devboards/pb1550/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor Pb1550 board.
 #
 
-lib-y := init.o board_setup.o irqmap.o
+obj-y := board_setup.o
diff --git a/arch/mips/alchemy/devboards/pb1550/board_setup.c b/arch/mips/alchemy/devboards/pb1550/board_setup.c
index 0ed76b6..25a9190 100644
--- a/arch/mips/alchemy/devboards/pb1550/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1550/board_setup.c
@@ -32,6 +32,25 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1550.h>
 
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
 void board_reset(void)
 {
 	/* Hit BCSR.SYSTEM[RESET] */
diff --git a/arch/mips/alchemy/devboards/pb1550/init.c b/arch/mips/alchemy/devboards/pb1550/init.c
deleted file mode 100644
index e1055a1..0000000
--- a/arch/mips/alchemy/devboards/pb1550/init.c
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
diff --git a/arch/mips/alchemy/devboards/pb1550/irqmap.c b/arch/mips/alchemy/devboards/pb1550/irqmap.c
deleted file mode 100644
index a02a4d1..0000000
--- a/arch/mips/alchemy/devboards/pb1550/irqmap.c
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
diff --git a/arch/mips/alchemy/devboards/prom.c b/arch/mips/alchemy/devboards/prom.c
new file mode 100644
index 0000000..7620efd
--- /dev/null
+++ b/arch/mips/alchemy/devboards/prom.c
@@ -0,0 +1,62 @@
+/*
+ * Common code used by all Alchemy develboards.
+ *
+ * Extracted from files which had this to say:
+ *
+ * Copyright 2000, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <asm/bootinfo.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <prom.h>
+
+#if defined(CONFIG_MIPS_PB1000) || defined(CONFIG_MIPS_DB1000) || \
+    defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1100) || \
+    defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_DB1500) || \
+    defined(CONFIG_MIPS_BOSPORUS) || defined(CONFIG_MIPS_MIRAGE)
+#define ALCHEMY_BOARD_DEFAULT_MEMSIZE	0x04000000
+
+#else	/* Au1550/Au1200-based develboards */
+#define ALCHEMY_BOARD_DEFAULT_MEMSIZE	0x08000000
+#endif
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
+		memsize = ALCHEMY_BOARD_DEFAULT_MEMSIZE;
+	else
+		strict_strtol(memsize_str, 0, &memsize);
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
-- 
1.6.0.4
