Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jan 2006 21:29:21 +0000 (GMT)
Received: from i-83-67-53-76.freedom2surf.net ([83.67.53.76]:41106 "EHLO
	nephila.localnet") by ftp.linux-mips.org with ESMTP
	id S8133481AbWA2V3E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 29 Jan 2006 21:29:04 +0000
Received: from pdh by nephila.localnet with local (Exim 4.50)
	id 1F3KBA-0000xS-HO; Sun, 29 Jan 2006 21:33:48 +0000
Date:	Sun, 29 Jan 2006 21:33:48 +0000
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2.6.X] Fix Cobalt PCI cache line sizes
Message-ID: <20060129213348.GA3503@colonel-panic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Correct cache line sizes.

P.

Index: linux.git/arch/mips/pci/fixup-cobalt.c
===================================================================
--- linux.git.orig/arch/mips/pci/fixup-cobalt.c	2006-01-29 12:35:50.000000000 +0000
+++ linux.git/arch/mips/pci/fixup-cobalt.c	2006-01-29 12:36:59.000000000 +0000
@@ -52,7 +52,7 @@
 	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &lt);
 	if (lt < 64)
 		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 64);
-	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, 7);
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, 8);
 }
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,
@@ -69,7 +69,7 @@
 	 * host bridge.
 	 */
 	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 64);
-	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, 7);
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, 8);
 
 	/*
 	 * The code described by the comment below has been removed
