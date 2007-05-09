Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 May 2007 16:03:33 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:52479 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023648AbXEIPDa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 May 2007 16:03:30 +0100
Received: from localhost (p3015-ipad31funabasi.chiba.ocn.ne.jp [221.189.127.15])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8EF0FADEF; Thu, 10 May 2007 00:03:25 +0900 (JST)
Date:	Thu, 10 May 2007 00:03:36 +0900 (JST)
Message-Id: <20070510.000336.96686963.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: Re: [PATCH] rbtx4938: Fix secondary PCIC and glue internal NICs
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070317.012539.72709076.anemo@mba.ocn.ne.jp>
References: <20070317.012539.72709076.anemo@mba.ocn.ne.jp>
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
X-archive-position: 15009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 17 Mar 2007 01:25:39 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> * Fix pci ops for secondary PCIC
> * Do not reserve 1MB for PCI MEM region (leave PCIBIOS_MIN_MEM zero)
> * Use NETDEV_REGISTER event to provide ethernet addresses for internal
>   NICs (tc35815 driver)
> * Check return value of early_read_config_word()

Updated against current git tree.


Subject: [PATCH] rbtx4938: Fix secondary PCIC and glue internal NICs

* Fix pci ops for secondary PCIC
* Do not reserve 1MB for PCI MEM region (leave PCIBIOS_MIN_MEM zero)
* Use NETDEV_REGISTER event to provide ethernet addresses for internal
  NICs (tc35815 driver)
* Check return value of early_read_config_word()

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/pci/ops-tx4938.c                |   60 +++++++++++++++++-----------
 arch/mips/tx4938/toshiba_rbtx4938/setup.c |   56 +++++++++++++++++----------
 2 files changed, 72 insertions(+), 44 deletions(-)

