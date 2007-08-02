Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 15:35:21 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:26572 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022151AbXHBOfB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2007 15:35:01 +0100
Received: from localhost (p2209-ipad28funabasi.chiba.ocn.ne.jp [220.107.201.209])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F17C3B5F6; Thu,  2 Aug 2007 23:34:54 +0900 (JST)
Date:	Thu, 02 Aug 2007 23:36:02 +0900 (JST)
Message-Id: <20070802.233602.41630863.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2/5] Cleanup TX39/TX49 irq codes
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Cleanup jmr3927, tx4927 and tx4938 irq codes, using common IRQ_CPU,
I8259 and IRQ_TXX9 irq routines.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Kconfig                                  |    8 +-
 arch/mips/jmr3927/rbhma3100/irq.c                  |   48 +---
 arch/mips/jmr3927/rbhma3100/setup.c                |   13 -
 arch/mips/tx4927/common/tx4927_irq.c               |  395 +-------------------
 .../tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c |  171 +--------
 .../toshiba_rbtx4927/toshiba_rbtx4927_setup.c      |   11 +-
 arch/mips/tx4938/common/irq.c                      |  279 +-------------
 arch/mips/tx4938/toshiba_rbtx4938/irq.c            |    2 +-
 arch/mips/tx4938/toshiba_rbtx4938/setup.c          |    9 +-
 include/asm-mips/jmr3927/jmr3927.h                 |    3 +-
 include/asm-mips/jmr3927/tx3927.h                  |   36 --
 include/asm-mips/tx4927/toshiba_rbtx4927.h         |    2 +-
 include/asm-mips/tx4927/tx4927.h                   |   49 +---
 include/asm-mips/tx4927/tx4927_pci.h               |   23 +--
 include/asm-mips/tx4938/rbtx4938.h                 |   25 +-
 include/asm-mips/tx4938/tx4938.h                   |   41 --
 16 files changed, 55 insertions(+), 1060 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cec0d84..4b02d8a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -528,6 +528,7 @@ config TOSHIBA_JMR3927
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select MIPS_TX3927
+	select IRQ_TXX9
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_TX39XX
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -540,7 +541,9 @@ config TOSHIBA_RBTX4927
 	select DMA_NONCOHERENT
 	select HAS_TXX9_SERIAL
 	select HW_HAS_PCI
-	select I8259
+	select IRQ_CPU
+	select IRQ_TXX9
+	select I8259 if TOSHIBA_FPCIB0
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_TX49XX
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -560,7 +563,8 @@ config TOSHIBA_RBTX4938
 	select GENERIC_ISA_DMA
 	select HAS_TXX9_SERIAL
 	select HW_HAS_PCI
-	select I8259
+	select IRQ_CPU
+	select IRQ_TXX9
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_TX49XX
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/jmr3927/rbhma3100/irq.c b/arch/mips/jmr3927/rbhma3100/irq.c
index 1187b44..d9efe69 100644
--- a/arch/mips/jmr3927/rbhma3100/irq.c
+++ b/arch/mips/jmr3927/rbhma3100/irq.c
@@ -45,9 +45,6 @@
 #error JMR3927_IRQ_END > NR_IRQS
 #endif
 
-#define irc_dlevel	0
-#define irc_elevel	1
-
 static unsigned char irc_level[TX3927_NUM_IR] = {
 	5, 5, 5, 5, 5, 5,	/* INT[5:0] */
 	7, 7,			/* SIO */
@@ -80,34 +77,6 @@ static void unmask_irq_ioc(unsigned int irq)
 	(void)jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR);
 }
 
-static void mask_irq_irc(unsigned int irq)
-{
-	unsigned int irq_nr = irq - JMR3927_IRQ_IRC;
-	volatile unsigned long *ilrp = &tx3927_ircptr->ilr[irq_nr / 2];
-	if (irq_nr & 1)
-		*ilrp = (*ilrp & 0x00ff) | (irc_dlevel << 8);
-	else
-		*ilrp = (*ilrp & 0xff00) | irc_dlevel;
-	/* update IRCSR */
-	tx3927_ircptr->imr = 0;
-	tx3927_ircptr->imr = irc_elevel;
-	/* flush write buffer */
-	(void)tx3927_ircptr->ssr;
-}
-
-static void unmask_irq_irc(unsigned int irq)
-{
-	unsigned int irq_nr = irq - JMR3927_IRQ_IRC;
-	volatile unsigned long *ilrp = &tx3927_ircptr->ilr[irq_nr / 2];
-	if (irq_nr & 1)
-		*ilrp = (*ilrp & 0x00ff) | (irc_level[irq_nr] << 8);
-	else
-		*ilrp = (*ilrp & 0xff00) | irc_level[irq_nr];
-	/* update IRCSR */
-	tx3927_ircptr->imr = 0;
-	tx3927_ircptr->imr = irc_elevel;
-}
-
 asmlinkage void plat_irq_dispatch(void)
 {
 	unsigned long cp0_cause = read_c0_cause();
@@ -168,10 +137,6 @@ void __init arch_init_irq(void)
 	/* clear PCI Reset interrupts */
 	jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
 
-	/* enable interrupt control */
-	tx3927_ircptr->cer = TX3927_IRCER_ICE;
-	tx3927_ircptr->imr = irc_elevel;
-
 	jmr3927_irq_init();
 
 	/* setup IOC interrupt 1 (PCI, MODEM) */
@@ -193,20 +158,13 @@ static struct irq_chip jmr3927_irq_ioc = {
 	.unmask = unmask_irq_ioc,
 };
 
-static struct irq_chip jmr3927_irq_irc = {
-	.name = "jmr3927_irc",
-	.ack = mask_irq_irc,
-	.mask = mask_irq_irc,
-	.mask_ack = mask_irq_irc,
-	.unmask = unmask_irq_irc,
-};
-
 static void __init jmr3927_irq_init(void)
 {
 	u32 i;
 
-	for (i = JMR3927_IRQ_IRC; i < JMR3927_IRQ_IRC + JMR3927_NR_IRQ_IRC; i++)
-		set_irq_chip_and_handler(i, &jmr3927_irq_irc, handle_level_irq);
+	txx9_irq_init(TX3927_IRC_REG);
+	for (i = 0; i < TXx9_MAX_IR; i++)
+		txx9_irq_set_pri(i, irc_level[i]);
 	for (i = JMR3927_IRQ_IOC; i < JMR3927_IRQ_IOC + JMR3927_NR_IRQ_IOC; i++)
 		set_irq_chip_and_handler(i, &jmr3927_irq_ioc, handle_level_irq);
 }
diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
index 8303001..fde56e8 100644
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ b/arch/mips/jmr3927/rbhma3100/setup.c
@@ -290,19 +290,6 @@ static void __init tx3927_setup(void)
 	       tx3927_ccfgptr->crir,
 	       tx3927_ccfgptr->ccfg, tx3927_ccfgptr->pcfg);
 
