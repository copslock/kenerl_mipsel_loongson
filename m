Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jan 2008 16:16:10 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:2807 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20030069AbYARQQC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Jan 2008 16:16:02 +0000
Received: from localhost (p4201-ipad303funabasi.chiba.ocn.ne.jp [123.217.150.201])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9ADE1A12E; Sat, 19 Jan 2008 01:15:55 +0900 (JST)
Date:	Sat, 19 Jan 2008 01:15:52 +0900 (JST)
Message-Id: <20080119.011552.41196389.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, jeff@garzik.org
Subject: [PATCH] tc35815: Use irq number for tc35815-mac platform device id
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
X-archive-position: 18094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The tc35815-mac platform device used a pci bus number and a devfn to
identify its target device, but the pci bus number may vary if some
bus-bridges are found.  Use irq number which is be unique for embedded
controllers.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/tx4938/toshiba_rbtx4938/setup.c |    4 ++--
 drivers/net/tc35815.c                     |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index 4a81523..632e5d2 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -598,8 +598,8 @@ static int __init rbtx4938_ethaddr_init(void)
 			printk(KERN_WARNING "seeprom: bad checksum.\n");
 	}
 	for (i = 0; i < 2; i++) {
-		unsigned int slot = TX4938_PCIC_IDSEL_AD_TO_SLOT(31 - i);
-		unsigned int id = (1 << 8) | PCI_DEVFN(slot, 0); /* bus 1 */
+		unsigned int id =
+			TXX9_IRQ_BASE + (i ? TX4938_IR_ETH1 : TX4938_IR_ETH0);
 		struct platform_device *pdev;
 		if (!(tx4938_ccfgptr->pcfg &
 		      (i ? TX4938_PCFG_ETH1_SEL : TX4938_PCFG_ETH0_SEL)))
diff --git a/drivers/net/tc35815.c b/drivers/net/tc35815.c
index d887c05..370d329 100644
--- a/drivers/net/tc35815.c
+++ b/drivers/net/tc35815.c
@@ -611,7 +611,7 @@ static int __devinit tc35815_mac_match(struct device *dev, void *data)
 {
 	struct platform_device *plat_dev = to_platform_device(dev);
 	struct pci_dev *pci_dev = data;
-	unsigned int id = (pci_dev->bus->number << 8) | pci_dev->devfn;
+	unsigned int id = pci_dev->irq;
 	return !strcmp(plat_dev->name, "tc35815-mac") && plat_dev->id == id;
 }
 
