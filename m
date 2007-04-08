Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Apr 2007 12:38:36 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:40886 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022053AbXDHLiL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 8 Apr 2007 12:38:11 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1HaVfh-0003wA-01
	for linux-mips@linux-mips.org; Sun, 08 Apr 2007 13:35:01 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 4FFADC223A; Sun,  8 Apr 2007 13:34:57 +0200 (CEST)
Date:	Sun, 8 Apr 2007 13:34:57 +0200
To:	linux-mips@linux-mips.org
Subject: [PATCH] Change PCI host bridge setup/resources
Message-ID: <20070408113457.GB7553@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

PCI host bridge setup for SNI RM machines with PCI is quite broken, now that
Linux does it's resource setup own its own. It will use IO addresses,
which are needed by the EISA config detection and assigns PCI memory
addresses, which overlap with ISA legacy addresses (video ram). Below
is a patch, which changes the way how the PCI memory addresses are
used and sets the minimum IO address to give enough IO space for
8 EISA slots). This patch needs the other PCI resource change, I've
posted.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---


diff --git a/arch/mips/sni/pcit.c b/arch/mips/sni/pcit.c
index 1dfc3f0..00d151f 100644
--- a/arch/mips/sni/pcit.c
+++ b/arch/mips/sni/pcit.c
@@ -43,7 +43,7 @@ static struct platform_device pcit_serial8250_device = {
 };
 
 static struct plat_serial8250_port pcit_cplus_data[] = {
-	PORT(0x3f8, 4),
+	PORT(0x3f8, 0),
 	PORT(0x2f8, 3),
 	PORT(0x3e8, 4),
 	PORT(0x2e8, 3),
@@ -59,9 +59,9 @@ static struct platform_device pcit_cplus_serial8250_device = {
 };
 
 static struct resource sni_io_resource = {
-	.start	= 0x00001000UL,
+	.start	= 0x00000000UL,
 	.end	= 0x03bfffffUL,
-	.name	= "PCIT IO MEM",
+	.name	= "PCIT IO",
 	.flags	= IORESOURCE_IO,
 };
 
@@ -92,6 +92,11 @@ static struct resource pcit_io_resources[] = {
 		.name	= "dma2",
 		.flags	= IORESOURCE_BUSY
 	}, {
+		.start	=  0xcf8,
+		.end	= 0xcfb,
+		.name	= "PCI config addr",
+		.flags	= IORESOURCE_BUSY
+	}, {
 		.start	=  0xcfc,
 		.end	= 0xcff,
 		.name	= "PCI config data",
@@ -100,107 +105,19 @@ static struct resource pcit_io_resources[] = {
 };
 
 static struct resource sni_mem_resource = {
-	.start	= 0x10000000UL,
-	.end	= 0xffffffffUL,
+	.start	= 0x18000000UL,
+	.end	= 0x1fbfffffUL,
 	.name	= "PCIT PCI MEM",
 	.flags	= IORESOURCE_MEM
 };
 
-/*
- * The RM200/RM300 has a few holes in it's PCI/EISA memory address space used
- * for other purposes.  Be paranoid and allocate all of the before the PCI
- * code gets a chance to to map anything else there ...
- *
- * This leaves the following areas available:
- *
- * 0x10000000 - 0x1009ffff (640kB) PCI/EISA/ISA Bus Memory
- * 0x10100000 - 0x13ffffff ( 15MB) PCI/EISA/ISA Bus Memory
- * 0x18000000 - 0x1fbfffff (124MB) PCI/EISA Bus Memory
- * 0x1ff08000 - 0x1ffeffff (816kB) PCI/EISA Bus Memory
- * 0xa0000000 - 0xffffffff (1.5GB) PCI/EISA Bus Memory
- */
-static struct resource pcit_mem_resources[] = {
-	{
-		.start	= 0x14000000,
-		.end	= 0x17bfffff,
-		.name	= "PCI IO",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x17c00000,
-		.end	= 0x17ffffff,
-		.name	= "Cache Replacement Area",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x180a0000,
-		.end	= 0x180bffff,
-		.name	= "Video RAM area",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x180c0000,
-		.end	= 0x180fffff,
-		.name	= "ISA Reserved",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x19000000,
-		.end	= 0x1fbfffff,
-		.name	= "PCI MEM",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x1fc00000,
-		.end	= 0x1fc7ffff,
-		.name	= "Boot PROM",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x1fc80000,
-		.end	= 0x1fcfffff,
-		.name	= "Diag PROM",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x1fd00000,
-		.end	= 0x1fdfffff,
-		.name	= "X-Bus",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x1fe00000,
-		.end	= 0x1fefffff,
-		.name	= "BIOS map",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x1ff00000,
-		.end	= 0x1ff7ffff,
-		.name	= "NVRAM / EEPROM",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x1fff0000,
-		.end	= 0x1fffefff,
-		.name	= "MAUI ASIC",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x1ffff000,
-		.end	= 0x1fffffff,
-		.name	= "MP Agent",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x20000000,
-		.end	= 0x9fffffff,
-		.name	= "Main Memory",
-		.flags	= IORESOURCE_BUSY
-	}
-};
-
 static void __init sni_pcit_resource_init(void)
 {
 	int i;
 
 	/* request I/O space for devices used on all i[345]86 PCs */
 	for (i = 0; i < ARRAY_SIZE(pcit_io_resources); i++)
-		request_resource(&ioport_resource, pcit_io_resources + i);
-
-	/* request mem space for pcimt-specific devices */
-	for (i = 0; i < ARRAY_SIZE(pcit_mem_resources); i++)
-		request_resource(&sni_mem_resource, pcit_mem_resources + i);
-
-	ioport_resource.end = sni_io_resource.end;
+		request_resource(&sni_io_resource, pcit_io_resources + i);
 }
 
 
@@ -209,9 +126,10 @@ extern struct pci_ops sni_pcit_ops;
 static struct pci_controller sni_pcit_controller = {
 	.pci_ops	= &sni_pcit_ops,
 	.mem_resource	= &sni_mem_resource,
-	.mem_offset	= 0x10000000UL,
+	.mem_offset	= 0x00000000UL,
 	.io_resource	= &sni_io_resource,
-	.io_offset	= 0x00000000UL
+	.io_offset	= 0x00000000UL,
+	.io_map_base    = SNI_PORT_BASE
 };
 
 static void enable_pcit_irq(unsigned int irq)
@@ -262,7 +180,7 @@ static void pcit_hwint0(void)
 	int irq;
 
 	clear_c0_status(IE_IRQ0);
-	irq = ffs((pending >> 16) & 0x7f);
+	irq = ffs((pending >> 16) & 0x3f);
 
 	if (likely(irq > 0))
 		do_IRQ (irq + SNI_PCIT_INT_START - 1);
@@ -289,6 +207,8 @@ static void sni_pcit_hwint_cplus(void)
 
 	if (pending & C_IRQ0)
 		pcit_hwint0();
+	else if (pending & C_IRQ1)
+		do_IRQ (MIPS_CPU_IRQ_BASE + 3);
 	else if (pending & C_IRQ2)
 		do_IRQ (MIPS_CPU_IRQ_BASE + 4);
 	else if (pending & C_IRQ3)
@@ -317,21 +237,23 @@ void __init sni_pcit_cplus_irq_init(void)
 	mips_cpu_irq_init();
 	for (i = SNI_PCIT_INT_START; i <= SNI_PCIT_INT_END; i++)
 		set_irq_chip(i, &pcit_irq_type);
-	*(volatile u32 *)SNI_PCIT_INT_REG = 0;
+	*(volatile u32 *)SNI_PCIT_INT_REG = 0x40000000;
 	sni_hwint = sni_pcit_hwint_cplus;
 	change_c0_status(ST0_IM, IE_IRQ0);
-	setup_irq (SNI_PCIT_INT_START + 6, &sni_isa_irq);
+	setup_irq (MIPS_CPU_IRQ_BASE + 3, &sni_isa_irq);
 }
 
 void sni_pcit_init(void)
 {
-	sni_pcit_resource_init();
 	rtc_mips_get_time = mc146818_get_cmos_time;
 	rtc_mips_set_time = mc146818_set_rtc_mmss;
 	board_time_init = sni_cpu_time_init;
+	ioport_resource.end = sni_io_resource.end;
 #ifdef CONFIG_PCI
+	PCIBIOS_MIN_IO = 0x9000;
 	register_pci_controller(&sni_pcit_controller);
 #endif
+	sni_pcit_resource_init();
 }
 
 static int __init snirm_pcit_setup_devinit(void)
diff --git a/arch/mips/sni/pcimt.c b/arch/mips/sni/pcimt.c
index 8e8593b..9ee208d 100644
--- a/arch/mips/sni/pcimt.c
+++ b/arch/mips/sni/pcimt.c
@@ -91,7 +91,7 @@ static struct platform_device pcimt_serial8250_device = {
 };
 
 static struct resource sni_io_resource = {
-	.start	= 0x00001000UL,
+	.start	= 0x00000000UL,
 	.end	= 0x03bfffffUL,
 	.name	= "PCIMT IO MEM",
 	.flags	= IORESOURCE_IO,
@@ -132,107 +132,19 @@ static struct resource pcimt_io_resources[] = {
 };
 
 static struct resource sni_mem_resource = {
-	.start	= 0x10000000UL,
-	.end	= 0xffffffffUL,
+	.start	= 0x18000000UL,
+	.end	= 0x1fbfffffUL,
 	.name	= "PCIMT PCI MEM",
 	.flags	= IORESOURCE_MEM
 };
 
-/*
- * The RM200/RM300 has a few holes in it's PCI/EISA memory address space used
- * for other purposes.  Be paranoid and allocate all of the before the PCI
- * code gets a chance to to map anything else there ...
- *
- * This leaves the following areas available:
- *
- * 0x10000000 - 0x1009ffff (640kB) PCI/EISA/ISA Bus Memory
- * 0x10100000 - 0x13ffffff ( 15MB) PCI/EISA/ISA Bus Memory
- * 0x18000000 - 0x1fbfffff (124MB) PCI/EISA Bus Memory
- * 0x1ff08000 - 0x1ffeffff (816kB) PCI/EISA Bus Memory
- * 0xa0000000 - 0xffffffff (1.5GB) PCI/EISA Bus Memory
- */
-static struct resource pcimt_mem_resources[] = {
-	{
-		.start	= 0x100a0000,
-		.end	= 0x100bffff,
-		.name	= "Video RAM area",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x100c0000,
-		.end	= 0x100fffff,
-		.name	= "ISA Reserved",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x14000000,
-		.end	= 0x17bfffff,
-		.name	= "PCI IO",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x17c00000,
-		.end	= 0x17ffffff,
-		.name	= "Cache Replacement Area",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x1a000000,
-		.end	= 0x1a000003,
-		.name	= "PCI INT Acknowledge",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x1fc00000,
-		.end	= 0x1fc7ffff,
-		.name	= "Boot PROM",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x1fc80000,
-		.end	= 0x1fcfffff,
-		.name	= "Diag PROM",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x1fd00000,
-		.end	= 0x1fdfffff,
-		.name	= "X-Bus",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x1fe00000,
-		.end	= 0x1fefffff,
-		.name	= "BIOS map",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x1ff00000,
-		.end	= 0x1ff7ffff,
-		.name	= "NVRAM / EEPROM",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x1fff0000,
-		.end	= 0x1fffefff,
-		.name	= "ASIC PCI",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x1ffff000,
-		.end	= 0x1fffffff,
-		.name	= "MP Agent",
-		.flags	= IORESOURCE_BUSY
-	}, {
-		.start	= 0x20000000,
-		.end	= 0x9fffffff,
-		.name	= "Main Memory",
-		.flags	= IORESOURCE_BUSY
-	}
-};
-
 static void __init sni_pcimt_resource_init(void)
 {
 	int i;
 
 	/* request I/O space for devices used on all i[345]86 PCs */
 	for (i = 0; i < ARRAY_SIZE(pcimt_io_resources); i++)
-		request_resource(&ioport_resource, pcimt_io_resources + i);
-
-	/* request mem space for pcimt-specific devices */
-	for (i = 0; i < ARRAY_SIZE(pcimt_mem_resources); i++)
-		request_resource(&sni_mem_resource, pcimt_mem_resources + i);
-
-	ioport_resource.end = sni_io_resource.end;
+		request_resource(&sni_io_resource, pcimt_io_resources + i);
 }
 
 extern struct pci_ops sni_pcimt_ops;
@@ -240,9 +152,10 @@ extern struct pci_ops sni_pcimt_ops;
 static struct pci_controller sni_controller = {
 	.pci_ops	= &sni_pcimt_ops,
 	.mem_resource	= &sni_mem_resource,
-	.mem_offset	= 0x10000000UL,
+	.mem_offset	= 0x00000000UL,
 	.io_resource	= &sni_io_resource,
-	.io_offset	= 0x00000000UL
+	.io_offset	= 0x00000000UL,
+	.io_map_base    = SNI_PORT_BASE
 };
 
 static void enable_pcimt_irq(unsigned int irq)
@@ -363,15 +276,17 @@ void __init sni_pcimt_irq_init(void)
 
 void sni_pcimt_init(void)
 {
-	sni_pcimt_resource_init();
 	sni_pcimt_detect();
 	sni_pcimt_sc_init();
 	rtc_mips_get_time = mc146818_get_cmos_time;
 	rtc_mips_set_time = mc146818_set_rtc_mmss;
 	board_time_init = sni_cpu_time_init;
+	ioport_resource.end = sni_io_resource.end;
 #ifdef CONFIG_PCI
+	PCIBIOS_MIN_IO = 0x9000;
 	register_pci_controller(&sni_controller);
 #endif
+	sni_pcimt_resource_init();
 }
 
 static int __init snirm_pcimt_setup_devinit(void)


-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
