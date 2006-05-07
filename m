Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 May 2006 14:52:36 +0100 (BST)
Received: from fencepost.gnu.org ([199.232.76.164]:13032 "EHLO
	fencepost.gnu.org") by ftp.linux-mips.org with ESMTP
	id S8133425AbWEGNwY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 7 May 2006 14:52:24 +0100
Received: from hvr by fencepost.gnu.org with local (Exim 4.34)
	id 1FcjgI-0007TD-8R; Sun, 07 May 2006 09:52:18 -0400
From:	Herbert Valerio Riedel <hvr@gnu.org>
Date:	Sun May 7 15:48:25 2006 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] [MIPS] au1xxx: board specific irq code cleanup
Message-Id: <E1FcjgI-0007TD-8R@fencepost.gnu.org>
Return-Path: <hvr@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hvr@gnu.org
Precedence: bulk
X-list: linux-mips

convert sizeof/sizeof use to use of ARRAY_SIZE macro, and annotate
irqmap structures as __initdata

Signed-off-by: Herbert Valerio Riedel <hvr@gnu.org>


---

 arch/mips/au1000/common/au1xxx_irqmap.c |    4 ++--
 arch/mips/au1000/csb250/irqmap.c        |    4 ++--
 arch/mips/au1000/db1x00/irqmap.c        |    4 ++--
 arch/mips/au1000/hydrogen3/irqmap.c     |    4 ++--
 arch/mips/au1000/mtx-1/irqmap.c         |    4 ++--
 arch/mips/au1000/pb1000/irqmap.c        |    4 ++--
 arch/mips/au1000/pb1100/irqmap.c        |    4 ++--
 arch/mips/au1000/pb1200/irqmap.c        |    4 ++--
 arch/mips/au1000/pb1500/irqmap.c        |    4 ++--
 arch/mips/au1000/pb1550/irqmap.c        |    4 ++--
 arch/mips/au1000/xxs1500/irqmap.c       |    4 ++--
 11 files changed, 22 insertions(+), 22 deletions(-)

b09723a2dc77200c4bd76835663016ca60b5a0ec
diff --git a/arch/mips/au1000/common/au1xxx_irqmap.c b/arch/mips/au1000/common/au1xxx_irqmap.c
index 0b2c03c..5a1e368 100644
--- a/arch/mips/au1000/common/au1xxx_irqmap.c
+++ b/arch/mips/au1000/common/au1xxx_irqmap.c
@@ -55,7 +55,7 @@
  * Careful if you change match 2 request!
  * The interrupt handler is called directly from the low level dispatch code.
  */
