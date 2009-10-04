Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Oct 2009 14:56:55 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:32847 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492532AbZJDMzm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 Oct 2009 14:55:42 +0200
Received: by ewy10 with SMTP id 10so1846514ewy.33
        for <multiple recipients>; Sun, 04 Oct 2009 05:55:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XCYdh6qUXRgLHwtQAlsJk/gSJOvnMa5shBNZXqxbGiY=;
        b=L4eATt808HACarV7tD7LjMdn5MSsOHfp/ZiQec2r6Q9hADgBQnKtsksjiiIghVJk25
         CssIqnjy3TZTzd60uy5qpWnR+8BbNmV2WHXPxlll1whXN6EzwhqXsshLjV9jD+m8UXOB
         FRqQbkVCEZaJxbMITzOapl7IwqMAsqPgy6YYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pzrQPk3mmVvcSBtDyAvu9k0sxUQjSYDmU4zYWpvLlWpLWXc5oz7mEZwvEysTrxFcZd
         oe3Ce2+A9UYYHmUuealQQrGQ7UUuUi0rvIWwfhh0pWFeI2A0ptcu97r3rnKQci9Exsdi
         A0u1WpDu0DDBh/jnzbtD6TPyPkYvo94Mc4A54=
Received: by 10.210.6.8 with SMTP id 8mr3840855ebf.80.1254660934428;
        Sun, 04 Oct 2009 05:55:34 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 28sm1555483eyg.4.2009.10.04.05.55.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Oct 2009 05:55:33 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 3/6] Alchemy: remove board_init_irq() function.
Date:	Sun,  4 Oct 2009 14:55:26 +0200
Message-Id: <1254660929-15453-4-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
In-Reply-To: <1254660929-15453-3-git-send-email-manuel.lauss@gmail.com>
References: <1254660929-15453-1-git-send-email-manuel.lauss@gmail.com>
 <1254660929-15453-2-git-send-email-manuel.lauss@gmail.com>
 <1254660929-15453-3-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

remove board_init_irq():  On all in-kernel boards it is sufficient to
initialize board interrupts in an arch_initcall by using the default
linux irq functions.

Some small irqmap.c files have been folded into board_setup files.

Run-tested on DB1200; compile-tested on all other affected boards.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/irq.c                   |   15 ++--
 arch/mips/alchemy/devboards/db1x00/Makefile      |    2 +-
 arch/mips/alchemy/devboards/db1x00/board_setup.c |   51 ++++++++++++
 arch/mips/alchemy/devboards/db1x00/irqmap.c      |   90 ----------------------
 arch/mips/alchemy/devboards/pb1000/board_setup.c |   17 ++---
 arch/mips/alchemy/devboards/pb1100/board_setup.c |   24 +++---
 arch/mips/alchemy/devboards/pb1200/Makefile      |    2 +-
 arch/mips/alchemy/devboards/pb1200/board_setup.c |   48 +++++++++++-
 arch/mips/alchemy/devboards/pb1200/irqmap.c      |   75 ------------------
 arch/mips/alchemy/devboards/pb1500/board_setup.c |   25 +++---
 arch/mips/alchemy/devboards/pb1550/board_setup.c |   19 ++---
 arch/mips/alchemy/mtx-1/Makefile                 |    2 +-
 arch/mips/alchemy/mtx-1/board_setup.c            |   24 ++++++
 arch/mips/alchemy/mtx-1/irqmap.c                 |   56 -------------
 arch/mips/alchemy/xxs1500/Makefile               |    2 +-
 arch/mips/alchemy/xxs1500/board_setup.c          |   21 +++++
 arch/mips/alchemy/xxs1500/irqmap.c               |   52 -------------
 arch/mips/include/asm/mach-au1x00/au1000.h       |   15 ----
 arch/mips/include/asm/mach-db1x00/db1200.h       |    1 +
 arch/mips/include/asm/mach-pb1x00/pb1200.h       |    1 +
 20 files changed, 194 insertions(+), 348 deletions(-)
 delete mode 100644 arch/mips/alchemy/devboards/db1x00/irqmap.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1200/irqmap.c
 delete mode 100644 arch/mips/alchemy/mtx-1/irqmap.c
 delete mode 100644 arch/mips/alchemy/xxs1500/irqmap.c

diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index c88c821..cd264b1 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -40,8 +40,11 @@
 static int au1x_ic_settype(unsigned int irq, unsigned int flow_type);
 
 /* per-processor fixed function irqs */
