Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 16:24:16 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:44264 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28577883AbYGWPXe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2008 16:23:34 +0100
Received: from localhost.localdomain (p3049-ipad205funabasi.chiba.ocn.ne.jp [222.146.98.49])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A75BD8929; Thu, 24 Jul 2008 00:23:28 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 04/10] txx9: Add some pci options
Date:	Thu, 24 Jul 2008 00:25:15 +0900
Message-Id: <1216826721-28259-4-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.5.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add pci options for backplane type, clock selection, error handling,
timeout values.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/pci/ops-tx4927.c         |   22 ++++++++++++++++++++++
 arch/mips/txx9/generic/pci.c       |   36 ++++++++++++++++++++++++++++++++++++
 arch/mips/txx9/generic/setup.c     |    4 ++++
 arch/mips/txx9/rbtx4927/setup.c    |    1 +
 arch/mips/txx9/rbtx4938/setup.c    |    1 +
 include/asm-mips/txx9/pci.h        |    3 +++
 include/asm-mips/txx9/tx4927pcic.h |    1 +
 7 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
index 6d84409..038e311 100644
--- a/arch/mips/pci/ops-tx4927.c
+++ b/arch/mips/pci/ops-tx4927.c
@@ -194,6 +194,28 @@ static struct {
 	.gbwc = 0xfe0,	/* 4064 GBUSCLK for CCFG.GTOT=0b11 */
 };
 
+char *__devinit tx4927_pcibios_setup(char *str)
+{
+	unsigned long val;
+
+	if (!strncmp(str, "trdyto=", 7)) {
+		if (strict_strtoul(str + 7, 0, &val) == 0)
+			tx4927_pci_opts.trdyto = val;
+		return NULL;
+	}
+	if (!strncmp(str, "retryto=", 8)) {
+		if (strict_strtoul(str + 8, 0, &val) == 0)
+			tx4927_pci_opts.retryto = val;
+		return NULL;
+	}
+	if (!strncmp(str, "gbwc=", 5)) {
+		if (strict_strtoul(str + 5, 0, &val) == 0)
+			tx4927_pci_opts.gbwc = val;
+		return NULL;
+	}
+	return str;
+}
+
 void __init tx4927_pcic_setup(struct tx4927_pcic_reg __iomem *pcicptr,
 			      struct pci_controller *channel, int extarb)
 {
diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index 0b92d8c..7b637a7 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -386,3 +386,39 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return txx9_board_vec->pci_map_irq(dev, slot, pin);
 }
+
+char * (*txx9_board_pcibios_setup)(char *str) __devinitdata;
+
+char *__devinit txx9_pcibios_setup(char *str)
+{
+	if (txx9_board_pcibios_setup && !txx9_board_pcibios_setup(str))
+		return NULL;
+	if (!strcmp(str, "picmg")) {
+		/* PICMG compliant backplane (TOSHIBA JMB-PICMG-ATX
+		   (5V or 3.3V), JMB-PICMG-L2 (5V only), etc.) */
+		txx9_pci_option |= TXX9_PCI_OPT_PICMG;
+		return NULL;
+	} else if (!strcmp(str, "nopicmg")) {
+		/* non-PICMG compliant backplane (TOSHIBA
+		   RBHBK4100,RBHBK4200, Interface PCM-PCM05, etc.) */
+		txx9_pci_option &= ~TXX9_PCI_OPT_PICMG;
+		return NULL;
+	} else if (!strncmp(str, "clk=", 4)) {
+		char *val = str + 4;
+		txx9_pci_option &= ~TXX9_PCI_OPT_CLK_MASK;
+		if (strcmp(val, "33") == 0)
+			txx9_pci_option |= TXX9_PCI_OPT_CLK_33;
+		else if (strcmp(val, "66") == 0)
+			txx9_pci_option |= TXX9_PCI_OPT_CLK_66;
+		else /* "auto" */
+			txx9_pci_option |= TXX9_PCI_OPT_CLK_AUTO;
+		return NULL;
+	} else if (!strncmp(str, "err=", 4)) {
+		if (!strcmp(str + 4, "panic"))
+			txx9_pci_err_action = TXX9_PCI_ERR_PANIC;
+		else if (!strcmp(str + 4, "ignore"))
+			txx9_pci_err_action = TXX9_PCI_ERR_IGNORE;
+		return NULL;
+	}
+	return str;
+}
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 8c60c78..4fbd7ba 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -23,6 +23,7 @@
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 #include <asm/txx9/generic.h>
+#include <asm/txx9/pci.h>
 #ifdef CONFIG_CPU_TX49XX
 #include <asm/txx9/tx4938.h>
 #endif
@@ -194,6 +195,9 @@ void __init plat_mem_setup(void)
 	ioport_resource.end = ~0UL;	/* no limit */
 	iomem_resource.start = 0;
 	iomem_resource.end = ~0UL;	/* no limit */
+#ifdef CONFIG_PCI
+	pcibios_plat_setup = txx9_pcibios_setup;
+#endif
 	txx9_board_vec->mem_setup();
 }
 
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index 3da20ea..88c05cc 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -238,6 +238,7 @@ static void __init rbtx4927_mem_setup(void)
 	txx9_alloc_pci_controller(&txx9_primary_pcic,
 				  RBTX4927_PCIMEM, RBTX4927_PCIMEM_SIZE,
 				  RBTX4927_PCIIO, RBTX4927_PCIIO_SIZE);
+	txx9_board_pcibios_setup = tx4927_pcibios_setup;
 #else
 	set_io_port_base(KSEG1 + RBTX4927_ISA_IO_OFFSET);
 #endif
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index 6c2b99b..fc9034d 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -193,6 +193,7 @@ static void __init rbtx4938_mem_setup(void)
 
 #ifdef CONFIG_PCI
 	txx9_alloc_pci_controller(&txx9_primary_pcic, 0, 0, 0, 0);
+	txx9_board_pcibios_setup = tx4927_pcibios_setup;
 #else
 	set_io_port_base(RBTX4938_ETHER_BASE);
 #endif
diff --git a/include/asm-mips/txx9/pci.h b/include/asm-mips/txx9/pci.h
index d89a450..3d32529 100644
--- a/include/asm-mips/txx9/pci.h
+++ b/include/asm-mips/txx9/pci.h
@@ -33,4 +33,7 @@ enum txx9_pci_err_action {
 };
 extern enum txx9_pci_err_action txx9_pci_err_action;
 
+extern char * (*txx9_board_pcibios_setup)(char *str);
+char *txx9_pcibios_setup(char *str);
+
 #endif /* __ASM_TXX9_PCI_H */
diff --git a/include/asm-mips/txx9/tx4927pcic.h b/include/asm-mips/txx9/tx4927pcic.h
index d61c3d0..e1d78e9 100644
--- a/include/asm-mips/txx9/tx4927pcic.h
+++ b/include/asm-mips/txx9/tx4927pcic.h
@@ -195,5 +195,6 @@ struct tx4927_pcic_reg __iomem *get_tx4927_pcicptr(
 void __init tx4927_pcic_setup(struct tx4927_pcic_reg __iomem *pcicptr,
 			      struct pci_controller *channel, int extarb);
 void tx4927_report_pcic_status(void);
+char *tx4927_pcibios_setup(char *str);
 
 #endif /* __ASM_TXX9_TX4927PCIC_H */
-- 
1.5.5.5