-	/* IRC */
-	/* disable interrupt control */
-	tx3927_ircptr->cer = 0;
-	/* mask all IRC interrupts */
-	tx3927_ircptr->imr = 0;
-	for (i = 0; i < TX3927_NUM_IR / 2; i++) {
-		tx3927_ircptr->ilr[i] = 0;
-	}
-	/* setup IRC interrupt mode (Low Active) */
-	for (i = 0; i < TX3927_NUM_IR / 8; i++) {
-		tx3927_ircptr->cr[i] = 0;
-	}
-
 	/* TMR */
 	/* disable all timers */
 	for (i = 0; i < TX3927_NR_TMR; i++) {
diff --git a/arch/mips/tx4927/common/tx4927_irq.c b/arch/mips/tx4927/common/tx4927_irq.c
index 00b0b97..0aabd57 100644
--- a/arch/mips/tx4927/common/tx4927_irq.c
+++ b/arch/mips/tx4927/common/tx4927_irq.c
@@ -23,398 +23,20 @@
  *  with this program; if not, write to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
 #include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/irq.h>
-#include <linux/bitops.h>
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/irq.h>
+#include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
-#include <asm/system.h>
 #include <asm/tx4927/tx4927.h>
 #ifdef CONFIG_TOSHIBA_RBTX4927
 #include <asm/tx4927/toshiba_rbtx4927.h>
 #endif
 
-/*
- * DEBUG
- */
-
-#undef TX4927_IRQ_DEBUG
-
-#ifdef TX4927_IRQ_DEBUG
-#define TX4927_IRQ_NONE        0x00000000
-
-#define TX4927_IRQ_INFO        ( 1 <<  0 )
-#define TX4927_IRQ_WARN        ( 1 <<  1 )
-#define TX4927_IRQ_EROR        ( 1 <<  2 )
-
-#define TX4927_IRQ_INIT        ( 1 <<  5 )
-#define TX4927_IRQ_NEST1       ( 1 <<  6 )
-#define TX4927_IRQ_NEST2       ( 1 <<  7 )
-#define TX4927_IRQ_NEST3       ( 1 <<  8 )
-#define TX4927_IRQ_NEST4       ( 1 <<  9 )
-
-#define TX4927_IRQ_CP0_INIT     ( 1 << 10 )
-#define TX4927_IRQ_CP0_ENABLE   ( 1 << 13 )
-#define TX4927_IRQ_CP0_DISABLE  ( 1 << 14 )
-
-#define TX4927_IRQ_PIC_INIT     ( 1 << 20 )
-#define TX4927_IRQ_PIC_ENABLE   ( 1 << 23 )
-#define TX4927_IRQ_PIC_DISABLE  ( 1 << 24 )
-
-#define TX4927_IRQ_ALL         0xffffffff
-#endif
-
-#ifdef TX4927_IRQ_DEBUG
-static const u32 tx4927_irq_debug_flag = (TX4927_IRQ_NONE
-					  | TX4927_IRQ_INFO
-					  | TX4927_IRQ_WARN | TX4927_IRQ_EROR
-//                                       | TX4927_IRQ_CP0_INIT
-//                                       | TX4927_IRQ_CP0_ENABLE
-//                                       | TX4927_IRQ_CP0_ENDIRQ
-//                                       | TX4927_IRQ_PIC_INIT
-//                                       | TX4927_IRQ_PIC_ENABLE
-//                                       | TX4927_IRQ_PIC_DISABLE
-//                                       | TX4927_IRQ_INIT
-//                                       | TX4927_IRQ_NEST1
-//                                       | TX4927_IRQ_NEST2
-//                                       | TX4927_IRQ_NEST3
-//                                       | TX4927_IRQ_NEST4
-    );
-#endif
-
-#ifdef TX4927_IRQ_DEBUG
-#define TX4927_IRQ_DPRINTK(flag,str...) \
-        if ( (tx4927_irq_debug_flag) & (flag) ) \
-        { \
-           char tmp[100]; \
-           sprintf( tmp, str ); \
-           printk( "%s(%s:%u)::%s", __FUNCTION__, __FILE__, __LINE__, tmp ); \
-        }
-#else
-#define TX4927_IRQ_DPRINTK(flag,str...)
-#endif
-
-/*
- * Forwad definitions for all pic's
- */
-
-static void tx4927_irq_cp0_enable(unsigned int irq);
-static void tx4927_irq_cp0_disable(unsigned int irq);
-
-static void tx4927_irq_pic_enable(unsigned int irq);
-static void tx4927_irq_pic_disable(unsigned int irq);
-
-/*
- * Kernel structs for all pic's
- */
-
-#define TX4927_CP0_NAME "TX4927-CP0"
-static struct irq_chip tx4927_irq_cp0_type = {
-	.name		= TX4927_CP0_NAME,
-	.ack		= tx4927_irq_cp0_disable,
-	.mask		= tx4927_irq_cp0_disable,
-	.mask_ack	= tx4927_irq_cp0_disable,
-	.unmask		= tx4927_irq_cp0_enable,
-};
-
-#define TX4927_PIC_NAME "TX4927-PIC"
-static struct irq_chip tx4927_irq_pic_type = {
-	.name		= TX4927_PIC_NAME,
-	.ack		= tx4927_irq_pic_disable,
-	.mask		= tx4927_irq_pic_disable,
-	.mask_ack	= tx4927_irq_pic_disable,
-	.unmask		= tx4927_irq_pic_enable,
-};
-
-#define TX4927_PIC_ACTION(s) { no_action, 0, CPU_MASK_NONE, s, NULL, NULL }
-static struct irqaction tx4927_irq_pic_action =
-TX4927_PIC_ACTION(TX4927_PIC_NAME);
-
-#define CCP0_STATUS 12
-#define CCP0_CAUSE 13
-
-/*
- * Functions for cp0
- */
-
-#define tx4927_irq_cp0_mask(irq) ( 1 << ( irq-TX4927_IRQ_CP0_BEG+8 ) )
-
-static void
-tx4927_irq_cp0_modify(unsigned cp0_reg, unsigned clr_bits, unsigned set_bits)
-{
-	unsigned long val = 0;
-
-	switch (cp0_reg) {
-	case CCP0_STATUS:
-		val = read_c0_status();
-		break;
-
-	case CCP0_CAUSE:
-		val = read_c0_cause();
-		break;
-
-	}
-
-	val &= (~clr_bits);
-	val |= (set_bits);
-
-	switch (cp0_reg) {
-	case CCP0_STATUS:{
-			write_c0_status(val);
-			break;
-		}
-	case CCP0_CAUSE:{
-			write_c0_cause(val);
-			break;
-		}
-	}
-}
-
-static void __init tx4927_irq_cp0_init(void)
-{
-	int i;
-
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_INIT, "beg=%d end=%d\n",
-			   TX4927_IRQ_CP0_BEG, TX4927_IRQ_CP0_END);
-
-	for (i = TX4927_IRQ_CP0_BEG; i <= TX4927_IRQ_CP0_END; i++)
-		set_irq_chip_and_handler(i, &tx4927_irq_cp0_type,
-					 handle_level_irq);
-}
-
-static void tx4927_irq_cp0_enable(unsigned int irq)
-{
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_ENABLE, "irq=%d \n", irq);
-
-	tx4927_irq_cp0_modify(CCP0_STATUS, 0, tx4927_irq_cp0_mask(irq));
-}
-
-static void tx4927_irq_cp0_disable(unsigned int irq)
-{
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_CP0_DISABLE, "irq=%d \n", irq);
-
-	tx4927_irq_cp0_modify(CCP0_STATUS, tx4927_irq_cp0_mask(irq), 0);
-}
-
-/*
- * Functions for pic
- */
-u32 tx4927_irq_pic_addr(int irq)
-{
-	/* MVMCP -- need to formulize this */
-	irq -= TX4927_IRQ_PIC_BEG;
-	switch (irq) {
-	case 17:
-	case 16:
-	case 1:
-	case 0:
-		return (0xff1ff610);
-
-	case 19:
-	case 18:
-	case 3:
-	case 2:
-		return (0xff1ff614);
-
-	case 21:
-	case 20:
-	case 5:
-	case 4:
-		return (0xff1ff618);
-
-	case 23:
-	case 22:
-	case 7:
-	case 6:
-		return (0xff1ff61c);
-
-	case 25:
-	case 24:
-	case 9:
-	case 8:
-		return (0xff1ff620);
-
-	case 27:
-	case 26:
-	case 11:
-	case 10:
-		return (0xff1ff624);
-
-	case 29:
-	case 28:
-	case 13:
-	case 12:
-		return (0xff1ff628);
-
-	case 31:
-	case 30:
-	case 15:
-	case 14:
-		return (0xff1ff62c);
-
-	}
-	return (0);
-}
-
-u32 tx4927_irq_pic_mask(int irq)
-{
-	/* MVMCP -- need to formulize this */
-	irq -= TX4927_IRQ_PIC_BEG;
-	switch (irq) {
-	case 31:
-	case 29:
-	case 27:
-	case 25:
-	case 23:
-	case 21:
-	case 19:
-	case 17:{
-			return (0x07000000);
-		}
-	case 30:
-	case 28:
-	case 26:
-	case 24:
-	case 22:
-	case 20:
-	case 18:
-	case 16:{
-			return (0x00070000);
-		}
-	case 15:
-	case 13:
-	case 11:
-	case 9:
-	case 7:
-	case 5:
-	case 3:
-	case 1:{
-			return (0x00000700);
-		}
-	case 14:
-	case 12:
-	case 10:
-	case 8:
-	case 6:
-	case 4:
-	case 2:
-	case 0:{
-			return (0x00000007);
-		}
-	}
-	return (0x00000000);
-}
-
-static void tx4927_irq_pic_modify(unsigned pic_reg, unsigned clr_bits,
-	unsigned set_bits)
-{
-	unsigned long val = 0;
-
-	val = TX4927_RD(pic_reg);
-	val &= (~clr_bits);
-	val |= (set_bits);
-	TX4927_WR(pic_reg, val);
-}
-
-static void __init tx4927_irq_pic_init(void)
-{
-	int i;
-
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_INIT, "beg=%d end=%d\n",
-			   TX4927_IRQ_PIC_BEG, TX4927_IRQ_PIC_END);
-
-	for (i = TX4927_IRQ_PIC_BEG; i <= TX4927_IRQ_PIC_END; i++)
-		set_irq_chip_and_handler(i, &tx4927_irq_pic_type,
-					 handle_level_irq);
-
-	setup_irq(TX4927_IRQ_NEST_PIC_ON_CP0, &tx4927_irq_pic_action);
-
-	TX4927_WR(0xff1ff640, 0x6);	/* irq level mask -- only accept hightest */
-	TX4927_WR(0xff1ff600, TX4927_RD(0xff1ff600) | 0x1);	/* irq enable */
-}
-
-static void tx4927_irq_pic_enable(unsigned int irq)
-{
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_ENABLE, "irq=%d\n", irq);
-
-	tx4927_irq_pic_modify(tx4927_irq_pic_addr(irq), 0,
-			      tx4927_irq_pic_mask(irq));
-}
-
-static void tx4927_irq_pic_disable(unsigned int irq)
-{
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_PIC_DISABLE, "irq=%d\n", irq);
-
-	tx4927_irq_pic_modify(tx4927_irq_pic_addr(irq),
-			      tx4927_irq_pic_mask(irq), 0);
-}
-
-/*
- * Main init functions
- */
 void __init tx4927_irq_init(void)
 {
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_INIT, "-\n");
-
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_INIT, "=Calling tx4927_irq_cp0_init()\n");
-	tx4927_irq_cp0_init();
-
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_INIT, "=Calling tx4927_irq_pic_init()\n");
-	tx4927_irq_pic_init();
-
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_INIT, "+\n");
-}
-
-static int tx4927_irq_nested(void)
-{
-	int sw_irq = 0;
-	u32 level2;
-
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_NEST1, "-\n");
-
-	level2 = TX4927_RD(0xff1ff6a0);
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_NEST2, "=level2a=0x%x\n", level2);
-
-	if ((level2 & 0x10000) == 0) {
-		level2 &= 0x1f;
-		TX4927_IRQ_DPRINTK(TX4927_IRQ_NEST3, "=level2b=0x%x\n", level2);
-
-		sw_irq = TX4927_IRQ_PIC_BEG + level2;
-		TX4927_IRQ_DPRINTK(TX4927_IRQ_NEST3, "=sw_irq=%d\n", sw_irq);
-
-		if (sw_irq == 27) {
-			TX4927_IRQ_DPRINTK(TX4927_IRQ_NEST4, "=irq-%d\n",
-					   sw_irq);
-
-#ifdef CONFIG_TOSHIBA_RBTX4927
-			{
-				sw_irq = toshiba_rbtx4927_irq_nested(sw_irq);
-			}
-#endif
-
-			TX4927_IRQ_DPRINTK(TX4927_IRQ_NEST4, "=irq+%d\n",
-					   sw_irq);
-		}
-	}
-
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_NEST2, "=sw_irq=%d\n", sw_irq);
-
-	TX4927_IRQ_DPRINTK(TX4927_IRQ_NEST1, "+\n");
-
-	return (sw_irq);
+	mips_cpu_irq_init();
+	txx9_irq_init(TX4927_IRC_REG);
+	set_irq_chained_handler(TX4927_IRQ_NEST_PIC_ON_CP0, handle_simple_irq);
 }
 
 asmlinkage void plat_irq_dispatch(void)