-au1xxx_irq_map_t au1xxx_ic0_map[] = {
+au1xxx_irq_map_t __initdata au1xxx_ic0_map[] = {
 
 #if defined(CONFIG_SOC_AU1000)
 	{ AU1000_UART0_INT, INTC_INT_HIGH_LEVEL, 0},
@@ -220,5 +220,5 @@ au1xxx_irq_map_t au1xxx_ic0_map[] = {
 
 };
 
-int au1xxx_ic0_nr_irqs = sizeof(au1xxx_ic0_map)/sizeof(au1xxx_irq_map_t);
+int __initdata au1xxx_ic0_nr_irqs = ARRAY_SIZE(au1xxx_ic0_map);
 
diff --git a/arch/mips/au1000/csb250/irqmap.c b/arch/mips/au1000/csb250/irqmap.c
index 5cb1166..57d6040 100644
--- a/arch/mips/au1000/csb250/irqmap.c
+++ b/arch/mips/au1000/csb250/irqmap.c
@@ -47,7 +47,7 @@
 #include <asm/system.h>
 #include <asm/au1000.h>
 
-au1xxx_irq_map_t au1xxx_irq_map[] = {
+au1xxx_irq_map_t __initdata au1xxx_irq_map[] = {
 
 	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0},
 	{ AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
@@ -57,4 +57,4 @@ au1xxx_irq_map_t au1xxx_irq_map[] = {
 	{ AU1500_GPIO_207, INTC_INT_LOW_LEVEL, 0 },
 };
 
-int au1xxx_nr_irqs = sizeof(au1xxx_irq_map)/sizeof(au1xxx_irq_map_t);
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
diff --git a/arch/mips/au1000/db1x00/irqmap.c b/arch/mips/au1000/db1x00/irqmap.c
index f63024a..0138c5b 100644
--- a/arch/mips/au1000/db1x00/irqmap.c
+++ b/arch/mips/au1000/db1x00/irqmap.c
@@ -80,7 +80,7 @@ char irq_tab_alchemy[][5] __initdata = {
 #endif
 
 
-au1xxx_irq_map_t au1xxx_irq_map[] = {
+au1xxx_irq_map_t __initdata au1xxx_irq_map[] = {
 
 #ifndef CONFIG_MIPS_MIRAGE
 #ifdef CONFIG_MIPS_DB1550
@@ -101,4 +101,4 @@ au1xxx_irq_map_t au1xxx_irq_map[] = {
 
 };
 
-int au1xxx_nr_irqs = sizeof(au1xxx_irq_map)/sizeof(au1xxx_irq_map_t);
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
diff --git a/arch/mips/au1000/hydrogen3/irqmap.c b/arch/mips/au1000/hydrogen3/irqmap.c
index 6eacaa0..14e1ed3 100644
--- a/arch/mips/au1000/hydrogen3/irqmap.c
+++ b/arch/mips/au1000/hydrogen3/irqmap.c
@@ -47,10 +47,10 @@
 #include <asm/system.h>
 #include <asm/au1000.h>
 
-au1xxx_irq_map_t au1xxx_irq_map[] = {
+au1xxx_irq_map_t __initdata au1xxx_irq_map[] = {
 
 	/* { AU1500_GPIO_205, INTC_INT_LOW_LEVEL, 0 }, */
 	{ AU1000_GPIO_21, INTC_INT_LOW_LEVEL, 0 },
 };
 
-int au1xxx_nr_irqs = sizeof(au1xxx_irq_map)/sizeof(au1xxx_irq_map_t);
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
diff --git a/arch/mips/au1000/mtx-1/irqmap.c b/arch/mips/au1000/mtx-1/irqmap.c
index f9a0a8b..4693a4e 100644
--- a/arch/mips/au1000/mtx-1/irqmap.c
+++ b/arch/mips/au1000/mtx-1/irqmap.c
@@ -58,7 +58,7 @@ char irq_tab_alchemy[][5] __initdata = {
  [7] = { -1, INTD, INTC, INTX, INTX},   /* IDSEL 07 - AdapterD-Slot1 (bottom) */
 };
 
-au1xxx_irq_map_t au1xxx_irq_map[] = {
+au1xxx_irq_map_t __initdata au1xxx_irq_map[] = {
        { AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0},
        { AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
        { AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
@@ -66,4 +66,4 @@ au1xxx_irq_map_t au1xxx_irq_map[] = {
        { AU1500_GPIO_205, INTC_INT_LOW_LEVEL, 0 },
 };
 
-int au1xxx_nr_irqs = sizeof(au1xxx_irq_map)/sizeof(au1xxx_irq_map_t);
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
diff --git a/arch/mips/au1000/pb1000/irqmap.c b/arch/mips/au1000/pb1000/irqmap.c
index a3c460e..156500b 100644
--- a/arch/mips/au1000/pb1000/irqmap.c
+++ b/arch/mips/au1000/pb1000/irqmap.c
@@ -47,8 +47,8 @@
 #include <asm/system.h>
 #include <asm/mach-au1x00/au1000.h>
 
-au1xxx_irq_map_t au1xxx_irq_map[] = {
+au1xxx_irq_map_t __initdata au1xxx_irq_map[] = {
 	{ AU1000_GPIO_15, INTC_INT_LOW_LEVEL, 0 },
 };
 
-int au1xxx_nr_irqs = sizeof(au1xxx_irq_map)/sizeof(au1xxx_irq_map_t);
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
diff --git a/arch/mips/au1000/pb1100/irqmap.c b/arch/mips/au1000/pb1100/irqmap.c
index 43be715..d986916 100644
--- a/arch/mips/au1000/pb1100/irqmap.c
+++ b/arch/mips/au1000/pb1100/irqmap.c
@@ -47,11 +47,11 @@
 #include <asm/system.h>
 #include <asm/mach-au1x00/au1000.h>
 
-au1xxx_irq_map_t au1xxx_irq_map[] = {
+au1xxx_irq_map_t __initdata au1xxx_irq_map[] = {
 	{ AU1000_GPIO_9, INTC_INT_LOW_LEVEL, 0 }, // PCMCIA Card Fully_Interted#
 	{ AU1000_GPIO_10, INTC_INT_LOW_LEVEL, 0 }, // PCMCIA Card STSCHG#
 	{ AU1000_GPIO_11, INTC_INT_LOW_LEVEL, 0 }, // PCMCIA Card IRQ#
 	{ AU1000_GPIO_13, INTC_INT_LOW_LEVEL, 0 }, // DC_IRQ#
 };
 
-int au1xxx_nr_irqs = sizeof(au1xxx_irq_map)/sizeof(au1xxx_irq_map_t);
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
diff --git a/arch/mips/au1000/pb1200/irqmap.c b/arch/mips/au1000/pb1200/irqmap.c
index 59e70e5..bacc0c6 100644
--- a/arch/mips/au1000/pb1200/irqmap.c
+++ b/arch/mips/au1000/pb1200/irqmap.c
@@ -55,11 +55,11 @@
 #define PB1200_INT_END DB1200_INT_END
 #endif
 
-au1xxx_irq_map_t au1xxx_irq_map[] = {
+au1xxx_irq_map_t __initdata au1xxx_irq_map[] = {
 	{ AU1000_GPIO_7, INTC_INT_LOW_LEVEL, 0 }, // This is exteranl interrupt cascade
 };
 
-int au1xxx_nr_irqs = sizeof(au1xxx_irq_map)/sizeof(au1xxx_irq_map_t);
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
 
 /*
  *	Support for External interrupts on the PbAu1200 Development platform.
diff --git a/arch/mips/au1000/pb1500/irqmap.c b/arch/mips/au1000/pb1500/irqmap.c
index 8cb76c2..409d161 100644
--- a/arch/mips/au1000/pb1500/irqmap.c
+++ b/arch/mips/au1000/pb1500/irqmap.c
@@ -52,7 +52,7 @@ char irq_tab_alchemy[][5] __initdata = {
  [13] = { -1, INTA, INTB, INTC, INTD},   /* IDSEL 13 - PCI slot */
 };
 
-au1xxx_irq_map_t au1xxx_irq_map[] = {
+au1xxx_irq_map_t __initdata au1xxx_irq_map[] = {
 	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0},
 	{ AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
@@ -60,4 +60,4 @@ au1xxx_irq_map_t au1xxx_irq_map[] = {
 	{ AU1500_GPIO_205, INTC_INT_LOW_LEVEL, 0 },
 };
 
-int au1xxx_nr_irqs = sizeof(au1xxx_irq_map)/sizeof(au1xxx_irq_map_t);
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
diff --git a/arch/mips/au1000/pb1550/irqmap.c b/arch/mips/au1000/pb1550/irqmap.c
index 47c7a1c..24a9d18 100644
--- a/arch/mips/au1000/pb1550/irqmap.c
+++ b/arch/mips/au1000/pb1550/irqmap.c
@@ -52,9 +52,9 @@ char irq_tab_alchemy[][5] __initdata = {
  [13] =	{ -1, INTA, INTB, INTC, INTD},   /* IDSEL 13 - PCI slot 1 (right) */
 };
 
-au1xxx_irq_map_t au1xxx_irq_map[] = {
+au1xxx_irq_map_t __initdata au1xxx_irq_map[] = {
 	{ AU1000_GPIO_0, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1000_GPIO_1, INTC_INT_LOW_LEVEL, 0 },
 };
 
-int au1xxx_nr_irqs = sizeof(au1xxx_irq_map)/sizeof(au1xxx_irq_map_t);
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
diff --git a/arch/mips/au1000/xxs1500/irqmap.c b/arch/mips/au1000/xxs1500/irqmap.c
index 52f2f7d..3844c64 100644
--- a/arch/mips/au1000/xxs1500/irqmap.c
+++ b/arch/mips/au1000/xxs1500/irqmap.c
@@ -47,7 +47,7 @@
 #include <asm/system.h>
 #include <asm/au1000.h>
 
-au1xxx_irq_map_t au1xxx_irq_map[] = {
+au1xxx_irq_map_t __initdata au1xxx_irq_map[] = {
 	{ AU1500_GPIO_204, INTC_INT_HIGH_LEVEL, 0},
 	{ AU1500_GPIO_201, INTC_INT_LOW_LEVEL, 0 },
 	{ AU1500_GPIO_202, INTC_INT_LOW_LEVEL, 0 },
@@ -63,4 +63,4 @@ au1xxx_irq_map_t au1xxx_irq_map[] = {
 	{ AU1000_GPIO_5, INTC_INT_LOW_LEVEL, 0 },
 };
 
-int au1xxx_nr_irqs = sizeof(au1xxx_irq_map)/sizeof(au1xxx_irq_map_t);
+int __initdata au1xxx_nr_irqs = ARRAY_SIZE(au1xxx_irq_map);
-- 
1.2.6
