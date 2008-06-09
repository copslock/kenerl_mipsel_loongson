Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2008 17:20:02 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:53231 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20031030AbYFIQUA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Jun 2008 17:20:00 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m59GJtEa028053;
	Mon, 9 Jun 2008 18:19:55 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m59GJsCH028049;
	Mon, 9 Jun 2008 17:19:54 +0100
Date:	Mon, 9 Jun 2008 17:19:53 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Daniel Jacobowitz <drow@false.org>, linux-mips@linux-mips.org
Subject: [PATCH 1/2] mips: Remove obsolete isa_slot_offset
Message-ID: <Pine.LNX.4.55.0806091655480.26593@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 The isa_slot_offset variable and its __ISA_IO_base macro is not used
anywhere anymore.  It does not look like a decent interface per today's
standards either.  Remove both including all places of initialization.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Hello,

 This is the first half of a set of two changes resulting from my
investigation of how proper iomap support should be done for the SB1250 in
response to a report from Daniel.  Tested successfully with a SWARM board
with no regressions.

 Please apply.

  Maciej

patch-2.6.26-rc1-20080505-isa-slot-offset-0
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/arch/mips/jazz/setup.c linux-2.6.26-rc1-20080505/arch/mips/jazz/setup.c
--- linux-2.6.26-rc1-20080505.macro/arch/mips/jazz/setup.c	2008-05-05 02:55:23.000000000 +0000
+++ linux-2.6.26-rc1-20080505/arch/mips/jazz/setup.c	2008-06-08 23:37:22.000000000 +0000
@@ -79,7 +79,6 @@ void __init plat_mem_setup(void)
 	if (mips_machtype == MACH_MIPS_MAGNUM_4000)
 		EISA_bus = 1;
 #endif
-	isa_slot_offset = 0xe3000000;
 
 	/* request I/O space for devices used on all i[345]86 PCs */
 	for (i = 0; i < ARRAY_SIZE(jazz_io_resources); i++)
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/arch/mips/kernel/setup.c linux-2.6.26-rc1-20080505/arch/mips/kernel/setup.c
--- linux-2.6.26-rc1-20080505.macro/arch/mips/kernel/setup.c	2008-05-05 02:55:23.000000000 +0000
+++ linux-2.6.26-rc1-20080505/arch/mips/kernel/setup.c	2008-06-08 23:38:07.000000000 +0000
@@ -68,13 +68,6 @@ static char command_line[CL_SIZE];
 const unsigned long mips_io_port_base __read_mostly = -1;
 EXPORT_SYMBOL(mips_io_port_base);
 
-/*
- * isa_slot_offset is the address where E(ISA) busaddress 0 is mapped
- * for the processor.
- */
-unsigned long isa_slot_offset;
-EXPORT_SYMBOL(isa_slot_offset);
-
 static struct resource code_resource = { .name = "Kernel code", };
 static struct resource data_resource = { .name = "Kernel data", };
 
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/arch/mips/pci/pci-bcm1480.c linux-2.6.26-rc1-20080505/arch/mips/pci/pci-bcm1480.c
--- linux-2.6.26-rc1-20080505.macro/arch/mips/pci/pci-bcm1480.c	2008-05-05 02:55:23.000000000 +0000
+++ linux-2.6.26-rc1-20080505/arch/mips/pci/pci-bcm1480.c	2008-06-08 23:39:17.000000000 +0000
@@ -254,8 +254,6 @@ static int __init bcm1480_pcibios_init(v
 		ioremap(A_BCM1480_PHYS_PCI_IO_MATCH_BYTES, 65536);
 	bcm1480_controller.io_map_base -= bcm1480_controller.io_offset;
 	set_io_port_base(bcm1480_controller.io_map_base);
-	isa_slot_offset = (unsigned long)
-		ioremap(A_BCM1480_PHYS_PCI_MEM_MATCH_BYTES, 1024*1024);
 
 	register_pci_controller(&bcm1480_controller);
 
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/arch/mips/pci/pci-sb1250.c linux-2.6.26-rc1-20080505/arch/mips/pci/pci-sb1250.c
--- linux-2.6.26-rc1-20080505.macro/arch/mips/pci/pci-sb1250.c	2007-10-11 04:56:52.000000000 +0000
+++ linux-2.6.26-rc1-20080505/arch/mips/pci/pci-sb1250.c	2008-06-08 23:39:46.000000000 +0000
@@ -256,8 +256,6 @@ static int __init sb1250_pcibios_init(vo
 
 	set_io_port_base((unsigned long)
 			 ioremap(A_PHYS_LDTPCI_IO_MATCH_BYTES, 65536));
-	isa_slot_offset = (unsigned long)
-	    ioremap(A_PHYS_LDTPCI_IO_MATCH_BYTES_32, 1024 * 1024);
 
 #ifdef CONFIG_SIBYTE_HAS_LDT
 	/*
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/arch/mips/sni/setup.c linux-2.6.26-rc1-20080505/arch/mips/sni/setup.c
--- linux-2.6.26-rc1-20080505.macro/arch/mips/sni/setup.c	2008-05-05 02:55:23.000000000 +0000
+++ linux-2.6.26-rc1-20080505/arch/mips/sni/setup.c	2008-06-08 23:40:05.000000000 +0000
@@ -116,7 +116,6 @@ void __init plat_mem_setup(void)
 	/*
 	 * Setup (E)ISA I/O memory access stuff
 	 */
-	isa_slot_offset = CKSEG1ADDR(0xb0000000);
 #ifdef CONFIG_EISA
 	EISA_bus = 1;
 #endif
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/include/asm-mips/io.h linux-2.6.26-rc1-20080505/include/asm-mips/io.h
--- linux-2.6.26-rc1-20080505.macro/include/asm-mips/io.h	2008-05-05 02:55:55.000000000 +0000
+++ linux-2.6.26-rc1-20080505/include/asm-mips/io.h	2008-06-08 23:23:23.000000000 +0000
@@ -161,13 +161,6 @@ static inline void * isa_bus_to_virt(uns
 #define bus_to_virt phys_to_virt
 
 /*
- * isa_slot_offset is the address where E(ISA) busaddress 0 is mapped
- * for the processor.  This implies the assumption that there is only
- * one of these busses.
- */
-extern unsigned long isa_slot_offset;
-
-/*
  * Change "struct page" to physical address.
  */
 #define page_to_phys(page)	((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
@@ -528,16 +521,6 @@ static inline void memcpy_toio(volatile 
 }
 
 /*
- * ISA space is 'always mapped' on currently supported MIPS systems, no need
- * to explicitly ioremap() it. The fact that the ISA IO space is mapped
- * to PAGE_OFFSET is pure coincidence - it does not mean ISA values
- * are physical addresses. The following constant pointer can be
- * used as the IO-area pointer (it can be iounmapped as well, so the
- * analogy with PCI is quite large):
- */
-#define __ISA_IO_base ((char *)(isa_slot_offset))
-
-/*
  * The caches on some architectures aren't dma-coherent and have need to
  * handle this in software.  There are three types of operations that
  * can be applied to dma buffers.
