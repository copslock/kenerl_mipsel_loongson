Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 14:59:50 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:36855 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20031898AbYGYN7r (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Jul 2008 14:59:47 +0100
Received: from localhost (p3225-ipad203funabasi.chiba.ocn.ne.jp [222.146.82.225])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F042CADE0; Fri, 25 Jul 2008 22:59:39 +0900 (JST)
Date:	Fri, 25 Jul 2008 23:01:35 +0900 (JST)
Message-Id: <20080725.230135.59464757.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH 05/10] txx9: PCI error handling
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1216826721-28259-5-git-send-email-anemo@mba.ocn.ne.jp>
References: <1216826721-28259-5-git-send-email-anemo@mba.ocn.ne.jp>
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
X-archive-position: 19955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 24 Jul 2008 00:25:16 +0900, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Add more control and detailed report on PCI error interrupt.

Revised.  Get rid of a warning on 64-bit build.  Other patches can
still be used as is.

-----------------------------------------------------------------
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Date: Thu, 24 Jul 2008 00:25:16 +0900
Subject: [PATCH] txx9: PCI error handling

Add more control and detailed report on PCI error interrupt.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/pci/ops-tx3927.c         |   34 +++++++++++++++++++
 arch/mips/pci/ops-tx4927.c         |   62 ++++++++++++++++++++++++++++++++++++
 arch/mips/pci/pci-tx4927.c         |   10 ++++++
 arch/mips/pci/pci-tx4938.c         |   10 ++++++
 arch/mips/txx9/jmr3927/irq.c       |   20 -----------
 arch/mips/txx9/jmr3927/setup.c     |    1 +
 arch/mips/txx9/rbtx4927/setup.c    |    2 +
 arch/mips/txx9/rbtx4938/setup.c    |    1 +
 include/asm-mips/txx9/tx3927.h     |    7 ++++
 include/asm-mips/txx9/tx4927.h     |    1 +
 include/asm-mips/txx9/tx4927pcic.h |    3 ++
 include/asm-mips/txx9/tx4938.h     |    1 +
 12 files changed, 132 insertions(+), 20 deletions(-)

diff --git a/arch/mips/pci/ops-tx3927.c b/arch/mips/pci/ops-tx3927.c
index c6bd79e..31c1501 100644
--- a/arch/mips/pci/ops-tx3927.c
+++ b/arch/mips/pci/ops-tx3927.c
@@ -37,8 +37,11 @@
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 
 #include <asm/addrspace.h>
+#include <asm/txx9irq.h>
+#include <asm/txx9/pci.h>
 #include <asm/txx9/tx3927.h>
 
 static int mkaddr(struct pci_bus *bus, unsigned char devfn, unsigned char where)
@@ -194,3 +197,34 @@ void __init tx3927_pcic_setup(struct pci_controller *channel,
 		PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
 	local_irq_restore(flags);
 }
+
+static irqreturn_t tx3927_pcierr_interrupt(int irq, void *dev_id)
+{
+	struct pt_regs *regs = get_irq_regs();
+
+	if (txx9_pci_err_action != TXX9_PCI_ERR_IGNORE) {
+		printk(KERN_WARNING "PCI error interrupt at 0x%08lx.\n",
+		       regs->cp0_epc);
+		printk(KERN_WARNING "pcistat:%02x, lbstat:%04lx\n",
+		       tx3927_pcicptr->pcistat, tx3927_pcicptr->lbstat);
+	}
+	if (txx9_pci_err_action != TXX9_PCI_ERR_PANIC) {
+		/* clear all pci errors */
+		tx3927_pcicptr->pcistat |= TX3927_PCIC_PCISTATIM_ALL;
+		tx3927_pcicptr->istat = TX3927_PCIC_IIM_ALL;
+		tx3927_pcicptr->tstat = TX3927_PCIC_TIM_ALL;
+		tx3927_pcicptr->lbstat = TX3927_PCIC_LBIM_ALL;
+		return IRQ_HANDLED;
+	}
+	console_verbose();
+	panic("PCI error.");
+}
+
+void __init tx3927_setup_pcierr_irq(void)
+{
+	if (request_irq(TXX9_IRQ_BASE + TX3927_IR_PCI,
+			tx3927_pcierr_interrupt,
+			IRQF_DISABLED, "PCI error",
+			(void *)TX3927_PCIC_REG))
+		printk(KERN_WARNING "Failed to request irq for PCIERR\n");
+}
diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
index 038e311..5989e74 100644
--- a/arch/mips/pci/ops-tx4927.c
+++ b/arch/mips/pci/ops-tx4927.c
@@ -16,6 +16,8 @@
  * option) any later version.
  */
 #include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <asm/txx9/pci.h>
 #include <asm/txx9/tx4927pcic.h>
 
 static struct {
@@ -431,6 +433,66 @@ void tx4927_report_pcic_status(void)
 	}
 }
 
