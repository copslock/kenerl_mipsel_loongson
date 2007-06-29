Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jun 2007 14:34:24 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:35800 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023167AbXF2NeT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Jun 2007 14:34:19 +0100
Received: from localhost (p7072-ipad34funabasi.chiba.ocn.ne.jp [124.85.64.72])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 21468B78A; Fri, 29 Jun 2007 22:34:15 +0900 (JST)
Date:	Fri, 29 Jun 2007 22:35:01 +0900 (JST)
Message-Id: <20070629.223501.93206611.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, sshtylyov@ru.mvista.com, mlachwani@mvista.com,
	jeff@garzik.org
Subject: [PATCH] rbtx4938: Fix secondary PCIC and glue internal NICs
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
X-archive-position: 15576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Fix pci ops for secondary PCIC
* Do not reserve 1MB for PCI MEM region (leave PCIBIOS_MIN_MEM zero)
* Use platform_device to provide ethernet addresses for internal NICs.
  (background: TX49XX SoCs include PCI NIC (TC35815 compatible)
  connected via its internal PCI bus, but the NIC's PROM interface is
  not connected to SEEPROM.  So we must provide its ethernet address
  by another way.)
* Check return value of early_read_config_word()

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
A driver side of this patch is:
"[PATCH] tc35815: Load MAC address via platform_device"

 arch/mips/pci/ops-tx4938.c                |   80 +++++++++++++++++-----------
 arch/mips/tx4938/toshiba_rbtx4938/setup.c |   54 ++++++++-----------
 2 files changed, 71 insertions(+), 63 deletions(-)

diff --git a/arch/mips/pci/ops-tx4938.c b/arch/mips/pci/ops-tx4938.c
index 4450070..a450c40 100644
--- a/arch/mips/pci/ops-tx4938.c
+++ b/arch/mips/pci/ops-tx4938.c
@@ -46,50 +46,63 @@ struct resource tx4938_pcic1_pci_mem_resource = {
 	.flags	= IORESOURCE_MEM
 };
 
-static int mkaddr(int bus, int dev_fn, int where, int *flagsp)
+static int mkaddr(int bus, int dev_fn, int where,
+		  struct tx4938_pcic_reg *pcicptr)
 {
 	if (bus > 0) {
 		/* Type 1 configuration */
-		tx4938_pcicptr->g2pcfgadrs = ((bus & 0xff) << 0x10) |
+		pcicptr->g2pcfgadrs = ((bus & 0xff) << 0x10) |
 		    ((dev_fn & 0xff) << 0x08) | (where & 0xfc) | 1;
 	} else {
 		if (dev_fn >= PCI_DEVFN(TX4938_PCIC_MAX_DEVNU, 0))
 			return -1;
 
 		/* Type 0 configuration */
-		tx4938_pcicptr->g2pcfgadrs = ((bus & 0xff) << 0x10) |
+		pcicptr->g2pcfgadrs = ((bus & 0xff) << 0x10) |
 		    ((dev_fn & 0xff) << 0x08) | (where & 0xfc);
 	}
 	/* clear M_ABORT and Disable M_ABORT Int. */
-	tx4938_pcicptr->pcistatus =
-	    (tx4938_pcicptr->pcistatus & 0x0000ffff) |
+	pcicptr->pcistatus =
+	    (pcicptr->pcistatus & 0x0000ffff) |
 	    (PCI_STATUS_REC_MASTER_ABORT << 16);
-	tx4938_pcicptr->pcimask &= ~PCI_STATUS_REC_MASTER_ABORT;
+	pcicptr->pcimask &= ~PCI_STATUS_REC_MASTER_ABORT;
 
 	return 0;
 }
 
