Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Feb 2005 14:57:11 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:15489 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225756AbVBTO44>; Sun, 20 Feb 2005 14:56:56 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1D2sVy-0006w4-00; Sun, 20 Feb 2005 14:56:54 +0000
Date:	Sun, 20 Feb 2005 14:56:53 +0000
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2.6] Cobalts fixes [2 of 6]
Message-ID: <20050220145653.GB26582@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Fix Qube/RaQ PCI support under 2.6.

P.

--- linux-cvs/arch/mips/pci/fixup-cobalt.c	2004-10-31 16:07:33.000000000 +0000
+++ linux-wip/arch/mips/pci/fixup-cobalt.c	2005-02-20 14:10:39.000000000 +0000
@@ -47,6 +47,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
 static void qube_raq_galileo_fixup(struct pci_dev *dev)
 {
 	unsigned short galileo_id;
+	int i;
 
 	/* Fix PCI latency-timer and cache-line-size values in Galileo
 	 * host bridge.
@@ -55,6 +56,13 @@ static void qube_raq_galileo_fixup(struc
 	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, 7);
 
 	/*
+	 * The code described by the comment below has been removed
+	 * as it causes bus mastering by the Ethernet controllers
+	 * to break under any kind of network load. We always set
+	 * the retry timeouts to their maximum.
+	 *
+	 * --x--x--x--x--x--x--x--x--x--x--x--x--x--x--x--x--x--x--x--x--
+	 *
 	 * On all machines prior to Q2, we had the STOP line disconnected
 	 * from Galileo to VIA on PCI.  The new Galileo does not function
 	 * correctly unless we have it connected.
@@ -64,19 +72,34 @@ static void qube_raq_galileo_fixup(struc
 	 */
 	pci_read_config_word(dev, PCI_REVISION_ID, &galileo_id);
 	galileo_id &= 0xff;	/* mask off class info */
+
+ 	printk("Galileo ID: %u\n", galileo_id);
+
+#if 0
 	if (galileo_id >= 0x10) {
 		/* New Galileo, assumes PCI stop line to VIA is connected. */
 		GALILEO_OUTL(0x4020, GT_PCI0_TOR_OFS);
-	} else if (galileo_id == 0x1 || galileo_id == 0x2) {
+	} else if (galileo_id == 0x1 || galileo_id == 0x2)
+#endif
+	{
 		signed int timeo;
 		/* XXX WE MUST DO THIS ELSE GALILEO LOCKS UP! -DaveM */
 		timeo = GALILEO_INL(GT_PCI0_TOR_OFS);
 		/* Old Galileo, assumes PCI STOP line to VIA is disconnected. */
 		GALILEO_OUTL(0xffff, GT_PCI0_TOR_OFS);
 	}
+
+	/*
+	 * hide Galileo from the kernel's PCI resource assignment. The BARs
+	 * on Galileo will already have been set up by the boot loader to
+	 * match the DRAM configuration so we don't want them being monkeyed
+	 * around with.
+	 */
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; ++i)
+		dev->resource[i].start = dev->resource[i].end = dev->resource[i].flags = 0;
 }
 
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GALILEO, PCI_ANY_ID,
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_ANY_ID,
 	 qube_raq_galileo_fixup);
 
 static char irq_tab_cobalt[] __initdata = {
--- linux-cvs/include/asm-mips/cobalt/mach-gt64120.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-wip/include/asm-mips/cobalt/mach-gt64120.h	2005-02-20 13:48:22.000000000 +0000
@@ -0,0 +1 @@
+/* there's something here ... in the dark */
