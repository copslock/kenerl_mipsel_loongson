Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2008 17:20:21 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:55791 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20031402AbYFIQUH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Jun 2008 17:20:07 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m59GK4I0028065;
	Mon, 9 Jun 2008 18:20:04 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m59GK3Fq028059;
	Mon, 9 Jun 2008 17:20:03 +0100
Date:	Mon, 9 Jun 2008 17:20:03 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Daniel Jacobowitz <drow@false.org>, linux-mips@linux-mips.org
Subject: [PATCH 2/2] sb1250: Initialize io_map_base
Message-ID: <Pine.LNX.4.55.0806091659570.26593@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Correctly initialize io_map_base for the SB1250 PCI controller as
required for proper iomap support.  Based on a proposal from Daniel
Jacobowitz.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Hello,

 This is the second half of a set of two changes resulting from my
investigation of how proper iomap support should be done for the SB1250 in
response to a report from Daniel.  This patch has to be applied on top of
the first half.  Tested successfully with a SWARM board and a pair of
DEFPA cards in the port I/O mode on either of the PCI buses each with no
regressions.  Note the driver used does not make use of the iomap feature
at the moment so the feature was not exactly tested, but is conceptually
correct.

 Please apply.

  Maciej

patch-2.6.26-rc1-20080505-drow-sb1250-pci-io-3
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/arch/mips/pci/pci-sb1250.c linux-2.6.26-rc1-20080505/arch/mips/pci/pci-sb1250.c
--- linux-2.6.26-rc1-20080505.macro/arch/mips/pci/pci-sb1250.c	2008-06-08 23:39:46.000000000 +0000
+++ linux-2.6.26-rc1-20080505/arch/mips/pci/pci-sb1250.c	2008-06-08 23:45:01.000000000 +0000
@@ -207,6 +207,7 @@ struct pci_controller sb1250_controller 
 
 static int __init sb1250_pcibios_init(void)
 {
+	void __iomem *io_map_base;
 	uint32_t cmdreg;
 	uint64_t reg;
 	extern int pci_probe_only;
@@ -253,9 +254,9 @@ static int __init sb1250_pcibios_init(vo
 	 * works correctly with most of Linux's drivers.
 	 * XXX ehs: Should this happen in PCI Device mode?
 	 */
-
-	set_io_port_base((unsigned long)
-			 ioremap(A_PHYS_LDTPCI_IO_MATCH_BYTES, 65536));
+	io_map_base = ioremap(A_PHYS_LDTPCI_IO_MATCH_BYTES, 1024 * 1024);
+	sb1250_controller.io_map_base = io_map_base;
+	set_io_port_base((unsigned long)io_map_base);
 
 #ifdef CONFIG_SIBYTE_HAS_LDT
 	/*
