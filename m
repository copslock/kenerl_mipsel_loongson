Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 16:24:35 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:41704 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28577881AbYGWPXe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2008 16:23:34 +0100
Received: from localhost.localdomain (p3049-ipad205funabasi.chiba.ocn.ne.jp [222.146.98.49])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 128F0AA0C; Thu, 24 Jul 2008 00:23:28 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 02/10] txx9: PCI fixes for tx3927/tx4927
Date:	Thu, 24 Jul 2008 00:25:13 +0900
Message-Id: <1216826721-28259-2-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.5.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Fix tx3927 pci ops for Type-1 configuration
* Fix abort checking of tx3927 pci ops
* Flush write buffer to avoid spurious PCI error interrupt
* Add a quirk for FPCIB backplane

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/pci/ops-tx3927.c |   46 ++++++++++++++++++-------------------------
 arch/mips/pci/ops-tx4927.c |   34 ++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/arch/mips/pci/ops-tx3927.c b/arch/mips/pci/ops-tx3927.c
index 8a17a39..c6bd79e 100644
--- a/arch/mips/pci/ops-tx3927.c
+++ b/arch/mips/pci/ops-tx3927.c
@@ -41,41 +41,41 @@
 #include <asm/addrspace.h>
 #include <asm/txx9/tx3927.h>
 
-static inline int mkaddr(unsigned char bus, unsigned char dev_fn,
-	unsigned char where)
+static int mkaddr(struct pci_bus *bus, unsigned char devfn, unsigned char where)
 {
-	if (bus == 0 && dev_fn >= PCI_DEVFN(TX3927_PCIC_MAX_DEVNU, 0))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	tx3927_pcicptr->ica = ((bus & 0xff) << 0x10) |
-	                      ((dev_fn & 0xff) << 0x08) |
-	                      (where & 0xfc);
+	if (bus->parent == NULL &&
+	    devfn >= PCI_DEVFN(TX3927_PCIC_MAX_DEVNU, 0))
+		return -1;
+	tx3927_pcicptr->ica =
+		((bus->number & 0xff) << 0x10) |
+		((devfn & 0xff) << 0x08) |
+		(where & 0xfc) | (bus->parent ? 1 : 0);
 
 	/* clear M_ABORT and Disable M_ABORT Int. */
 	tx3927_pcicptr->pcistat |= PCI_STATUS_REC_MASTER_ABORT;
 	tx3927_pcicptr->pcistatim &= ~PCI_STATUS_REC_MASTER_ABORT;
-
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static inline int check_abort(void)
 {
-	if (tx3927_pcicptr->pcistat & PCI_STATUS_REC_MASTER_ABORT)
+	if (tx3927_pcicptr->pcistat & PCI_STATUS_REC_MASTER_ABORT) {
 		tx3927_pcicptr->pcistat |= PCI_STATUS_REC_MASTER_ABORT;
 		tx3927_pcicptr->pcistatim |= PCI_STATUS_REC_MASTER_ABORT;
+		/* flush write buffer */
+		iob();
 		return PCIBIOS_DEVICE_NOT_FOUND;
-
+	}
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static int tx3927_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	int where, int size, u32 * val)
 {
-	int ret;
-
-	ret = mkaddr(bus->number, devfn, where);
-	if (ret)
-		return ret;
+	if (mkaddr(bus, devfn, where)) {
+		*val = 0xffffffff;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
 
 	switch (size) {
 	case 1:
@@ -97,11 +97,8 @@ static int tx3927_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 static int tx3927_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 	int where, int size, u32 val)
 {
-	int ret;
-
-	ret = mkaddr(bus->number, devfn, where);
-	if (ret)
-		return ret;
+	if (mkaddr(bus, devfn, where))
+		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	switch (size) {
 	case 1:
@@ -117,11 +114,6 @@ static int tx3927_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 		tx3927_pcicptr->icd = cpu_to_le32(val);
 	}
 
-	if (tx3927_pcicptr->pcistat & PCI_STATUS_REC_MASTER_ABORT)
-		tx3927_pcicptr->pcistat |= PCI_STATUS_REC_MASTER_ABORT;
-		tx3927_pcicptr->pcistatim |= PCI_STATUS_REC_MASTER_ABORT;
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
 	return check_abort();
 }
 
diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
index c6b49bc..6d84409 100644
--- a/arch/mips/pci/ops-tx4927.c
+++ b/arch/mips/pci/ops-tx4927.c
@@ -85,6 +85,8 @@ static int check_abort(struct tx4927_pcic_reg __iomem *pcicptr)
 		__raw_writel((__raw_readl(&pcicptr->pcistatus) & 0x0000ffff)
 			     | (PCI_STATUS_REC_MASTER_ABORT << 16),
 			     &pcicptr->pcistatus);
+		/* flush write buffer */
+		iob();
 		code = PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	return code;
@@ -406,3 +408,35 @@ void tx4927_report_pcic_status(void)
 			tx4927_report_pcic_status1(pcicptrs[i].pcicptr);
 	}
 }
+
+#ifdef CONFIG_TOSHIBA_FPCIB0
+static void __init tx4927_quirk_slc90e66_bridge(struct pci_dev *dev)
+{
+	struct tx4927_pcic_reg __iomem *pcicptr = pci_bus_to_pcicptr(dev->bus);
+
+	if (!pcicptr)
+		return;
+	if (__raw_readl(&pcicptr->pbacfg) & TX4927_PCIC_PBACFG_PBAEN) {
+		/* Reset Bus Arbiter */
+		__raw_writel(TX4927_PCIC_PBACFG_RPBA, &pcicptr->pbacfg);
+		/*
+		 * swap reqBP and reqXP (raise priority of SLC90E66).
+		 * SLC90E66(PCI-ISA bridge) is connected to REQ2 on
+		 * PCI Backplane board.
+		 */
+		__raw_writel(0x72543610, &pcicptr->pbareqport);
+		__raw_writel(0, &pcicptr->pbabm);
+		/* Use Fixed ParkMaster (required by SLC90E66) */
+		__raw_writel(TX4927_PCIC_PBACFG_FIXPA, &pcicptr->pbacfg);
+		/* Enable Bus Arbiter */
+		__raw_writel(TX4927_PCIC_PBACFG_FIXPA |
+			     TX4927_PCIC_PBACFG_PBAEN,
+			     &pcicptr->pbacfg);
+		printk(KERN_INFO "PCI: Use Fixed Park Master (REQPORT %08x)\n",
+		       __raw_readl(&pcicptr->pbareqport));
+	}
+}
+#define PCI_DEVICE_ID_EFAR_SLC90E66_0 0x9460
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_0,
+	tx4927_quirk_slc90e66_bridge);
+#endif
-- 
1.5.5.5