-struct au1xxx_irqmap au1xxx_ic0_map[] __initdata = {
-
+struct au1xxx_irqmap {
+	int im_irq;
+	int im_type;
+	int im_request;
+} au1xxx_ic0_map[] __initdata = {
 #if defined(CONFIG_SOC_AU1000)
 	{ AU1000_UART0_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
 	{ AU1000_UART1_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
@@ -529,7 +532,7 @@ spurious:
 }
 
 /* setup edge/level and assign request 0/1 */
-void __init au1xxx_setup_irqmap(struct au1xxx_irqmap *map, int count)
+static void __init setup_irqmap(struct au1xxx_irqmap *map, int count)
 {
 	unsigned int bit, irq_nr;
 
@@ -601,11 +604,7 @@ void __init arch_init_irq(void)
 	/*
 	 * Initialize IC0, which is fixed per processor.
 	 */
-	au1xxx_setup_irqmap(au1xxx_ic0_map, ARRAY_SIZE(au1xxx_ic0_map));
-
-	/* Boards can register additional (GPIO-based) IRQs.
-	*/
-	board_init_irq();
+	setup_irqmap(au1xxx_ic0_map, ARRAY_SIZE(au1xxx_ic0_map));
 
 	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3);
 }
diff --git a/arch/mips/alchemy/devboards/db1x00/Makefile b/arch/mips/alchemy/devboards/db1x00/Makefile
index 432241a..ce48d58 100644
--- a/arch/mips/alchemy/devboards/db1x00/Makefile
+++ b/arch/mips/alchemy/devboards/db1x00/Makefile
@@ -5,4 +5,4 @@
 # Makefile for the Alchemy Semiconductor DBAu1xx0 boards.
 #
 
-obj-y := board_setup.o irqmap.o
+obj-y := board_setup.o
diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index e713390..9a619ae 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -29,6 +29,7 @@
 
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/db1x00.h>
@@ -36,6 +37,37 @@
 
 #include <prom.h>
 
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
 const char *get_system_type(void)
 {
 #ifdef CONFIG_MIPS_BOSPORUS
@@ -149,3 +181,22 @@ void __init board_setup(void)
 
 	au_sync();
 }
+
+static int __init db1x00_init_irq(void)
+{
+#if defined(CONFIG_MIPS_MIRAGE)
+	set_irq_type(AU1000_GPIO_7, IRQF_TRIGGER_RISING); /* TS pendown */
+#elif defined(CONFIG_MIPS_DB1550)
+	set_irq_type(AU1000_GPIO_3, IRQF_TRIGGER_LOW);	/* CARD0# */
+	set_irq_type(AU1000_GPIO_5, IRQF_TRIGGER_LOW);	/* CARD1# */
+#else
+	set_irq_type(AU1000_GPIO_0, IRQF_TRIGGER_LOW);	/* CD0# */
+	set_irq_type(AU1000_GPIO_3, IRQF_TRIGGER_LOW);	/* CD1# */
+	set_irq_type(AU1000_GPIO_2, IRQF_TRIGGER_LOW);	/* CARD0# */
+	set_irq_type(AU1000_GPIO_5, IRQF_TRIGGER_LOW);	/* CARD1# */
+	set_irq_type(AU1000_GPIO_1, IRQF_TRIGGER_LOW);	/* STSCHG0# */
+	set_irq_type(AU1000_GPIO_4, IRQF_TRIGGER_LOW);	/* STSCHG1# */
+#endif
+	return 0;
+}
+arch_initcall(db1x00_init_irq);
diff --git a/arch/mips/alchemy/devboards/db1x00/irqmap.c b/arch/mips/alchemy/devboards/db1x00/irqmap.c
deleted file mode 100644
index 0b09025..0000000
--- a/arch/mips/alchemy/devboards/db1x00/irqmap.c
+++ /dev/null
@@ -1,90 +0,0 @@
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
-	{ AU1000_GPIO_3, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 0 IRQ# */
-	{ AU1000_GPIO_5, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 1 IRQ# */
-#else
-	{ AU1000_GPIO_0, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 0 Fully_Interted# */
-	{ AU1000_GPIO_1, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 0 STSCHG# */
-	{ AU1000_GPIO_2, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 0 IRQ# */
-
-	{ AU1000_GPIO_3, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 1 Fully_Interted# */
-	{ AU1000_GPIO_4, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 1 STSCHG# */
-	{ AU1000_GPIO_5, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card 1 IRQ# */
-#endif
-#else
-	{ AU1000_GPIO_7, IRQF_TRIGGER_RISING, 0 }, /* touchscreen pen down */
-#endif
-
-};
-
-void __init board_init_irq(void)
-{
-	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
-}
diff --git a/arch/mips/alchemy/devboards/pb1000/board_setup.c b/arch/mips/alchemy/devboards/pb1000/board_setup.c
index cd27354..f1cafea 100644
--- a/arch/mips/alchemy/devboards/pb1000/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1000/board_setup.c
@@ -32,11 +32,6 @@
 #include <prom.h>
 
 
-struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1000_GPIO_15, IRQF_TRIGGER_LOW, 0 },
-};
-
-
 const char *get_system_type(void)
 {
 	return "Alchemy Pb1000";
@@ -46,11 +41,6 @@ void board_reset(void)
 {
 }
 
-void __init board_init_irq(void)
-{
-	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
-}
-
 void __init board_setup(void)
 {
 	u32 pin_func, static_cfg0;
@@ -193,3 +183,10 @@ void __init board_setup(void)
 		break;
 	}
 }
+
+static int __init pb1000_init_irq(void)
+{
+	set_irq_type(AU1000_GPIO_15, IRQF_TRIGGER_LOW);
+	return 0;
+}
+arch_initcall(pb1000_init_irq);
diff --git a/arch/mips/alchemy/devboards/pb1100/board_setup.c b/arch/mips/alchemy/devboards/pb1100/board_setup.c
index eb749fb..aad424a 100644
--- a/arch/mips/alchemy/devboards/pb1100/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1100/board_setup.c
@@ -35,14 +35,6 @@
 #include <prom.h>
 
 
-struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1000_GPIO_9,  IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card Fully_Inserted# */
-	{ AU1000_GPIO_10, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card STSCHG# */
-	{ AU1000_GPIO_11, IRQF_TRIGGER_LOW, 0 }, /* PCMCIA Card IRQ# */
-	{ AU1000_GPIO_13, IRQF_TRIGGER_LOW, 0 }, /* DC_IRQ# */
-};
-
-
 const char *get_system_type(void)
 {
 	return "Alchemy Pb1100";
@@ -53,11 +45,6 @@ void board_reset(void)
 	bcsr_write(BCSR_SYSTEM, 0);
 }
 
-void __init board_init_irq(void)
-{
-	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
-}
-
 void __init board_setup(void)
 {
 	volatile void __iomem *base = (volatile void __iomem *)0xac000000UL;
@@ -158,3 +145,14 @@ void __init board_setup(void)
 		au_sync();
 	}
 }
+
+static int __init pb1100_init_irq(void)
+{
+	set_irq_type(AU1000_GPIO_9,  IRQF_TRIGGER_LOW);	/* PCCD# */
+	set_irq_type(AU1000_GPIO_10, IRQF_TRIGGER_LOW); /* PCSTSCHG# */
+	set_irq_type(AU1000_GPIO_11, IRQF_TRIGGER_LOW); /* PCCard# */
+	set_irq_type(AU1000_GPIO_13, IRQF_TRIGGER_LOW); /* DC_IRQ# */
+
+	return 0;
+}
+arch_initcall(pb1100_init_irq);
diff --git a/arch/mips/alchemy/devboards/pb1200/Makefile b/arch/mips/alchemy/devboards/pb1200/Makefile
index c8c3a99..2ea9b02 100644
--- a/arch/mips/alchemy/devboards/pb1200/Makefile
+++ b/arch/mips/alchemy/devboards/pb1200/Makefile
@@ -2,6 +2,6 @@
 # Makefile for the Alchemy Semiconductor Pb1200/DBAu1200 boards.
 #
 
-obj-y := board_setup.o irqmap.o platform.o
+obj-y := board_setup.o platform.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/alchemy/devboards/pb1200/board_setup.c b/arch/mips/alchemy/devboards/pb1200/board_setup.c
index db56380..76aa652 100644
--- a/arch/mips/alchemy/devboards/pb1200/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1200/board_setup.c
@@ -25,13 +25,25 @@
  */
 
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/sched.h>
 
+#include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/bcsr.h>
 
-#include <prom.h>
-#include <au1xxx.h>
+#ifdef CONFIG_MIPS_PB1200
+#include <asm/mach-pb1x00/pb1200.h>
+#endif
+
+#ifdef CONFIG_MIPS_DB1200
+#include <asm/mach-db1x00/db1200.h>
+#define PB1200_INT_BEGIN DB1200_INT_BEGIN
+#define PB1200_INT_END DB1200_INT_END
+#endif
 
+#include <asm/mach-db1x00/bcsr.h>
+
+#include <prom.h>
 
 const char *get_system_type(void)
 {
@@ -137,6 +149,38 @@ void __init board_setup(void)
 	au_sync();
 }
 
+static int __init pb1200_init_irq(void)
+{
+#ifdef CONFIG_MIPS_PB1200
+	/* We have a problem with CPLD rev 3. */
+	if (BCSR_WHOAMI_CPLD(bcsr_read(BCSR_WHOAMI)) <= 3) {
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
+	set_irq_type(AU1000_GPIO_7, IRQF_TRIGGER_LOW);
+	bcsr_init_irq(PB1200_INT_BEGIN, PB1200_INT_END, AU1000_GPIO_7);
+
+	return 0;
+}
+arch_initcall(pb1200_init_irq);
+
+
 int board_au1200fb_panel(void)
 {
 	return (bcsr_read(BCSR_SWITCHES) >> 8) & 0x0f;
diff --git a/arch/mips/alchemy/devboards/pb1200/irqmap.c b/arch/mips/alchemy/devboards/pb1200/irqmap.c
deleted file mode 100644
index 3beb804..0000000
--- a/arch/mips/alchemy/devboards/pb1200/irqmap.c
+++ /dev/null
@@ -1,75 +0,0 @@
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
-#include <asm/mach-db1x00/bcsr.h>
-
-struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	/* This is external interrupt cascade */
-	{ AU1000_GPIO_7, IRQF_TRIGGER_LOW, 0 },
-};
-
-void __init board_init_irq(void)
-{
-	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
-
-#ifdef CONFIG_MIPS_PB1200
-	/* We have a problem with CPLD rev 3. */
-	if (BCSR_WHOAMI_CPLD(bcsr_read(BCSR_WHOAMI)) <= 3) {
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
-	bcsr_init_irq(PB1200_INT_BEGIN, PB1200_INT_END, AU1000_GPIO_7);
-}
diff --git a/arch/mips/alchemy/devboards/pb1500/board_setup.c b/arch/mips/alchemy/devboards/pb1500/board_setup.c
index c5389e5..bf8e149 100644
--- a/arch/mips/alchemy/devboards/pb1500/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1500/board_setup.c
@@ -40,14 +40,6 @@ char irq_tab_alchemy[][5] __initdata = {
 	[13] = { -1, INTA, INTB, INTC, INTD },   /* IDSEL 13 - PCI slot */
 };
 
-struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1500_GPIO_204, IRQF_TRIGGER_HIGH, 0 },
-	{ AU1500_GPIO_201, IRQF_TRIGGER_LOW, 0 },
-	{ AU1500_GPIO_202, IRQF_TRIGGER_LOW, 0 },
-	{ AU1500_GPIO_203, IRQF_TRIGGER_LOW, 0 },
-	{ AU1500_GPIO_205, IRQF_TRIGGER_LOW, 0 },
-};
-
 
 const char *get_system_type(void)
 {
@@ -59,11 +51,6 @@ void board_reset(void)
 	bcsr_write(BCSR_SYSTEM, 0);
 }
 
-void __init board_init_irq(void)
-{
-	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
-}
-
 void __init board_setup(void)
 {
 	u32 pin_func;
@@ -166,3 +153,15 @@ void __init board_setup(void)
 		au_sync();
 	}
 }
+
+static int __init pb1500_init_irq(void)
+{
+	set_irq_type(AU1500_GPIO_204, IRQF_TRIGGER_HIGH);
+	set_irq_type(AU1500_GPIO_201, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO_202, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO_203, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO_205, IRQF_TRIGGER_LOW);
+
+	return 0;
+}
+arch_initcall(pb1500_init_irq);
diff --git a/arch/mips/alchemy/devboards/pb1550/board_setup.c b/arch/mips/alchemy/devboards/pb1550/board_setup.c
index af7a1b5..64f1ff9 100644
--- a/arch/mips/alchemy/devboards/pb1550/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1550/board_setup.c
@@ -42,11 +42,6 @@ char irq_tab_alchemy[][5] __initdata = {
 	[13] = { -1, INTA, INTB, INTC, INTD }, /* IDSEL 13 - PCI slot 1 (right) */
 };
 
-struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1000_GPIO_0, IRQF_TRIGGER_LOW, 0 },
-	{ AU1000_GPIO_1, IRQF_TRIGGER_LOW, 0 },
-};
-
 const char *get_system_type(void)
 {
 	return "Alchemy Pb1550";
@@ -57,11 +52,6 @@ void board_reset(void)
 	bcsr_write(BCSR_SYSTEM, 0);
 }
 
-void __init board_init_irq(void)
-{
-	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
-}
-
 void __init board_setup(void)
 {
 	u32 pin_func;
@@ -93,3 +83,12 @@ void __init board_setup(void)
 
 	printk(KERN_INFO "AMD Alchemy Pb1550 Board\n");
 }
+
+static int __init pb1550_init_irq(void)
+{
+	set_irq_type(AU1000_GPIO_0, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1000_GPIO_1, IRQF_TRIGGER_LOW);
+
+	return 0;
+}
+arch_initcall(pb1550_init_irq);
diff --git a/arch/mips/alchemy/mtx-1/Makefile b/arch/mips/alchemy/mtx-1/Makefile
index 7c67b3d..4a53815 100644
--- a/arch/mips/alchemy/mtx-1/Makefile
+++ b/arch/mips/alchemy/mtx-1/Makefile
@@ -6,7 +6,7 @@
 # Makefile for 4G Systems MTX-1 board.
 #
 
-lib-y := init.o board_setup.o irqmap.o
+lib-y := init.o board_setup.o
 obj-y := platform.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
index cc32c69..568492c 100644
--- a/arch/mips/alchemy/mtx-1/board_setup.c
+++ b/arch/mips/alchemy/mtx-1/board_setup.c
@@ -30,11 +30,23 @@
 
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 
 #include <asm/mach-au1x00/au1000.h>
 
 #include <prom.h>
 
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
 extern int (*board_pci_idsel)(unsigned int devsel, int assert);
 int mtx1_pci_idsel(unsigned int devsel, int assert);
 
@@ -110,3 +122,15 @@ mtx1_pci_idsel(unsigned int devsel, int assert)
 	au_sync_udelay(1);
 	return 1;
 }
+
+static int __init mtx1_init_irq(void)
+{
+	set_irq_type(AU1500_GPIO_204, IRQF_TRIGGER_HIGH);
+	set_irq_type(AU1500_GPIO_201, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO_202, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO_203, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO_205, IRQF_TRIGGER_LOW);
+
+	return 0;
+}
+arch_initcall(mtx1_init_irq);
diff --git a/arch/mips/alchemy/mtx-1/irqmap.c b/arch/mips/alchemy/mtx-1/irqmap.c
deleted file mode 100644
index f1ab12a..0000000
--- a/arch/mips/alchemy/mtx-1/irqmap.c
+++ /dev/null
@@ -1,56 +0,0 @@
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
-       { AU1500_GPIO_204, IRQF_TRIGGER_HIGH, 0 },
-       { AU1500_GPIO_201, IRQF_TRIGGER_LOW, 0 },
-       { AU1500_GPIO_202, IRQF_TRIGGER_LOW, 0 },
-       { AU1500_GPIO_203, IRQF_TRIGGER_LOW, 0 },
-       { AU1500_GPIO_205, IRQF_TRIGGER_LOW, 0 },
-};
-
-
-void __init board_init_irq(void)
-{
-	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
-}
diff --git a/arch/mips/alchemy/xxs1500/Makefile b/arch/mips/alchemy/xxs1500/Makefile
index db3c526..545d8f5 100644
--- a/arch/mips/alchemy/xxs1500/Makefile
+++ b/arch/mips/alchemy/xxs1500/Makefile
@@ -5,4 +5,4 @@
 # Makefile for MyCable XXS1500 board.
 #
 
-lib-y := init.o board_setup.o irqmap.o
+lib-y := init.o board_setup.o
diff --git a/arch/mips/alchemy/xxs1500/board_setup.c b/arch/mips/alchemy/xxs1500/board_setup.c
index 4de2d48..cad14f8 100644
--- a/arch/mips/alchemy/xxs1500/board_setup.c
+++ b/arch/mips/alchemy/xxs1500/board_setup.c
@@ -25,6 +25,7 @@
 
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/delay.h>
 
 #include <asm/mach-au1x00/au1000.h>
@@ -92,3 +93,23 @@ void __init board_setup(void)
 #endif
 #endif
 }