+static void tx4927_dump_pcic_settings1(struct tx4927_pcic_reg __iomem *pcicptr)
+{
+	int i;
+	__u32 __iomem *preg = (__u32 __iomem *)pcicptr;
+
+	printk(KERN_INFO "tx4927 pcic (0x%p) settings:", pcicptr);
+	for (i = 0; i < sizeof(struct tx4927_pcic_reg); i += 4, preg++) {
+		if (i % 32 == 0) {
+			printk(KERN_CONT "\n");
+			printk(KERN_INFO "%04x:", i);
+		}
+		/* skip registers with side-effects */
+		if (i == offsetof(struct tx4927_pcic_reg, g2pintack)
+		    || i == offsetof(struct tx4927_pcic_reg, g2pspc)
+		    || i == offsetof(struct tx4927_pcic_reg, g2pcfgadrs)
+		    || i == offsetof(struct tx4927_pcic_reg, g2pcfgdata)) {
+			printk(KERN_CONT " XXXXXXXX");
+			continue;
+		}
+		printk(KERN_CONT " %08x", __raw_readl(preg));
+	}
+	printk(KERN_CONT "\n");
+}
+
+void tx4927_dump_pcic_settings(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pcicptrs); i++) {
+		if (pcicptrs[i].pcicptr)
+			tx4927_dump_pcic_settings1(pcicptrs[i].pcicptr);
+	}
+}
+
+irqreturn_t tx4927_pcierr_interrupt(int irq, void *dev_id)
+{
+	struct pt_regs *regs = get_irq_regs();
+	struct tx4927_pcic_reg __iomem *pcicptr =
+		(struct tx4927_pcic_reg __iomem *)(unsigned long)dev_id;
+
+	if (txx9_pci_err_action != TXX9_PCI_ERR_IGNORE) {
+		printk(KERN_WARNING "PCIERR interrupt at 0x%0*lx\n",
+		       (int)(2 * sizeof(unsigned long)), regs->cp0_epc);
+		tx4927_report_pcic_status1(pcicptr);
+	}
+	if (txx9_pci_err_action != TXX9_PCI_ERR_PANIC) {
+		/* clear all pci errors */
+		__raw_writel((__raw_readl(&pcicptr->pcistatus) & 0x0000ffff)
+			     | (TX4927_PCIC_PCISTATUS_ALL << 16),
+			     &pcicptr->pcistatus);
+		__raw_writel(TX4927_PCIC_G2PSTATUS_ALL, &pcicptr->g2pstatus);
+		__raw_writel(TX4927_PCIC_PBASTATUS_ALL, &pcicptr->pbastatus);
+		__raw_writel(TX4927_PCIC_PCICSTATUS_ALL, &pcicptr->pcicstatus);
+		return IRQ_HANDLED;
+	}
+	console_verbose();
+	tx4927_dump_pcic_settings1(pcicptr);
+	panic("PCI error.");
+}
+
 #ifdef CONFIG_TOSHIBA_FPCIB0
 static void __init tx4927_quirk_slc90e66_bridge(struct pci_dev *dev)
 {
diff --git a/arch/mips/pci/pci-tx4927.c b/arch/mips/pci/pci-tx4927.c
index 27e86a0..aaa9005 100644
--- a/arch/mips/pci/pci-tx4927.c
+++ b/arch/mips/pci/pci-tx4927.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
+#include <linux/interrupt.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/tx4927.h>
 
@@ -81,3 +82,12 @@ int __init tx4927_pciclk66_setup(void)
 		pciclk = -1;
 	return pciclk;
 }
