Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Jun 2003 20:39:19 +0100 (BST)
Received: from janus.foobazco.org ([IPv6:::ffff:198.144.194.226]:61825 "EHLO
	mail.foobazco.org") by linux-mips.org with ESMTP
	id <S8225073AbTFNTjR>; Sat, 14 Jun 2003 20:39:17 +0100
Received: from fallout.sjc.foobazco.org (fallout.sjc.foobazco.org [192.168.21.20])
	by mail.foobazco.org (Postfix) with ESMTP
	id AEBBCFACE; Sat, 14 Jun 2003 12:39:13 -0700 (PDT)
Received: by fallout.sjc.foobazco.org (Postfix, from userid 1014)
	id 6290224; Sat, 14 Jun 2003 12:39:13 -0700 (PDT)
Date: Sat, 14 Jun 2003 12:39:13 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: PATCH: ip32 pci update
Message-ID: <20030614193913.GA25863@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Return-Path: <wesolows@foobazco.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wesolows@foobazco.org
Precedence: bulk
X-list: linux-mips

Since we're chainsawing PCI anyway, here's an update to the IP32 code.

diff -urN -x CVS 2.5-mips/arch/mips/sgi-ip32/ip32-pci.c 2.5-mips-moosehead/arch/mips/sgi-ip32/ip32-pci.c
--- 2.5-mips/arch/mips/sgi-ip32/ip32-pci.c	2003-06-04 17:04:31.000000000 -0700
+++ 2.5-mips-moosehead/arch/mips/sgi-ip32/ip32-pci.c	2003-06-14 12:33:19.952495096 -0700
@@ -135,9 +135,6 @@
 	mace_write_32 (MACEPCI_ERROR_ADDR, 0);
 	mace_write_32 (MACEPCI_ERROR_FLAGS, 0);
 	mace_write_32 (MACEPCI_CONTROL, 0xff008500);
-	crime_write_64 (CRIME_HARD_INT, 0UL);
-	crime_write_64 (CRIME_SOFT_INT, 0UL);
-	crime_write_64 (CRIME_INT_STAT, 0x000000000000ff00UL);
 
 	if (request_irq (MACE_PCI_BRIDGE_IRQ, macepci_error, 0,
 			 "MACE PCI error", NULL))
@@ -214,26 +211,6 @@
 		pci_write_config_word (dev, PCI_COMMAND, cmd);
 		pci_set_master (dev);
 	}
-        /*
-         * Fixup O2 PCI slot. Bad hack.
-         */
-/*        devtag = pci_make_tag(0, 0, 3, 0);
-
-        slot = macepci_conf_read(0, devtag, PCI_COMMAND_STATUS_REG);
-        slot |= PCI_COMMAND_IO_ENABLE | PCI_COMMAND_MEM_ENABLE;
-        macepci_conf_write(0, devtag, PCI_COMMAND_STATUS_REG, slot);
-
-        slot = macepci_conf_read(0, devtag, PCI_MAPREG_START);
-        if (slot == 0xffffffe1)
-                macepci_conf_write(0, devtag, PCI_MAPREG_START, 0x00001000);
-
-        slot = macepci_conf_read(0, devtag, PCI_MAPREG_START + (2 << 2));
-        if ((slot & 0xffff0000) == 0) {
-                slot += 0x00010000;
-                macepci_conf_write(0, devtag, PCI_MAPREG_START + (2 << 2),
-                    0x00000000);
-        }
- */
 #ifdef DEBUG_MACE_PCI
 	printk ("Triggering PCI bridge interrupt...\n");
 	mace_write_32 (MACEPCI_ERROR_FLAGS, MACEPCI_ERROR_INTERRUPT_TEST);


-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
