Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jan 2008 11:13:27 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:38617 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20029174AbYAELNR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 5 Jan 2008 11:13:17 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JB6xn-0001kj-00; Sat, 05 Jan 2008 12:13:15 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 2DE1CC2EF8; Sat,  5 Jan 2008 12:13:11 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Fix IP32 breakage
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080105111311.2DE1CC2EF8@solo.franken.de>
Date:	Sat,  5 Jan 2008 12:13:11 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

- suppress master aborts during config read
- set io_map_base
- only fixup end of iomem resource to avoid failing request_resource
  in serial driver
- killed useless setting of crime_int bit, which caused wrong interrupts
- use physcial address for serial port platform device and let 8250
  driver do the ioremap

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/pci/ops-mace.c           |    7 +++++++
 arch/mips/pci/pci-ip32.c           |    4 +++-
 arch/mips/sgi-ip32/ip32-irq.c      |    1 -
 arch/mips/sgi-ip32/ip32-platform.c |   20 +++++++++-----------
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/mips/pci/ops-mace.c b/arch/mips/pci/ops-mace.c
index fe54514..e958818 100644
--- a/arch/mips/pci/ops-mace.c
+++ b/arch/mips/pci/ops-mace.c
@@ -42,6 +42,10 @@ static int
 mace_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 		     int reg, int size, u32 *val)
 {
+	u32 control = mace->pci.control;
+
+	/* disable master aborts interrupts during config read */
+	mace->pci.control = control & ~MACEPCI_CONTROL_MAR_INT;
 	mace->pci.config_addr = mkaddr(bus, devfn, reg);
 	switch (size) {
 	case 1:
@@ -54,6 +58,9 @@ mace_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 		*val = mace->pci.config_data.l;
 		break;
 	}
+	/* ack possible master abort */
+	mace->pci.error &= ~MACEPCI_ERROR_MASTER_ABORT;
+	mace->pci.control = control;
 
 	DPRINTK("read%d: reg=%08x,val=%02x\n", size * 8, reg, *val);
 
diff --git a/arch/mips/pci/pci-ip32.c b/arch/mips/pci/pci-ip32.c
index 618ea7d..532b561 100644
--- a/arch/mips/pci/pci-ip32.c
+++ b/arch/mips/pci/pci-ip32.c
@@ -119,6 +119,7 @@ static struct pci_controller mace_pci_controller = {
 	.iommu		= 0,
 	.mem_offset	= MACE_PCI_MEM_OFFSET,
 	.io_offset	= 0,
+	.io_map_base	= CKSEG1ADDR(MACEPCI_LOW_IO),
 };
 
 static int __init mace_init(void)
@@ -135,7 +136,8 @@ static int __init mace_init(void)
 	BUG_ON(request_irq(MACE_PCI_BRIDGE_IRQ, macepci_error, 0,
 			   "MACE PCI error", NULL));
 
-	iomem_resource = mace_pci_mem_resource;
+	/* extend memory resources */
+	iomem_resource.end = mace_pci_mem_resource.end;
 	ioport_resource = mace_pci_io_resource;
 
 	register_pci_controller(&mace_pci_controller);
diff --git a/arch/mips/sgi-ip32/ip32-irq.c b/arch/mips/sgi-ip32/ip32-irq.c
index cab7cc2..b0ea0e4 100644
--- a/arch/mips/sgi-ip32/ip32-irq.c
+++ b/arch/mips/sgi-ip32/ip32-irq.c
@@ -426,7 +426,6 @@ static void ip32_irq0(void)
 
 	crime_int = crime->istat & crime_mask;
 	irq = MACE_VID_IN1_IRQ + __ffs(crime_int);
-	crime_int = 1 << irq;
 
 	if (crime_int & CRIME_MACEISA_INT_MASK) {
 		unsigned long mace_int = mace->perif.ctrl.istat;
diff --git a/arch/mips/sgi-ip32/ip32-platform.c b/arch/mips/sgi-ip32/ip32-platform.c
index 77febd6..89a71f4 100644
--- a/arch/mips/sgi-ip32/ip32-platform.c
+++ b/arch/mips/sgi-ip32/ip32-platform.c
@@ -13,21 +13,22 @@
 #include <asm/ip32/mace.h>
 #include <asm/ip32/ip32_ints.h>
 
-/*
- * .iobase isn't a constant (in the sense of C) so we fill it in at runtime.
- */
-#define MACE_PORT(int)							\
+#define MACEISA_SERIAL1_OFFS   offsetof(struct sgi_mace, isa.serial1)
+#define MACEISA_SERIAL2_OFFS   offsetof(struct sgi_mace, isa.serial2)
+
+#define MACE_PORT(offset,_irq)						\
 {									\
-	.irq		= int,						\
+	.mapbase	= MACE_BASE + offset,				\
+	.irq		= _irq,						\
 	.uartclk	= 1843200,					\
 	.iotype		= UPIO_MEM,					\
-	.flags		= UPF_SKIP_TEST,				\
+	.flags		= UPF_SKIP_TEST|UPF_IOREMAP,			\
 	.regshift	= 8,						\
 }
 
 static struct plat_serial8250_port uart8250_data[] = {
-	MACE_PORT(MACEISA_SERIAL1_IRQ),
-	MACE_PORT(MACEISA_SERIAL2_IRQ),
+	MACE_PORT(MACEISA_SERIAL1_OFFS, MACEISA_SERIAL1_IRQ),
+	MACE_PORT(MACEISA_SERIAL2_OFFS, MACEISA_SERIAL2_IRQ),
 	{ },
 };
 
@@ -41,9 +42,6 @@ static struct platform_device uart8250_device = {
 
 static int __init uart8250_init(void)
 {
-	uart8250_data[0].membase = (void __iomem *) &mace->isa.serial1;
-	uart8250_data[1].membase = (void __iomem *) &mace->isa.serial2;
-
 	return platform_device_register(&uart8250_device);
 }
 