@@ -424,9 +46,12 @@ asmlinkage void plat_irq_dispatch(void)
 	if (pending & STATUSF_IP7)			/* cpu timer */
 		do_IRQ(TX4927_IRQ_CPU_TIMER);
 	else if (pending & STATUSF_IP2) {		/* tx4927 pic */
-		unsigned int irq = tx4927_irq_nested();
-
-		if (unlikely(irq == 0)) {
+		int irq = txx9_irq();
+#ifdef CONFIG_TOSHIBA_RBTX4927
+		if (irq == TX4927_IRQ_NEST_EXT_ON_PIC)
+			irq = toshiba_rbtx4927_irq_nested(irq);
+#endif
+		if (unlikely(irq < 0)) {
 			spurious_interrupt();
 			return;
 		}
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
index e265fcd..9607ad5 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
@@ -133,6 +133,7 @@ JP7 is not bus master -- do NOT use -- only 4 pci bus master's allowed -- SouthB
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
 #ifdef CONFIG_TOSHIBA_FPCIB0
+#include <asm/i8259.h>
 #include <asm/tx4927/smsc_fdc37m81x.h>
 #endif
 #include <asm/tx4927/toshiba_rbtx4927.h>
@@ -151,11 +152,6 @@ JP7 is not bus master -- do NOT use -- only 4 pci bus master's allowed -- SouthB
 #define TOSHIBA_RBTX4927_IRQ_IOC_ENABLE    ( 1 << 13 )
 #define TOSHIBA_RBTX4927_IRQ_IOC_DISABLE   ( 1 << 14 )
 
-#define TOSHIBA_RBTX4927_IRQ_ISA_INIT      ( 1 << 20 )
-#define TOSHIBA_RBTX4927_IRQ_ISA_ENABLE    ( 1 << 23 )
-#define TOSHIBA_RBTX4927_IRQ_ISA_DISABLE   ( 1 << 24 )
-#define TOSHIBA_RBTX4927_IRQ_ISA_MASK      ( 1 << 25 )
-
 #define TOSHIBA_RBTX4927_SETUP_ALL         0xffffffff
 #endif
 
@@ -167,10 +163,6 @@ static const u32 toshiba_rbtx4927_irq_debug_flag =
 //                                                 | TOSHIBA_RBTX4927_IRQ_IOC_INIT
 //                                                 | TOSHIBA_RBTX4927_IRQ_IOC_ENABLE
 //                                                 | TOSHIBA_RBTX4927_IRQ_IOC_DISABLE
-//                                                 | TOSHIBA_RBTX4927_IRQ_ISA_INIT
-//                                                 | TOSHIBA_RBTX4927_IRQ_ISA_ENABLE
-//                                                 | TOSHIBA_RBTX4927_IRQ_ISA_DISABLE
-//                                                 | TOSHIBA_RBTX4927_IRQ_ISA_MASK
     );
 #endif
 
@@ -196,33 +188,14 @@ static const u32 toshiba_rbtx4927_irq_debug_flag =
 #define TOSHIBA_RBTX4927_IRQ_IOC_BEG  ((TX4927_IRQ_PIC_END+1)+TOSHIBA_RBTX4927_IRQ_IOC_RAW_BEG)	/* 56 */
 #define TOSHIBA_RBTX4927_IRQ_IOC_END  ((TX4927_IRQ_PIC_END+1)+TOSHIBA_RBTX4927_IRQ_IOC_RAW_END)	/* 63 */
 
-
-#define TOSHIBA_RBTX4927_IRQ_ISA_BEG MI8259_IRQ_ISA_BEG
-#define TOSHIBA_RBTX4927_IRQ_ISA_END MI8259_IRQ_ISA_END
-#define TOSHIBA_RBTX4927_IRQ_ISA_MID ((TOSHIBA_RBTX4927_IRQ_ISA_BEG+TOSHIBA_RBTX4927_IRQ_ISA_END+1)/2)
-
-
 #define TOSHIBA_RBTX4927_IRQ_NEST_IOC_ON_PIC TX4927_IRQ_NEST_EXT_ON_PIC
 #define TOSHIBA_RBTX4927_IRQ_NEST_ISA_ON_IOC (TOSHIBA_RBTX4927_IRQ_IOC_BEG+2)
-#define TOSHIBA_RBTX4927_IRQ_NEST_ISA_ON_ISA (TOSHIBA_RBTX4927_IRQ_ISA_BEG+2)
 
 extern int tx4927_using_backplane;
 
-#ifdef CONFIG_TOSHIBA_FPCIB0
-extern void enable_8259A_irq(unsigned int irq);
-extern void disable_8259A_irq(unsigned int irq);
-extern void mask_and_ack_8259A(unsigned int irq);
-#endif
-
 static void toshiba_rbtx4927_irq_ioc_enable(unsigned int irq);
 static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq);
 