diff --git a/arch/mips/pci/ops-tx4938.c b/arch/mips/pci/ops-tx4938.c
index 4450070..db435bf 100644
--- a/arch/mips/pci/ops-tx4938.c
+++ b/arch/mips/pci/ops-tx4938.c
@@ -46,50 +46,61 @@ struct resource tx4938_pcic1_pci_mem_resource = {
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
 
 	dev = PCI_SLOT(devfn);
 	func = PCI_FUNC(devfn);
@@ -101,12 +112,12 @@ static int tx4938_pcibios_read_config(struct pci_bus *bus, unsigned int devfn,
 		busno = 0;
 	}
 
-	if (mkaddr(busno, devfn, where, &flags))
+	if (mkaddr(busno, devfn, where, pcicptr))
 		return -1;
 
 	switch (size) {
 	case 1:
-		*val = *(volatile u8 *) ((unsigned long) & tx4938_pcicptr->g2pcfgdata |
+		*val = *(volatile u8 *) ((unsigned long) & pcicptr->g2pcfgdata |
 #ifdef __BIG_ENDIAN
 			      ((where & 3) ^ 3));
 #else
@@ -114,7 +125,7 @@ static int tx4938_pcibios_read_config(struct pci_bus *bus, unsigned int devfn,
 #endif
 		break;
 	case 2:
-		*val = *(volatile u16 *) ((unsigned long) & tx4938_pcicptr->g2pcfgdata |
+		*val = *(volatile u16 *) ((unsigned long) & pcicptr->g2pcfgdata |
 #ifdef __BIG_ENDIAN
 				((where & 3) ^ 2));
 #else
@@ -122,11 +133,11 @@ static int tx4938_pcibios_read_config(struct pci_bus *bus, unsigned int devfn,
 #endif
 		break;
 	case 4:
-		*val = tx4938_pcicptr->g2pcfgdata;
+		*val = pcicptr->g2pcfgdata;
 		break;
 	}
 
-	retval = check_abort(flags);
+	retval = check_abort(pcicptr);
 	if (retval == PCIBIOS_DEVICE_NOT_FOUND)
 		*val = 0xffffffff;
 
@@ -136,7 +147,8 @@ static int tx4938_pcibios_read_config(struct pci_bus *bus, unsigned int devfn,
 static int tx4938_pcibios_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 						int size, u32 val)
 {
-	int flags, dev, busno, func;
+	int dev, busno, func;
+	struct tx4938_pcic_reg *pcicptr = pci_bus_to_pcicptr(bus);
 
 	busno = bus->number;
 	dev = PCI_SLOT(devfn);
@@ -149,12 +161,12 @@ static int tx4938_pcibios_write_config(struct pci_bus *bus, unsigned int devfn,
 		busno = 0;
 	}
 
-	if (mkaddr(busno, devfn, where, &flags))
+	if (mkaddr(busno, devfn, where, pcicptr))
 		return -1;
 
 	switch (size) {
 	case 1:
-		*(volatile u8 *) ((unsigned long) & tx4938_pcicptr->g2pcfgdata |
+		*(volatile u8 *) ((unsigned long) & pcicptr->g2pcfgdata |
 #ifdef __BIG_ENDIAN
 			  ((where & 3) ^ 3)) = val;
 #else
@@ -162,7 +174,7 @@ static int tx4938_pcibios_write_config(struct pci_bus *bus, unsigned int devfn,
 #endif
 		break;
 	case 2:
-		*(volatile u16 *) ((unsigned long) & tx4938_pcicptr->g2pcfgdata |
+		*(volatile u16 *) ((unsigned long) & pcicptr->g2pcfgdata |
 #ifdef __BIG_ENDIAN
 			((where & 0x3) ^ 0x2)) = val;
 #else
@@ -170,11 +182,11 @@ static int tx4938_pcibios_write_config(struct pci_bus *bus, unsigned int devfn,
 #endif
 		break;
 	case 4:
-		tx4938_pcicptr->g2pcfgdata = val;
+		pcicptr->g2pcfgdata = val;
 		break;
 	}
 
-	return check_abort(flags);
+	return check_abort(pcicptr);
 }
 
 struct pci_ops tx4938_pci_ops = {
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index f5d1ce7..4e26673 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -21,6 +21,7 @@
 #include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
+#include <linux/netdevice.h>
 
 #include <asm/wbflush.h>
 #include <asm/reboot.h>
@@ -349,7 +350,7 @@ static struct pci_dev *fake_pci_dev(struct pci_controller *hose,
 	static struct pci_dev dev;
 	static struct pci_bus bus;
 
-	dev.sysdata = (void *)hose;
+	dev.sysdata = bus.sysdata = hose;
 	dev.devfn = devfn;
 	bus.number = busnr;
 	bus.ops = hose->pci_ops;
@@ -382,8 +383,10 @@ int txboard_pci66_check(struct pci_controller *hose, int top_bus, int current_bu
 	printk("PCI: Checking 66MHz capabilities...\n");
 
 	for (pci_devfn=devfn_start; pci_devfn<devfn_stop; pci_devfn++) {
-		early_read_config_word(hose, top_bus, current_bus, pci_devfn,
-				       PCI_VENDOR_ID, &vid);
+		if (early_read_config_word(hose, top_bus, current_bus,
+					   pci_devfn, PCI_VENDOR_ID,
+					   &vid) != PCIBIOS_SUCCESSFUL)
+			continue;
 
 		if (vid == 0xffff) continue;
 
@@ -460,7 +463,6 @@ static int __init tx4938_pcibios_init(void)
 	int extarb = !(tx4938_ccfgptr->ccfg & TX4938_CCFG_PCIXARB);
 
 	PCIBIOS_MIN_IO = 0x00001000UL;
-	PCIBIOS_MIN_MEM = 0x01000000UL;
 
 	mem_base[0] = txboard_request_phys_region_shrink(&mem_size[0]);
 	io_base[0] = txboard_request_phys_region_shrink(&io_size[0]);
@@ -607,26 +609,11 @@ static int rbtx4938_spi_cs_func(int chipid, int on)
 #ifdef CONFIG_PCI
 extern int spi_eeprom_read(int chipid, int address, unsigned char *buf, int len);
 
-int rbtx4938_get_tx4938_ethaddr(struct pci_dev *dev, unsigned char *addr)
+static int rbtx4938_get_tx4938_ethaddr(int ch, unsigned char *addr)
 {
-	struct pci_controller *channel = (struct pci_controller *)dev->bus->sysdata;
 	static unsigned char dat[17];
 	static int read_dat = 0;
-	int ch = 0;
 
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
-	}
 	if (!read_dat) {
 		unsigned char sum;
 		int i;
@@ -647,6 +634,35 @@ int rbtx4938_get_tx4938_ethaddr(struct pci_dev *dev, unsigned char *addr)
 	memcpy(addr, &dat[4 + 6 * ch], 6);
 	return 0;
 }
+
+static int rbtx4938_netdev_event(struct notifier_block *this,
+				 unsigned long event,
+				 void *ptr)
+{
+	struct net_device *dev = ptr;
+	if (event == NETDEV_REGISTER) {
+		int ch = -1;
+		if (dev->irq == RBTX4938_IRQ_IRC + TX4938_IR_ETH0)
+			ch = 0;
+		else if (dev->irq == RBTX4938_IRQ_IRC + TX4938_IR_ETH1)
+			ch = 1;
+		if (ch >= 0)
+			rbtx4938_get_tx4938_ethaddr(ch, dev->dev_addr);
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block rbtx4938_netdev_notifier = {
+	.notifier_call = rbtx4938_netdev_event,
+};
+
+static int __init rbtx4938_setup_eth(void)
+{
+	if (tx4938_ccfgptr->pcfg & (TX4938_PCFG_ETH0_SEL|TX4938_PCFG_ETH1_SEL))
+		register_netdevice_notifier(&rbtx4938_netdev_notifier);
+	return 0;
+}
+device_initcall(rbtx4938_setup_eth);
 #endif /* CONFIG_PCI */
 
 extern void __init txx9_spi_init(unsigned long base, int (*cs_func)(int chipid, int on));
