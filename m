Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 13:45:58 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:16927 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022624AbXEKMpf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2007 13:45:35 +0100
Received: by mo.po.2iij.net (mo31) id l4BCiIDC074299; Fri, 11 May 2007 21:44:18 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox31) id l4BCiGmk007793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 11 May 2007 21:44:16 +0900 (JST)
Message-Id: <200705111244.l4BCiGmk007793@mbox31.po.2iij.net>
Date:	Fri, 11 May 2007 21:43:09 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: [PATCH][MIPS][3/3] rework cobalt_board_id
References: <20070511212959.6558d88e.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


Hi Ralf,

This patch has reworked cobalt_board_id.
The cobalt_board_id is read from PCI config register.
It should be in PCI routine.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
--- mips-orig/arch/mips/cobalt/setup.c	2007-04-18 12:46:20.844204000 +0900
+++ mips/arch/mips/cobalt/setup.c	2007-04-18 13:47:54.189191500 +0900
@@ -10,7 +10,6 @@
  *
  */
 #include <linux/interrupt.h>
-#include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/pm.h>
 
@@ -26,8 +25,6 @@ extern void cobalt_machine_restart(char 
 extern void cobalt_machine_halt(void);
 extern void cobalt_machine_power_off(void);
 
-int cobalt_board_id;
-
 const char *get_system_type(void)
 {
 	switch (cobalt_board_id) {
@@ -92,7 +89,6 @@ static struct resource cobalt_reserved_r
 
 void __init plat_mem_setup(void)
 {
-	unsigned int devfn = PCI_DEVFN(COBALT_PCICONF_VIA, 0);
 	int i;
 
 	_machine_restart = cobalt_machine_restart;
@@ -107,14 +103,6 @@ void __init plat_mem_setup(void)
 	/* These resources have been reserved by VIA SuperI/O chip. */
 	for (i = 0; i < ARRAY_SIZE(cobalt_reserved_resources); i++)
 		request_resource(&ioport_resource, cobalt_reserved_resources + i);
-
-        /* Read the cobalt id register out of the PCI config space */
-        PCI_CFG_SET(devfn, (VIA_COBALT_BRD_ID_REG & ~0x3));
-        cobalt_board_id = GT_READ(GT_PCI0_CFGDATA_OFS);
-        cobalt_board_id >>= ((VIA_COBALT_BRD_ID_REG & 3) * 8);
-        cobalt_board_id = VIA_COBALT_BRD_REG_to_ID(cobalt_board_id);
-
-	printk("Cobalt board ID: %d\n", cobalt_board_id);
 }
 
 /*
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pci/fixup-cobalt.c mips/arch/mips/pci/fixup-cobalt.c
--- mips-orig/arch/mips/pci/fixup-cobalt.c	2007-04-18 11:40:59.490806000 +0900
+++ mips/arch/mips/pci/fixup-cobalt.c	2007-04-18 13:44:48.017556500 +0900
@@ -113,6 +113,27 @@ static void qube_raq_galileo_fixup(struc
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_GT64111,
 	 qube_raq_galileo_fixup);
 
+int cobalt_board_id;
+
+static void qube_raq_via_board_id_fixup(struct pci_dev *dev)
+{
+	u8 id;
+	int retval;
+
+	retval = pci_read_config_byte(dev, VIA_COBALT_BRD_ID_REG, &id);
+	if (retval) {
+		panic("Cannot read board ID");
+		return;
+	}
+
+	cobalt_board_id = VIA_COBALT_BRD_REG_to_ID(id);
+
+	printk(KERN_INFO "Cobalt board ID: %d\n", cobalt_board_id);
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0,
+	 qube_raq_via_board_id_fixup);
+
 static char irq_tab_qube1[] __initdata = {
   [COBALT_PCICONF_CPU]     = 0,
   [COBALT_PCICONF_ETH0]    = COBALT_QUBE1_ETH0_IRQ,