-#ifdef CONFIG_TOSHIBA_FPCIB0
-static void toshiba_rbtx4927_irq_isa_enable(unsigned int irq);
-static void toshiba_rbtx4927_irq_isa_disable(unsigned int irq);
-static void toshiba_rbtx4927_irq_isa_mask_and_ack(unsigned int irq);
-#endif
-
 #define TOSHIBA_RBTX4927_IOC_NAME "RBTX4927-IOC"
 static struct irq_chip toshiba_rbtx4927_irq_ioc_type = {
 	.name = TOSHIBA_RBTX4927_IOC_NAME,
@@ -235,18 +208,6 @@ static struct irq_chip toshiba_rbtx4927_irq_ioc_type = {
 #define TOSHIBA_RBTX4927_IOC_INTR_STAT 0xbc002006
 
 
-#ifdef CONFIG_TOSHIBA_FPCIB0
-#define TOSHIBA_RBTX4927_ISA_NAME "RBTX4927-ISA"
-static struct irq_chip toshiba_rbtx4927_irq_isa_type = {
-	.name = TOSHIBA_RBTX4927_ISA_NAME,
-	.ack = toshiba_rbtx4927_irq_isa_mask_and_ack,
-	.mask = toshiba_rbtx4927_irq_isa_disable,
-	.mask_ack = toshiba_rbtx4927_irq_isa_mask_and_ack,
-	.unmask = toshiba_rbtx4927_irq_isa_enable,
-};
-#endif
-
-
 u32 bit2num(u32 num)
 {
 	u32 i;
@@ -271,31 +232,10 @@ int toshiba_rbtx4927_irq_nested(int sw_irq)
 		}
 	}
 #ifdef CONFIG_TOSHIBA_FPCIB0
-	{
-		if (tx4927_using_backplane) {
-			u32 level4;
-			u32 level5;
-			outb(0x0A, 0x20);
-			level4 = inb(0x20) & 0xff;
-			if (level4) {
-				sw_irq =
-				    TOSHIBA_RBTX4927_IRQ_ISA_BEG +
-				    bit2num(level4);
-				if (sw_irq !=
-				    TOSHIBA_RBTX4927_IRQ_NEST_ISA_ON_ISA) {
-					goto RETURN;
-				}
-			}
-
-			outb(0x0A, 0xA0);
-			level5 = inb(0xA0) & 0xff;
-			if (level5) {
-				sw_irq =
-				    TOSHIBA_RBTX4927_IRQ_ISA_MID +
-				    bit2num(level5);
-				goto RETURN;
-			}
-		}
+	if (tx4927_using_backplane) {
+		int irq = i8259_irq();
+		if (irq >= 0)
+			sw_irq = irq;
 	}
 #endif
 
@@ -307,12 +247,6 @@ int toshiba_rbtx4927_irq_nested(int sw_irq)
 #define TOSHIBA_RBTX4927_PIC_ACTION(s) { no_action, IRQF_SHARED, CPU_MASK_NONE, s, NULL, NULL }
 static struct irqaction toshiba_rbtx4927_irq_ioc_action =
 TOSHIBA_RBTX4927_PIC_ACTION(TOSHIBA_RBTX4927_IOC_NAME);
-#ifdef CONFIG_TOSHIBA_FPCIB0
-static struct irqaction toshiba_rbtx4927_irq_isa_master =
-TOSHIBA_RBTX4927_PIC_ACTION(TOSHIBA_RBTX4927_ISA_NAME "/M");
-static struct irqaction toshiba_rbtx4927_irq_isa_slave =
-TOSHIBA_RBTX4927_PIC_ACTION(TOSHIBA_RBTX4927_ISA_NAME "/S");
-#endif
 
 
 /**********************************************************************************/
@@ -378,92 +312,6 @@ static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq)
 }
 
 
-/**********************************************************************************/
-/* Functions for isa                                                              */
-/**********************************************************************************/
-
-
-#ifdef CONFIG_TOSHIBA_FPCIB0
-static void __init toshiba_rbtx4927_irq_isa_init(void)
-{
-	int i;
-
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_ISA_INIT,
-				     "beg=%d end=%d\n",
-				     TOSHIBA_RBTX4927_IRQ_ISA_BEG,
-				     TOSHIBA_RBTX4927_IRQ_ISA_END);
-
-	for (i = TOSHIBA_RBTX4927_IRQ_ISA_BEG;
-	     i <= TOSHIBA_RBTX4927_IRQ_ISA_END; i++)
-		set_irq_chip_and_handler(i, &toshiba_rbtx4927_irq_isa_type,
-					 handle_level_irq);
-
-	setup_irq(TOSHIBA_RBTX4927_IRQ_NEST_ISA_ON_IOC,
-		  &toshiba_rbtx4927_irq_isa_master);
-	setup_irq(TOSHIBA_RBTX4927_IRQ_NEST_ISA_ON_ISA,
-		  &toshiba_rbtx4927_irq_isa_slave);
-
-	/* make sure we are looking at IRR (not ISR) */
-	outb(0x0A, 0x20);
-	outb(0x0A, 0xA0);
-}
-#endif
-
-
-#ifdef CONFIG_TOSHIBA_FPCIB0
-static void toshiba_rbtx4927_irq_isa_enable(unsigned int irq)
-{
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_ISA_ENABLE,
-				     "irq=%d\n", irq);
-
-	if (irq < TOSHIBA_RBTX4927_IRQ_ISA_BEG
-	    || irq > TOSHIBA_RBTX4927_IRQ_ISA_END) {
-		TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_EROR,
-					     "bad irq=%d\n", irq);
-		panic("\n");
-	}
-
-	enable_8259A_irq(irq);
-}
-#endif
-
-
-#ifdef CONFIG_TOSHIBA_FPCIB0
-static void toshiba_rbtx4927_irq_isa_disable(unsigned int irq)
-{
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_ISA_DISABLE,
-				     "irq=%d\n", irq);
-
-	if (irq < TOSHIBA_RBTX4927_IRQ_ISA_BEG
-	    || irq > TOSHIBA_RBTX4927_IRQ_ISA_END) {
-		TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_EROR,
-					     "bad irq=%d\n", irq);
-		panic("\n");
-	}
-
-	disable_8259A_irq(irq);
-}
-#endif
-
-
-#ifdef CONFIG_TOSHIBA_FPCIB0
-static void toshiba_rbtx4927_irq_isa_mask_and_ack(unsigned int irq)
-{
-	TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_ISA_MASK,
-				     "irq=%d\n", irq);
-
-	if (irq < TOSHIBA_RBTX4927_IRQ_ISA_BEG
-	    || irq > TOSHIBA_RBTX4927_IRQ_ISA_END) {
-		TOSHIBA_RBTX4927_IRQ_DPRINTK(TOSHIBA_RBTX4927_IRQ_EROR,
-					     "bad irq=%d\n", irq);
-		panic("\n");
-	}
-
-	mask_and_ack_8259A(irq);
-}
-#endif
-
-
 void __init arch_init_irq(void)
 {
 	extern void tx4927_irq_init(void);
@@ -471,12 +319,11 @@ void __init arch_init_irq(void)
 	tx4927_irq_init();
 	toshiba_rbtx4927_irq_ioc_init();
 #ifdef CONFIG_TOSHIBA_FPCIB0
-	{
-		if (tx4927_using_backplane) {
-			toshiba_rbtx4927_irq_isa_init();
-		}
-	}
+	if (tx4927_using_backplane)
+		init_i8259_irqs();
 #endif
+	/* Onboard 10M Ether: High Active */
+	set_irq_type(RBTX4927_RTL_8019_IRQ, IRQF_TRIGGER_HIGH);
 
 	wbflush();
 }
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
index ea5a70b..3e84237 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -151,7 +151,6 @@ unsigned long mips_memory_upper;
 static int tx4927_ccfg_toeon = 1;
 static int tx4927_pcic_trdyto = 0;	/* default: disabled */
 unsigned long tx4927_ce_base[8];