-static int check_abort(int flags)
+static int check_abort(struct tx4938_pcic_reg *pcicptr)
 {
 	int code = PCIBIOS_SUCCESSFUL;
 	/* wait write cycle completion before checking error status */
-	while (tx4938_pcicptr->pcicstatus & TX4938_PCIC_PCICSTATUS_IWB)
+	while (pcicptr->pcicstatus & TX4938_PCIC_PCICSTATUS_IWB)
 				;
-	if (tx4938_pcicptr->pcistatus & (PCI_STATUS_REC_MASTER_ABORT << 16)) {
-		tx4938_pcicptr->pcistatus =
-		    (tx4938_pcicptr->
+	if (pcicptr->pcistatus & (PCI_STATUS_REC_MASTER_ABORT << 16)) {
+		pcicptr->pcistatus =
+		    (pcicptr->
 		     pcistatus & 0x0000ffff) | (PCI_STATUS_REC_MASTER_ABORT
 						<< 16);
-		tx4938_pcicptr->pcimask |= PCI_STATUS_REC_MASTER_ABORT;
+		pcicptr->pcimask |= PCI_STATUS_REC_MASTER_ABORT;
 		code = PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	return code;
 }
 
+extern struct pci_controller tx4938_pci_controller[];
+extern struct tx4938_pcic_reg *get_tx4938_pcicptr(int ch);
+
+static struct tx4938_pcic_reg *pci_bus_to_pcicptr(struct pci_bus *bus)
+{
+	struct pci_controller *channel = bus->sysdata;
+	return get_tx4938_pcicptr(channel - &tx4938_pci_controller[0]);
+}
+
 static int tx4938_pcibios_read_config(struct pci_bus *bus, unsigned int devfn,
 					int where, int size, u32 * val)
 {
-	int flags, retval, dev, busno, func;
+	int retval, dev, busno, func;
+	struct tx4938_pcic_reg *pcicptr = pci_bus_to_pcicptr(bus);
+	void __iomem *cfgdata =
+		(void __iomem *)(unsigned long)&pcicptr->g2pcfgdata;
 
 	dev = PCI_SLOT(devfn);
 	func = PCI_FUNC(devfn);
@@ -101,32 +114,32 @@ static int tx4938_pcibios_read_config(struct pci_bus *bus, unsigned int devfn,
 		busno = 0;
 	}
 
-	if (mkaddr(busno, devfn, where, &flags))
+	if (mkaddr(busno, devfn, where, pcicptr))
 		return -1;
 
 	switch (size) {
 	case 1:
-		*val = *(volatile u8 *) ((unsigned long) & tx4938_pcicptr->g2pcfgdata |
 #ifdef __BIG_ENDIAN
-			      ((where & 3) ^ 3));
+		cfgdata += (where & 3) ^ 3;
 #else
-			      (where & 3));
+		cfgdata += where & 3;
 #endif
+		*val = __raw_readb(cfgdata);
 		break;
 	case 2:
-		*val = *(volatile u16 *) ((unsigned long) & tx4938_pcicptr->g2pcfgdata |
 #ifdef __BIG_ENDIAN
-				((where & 3) ^ 2));
+		cfgdata += (where & 2) ^ 2;
 #else
-				(where & 3));
+		cfgdata += where & 2;
 #endif
+		*val = __raw_readw(cfgdata);
 		break;
 	case 4:
-		*val = tx4938_pcicptr->g2pcfgdata;
+		*val = __raw_readl(cfgdata);
 		break;
 	}
 
-	retval = check_abort(flags);
+	retval = check_abort(pcicptr);
 	if (retval == PCIBIOS_DEVICE_NOT_FOUND)
 		*val = 0xffffffff;
 
@@ -136,7 +149,10 @@ static int tx4938_pcibios_read_config(struct pci_bus *bus, unsigned int devfn,
 static int tx4938_pcibios_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 						int size, u32 val)
 {
-	int flags, dev, busno, func;
+	int dev, busno, func;
+	struct tx4938_pcic_reg *pcicptr = pci_bus_to_pcicptr(bus);
+	void __iomem *cfgdata =
+		(void __iomem *)(unsigned long)&pcicptr->g2pcfgdata;
 
 	busno = bus->number;
 	dev = PCI_SLOT(devfn);
@@ -149,32 +165,32 @@ static int tx4938_pcibios_write_config(struct pci_bus *bus, unsigned int devfn,
 		busno = 0;
 	}
 
-	if (mkaddr(busno, devfn, where, &flags))
+	if (mkaddr(busno, devfn, where, pcicptr))
 		return -1;
 
 	switch (size) {
 	case 1:
-		*(volatile u8 *) ((unsigned long) & tx4938_pcicptr->g2pcfgdata |
 #ifdef __BIG_ENDIAN
-			  ((where & 3) ^ 3)) = val;
+		cfgdata += (where & 3) ^ 3;
 #else
-			  (where & 3)) = val;
+		cfgdata += where & 3;
 #endif
+		__raw_writeb(val, cfgdata);
 		break;
 	case 2:
-		*(volatile u16 *) ((unsigned long) & tx4938_pcicptr->g2pcfgdata |
 #ifdef __BIG_ENDIAN
-			((where & 0x3) ^ 0x2)) = val;
+		cfgdata += (where & 2) ^ 2;
 #else
-			(where & 3)) = val;
+		cfgdata += where & 2;
 #endif
+		__raw_writew(val, cfgdata);
 		break;
 	case 4:
-		tx4938_pcicptr->g2pcfgdata = val;
+		__raw_writel(val, cfgdata);
 		break;
 	}
 
-	return check_abort(flags);
+	return check_abort(pcicptr);
 }
 
 struct pci_ops tx4938_pci_ops = {
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index 361d89a..d9fbf51 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -352,7 +352,7 @@ static struct pci_dev *fake_pci_dev(struct pci_controller *hose,
 	static struct pci_dev dev;
 	static struct pci_bus bus;
 
-	dev.sysdata = (void *)hose;
+	dev.sysdata = bus.sysdata = hose;
 	dev.devfn = devfn;
 	bus.number = busnr;
 	bus.ops = hose->pci_ops;
@@ -385,8 +385,10 @@ int txboard_pci66_check(struct pci_controller *hose, int top_bus, int current_bu
 	printk("PCI: Checking 66MHz capabilities...\n");
 
 	for (pci_devfn=devfn_start; pci_devfn<devfn_stop; pci_devfn++) {
-		early_read_config_word(hose, top_bus, current_bus, pci_devfn,
-				       PCI_VENDOR_ID, &vid);
+		if (early_read_config_word(hose, top_bus, current_bus,
+					   pci_devfn, PCI_VENDOR_ID,
+					   &vid) != PCIBIOS_SUCCESSFUL)
+			continue;
 
 		if (vid == 0xffff) continue;
 
@@ -463,7 +465,6 @@ static int __init tx4938_pcibios_init(void)
 	int extarb = !(tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIXARB);
 
 	PCIBIOS_MIN_IO = 0x00001000UL;
-	PCIBIOS_MIN_MEM = 0x01000000UL;
 
 	mem_base[0] = txboard_request_phys_region_shrink(&mem_size[0]);
 	io_base[0] = txboard_request_phys_region_shrink(&io_size[0]);
@@ -578,18 +579,18 @@ arch_initcall(tx4938_pcibios_init);
 #define	SRTC_CS	2	/* IOC */
 
 #ifdef CONFIG_PCI
-static unsigned char rbtx4938_ethaddr[17];
 static int __init rbtx4938_ethaddr_init(void)
 {
+	unsigned char ethaddr[17];
 	unsigned char sum;
 	int i;
 
 	/* 0-3: "MAC\0", 4-9:eth0, 10-15:eth1, 16:sum */
-	if (spi_eeprom_read(SEEPROM1_CS, 0,
-			    rbtx4938_ethaddr, sizeof(rbtx4938_ethaddr)))
+	if (spi_eeprom_read(SEEPROM1_CS, 0, ethaddr, sizeof(ethaddr))) {
 		printk(KERN_ERR "seeprom: read error.\n");
-	else {
-		unsigned char *dat = rbtx4938_ethaddr;
+		return -ENODEV;
+	} else {
+		unsigned char *dat = ethaddr;
 		if (strcmp(dat, "MAC") != 0)
 			printk(KERN_WARNING "seeprom: bad signature.\n");
 		for (i = 0, sum = 0; i < sizeof(dat); i++)
@@ -597,31 +598,22 @@ static int __init rbtx4938_ethaddr_init(void)
 		if (sum)
 			printk(KERN_WARNING "seeprom: bad checksum.\n");
 	}
-	return 0;
-}
-device_initcall(rbtx4938_ethaddr_init);
-
-int rbtx4938_get_tx4938_ethaddr(struct pci_dev *dev, unsigned char *addr)
-{
-	struct pci_controller *channel = (struct pci_controller *)dev->bus->sysdata;
-	int ch = 0;
-
-	if (channel != &tx4938_pci_controller[1])
-		return -ENODEV;
-	/* TX4938 PCIC1 */
-	switch (PCI_SLOT(dev->devfn)) {
-	case TX4938_PCIC_IDSEL_AD_TO_SLOT(31):
-		ch = 0;
-		break;
-	case TX4938_PCIC_IDSEL_AD_TO_SLOT(30):
-		ch = 1;
-		break;
-	default:
-		return -ENODEV;
+	for (i = 0; i < 2; i++) {
+		unsigned int slot = TX4938_PCIC_IDSEL_AD_TO_SLOT(31 - i);
+		unsigned int id = (1 << 8) | PCI_DEVFN(slot, 0); /* bus 1 */
+		struct platform_device *pdev;
+		if (!(tx4938_ccfgptr->pcfg &
+		      (i ? TX4938_PCFG_ETH1_SEL : TX4938_PCFG_ETH0_SEL)))
+			continue;
+		pdev = platform_device_alloc("tc35815-mac", id);
+		if (!pdev ||
+		    platform_device_add_data(pdev, &ethaddr[4 + 6 * i], 6) ||
+		    platform_device_add(pdev))
+			platform_device_put(pdev);
 	}
-	memcpy(addr, &rbtx4938_ethaddr[4 + 6 * ch], 6);
 	return 0;
 }
+device_initcall(rbtx4938_ethaddr_init);
 #endif /* CONFIG_PCI */
 
 static void __init rbtx4938_spi_setup(void)
