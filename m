Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 15:34:54 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:4041 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022120AbXHBOeu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2007 15:34:50 +0100
Received: from localhost (p2209-ipad28funabasi.chiba.ocn.ne.jp [220.107.201.209])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9ABC5B517; Thu,  2 Aug 2007 23:34:45 +0900 (JST)
Date:	Thu, 02 Aug 2007 23:35:53 +0900 (JST)
Message-Id: <20070802.233553.126573448.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 1/5] The irq_chip for TX39/TX49 SoCs
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
X-archive-position: 16033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add generic irq_chip for TX39/TX49 SoCs.  This can be replace
jmr3927_irq_irc, tx4927_irq_pic_type and tx4938_irq_pic_type.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Kconfig           |    3 +
 arch/mips/kernel/Makefile   |    1 +
 arch/mips/kernel/irq_txx9.c |  196 +++++++++++++++++++++++++++++++++++++++++++
 include/asm-mips/txx9irq.h  |   30 +++++++
 4 files changed, 230 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2775dd6..cec0d84 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -767,6 +767,9 @@ config IRQ_MSP_SLP
 config IRQ_MSP_CIC
 	bool
 
+config IRQ_TXX9
+	bool
+
 config MIPS_BOARDS_GEN
 	bool
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 07344cb..2fd96d9 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_IRQ_CPU)		+= irq_cpu.o
 obj-$(CONFIG_IRQ_CPU_RM7K)	+= irq-rm7000.o
 obj-$(CONFIG_IRQ_CPU_RM9K)	+= irq-rm9000.o
 obj-$(CONFIG_MIPS_BOARDS_GEN)	+= irq-msc01.o
+obj-$(CONFIG_IRQ_TXX9)		+= irq_txx9.o
 
 obj-$(CONFIG_32BIT)		+= scall32-o32.o
 obj-$(CONFIG_64BIT)		+= scall64-64.o