+
+static int __init xxs1500_init_irq(void)
+{
+	set_irq_type(AU1500_GPIO_204, IRQF_TRIGGER_HIGH);
+	set_irq_type(AU1500_GPIO_201, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO_202, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO_203, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO_205, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1500_GPIO_207, IRQF_TRIGGER_LOW);
+
+	set_irq_type(AU1000_GPIO_0, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1000_GPIO_1, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1000_GPIO_2, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1000_GPIO_3, IRQF_TRIGGER_LOW);
+	set_irq_type(AU1000_GPIO_4, IRQF_TRIGGER_LOW); /* CF interrupt */
+	set_irq_type(AU1000_GPIO_5, IRQF_TRIGGER_LOW);
+
+	return 0;
+}
+arch_initcall(xxs1500_init_irq);
diff --git a/arch/mips/alchemy/xxs1500/irqmap.c b/arch/mips/alchemy/xxs1500/irqmap.c
deleted file mode 100644
index 0f0f301..0000000
--- a/arch/mips/alchemy/xxs1500/irqmap.c
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
-#include <linux/interrupt.h>
-#include <asm/mach-au1x00/au1000.h>
-
-struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
-	{ AU1500_GPIO_204, IRQF_TRIGGER_HIGH, 0 },
-	{ AU1500_GPIO_201, IRQF_TRIGGER_LOW, 0 },
-	{ AU1500_GPIO_202, IRQF_TRIGGER_LOW, 0 },
-	{ AU1500_GPIO_203, IRQF_TRIGGER_LOW, 0 },
-	{ AU1500_GPIO_205, IRQF_TRIGGER_LOW, 0 },
-	{ AU1500_GPIO_207, IRQF_TRIGGER_LOW, 0 },
-
-	{ AU1000_GPIO_0, IRQF_TRIGGER_LOW, 0 },
-	{ AU1000_GPIO_1, IRQF_TRIGGER_LOW, 0 },
-	{ AU1000_GPIO_2, IRQF_TRIGGER_LOW, 0 },
-	{ AU1000_GPIO_3, IRQF_TRIGGER_LOW, 0 },
-	{ AU1000_GPIO_4, IRQF_TRIGGER_LOW, 0 }, /* CF interrupt */
-	{ AU1000_GPIO_5, IRQF_TRIGGER_LOW, 0 },
-};
-
-void __init board_init_irq(void)
-{
-	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
-}
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 854e95f..0507822 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -143,21 +143,6 @@ void au_sleep(void);
 void save_au1xxx_intctl(void);
 void restore_au1xxx_intctl(void);
 
