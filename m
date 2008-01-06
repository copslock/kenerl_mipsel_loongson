Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Jan 2008 18:59:22 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:6670 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S20025161AbYAFS7O (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 6 Jan 2008 18:59:14 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 91196D8C9; Sun,  6 Jan 2008 18:59:06 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 541CB543CA; Sun,  6 Jan 2008 19:58:52 +0100 (CET)
Date:	Sun, 6 Jan 2008 19:58:52 +0100
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Fix IP32 breakage
Message-ID: <20080106185852.GA5530@deprecation.cyrius.com>
References: <20080105111311.2DE1CC2EF8@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080105111311.2DE1CC2EF8@solo.franken.de>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

The same patch is needed for 2.6.23.  Here's a version that will apply
against 2.6.23.  Ralf, can you please commit that as well.

From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas Bogendoerfer <tsbogend@alpha.franken.de> [2008-01-05 12:13]:
 - suppress master aborts during config read
 - set io_map_base
 - only fixup end of iomem resource to avoid failing request_resource
   in serial driver
 - killed useless setting of crime_int bit, which caused wrong interrupts
 - use physcial address for serial port platform device and let 8250
   driver do the ioremap

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

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
index fb9da9a..6eb982f 100644
--- a/arch/mips/sgi-ip32/ip32-irq.c
+++ b/arch/mips/sgi-ip32/ip32-irq.c
@@ -416,7 +416,6 @@ static void ip32_irq0(void)
 
 	crime_int = crime->istat & crime_mask;
 	irq = __ffs(crime_int);
-	crime_int = 1 << irq;
 
 	if (crime_int & CRIME_MACEISA_INT_MASK) {
 		unsigned long mace_int = mace->perif.ctrl.istat;
diff --git a/arch/mips/sgi-ip32/ip32-platform.c b/arch/mips/sgi-ip32/ip32-platform.c
index 7309e48..89a71f4 100644
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
-	uart8250_data[1].membase = (void __iomem *) &mace->isa.serial1;
-
 	return platform_device_register(&uart8250_device);
 }
 

-- 
Martin Michlmayr
http://www.cyrius.com/
