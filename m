Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2007 16:53:59 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:15866 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023096AbXGXPx5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2007 16:53:57 +0100
Received: from localhost (p1202-ipad203funabasi.chiba.ocn.ne.jp [222.146.80.202])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6EF8FB518; Wed, 25 Jul 2007 00:52:38 +0900 (JST)
Date:	Wed, 25 Jul 2007 00:53:40 +0900 (JST)
Message-Id: <20070725.005340.125898023.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2/2] rbtx4927: fix some warnings
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
X-archive-position: 15887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This patch fixes some gcc warnings and a section mismatch.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/pci/fixup-rbtx4927.c                     |    2 +-
 .../tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c |    4 +-
 .../toshiba_rbtx4927/toshiba_rbtx4927_setup.c      |   58 ++------------------
 3 files changed, 7 insertions(+), 57 deletions(-)

diff --git a/arch/mips/pci/fixup-rbtx4927.c b/arch/mips/pci/fixup-rbtx4927.c
index 3cdbecb..7450c33 100644
--- a/arch/mips/pci/fixup-rbtx4927.c
+++ b/arch/mips/pci/fixup-rbtx4927.c
@@ -79,7 +79,7 @@ static unsigned char backplane_pci_irq[4][4] = {
 				     TX4927_IRQ_IOC_PCIC}
 };
 
-int pci_get_irq(struct pci_dev *dev, int pin)
+static int pci_get_irq(const struct pci_dev *dev, int pin)
 {
 	unsigned char irq = pin;
 
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
index 5cc30c1..e265fcd 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
@@ -262,8 +262,6 @@ u32 bit2num(u32 num)
 int toshiba_rbtx4927_irq_nested(int sw_irq)
 {
 	u32 level3;
-	u32 level4;
-	u32 level5;
 
 	level3 = reg_rd08(TOSHIBA_RBTX4927_IOC_INTR_STAT) & 0x1f;
 	if (level3) {
@@ -275,6 +273,8 @@ int toshiba_rbtx4927_irq_nested(int sw_irq)
 #ifdef CONFIG_TOSHIBA_FPCIB0
 	{
 		if (tx4927_using_backplane) {
+			u32 level4;
+			u32 level5;
 			outb(0x0A, 0x20);
 			level4 = inb(0x20) & 0xff;
 			if (level4) {
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
index ab72292..ea5a70b 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -159,58 +159,6 @@ int tx4927_pci66 = 0;		/* 0:auto */
 char *toshiba_name = "";
 
 #ifdef CONFIG_PCI
-static void tx4927_pcierr_interrupt(int irq, void *dev_id)
-{
-#ifdef CONFIG_BLK_DEV_IDEPCI
-	/* ignore MasterAbort for ide probing... */
-	if (irq == TX4927_IRQ_IRC_PCIERR &&
-	    ((tx4927_pcicptr->pcistatus >> 16) & 0xf900) ==
-	    PCI_STATUS_REC_MASTER_ABORT) {
-		tx4927_pcicptr->pcistatus =
-		    (tx4927_pcicptr->
-		     pcistatus & 0x0000ffff) | (PCI_STATUS_REC_MASTER_ABORT
-						<< 16);
-
-		return;
-	}
-#endif
-	printk("PCI error interrupt (irq 0x%x).\n", irq);
-
-	printk("pcistat:%04x, g2pstatus:%08lx, pcicstatus:%08lx\n",
-	       (unsigned short) (tx4927_pcicptr->pcistatus >> 16),
-	       tx4927_pcicptr->g2pstatus, tx4927_pcicptr->pcicstatus);
-	printk("ccfg:%08lx, tear:%02lx_%08lx\n",
-	       (unsigned long) tx4927_ccfgptr->ccfg,
-	       (unsigned long) (tx4927_ccfgptr->tear >> 32),
-	       (unsigned long) tx4927_ccfgptr->tear);
-	show_regs(get_irq_regs());
-}
-
-void __init toshiba_rbtx4927_pci_irq_init(void)
-{
-	return;
-}
-
-void tx4927_reset_pci_pcic(void)
-{
-	/* Reset PCI Bus */
-	*tx4927_pcireset_ptr = 1;
-	/* Reset PCIC */
-	tx4927_ccfgptr->clkctr |= TX4927_CLKCTR_PCIRST;
-	udelay(10000);
-	/* clear PCIC reset */
-	tx4927_ccfgptr->clkctr &= ~TX4927_CLKCTR_PCIRST;
-	*tx4927_pcireset_ptr = 0;
-}
-#endif /* CONFIG_PCI */
-
-#ifdef CONFIG_PCI
-void print_pci_status(void)
-{
-	printk("PCI STATUS %lx\n", tx4927_pcicptr->pcistatus);
-	printk("PCIC STATUS %lx\n", tx4927_pcicptr->pcicstatus);
-}
-
 extern struct pci_controller tx4927_controller;
 
 static struct pci_dev *fake_pci_dev(struct pci_controller *hose,
@@ -239,10 +187,8 @@ static int early_##rw##_config_##size(struct pci_controller *hose,      \
 }
 
 EARLY_PCI_OP(read, byte, u8 *)
-EARLY_PCI_OP(read, word, u16 *)
 EARLY_PCI_OP(read, dword, u32 *)
 EARLY_PCI_OP(write, byte, u8)
-EARLY_PCI_OP(write, word, u16)
 EARLY_PCI_OP(write, dword, u32)
 
 static int __init tx4927_pcibios_init(void)
@@ -269,7 +215,9 @@ static int __init tx4927_pcibios_init(void)
 			u8 v08_64;
 			u32 v32_b0;
 			u8 v08_e1;
+#ifdef TOSHIBA_RBTX4927_SETUP_DEBUG
 			char *s = " sb/isa --";
+#endif
 
 			TOSHIBA_RBTX4927_SETUP_DPRINTK
 			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS, ":%s beg\n",
@@ -354,7 +302,9 @@ static int __init tx4927_pcibios_init(void)
 			u8 v08_41;
 			u8 v08_43;
 			u8 v08_5c;
+#ifdef TOSHIBA_RBTX4927_SETUP_DEBUG
 			char *s = " sb/ide --";
+#endif
 
 			TOSHIBA_RBTX4927_SETUP_DPRINTK
 			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS, ":%s beg\n",