-void tx4927_pci_setup(void);
 void tx4927_reset_pci_pcic(void);
 int tx4927_pci66 = 0;		/* 0:auto */
 #endif
@@ -442,7 +441,7 @@ arch_initcall(tx4927_pcibios_init);
 extern struct resource pci_io_resource;
 extern struct resource pci_mem_resource;
 
-void tx4927_pci_setup(void)
+void __init tx4927_pci_setup(void)
 {
 	static int called = 0;
 	extern unsigned int tx4927_get_mem_size(void);
@@ -748,12 +747,6 @@ void __init toshiba_rbtx4927_setup(void)
 	}
 #endif
 
-	/* setup irq stuff */
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_SETUP,
-				       ":Setting up tx4927 pic.\n");
-	TX4927_WR(0xff1ff604, 0x00000400);	/* irq trigger */
-	TX4927_WR(0xff1ff608, 0x00000000);	/* irq trigger */
-
 	/* setup serial stuff */
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_SETUP,
 				       ":Setting up tx4927 sio.\n");
@@ -915,7 +908,7 @@ void __init toshiba_rbtx4927_setup(void)
 			req.iotype = UPIO_MEM;
 			req.membase = (char *)(0xff1ff300 + i * 0x100);
 			req.mapbase = 0xff1ff300 + i * 0x100;
-			req.irq = 32 + i;
+			req.irq = TX4927_IRQ_PIC_BEG + 8 + i;
 			req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
 			req.uartclk = 50000000;
 			early_serial_txx9_setup(&req);
diff --git a/arch/mips/tx4938/common/irq.c b/arch/mips/tx4938/common/irq.c
index 3a2dbfc..c059b89 100644
--- a/arch/mips/tx4938/common/irq.c
+++ b/arch/mips/tx4938/common/irq.c
@@ -11,284 +11,21 @@
  *
  * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
  */
-#include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
 #include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/irq.h>
-#include <asm/bitops.h>
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/irq.h>
+#include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
-#include <asm/system.h>
-#include <asm/wbflush.h>
 #include <asm/tx4938/rbtx4938.h>
 
-/**********************************************************************************/
-/* Forwad definitions for all pic's                                               */
-/**********************************************************************************/
-
-static void tx4938_irq_cp0_enable(unsigned int irq);
-static void tx4938_irq_cp0_disable(unsigned int irq);
-
-static void tx4938_irq_pic_enable(unsigned int irq);
-static void tx4938_irq_pic_disable(unsigned int irq);
-
-/**********************************************************************************/
-/* Kernel structs for all pic's                                                   */
-/**********************************************************************************/
-
-#define TX4938_CP0_NAME "TX4938-CP0"
-static struct irq_chip tx4938_irq_cp0_type = {
-	.name = TX4938_CP0_NAME,
-	.ack = tx4938_irq_cp0_disable,
-	.mask = tx4938_irq_cp0_disable,
-	.mask_ack = tx4938_irq_cp0_disable,
-	.unmask = tx4938_irq_cp0_enable,
-};
-
-#define TX4938_PIC_NAME "TX4938-PIC"
-static struct irq_chip tx4938_irq_pic_type = {
-	.name = TX4938_PIC_NAME,
-	.ack = tx4938_irq_pic_disable,
-	.mask = tx4938_irq_pic_disable,
-	.mask_ack = tx4938_irq_pic_disable,
-	.unmask = tx4938_irq_pic_enable,
-};
-
-static struct irqaction tx4938_irq_pic_action = {
-	.handler = no_action,
-	.flags = 0,
-	.mask = CPU_MASK_NONE,
-	.name = TX4938_PIC_NAME
-};
-
-/**********************************************************************************/
-/* Functions for cp0                                                              */
-/**********************************************************************************/
-
-#define tx4938_irq_cp0_mask(irq) ( 1 << ( irq-TX4938_IRQ_CP0_BEG+8 ) )
-
-static void __init
-tx4938_irq_cp0_init(void)
-{
-	int i;
-
-	for (i = TX4938_IRQ_CP0_BEG; i <= TX4938_IRQ_CP0_END; i++)
-		set_irq_chip_and_handler(i, &tx4938_irq_cp0_type,
-					 handle_level_irq);
-}
-
-static void
-tx4938_irq_cp0_enable(unsigned int irq)
-{
-	set_c0_status(tx4938_irq_cp0_mask(irq));
-}
-
-static void
-tx4938_irq_cp0_disable(unsigned int irq)
-{
-	clear_c0_status(tx4938_irq_cp0_mask(irq));
-}
-
-/**********************************************************************************/
-/* Functions for pic                                                              */
-/**********************************************************************************/
-
-u32
-tx4938_irq_pic_addr(int irq)
-{
-	/* MVMCP -- need to formulize this */
-	irq -= TX4938_IRQ_PIC_BEG;
-
-	switch (irq) {
-	case 17:
-	case 16:
-	case 1:
-	case 0:{
-			return (TX4938_MKA(TX4938_IRC_IRLVL0));
-		}
-	case 19:
-	case 18:
-	case 3:
-	case 2:{
-			return (TX4938_MKA(TX4938_IRC_IRLVL1));
-		}
-	case 21:
-	case 20:
-	case 5:
-	case 4:{
-			return (TX4938_MKA(TX4938_IRC_IRLVL2));
-		}
-	case 23:
-	case 22:
-	case 7:
-	case 6:{
-			return (TX4938_MKA(TX4938_IRC_IRLVL3));
-		}
-	case 25:
-	case 24:
-	case 9:
-	case 8:{
-			return (TX4938_MKA(TX4938_IRC_IRLVL4));
-		}
-	case 27:
-	case 26:
-	case 11:
-	case 10:{
-			return (TX4938_MKA(TX4938_IRC_IRLVL5));
-		}
-	case 29:
-	case 28:
-	case 13:
-	case 12:{
-			return (TX4938_MKA(TX4938_IRC_IRLVL6));
-		}
-	case 31:
-	case 30:
-	case 15:
-	case 14:{
-			return (TX4938_MKA(TX4938_IRC_IRLVL7));
-		}
-	}
-
-	return 0;
-}
-
-u32
-tx4938_irq_pic_mask(int irq)
-{
-	/* MVMCP -- need to formulize this */
-	irq -= TX4938_IRQ_PIC_BEG;
-
-	switch (irq) {
-	case 31:
-	case 29:
-	case 27:
-	case 25:
-	case 23:
-	case 21:
-	case 19:
-	case 17:{
-			return (0x07000000);
-		}
-	case 30:
-	case 28:
-	case 26:
-	case 24:
-	case 22:
-	case 20:
-	case 18:
-	case 16:{
-			return (0x00070000);
-		}
-	case 15:
-	case 13:
-	case 11:
-	case 9:
-	case 7:
-	case 5:
-	case 3:
-	case 1:{
-			return (0x00000700);
-		}
-	case 14:
-	case 12:
-	case 10:
-	case 8:
-	case 6:
-	case 4:
-	case 2:
-	case 0:{
-			return (0x00000007);
-		}
-	}
-	return 0x00000000;
-}
-
-static void
-tx4938_irq_pic_modify(unsigned pic_reg, unsigned clr_bits, unsigned set_bits)
-{
-	unsigned long val = 0;
-
-	val = TX4938_RD(pic_reg);
-	val &= (~clr_bits);
-	val |= (set_bits);
-	TX4938_WR(pic_reg, val);
-	mmiowb();
-	TX4938_RD(pic_reg);
-}
-
-static void __init
-tx4938_irq_pic_init(void)
-{
-	int i;
-
-	for (i = TX4938_IRQ_PIC_BEG; i <= TX4938_IRQ_PIC_END; i++)
-		set_irq_chip_and_handler(i, &tx4938_irq_pic_type,
-					 handle_level_irq);
-
-	setup_irq(TX4938_IRQ_NEST_PIC_ON_CP0, &tx4938_irq_pic_action);
-
-	TX4938_WR(0xff1ff640, 0x6);	/* irq level mask -- only accept hightest */
-	TX4938_WR(0xff1ff600, TX4938_RD(0xff1ff600) | 0x1);	/* irq enable */
-}
-
-static void
-tx4938_irq_pic_enable(unsigned int irq)
-{
-	tx4938_irq_pic_modify(tx4938_irq_pic_addr(irq), 0,
-			      tx4938_irq_pic_mask(irq));
-}
-
-static void
-tx4938_irq_pic_disable(unsigned int irq)
-{
-	tx4938_irq_pic_modify(tx4938_irq_pic_addr(irq),
-			      tx4938_irq_pic_mask(irq), 0);
-}
-
-/**********************************************************************************/
-/* Main init functions                                                            */
-/**********************************************************************************/
-
 void __init
 tx4938_irq_init(void)
 {
-	tx4938_irq_cp0_init();
-	tx4938_irq_pic_init();
+	mips_cpu_irq_init();
+	txx9_irq_init(TX4938_IRC_REG);
+	set_irq_chained_handler(TX4938_IRQ_NEST_PIC_ON_CP0, handle_simple_irq);
 }
 
