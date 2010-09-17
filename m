Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Sep 2010 17:57:14 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1491078Ab0IQP5L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Sep 2010 17:57:11 +0200
Date:   Fri, 17 Sep 2010 16:57:10 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Porting Linux MIPS issue: maltaint.h files
Message-ID: <20100917155710.GA15030@linux-mips.org>
References: <AEA634773855ED4CAD999FBB1A66D076010CFA4E@CORPEXCH1.na.ads.idt.com>
 <20100916235739.GA16949@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100916235739.GA16949@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-archive-position: 27761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13754

On Fri, Sep 17, 2010 at 12:57:39AM +0100, Ralf Baechle wrote:

> Post a patch to cleanup the mess.
> 
> In this case (and I haven't looked at it for more than 30s ...) it seems
> that the constant X should be moved into <asm/gic.h> after which the
> inclusion of the Malta header can go away.

So here it is.

  Ralf

 arch/mips/include/asm/gic.h                  |    1 +
 arch/mips/include/asm/mips-boards/maltaint.h |    3 ---
 arch/mips/kernel/irq-gic.c                   |    3 +--
 arch/mips/mti-malta/malta-int.c              |    3 +++
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 9b9436a..86548da 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -321,6 +321,7 @@ struct gic_intrmask_regs {
  */
 struct gic_intr_map {
 	unsigned int cpunum;	/* Directed to this CPU */
+#define GIC_UNUSED		0xdead			/* Dummy data */
 	unsigned int pin;	/* Directed to this Pin */
 	unsigned int polarity;	/* Polarity : +/-	*/
 	unsigned int trigtype;	/* Trigger  : Edge/Levl */
diff --git a/arch/mips/include/asm/mips-boards/maltaint.h b/arch/mips/include/asm/mips-boards/maltaint.h
index cea872f..d11aa02 100644
--- a/arch/mips/include/asm/mips-boards/maltaint.h
+++ b/arch/mips/include/asm/mips-boards/maltaint.h
@@ -88,9 +88,6 @@
 
 #define GIC_EXT_INTR(x)		x
 
-/* Dummy data */
-#define X			0xdead
-
 /* External Interrupts used for IPI */
 #define GIC_IPI_EXT_INTR_RESCHED_VPE0	16
 #define GIC_IPI_EXT_INTR_CALLFNC_VPE0	17
diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
index b181f2f..3e57e29 100644
--- a/arch/mips/kernel/irq-gic.c
+++ b/arch/mips/kernel/irq-gic.c
@@ -7,7 +7,6 @@
 #include <asm/io.h>
 #include <asm/gic.h>
 #include <asm/gcmpregs.h>
-#include <asm/mips-boards/maltaint.h>
 #include <asm/irq.h>
 #include <linux/hardirq.h>
 #include <asm-generic/bitops/find.h>
@@ -222,7 +221,7 @@ static void __init gic_basic_init(int numintrs, int numvpes,
 	/* Setup specifics */
 	for (i = 0; i < mapsize; i++) {
 		cpu = intrmap[i].cpunum;
-		if (cpu == X)
+		if (cpu == GIC_UNUSED)
 			continue;
 		if (cpu == 0 && i != 0 && intrmap[i].flags == 0)
 			continue;
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 15949b0..b79b24a 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -385,6 +385,8 @@ static int __initdata msc_nr_eicirqs = ARRAY_SIZE(msc_eicirqmap);
  */
 
 #define GIC_CPU_NMI GIC_MAP_TO_NMI_MSK
+#define X GIC_UNUSED
+
 static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] = {
 	{ X, X,		   X,		X,		0 },
 	{ X, X,		   X,	 	X,		0 },
@@ -404,6 +406,7 @@ static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] = {
 	{ X, X,		   X,		X,	        0 },
 	/* The remainder of this table is initialised by fill_ipi_map */
 };
+#undef X
 
 /*
  * GCMP needs to be detected before any SMP initialisation
