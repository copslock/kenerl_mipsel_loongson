Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2003 14:51:14 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:64129 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224861AbTEWNvL>;
	Fri, 23 May 2003 14:51:11 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h4NDotLT005864;
	Fri, 23 May 2003 15:50:56 +0200 (MEST)
Date: Fri, 23 May 2003 15:51:00 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: [PATCH] pci_alloc_consistent() crash
Message-ID: <Pine.GSO.4.21.0305231549510.26586-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

	Hi Ralf,

Avoid a NULL-pointer dereference when using pci_alloc_consistent() for PCI-like
buses (i.e. hwdev = NULL).

--- linux-mips-2.4.x/arch/mips/kernel/pci-dma.c	Tue Apr  1 16:21:18 2003
+++ linux/arch/mips/kernel/pci-dma.c	Thu May 15 18:17:35 2003
@@ -21,6 +21,7 @@
 {
 	void *ret;
 	int gfp = GFP_ATOMIC;
+	struct pci_bus *bus = NULL;
 
 #ifdef CONFIG_ISA
 	if (hwdev == NULL || hwdev->dma_mask != 0xffffffff)
@@ -30,7 +31,9 @@
 
 	if (ret != NULL) {
 		memset(ret, 0, size);
-		*dma_handle = bus_to_baddr(hwdev->bus, __pa(ret));
+		if (hwdev)
+			bus = hwdev->bus;
+		*dma_handle = bus_to_baddr(bus, __pa(ret));
 #ifdef CONFIG_NONCOHERENT_IO
 		dma_cache_wback_inv((unsigned long) ret, size);
 		ret = UNCAC_ADDR(ret);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