-int
-tx4938_irq_nested(void)
-{
-	int sw_irq = 0;
-	u32 level2;
-
-	level2 = TX4938_RD(0xff1ff6a0);
-	if ((level2 & 0x10000) == 0) {
-		level2 &= 0x1f;
-		sw_irq = TX4938_IRQ_PIC_BEG + level2;
-		if (sw_irq == 26) {
-			{
-				extern int toshiba_rbtx4938_irq_nested(int sw_irq);
-				sw_irq = toshiba_rbtx4938_irq_nested(sw_irq);
-			}
-		}
-	}
-
-	wbflush();
-	return sw_irq;
-}
+int toshiba_rbtx4938_irq_nested(int irq);
 
 asmlinkage void plat_irq_dispatch(void)
 {
@@ -297,8 +34,10 @@ asmlinkage void plat_irq_dispatch(void)
 	if (pending & STATUSF_IP7)
 		do_IRQ(TX4938_IRQ_CPU_TIMER);
 	else if (pending & STATUSF_IP2) {
-		int irq = tx4938_irq_nested();
-		if (irq)
+		int irq = txx9_irq();
+		if (irq == TX4938_IRQ_PIC_BEG + TX4938_IR_INT(0))
+			irq = toshiba_rbtx4938_irq_nested(irq);
+		if (irq >= 0)
 			do_IRQ(irq);
 		else
 			spurious_interrupt();
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/irq.c b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
index 91aea7a..f001850 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/irq.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
@@ -181,7 +181,7 @@ void __init arch_init_irq(void)
 	tx4938_irq_init();
 	toshiba_rbtx4938_irq_ioc_init();
 	/* Onboard 10M Ether: High Active */
-	TX4938_WR(TX4938_MKA(TX4938_IRC_IRDM0), 0x00000040);
+	set_irq_type(RBTX4938_IRQ_ETHER, IRQF_TRIGGER_HIGH);
 
 	wbflush();
 }
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index f9ad482..57f3c70 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -773,10 +773,6 @@ void __init tx4938_board_setup(void)
 		 txboard_add_phys_region(base, size);
 	}
 