+
+void __init tx4927_setup_pcierr_irq(void)
+{
+	if (request_irq(TXX9_IRQ_BASE + TX4927_IR_PCIERR,
+			tx4927_pcierr_interrupt,
+			IRQF_DISABLED, "PCI error",
+			(void *)TX4927_PCIC_REG))
+		printk(KERN_WARNING "Failed to request irq for PCIERR\n");
+}
diff --git a/arch/mips/pci/pci-tx4938.c b/arch/mips/pci/pci-tx4938.c
index e537551..60e2c52 100644
--- a/arch/mips/pci/pci-tx4938.c
+++ b/arch/mips/pci/pci-tx4938.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
+#include <linux/interrupt.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/tx4938.h>
 
@@ -132,3 +133,12 @@ int tx4938_pcic1_map_irq(const struct pci_dev *dev, u8 slot)
 	}
 	return -1;
 }
+
+void __init tx4938_setup_pcierr_irq(void)
+{
+	if (request_irq(TXX9_IRQ_BASE + TX4938_IR_PCIERR,
+			tx4927_pcierr_interrupt,
+			IRQF_DISABLED, "PCI error",
+			(void *)TX4927_PCIC_REG))
+		printk(KERN_WARNING "Failed to request irq for PCIERR\n");
+}
diff --git a/arch/mips/txx9/jmr3927/irq.c b/arch/mips/txx9/jmr3927/irq.c
index 070c9a1..f3b6023 100644
--- a/arch/mips/txx9/jmr3927/irq.c
+++ b/arch/mips/txx9/jmr3927/irq.c
@@ -103,22 +103,6 @@ static int jmr3927_irq_dispatch(int pending)
 	return irq;
 }
 
-#ifdef CONFIG_PCI
-static irqreturn_t jmr3927_pcierr_interrupt(int irq, void *dev_id)
-{
-	printk(KERN_WARNING "PCI error interrupt (irq 0x%x).\n", irq);
-	printk(KERN_WARNING "pcistat:%02x, lbstat:%04lx\n",
-	       tx3927_pcicptr->pcistat, tx3927_pcicptr->lbstat);
-
-	return IRQ_HANDLED;
-}
-static struct irqaction pcierr_action = {
-	.handler = jmr3927_pcierr_interrupt,
-	.mask = CPU_MASK_NONE,
-	.name = "PCI error",
-};
-#endif
-
 static void __init jmr3927_irq_init(void);
 
 void __init jmr3927_irq_setup(void)
@@ -143,10 +127,6 @@ void __init jmr3927_irq_setup(void)
 	/* setup IOC interrupt 1 (PCI, MODEM) */
 	set_irq_chained_handler(JMR3927_IRQ_IOCINT, handle_simple_irq);
 
-#ifdef CONFIG_PCI
-	setup_irq(JMR3927_IRQ_IRC_PCI, &pcierr_action);
-#endif
-
 	/* enable all CPU interrupt bits. */
 	set_c0_status(ST0_IM);	/* IE bit is still 0. */
 }
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index 57dc91e..7c16c40 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -199,6 +199,7 @@ static void __init jmr3927_pci_setup(void)
 		jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
 	}
 	tx3927_pcic_setup(c, JMR3927_SDRAM_SIZE, extarb);
+	tx3927_setup_pcierr_irq();
 #endif /* CONFIG_PCI */
 }
 
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index 88c05cc..65b7224 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -103,6 +103,7 @@ static void __init tx4927_pci_setup(void)
 		tx4927_report_pciclk();
 		tx4927_pcic_setup(tx4927_pcicptr, c, extarb);
 	}
+	tx4927_setup_pcierr_irq();
 }
 
 static void __init tx4937_pci_setup(void)
@@ -149,6 +150,7 @@ static void __init tx4937_pci_setup(void)
 		tx4938_report_pciclk();
 		tx4927_pcic_setup(tx4938_pcicptr, c, extarb);
 	}