diff --git a/arch/mips/kernel/irq_txx9.c b/arch/mips/kernel/irq_txx9.c
new file mode 100644
index 0000000..172e14b
--- /dev/null
+++ b/arch/mips/kernel/irq_txx9.c
@@ -0,0 +1,196 @@
+/*
+ * linux/arch/mips/kernel/irq_txx9.c
+ *
+ * Based on linux/arch/mips/jmr3927/rbhma3100/irq.c,
+ *          linux/arch/mips/tx4927/common/tx4927_irq.c,
+ *          linux/arch/mips/tx4938/common/irq.c
+ *
+ * Copyright 2001, 2003-2005 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc.
+ *         ahennessy@mvista.com
+ *         source@mvista.com
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <asm/txx9irq.h>
+
+struct txx9_irc_reg {
+	u32 cer;
+	u32 cr[2];
+	u32 unused0;
+	u32 ilr[8];
+	u32 unused1[4];
+	u32 imr;
+	u32 unused2[7];
+	u32 scr;
+	u32 unused3[7];
+	u32 ssr;
+	u32 unused4[7];
+	u32 csr;
+};
+
+/* IRCER : Int. Control Enable */
+#define TXx9_IRCER_ICE	0x00000001
+
+/* IRCR : Int. Control */
+#define TXx9_IRCR_LOW	0x00000000
+#define TXx9_IRCR_HIGH	0x00000001
+#define TXx9_IRCR_DOWN	0x00000002
+#define TXx9_IRCR_UP	0x00000003
+#define TXx9_IRCR_EDGE(cr)	((cr) & 0x00000002)
+
+/* IRSCR : Int. Status Control */
+#define TXx9_IRSCR_EIClrE	0x00000100
+#define TXx9_IRSCR_EIClr_MASK	0x0000000f
+
+/* IRCSR : Int. Current Status */
+#define TXx9_IRCSR_IF	0x00010000
+#define TXx9_IRCSR_ILV_MASK	0x00000700
+#define TXx9_IRCSR_IVL_MASK	0x0000001f
+
+#define irc_dlevel	0
+#define irc_elevel	1
+
+static struct txx9_irc_reg __iomem *txx9_ircptr __read_mostly;
+
+static struct {
+	unsigned char level;
+	unsigned char mode;
+} txx9irq[TXx9_MAX_IR] __read_mostly;
+
+static void txx9_irq_unmask(unsigned int irq)
+{
+	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
+	u32 __iomem *ilrp = &txx9_ircptr->ilr[(irq_nr % 16 ) / 2];
+	int ofs = irq_nr / 16 * 16 + (irq_nr & 1) * 8;
+
+	__raw_writel((__raw_readl(ilrp) & ~(0xff << ofs))
+		     | (txx9irq[irq_nr].level << ofs),
+		     ilrp);
+#ifdef CONFIG_CPU_TX39XX
+	/* update IRCSR */
+	__raw_writel(0, &txx9_ircptr->imr);
+	__raw_writel(irc_elevel, &txx9_ircptr->imr);
+#endif
+}
+
+static inline void txx9_irq_mask(unsigned int irq)
+{
+	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
+	u32 __iomem *ilrp = &txx9_ircptr->ilr[(irq_nr % 16) / 2];
+	int ofs = irq_nr / 16 * 16 + (irq_nr & 1) * 8;
+
+	__raw_writel((__raw_readl(ilrp) & ~(0xff << ofs))
+		     | (irc_dlevel << ofs),
+		     ilrp);
+#ifdef CONFIG_CPU_TX39XX
+	/* update IRCSR */
+	__raw_writel(0, &txx9_ircptr->imr);
+	__raw_writel(irc_elevel, &txx9_ircptr->imr);
+	/* flush write buffer */
+	__raw_readl(&txx9_ircptr->ssr);
+#else
+	mmiowb();
+#endif
+}
+
+static void txx9_irq_mask_ack(unsigned int irq)
+{
+	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
+
+	txx9_irq_mask(irq);
+	if (TXx9_IRCR_EDGE(txx9irq[irq_nr].mode)) {
+		/* clear edge detection */
+		u32 cr = __raw_readl(&txx9_ircptr->cr[irq_nr / 8]);
+		cr = (cr >> ((irq_nr & (8 - 1)) * 2)) & 3;
+		__raw_writel(TXx9_IRSCR_EIClrE | irq_nr,
+			     &txx9_ircptr->scr);
+	}
+}
+
+static int txx9_irq_set_type(unsigned int irq, unsigned int flow_type)
+{
+	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
+	u32 cr;
+	u32 __iomem *crp;
+	int ofs;
+	int mode;
+
+	if (flow_type & IRQF_TRIGGER_PROBE)
+		return 0;
+	switch (flow_type & IRQF_TRIGGER_MASK) {
+	case IRQF_TRIGGER_RISING:	mode = TXx9_IRCR_UP;	break;
+	case IRQF_TRIGGER_FALLING:	mode = TXx9_IRCR_DOWN;	break;
+	case IRQF_TRIGGER_HIGH:	mode = TXx9_IRCR_HIGH;	break;
+	case IRQF_TRIGGER_LOW:	mode = TXx9_IRCR_LOW;	break;
+	default:
+		return -EINVAL;
+	}
+	crp = &txx9_ircptr->cr[(unsigned int)irq_nr / 8];
+	cr = __raw_readl(crp);
+	ofs = (irq_nr & (8 - 1)) * 2;
+	cr &= ~(0x3 << ofs);
+	cr |= (mode & 0x3) << ofs;
+	__raw_writel(cr, crp);
+	txx9irq[irq_nr].mode = mode;
+	return 0;
+}
+
+static struct irq_chip txx9_irq_chip = {
+	.name		= "TXX9",
+	.ack		= txx9_irq_mask_ack,
+	.mask		= txx9_irq_mask,
+	.mask_ack	= txx9_irq_mask_ack,
+	.unmask		= txx9_irq_unmask,
+	.set_type	= txx9_irq_set_type,
+};
+
+void __init txx9_irq_init(unsigned long baseaddr)
+{
+	int i;
+
+	txx9_ircptr = ioremap(baseaddr, sizeof(struct txx9_irc_reg));
+	for (i = 0; i < TXx9_MAX_IR; i++) {
+		txx9irq[i].level = 4; /* middle level */
+		txx9irq[i].mode = TXx9_IRCR_LOW;
+		set_irq_chip_and_handler(TXX9_IRQ_BASE + i,
+					 &txx9_irq_chip, handle_level_irq);
+	}
+
+	/* mask all IRC interrupts */
+	__raw_writel(0, &txx9_ircptr->imr);
+	for (i = 0; i < 8; i++)
+		__raw_writel(0, &txx9_ircptr->ilr[i]);
+	/* setup IRC interrupt mode (Low Active) */
+	for (i = 0; i < 2; i++)
+		__raw_writel(0, &txx9_ircptr->cr[i]);
+	/* enable interrupt control */
+	__raw_writel(TXx9_IRCER_ICE, &txx9_ircptr->cer);
+	__raw_writel(irc_elevel, &txx9_ircptr->imr);
+}
+
+int __init txx9_irq_set_pri(int irc_irq, int new_pri)
+{
+	int old_pri;
+
+	if ((unsigned int)irc_irq >= TXx9_MAX_IR)
+		return 0;
+	old_pri = txx9irq[irc_irq].level;
+	txx9irq[irc_irq].level = new_pri;
+	return old_pri;
+}
+
+int txx9_irq(void)
+{
+	u32 csr = __raw_readl(&txx9_ircptr->csr);
+
+	if (likely(!(csr & TXx9_IRCSR_IF)))
+		return TXX9_IRQ_BASE + (csr & (TXx9_MAX_IR - 1));
+	return -1;
+}
diff --git a/include/asm-mips/txx9irq.h b/include/asm-mips/txx9irq.h
new file mode 100644
index 0000000..1c439e5
--- /dev/null
+++ b/include/asm-mips/txx9irq.h
@@ -0,0 +1,30 @@
+/*
+ * include/asm-mips/txx9irq.h
+ * TX39/TX49 interrupt controller definitions.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#ifndef __ASM_TXX9IRQ_H
+#define __ASM_TXX9IRQ_H
+
+#include <irq.h>
+
+#ifdef CONFIG_IRQ_CPU
+#define TXX9_IRQ_BASE	(MIPS_CPU_IRQ_BASE + 8)
+#else
+#define TXX9_IRQ_BASE	0
+#endif
+
+#ifdef CONFIG_CPU_TX39XX
+#define TXx9_MAX_IR 16
+#else
+#define TXx9_MAX_IR 32
+#endif
+
+void txx9_irq_init(unsigned long baseaddr);
+int txx9_irq(void);
+int txx9_irq_set_pri(int irc_irq, int new_pri);
+
+#endif /* __ASM_TXX9IRQ_H */