-/*
- * Every board describes its IRQ mapping with this table.
- */
-struct au1xxx_irqmap {
-	int	im_irq;
-	int	im_type;
-	int	im_request;
-};
-
-/* core calls this function to let boards initialize other IRQ sources */
-void board_init_irq(void);
-
-/* boards call this to register additional (GPIO) interrupts */
-void au1xxx_setup_irqmap(struct au1xxx_irqmap *map, int count);
-
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
 /*
diff --git a/arch/mips/include/asm/mach-db1x00/db1200.h b/arch/mips/include/asm/mach-db1x00/db1200.h
index 2909b83..b7f18e1 100644
--- a/arch/mips/include/asm/mach-db1x00/db1200.h
+++ b/arch/mips/include/asm/mach-db1x00/db1200.h
@@ -25,6 +25,7 @@
 #define __ASM_DB1200_H
 
 #include <linux/types.h>
+#include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 
 #define DBDMA_AC97_TX_CHAN	DSCR_CMD0_PSC1_TX
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1200.h b/arch/mips/include/asm/mach-pb1x00/pb1200.h
index a51512c..2458eb4 100644
--- a/arch/mips/include/asm/mach-pb1x00/pb1200.h
+++ b/arch/mips/include/asm/mach-pb1x00/pb1200.h
@@ -25,6 +25,7 @@
 #define __ASM_PB1200_H
 
 #include <linux/types.h>
+#include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 
 #define DBDMA_AC97_TX_CHAN	DSCR_CMD0_PSC1_TX
-- 
1.6.5.rc2