+	tx4938_setup_pcierr_irq();
 }
 
 static void __init rbtx4927_arch_init(void)
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index fc9034d..4454b79 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -121,6 +121,7 @@ static void __init rbtx4938_pci_setup(void)
 		register_pci_controller(c);
 		tx4927_pcic_setup(tx4938_pcic1ptr, c, 0);
 	}
+	tx4938_setup_pcierr_irq();
 #endif /* CONFIG_PCI */
 }
 
diff --git a/include/asm-mips/txx9/tx3927.h b/include/asm-mips/txx9/tx3927.h
index ea79e1b..8d62b1b 100644
--- a/include/asm-mips/txx9/tx3927.h
+++ b/include/asm-mips/txx9/tx3927.h
@@ -236,11 +236,17 @@ struct tx3927_ccfg_reg {
 /* see PCI_STATUS_XXX in linux/pci.h */
 #define PCI_STATUS_NEW_CAP	0x0010
 
+/* bits for ISTAT/IIM */
+#define TX3927_PCIC_IIM_ALL	0x00001600
+
 /* bits for TC */
 #define TX3927_PCIC_TC_OF16E	0x00000020
 #define TX3927_PCIC_TC_IF8E	0x00000010
 #define TX3927_PCIC_TC_OF8E	0x00000008
 
+/* bits for TSTAT/TIM */
+#define TX3927_PCIC_TIM_ALL	0x0003ffff
+
 /* bits for IOBA/MBA */
 /* see PCI_BASE_ADDRESS_XXX in linux/pci.h */
 
@@ -320,5 +326,6 @@ struct tx3927_ccfg_reg {
 struct pci_controller;
 void __init tx3927_pcic_setup(struct pci_controller *channel,
 			      unsigned long sdram_size, int extarb);
+void tx3927_setup_pcierr_irq(void);
 
 #endif /* __ASM_TXX9_TX3927_H */
diff --git a/include/asm-mips/txx9/tx4927.h b/include/asm-mips/txx9/tx4927.h
index ceb4b79..2c26fd1 100644
--- a/include/asm-mips/txx9/tx4927.h
+++ b/include/asm-mips/txx9/tx4927.h
@@ -249,6 +249,7 @@ void tx4927_time_init(unsigned int tmrnr);
 void tx4927_setup_serial(void);
 int tx4927_report_pciclk(void);
 int tx4927_pciclk66_setup(void);
+void tx4927_setup_pcierr_irq(void);
 void tx4927_irq_init(void);
 
 #endif /* __ASM_TXX9_TX4927_H */
diff --git a/include/asm-mips/txx9/tx4927pcic.h b/include/asm-mips/txx9/tx4927pcic.h
index e1d78e9..223841c 100644
--- a/include/asm-mips/txx9/tx4927pcic.h
+++ b/include/asm-mips/txx9/tx4927pcic.h
@@ -10,6 +10,7 @@
 #define __ASM_TXX9_TX4927PCIC_H
 
 #include <linux/pci.h>
+#include <linux/irqreturn.h>
 
 struct tx4927_pcic_reg {
 	u32 pciid;
@@ -196,5 +197,7 @@ void __init tx4927_pcic_setup(struct tx4927_pcic_reg __iomem *pcicptr,
 			      struct pci_controller *channel, int extarb);
 void tx4927_report_pcic_status(void);
 char *tx4927_pcibios_setup(char *str);
+void tx4927_dump_pcic_settings(void);
+irqreturn_t tx4927_pcierr_interrupt(int irq, void *dev_id);
 
 #endif /* __ASM_TXX9_TX4927PCIC_H */
diff --git a/include/asm-mips/txx9/tx4938.h b/include/asm-mips/txx9/tx4938.h
index 1ed969d..4fff1c9 100644
--- a/include/asm-mips/txx9/tx4938.h
+++ b/include/asm-mips/txx9/tx4938.h
@@ -285,6 +285,7 @@ void tx4938_report_pci1clk(void);
 int tx4938_pciclk66_setup(void);
 struct pci_dev;
 int tx4938_pcic1_map_irq(const struct pci_dev *dev, u8 slot);
+void tx4938_setup_pcierr_irq(void);
 void tx4938_irq_init(void);
 
 #endif
-- 
1.5.5.5