-	/* IRC */
-	/* disable interrupt control */
-	tx4938_ircptr->cer = 0;
-
 	/* TMR */
 	/* disable all timers */
 	for (i = 0; i < TX4938_NR_TMR; i++) {
@@ -875,9 +871,6 @@ void __init toshiba_rbtx4938_setup(void)
 	if (txx9_master_clock == 0)
 		txx9_master_clock = 25000000; /* 25MHz */
 	tx4938_board_setup();
-	/* setup irq stuff */
-	TX4938_WR(TX4938_MKA(TX4938_IRC_IRDM0), 0x00000000);	/* irq trigger */
-	TX4938_WR(TX4938_MKA(TX4938_IRC_IRDM1), 0x00000000);	/* irq trigger */
 	/* setup serial stuff */
 	TX4938_WR(0xff1ff314, 0x00000000);	/* h/w flow control off */
 	TX4938_WR(0xff1ff414, 0x00000000);	/* h/w flow control off */
@@ -897,7 +890,7 @@ void __init toshiba_rbtx4938_setup(void)
 			req.iotype = UPIO_MEM;
 			req.membase = (char *)(0xff1ff300 + i * 0x100);
 			req.mapbase = 0xff1ff300 + i * 0x100;
-			req.irq = 32 + i;
+			req.irq = RBTX4938_IRQ_IRC_SIO(i);
 			req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
 			req.uartclk = 50000000;
 			early_serial_txx9_setup(&req);
diff --git a/include/asm-mips/jmr3927/jmr3927.h b/include/asm-mips/jmr3927/jmr3927.h
index 958e297..b2dc35f 100644
--- a/include/asm-mips/jmr3927/jmr3927.h
+++ b/include/asm-mips/jmr3927/jmr3927.h
@@ -13,6 +13,7 @@
 #include <asm/jmr3927/tx3927.h>
 #include <asm/addrspace.h>
 #include <asm/system.h>
+#include <asm/txx9irq.h>
 
 /* CS */
 #define JMR3927_ROMCE0	0x1fc00000	/* 4M */
@@ -115,7 +116,7 @@
 #define JMR3927_NR_IRQ_IRC	16	/* On-Chip IRC */
 #define JMR3927_NR_IRQ_IOC	8	/* PCI/MODEM/INT[6:7] */
 
-#define JMR3927_IRQ_IRC	16
+#define JMR3927_IRQ_IRC	TXX9_IRQ_BASE
 #define JMR3927_IRQ_IOC	(JMR3927_IRQ_IRC + JMR3927_NR_IRQ_IRC)
 #define JMR3927_IRQ_END	(JMR3927_IRQ_IOC + JMR3927_NR_IRQ_IOC)
 
diff --git a/include/asm-mips/jmr3927/tx3927.h b/include/asm-mips/jmr3927/tx3927.h
index 0b9073b..4be2f25 100644
--- a/include/asm-mips/jmr3927/tx3927.h
+++ b/include/asm-mips/jmr3927/tx3927.h
@@ -50,21 +50,6 @@ struct tx3927_dma_reg {
 	volatile unsigned long unused0;
 };
 
-struct tx3927_irc_reg {
-	volatile unsigned long cer;
-	volatile unsigned long cr[2];
-	volatile unsigned long unused0;
-	volatile unsigned long ilr[8];
-	volatile unsigned long unused1[4];
-	volatile unsigned long imr;
-	volatile unsigned long unused2[7];
-	volatile unsigned long scr;
-	volatile unsigned long unused3[7];
-	volatile unsigned long ssr;
-	volatile unsigned long unused4[7];
-	volatile unsigned long csr;
-};
-
 #include <asm/byteorder.h>
 
 #ifdef __BIG_ENDIAN
@@ -225,26 +210,6 @@ struct tx3927_ccfg_reg {
 /*
  * IRC
  */
-#define TX3927_IR_MAX_LEVEL	7
-
-/* IRCER : Int. Control Enable */
-#define TX3927_IRCER_ICE	0x00000001
-
-/* IRCR : Int. Control */
-#define TX3927_IRCR_LOW	0x00000000
-#define TX3927_IRCR_HIGH	0x00000001
-#define TX3927_IRCR_DOWN	0x00000002
-#define TX3927_IRCR_UP	0x00000003
-
-/* IRSCR : Int. Status Control */
-#define TX3927_IRSCR_EIClrE	0x00000100
-#define TX3927_IRSCR_EIClr_MASK	0x0000000f
-
-/* IRCSR : Int. Current Status */
-#define TX3927_IRCSR_IF	0x00010000
-#define TX3927_IRCSR_ILV_MASK	0x00000700
-#define TX3927_IRCSR_IVL_MASK	0x0000001f
-
 #define TX3927_IR_INT0	0
 #define TX3927_IR_INT1	1
 #define TX3927_IR_INT2	2
@@ -347,7 +312,6 @@ struct tx3927_ccfg_reg {
 #define tx3927_sdramcptr	((struct tx3927_sdramc_reg *)TX3927_SDRAMC_REG)
 #define tx3927_romcptr		((struct tx3927_romc_reg *)TX3927_ROMC_REG)
 #define tx3927_dmaptr		((struct tx3927_dma_reg *)TX3927_DMA_REG)
-#define tx3927_ircptr		((struct tx3927_irc_reg *)TX3927_IRC_REG)
 #define tx3927_pcicptr		((struct tx3927_pcic_reg *)TX3927_PCIC_REG)
 #define tx3927_ccfgptr		((struct tx3927_ccfg_reg *)TX3927_CCFG_REG)
 #define tx3927_tmrptr(ch)	((struct txx927_tmr_reg *)TX3927_TMR_REG(ch))
diff --git a/include/asm-mips/tx4927/toshiba_rbtx4927.h b/include/asm-mips/tx4927/toshiba_rbtx4927.h
index 5dc40a8..a606495 100644
--- a/include/asm-mips/tx4927/toshiba_rbtx4927.h
+++ b/include/asm-mips/tx4927/toshiba_rbtx4927.h
@@ -50,7 +50,7 @@
 
 
 #define RBTX4927_RTL_8019_BASE (0x1c020280-TBTX4927_ISA_IO_OFFSET)
-#define RBTX4927_RTL_8019_IRQ  (29)
+#define RBTX4927_RTL_8019_IRQ  (TX4927_IRQ_PIC_BEG + 5)
 
 int toshiba_rbtx4927_irq_nested(int sw_irq);
 
diff --git a/include/asm-mips/tx4927/tx4927.h b/include/asm-mips/tx4927/tx4927.h
index de85bd2..4bd4368 100644
--- a/include/asm-mips/tx4927/tx4927.h
+++ b/include/asm-mips/tx4927/tx4927.h
@@ -28,6 +28,7 @@
 #define __ASM_TX4927_TX4927_H
 
 #include <asm/tx4927/tx4927_mips.h>
+#include <asm/txx9irq.h>
 
 /*
  This register naming came from the integrated CPU/controller name TX4927
@@ -421,32 +422,6 @@
 #define TX4927_PIO_LIMIT                0xf50f
 
 
-/* TX4927 Interrupt Controller (32-bit registers) */
-#define TX4927_IRC_BASE                 0xf510
-#define TX4927_IRC_IRFLAG0              0xf510
-#define TX4927_IRC_IRFLAG1              0xf514
-#define TX4927_IRC_IRPOL                0xf518
-#define TX4927_IRC_IRRCNT               0xf51c
-#define TX4927_IRC_IRMASKINT            0xf520
-#define TX4927_IRC_IRMASKEXT            0xf524
-#define TX4927_IRC_IRDEN                0xf600
-#define TX4927_IRC_IRDM0                0xf604
-#define TX4927_IRC_IRDM1                0xf608
-#define TX4927_IRC_IRLVL0               0xf610
-#define TX4927_IRC_IRLVL1               0xf614
-#define TX4927_IRC_IRLVL2               0xf618
-#define TX4927_IRC_IRLVL3               0xf61c
-#define TX4927_IRC_IRLVL4               0xf620
-#define TX4927_IRC_IRLVL5               0xf624
-#define TX4927_IRC_IRLVL6               0xf628
-#define TX4927_IRC_IRLVL7               0xf62c
-#define TX4927_IRC_IRMSK                0xf640
-#define TX4927_IRC_IREDC                0xf660
-#define TX4927_IRC_IRPND                0xf680
-#define TX4927_IRC_IRCS                 0xf6a0
-#define TX4927_IRC_LIMIT                0xf6ff
-
-
 /* TX4927 AC-link controller (32-bit registers) */
 #define TX4927_ACLC_BASE                0xf700
 #define TX4927_ACLC_ACCTLEN             0xf700
@@ -493,25 +468,11 @@
 #define TX4927_WR( reg, val ) TX4927_WR32( reg, val )
 
 
+#define TX4927_IRQ_CP0_BEG  MIPS_CPU_IRQ_BASE
+#define TX4927_IRQ_CP0_END  (MIPS_CPU_IRQ_BASE + 8 - 1)
 
-
-
-#define MI8259_IRQ_ISA_RAW_BEG   0    /* optional backplane i8259 */
-#define MI8259_IRQ_ISA_RAW_END  15
-#define TX4927_IRQ_CP0_RAW_BEG   0    /* tx4927 cpu built-in cp0 */
-#define TX4927_IRQ_CP0_RAW_END   7
-#define TX4927_IRQ_PIC_RAW_BEG   0    /* tx4927 cpu build-in pic */
-#define TX4927_IRQ_PIC_RAW_END  31
-
-
-#define MI8259_IRQ_ISA_BEG                          MI8259_IRQ_ISA_RAW_BEG   /*  0 */
-#define MI8259_IRQ_ISA_END                          MI8259_IRQ_ISA_RAW_END   /* 15 */
-
-#define TX4927_IRQ_CP0_BEG  ((MI8259_IRQ_ISA_END+1)+TX4927_IRQ_CP0_RAW_BEG)  /* 16 */
-#define TX4927_IRQ_CP0_END  ((MI8259_IRQ_ISA_END+1)+TX4927_IRQ_CP0_RAW_END)  /* 23 */
-
-#define TX4927_IRQ_PIC_BEG  ((TX4927_IRQ_CP0_END+1)+TX4927_IRQ_PIC_RAW_BEG)  /* 24 */
-#define TX4927_IRQ_PIC_END  ((TX4927_IRQ_CP0_END+1)+TX4927_IRQ_PIC_RAW_END)  /* 55 */
+#define TX4927_IRQ_PIC_BEG  TXX9_IRQ_BASE
+#define TX4927_IRQ_PIC_END  (TXX9_IRQ_BASE + TXx9_MAX_IR - 1)
 
 
 #define TX4927_IRQ_USER0            (TX4927_IRQ_CP0_BEG+0)
diff --git a/include/asm-mips/tx4927/tx4927_pci.h b/include/asm-mips/tx4927/tx4927_pci.h
index 66c0646..f98b2bb 100644
--- a/include/asm-mips/tx4927/tx4927_pci.h
+++ b/include/asm-mips/tx4927/tx4927_pci.h
@@ -48,7 +48,7 @@
 #define TX4927_PCI_CLK_ACK      0x04
 #define TX4927_PCI_CLK_ACE      0x02
 #define TX4927_PCI_CLK_ENDIAN   0x01
-#define TX4927_NR_IRQ_LOCAL     (8+16)
+#define TX4927_NR_IRQ_LOCAL     TX4927_IRQ_PIC_BEG
 #define TX4927_NR_IRQ_IRC       32      /* On-Chip IRC */
 
 #define TX4927_IR_PCIC  	16
@@ -99,21 +99,6 @@ struct tx4927_ccfg_reg {
         volatile unsigned long long ramp;
 };
 
-struct tx4927_irc_reg {
-        volatile unsigned long cer;
-        volatile unsigned long cr[2];
-        volatile unsigned long unused0;
-        volatile unsigned long ilr[8];
-        volatile unsigned long unused1[4];
-        volatile unsigned long imr;
-        volatile unsigned long unused2[7];
-        volatile unsigned long scr;
-        volatile unsigned long unused3[7];
-        volatile unsigned long ssr;
-        volatile unsigned long unused4[7];
-        volatile unsigned long csr;
-};
-
 struct tx4927_pcic_reg {
         volatile unsigned long pciid;
         volatile unsigned long pcistatus;
@@ -182,11 +167,6 @@ struct tx4927_pcic_reg {
 
 #endif /* _LANGUAGE_ASSEMBLY */
 
-/* IRCSR : Int. Current Status */
-#define TX4927_IRCSR_IF         0x00010000
-#define TX4927_IRCSR_ILV_MASK   0x00000700
-#define TX4927_IRCSR_IVL_MASK   0x0000001f
-
 /*
  * PCIC
  */
@@ -278,7 +258,6 @@ struct tx4927_pcic_reg {
 #define tx4927_pcicptr          ((struct tx4927_pcic_reg *)TX4927_PCIC_REG)
 #define tx4927_ccfgptr          ((struct tx4927_ccfg_reg *)TX4927_CCFG_REG)
 #define tx4927_ebuscptr         ((struct tx4927_ebusc_reg *)TX4927_EBUSC_REG)
-#define tx4927_ircptr           ((struct tx4927_irc_reg *)TX4927_IRC_REG)
 
 #endif /* _LANGUAGE_ASSEMBLY */
 
diff --git a/include/asm-mips/tx4938/rbtx4938.h b/include/asm-mips/tx4938/rbtx4938.h
index 74e7d80..b14acb5 100644
--- a/include/asm-mips/tx4938/rbtx4938.h
+++ b/include/asm-mips/tx4938/rbtx4938.h
@@ -14,6 +14,7 @@
 
 #include <asm/addrspace.h>
 #include <asm/tx4938/tx4938.h>
+#include <asm/txx9irq.h>
 
 /* CS */
 #define RBTX4938_CE0	0x1c000000	/* 64M */
@@ -123,21 +124,11 @@
 #define RBTX4938_NR_IRQ_IRC	32	/* On-Chip IRC */
 #define RBTX4938_NR_IRQ_IOC	8
 
-#define MI8259_IRQ_ISA_RAW_BEG   0	/* optional backplane i8259 */
-#define MI8259_IRQ_ISA_RAW_END  15
-#define TX4938_IRQ_CP0_RAW_BEG   0	/* tx4938 cpu built-in cp0 */
-#define TX4938_IRQ_CP0_RAW_END   7
-#define TX4938_IRQ_PIC_RAW_BEG   0	/* tx4938 cpu build-in pic */
-#define TX4938_IRQ_PIC_RAW_END  31
+#define TX4938_IRQ_CP0_BEG  MIPS_CPU_IRQ_BASE
+#define TX4938_IRQ_CP0_END  (MIPS_CPU_IRQ_BASE + 8 - 1)
 
-#define MI8259_IRQ_ISA_BEG                          MI8259_IRQ_ISA_RAW_BEG	/*  0 */
-#define MI8259_IRQ_ISA_END                          MI8259_IRQ_ISA_RAW_END	/* 15 */
-
-#define TX4938_IRQ_CP0_BEG  ((MI8259_IRQ_ISA_END+1)+TX4938_IRQ_CP0_RAW_BEG)	/* 16 */
-#define TX4938_IRQ_CP0_END  ((MI8259_IRQ_ISA_END+1)+TX4938_IRQ_CP0_RAW_END)	/* 23 */
-
-#define TX4938_IRQ_PIC_BEG  ((TX4938_IRQ_CP0_END+1)+TX4938_IRQ_PIC_RAW_BEG)	/* 24 */
-#define TX4938_IRQ_PIC_END  ((TX4938_IRQ_CP0_END+1)+TX4938_IRQ_PIC_RAW_END)	/* 55 */
+#define TX4938_IRQ_PIC_BEG  TXX9_IRQ_BASE
+#define TX4938_IRQ_PIC_END  (TXX9_IRQ_BASE + TXx9_MAX_IR - 1)
 #define TX4938_IRQ_NEST_EXT_ON_PIC  (TX4938_IRQ_PIC_BEG+2)
 #define TX4938_IRQ_NEST_PIC_ON_CP0  (TX4938_IRQ_CP0_BEG+2)
 #define TX4938_IRQ_USER0            (TX4938_IRQ_CP0_BEG+0)
@@ -192,10 +183,4 @@
 #define RBTX4938_RTL_8019_BASE (RBTX4938_ETHER_ADDR - mips_io_port_base)
 #define RBTX4938_RTL_8019_IRQ  (RBTX4938_IRQ_ETHER)
 
-/* IRCR : Int. Control */
-#define TX4938_IRCR_LOW  0x00000000
-#define TX4938_IRCR_HIGH 0x00000001
-#define TX4938_IRCR_DOWN 0x00000002
-#define TX4938_IRCR_UP   0x00000003
-
 #endif /* __ASM_TX_BOARDS_RBTX4938_H */
diff --git a/include/asm-mips/tx4938/tx4938.h b/include/asm-mips/tx4938/tx4938.h
index e25b1a0..afdb198 100644
--- a/include/asm-mips/tx4938/tx4938.h
+++ b/include/asm-mips/tx4938/tx4938.h
@@ -272,20 +272,6 @@ struct tx4938_pio_reg {
 	volatile unsigned long maskcpu;
 	volatile unsigned long maskext;
 };
-struct tx4938_irc_reg {
-	volatile unsigned long cer;
-	volatile unsigned long cr[2];
-	volatile unsigned long unused0;
-	volatile unsigned long ilr[8];
-	volatile unsigned long unused1[4];
-	volatile unsigned long imr;
-	volatile unsigned long unused2[7];
-	volatile unsigned long scr;
-	volatile unsigned long unused3[7];
-	volatile unsigned long ssr;
-	volatile unsigned long unused4[7];
-	volatile unsigned long csr;
-};
 
 struct tx4938_ndfmc_reg {
 	endian_def_l2(unused0, dtr);
@@ -646,39 +632,12 @@ struct tx4938_ccfg_reg {
 #define TX4938_DMA_CSR_DESERR	0x00000002
 #define TX4938_DMA_CSR_SORERR	0x00000001
 
-/* TX4938 Interrupt Controller (32-bit registers) */
-#define TX4938_IRC_BASE                 0xf510
-#define TX4938_IRC_IRFLAG0              0xf510
-#define TX4938_IRC_IRFLAG1              0xf514
-#define TX4938_IRC_IRPOL                0xf518
-#define TX4938_IRC_IRRCNT               0xf51c
-#define TX4938_IRC_IRMASKINT            0xf520
-#define TX4938_IRC_IRMASKEXT            0xf524
-#define TX4938_IRC_IRDEN                0xf600
-#define TX4938_IRC_IRDM0                0xf604
-#define TX4938_IRC_IRDM1                0xf608
-#define TX4938_IRC_IRLVL0               0xf610
-#define TX4938_IRC_IRLVL1               0xf614
-#define TX4938_IRC_IRLVL2               0xf618
-#define TX4938_IRC_IRLVL3               0xf61c
-#define TX4938_IRC_IRLVL4               0xf620
-#define TX4938_IRC_IRLVL5               0xf624
-#define TX4938_IRC_IRLVL6               0xf628
-#define TX4938_IRC_IRLVL7               0xf62c
-#define TX4938_IRC_IRMSK                0xf640
-#define TX4938_IRC_IREDC                0xf660
-#define TX4938_IRC_IRPND                0xf680
-#define TX4938_IRC_IRCS                 0xf6a0
-#define TX4938_IRC_LIMIT                0xf6ff
-
-
 #ifndef __ASSEMBLY__
 
 #define tx4938_sdramcptr	((struct tx4938_sdramc_reg *)TX4938_SDRAMC_REG)
 #define tx4938_ebuscptr         ((struct tx4938_ebusc_reg *)TX4938_EBUSC_REG)
 #define tx4938_dmaptr(ch)	((struct tx4938_dma_reg *)TX4938_DMA_REG(ch))
 #define tx4938_ndfmcptr		((struct tx4938_ndfmc_reg *)TX4938_NDFMC_REG)
-#define tx4938_ircptr		((struct tx4938_irc_reg *)TX4938_IRC_REG)
 #define tx4938_pcicptr		((struct tx4938_pcic_reg *)TX4938_PCIC_REG)
 #define tx4938_pcic1ptr		((struct tx4938_pcic_reg *)TX4938_PCIC1_REG)
 #define tx4938_ccfgptr		((struct tx4938_ccfg_reg *)TX4938_CCFG_REG)
