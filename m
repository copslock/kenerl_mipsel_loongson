Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 15:02:07 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:37629 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022382AbXIDOB7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2007 15:01:59 +0100
Received: from localhost (p7110-ipad205funabasi.chiba.ocn.ne.jp [222.146.102.110])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A3350D7AD; Tue,  4 Sep 2007 23:00:36 +0900 (JST)
Date:	Tue, 04 Sep 2007 23:02:02 +0900 (JST)
Message-Id: <20070904.230202.41011018.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	chris@mips.com, linux-mips@linux-mips.org
Subject: Re: [MIPS] SMTC: Fix crash on bootup with idebus= command line
 argument.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070904125010.GA15630@linux-mips.org>
References: <20070904.000501.41013092.anemo@mba.ocn.ne.jp>
	<46DC2D2E.8080408@mips.com>
	<20070904125010.GA15630@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 4 Sep 2007 13:50:10 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > The bug wasn't really SMTC specific, it was just that it showed up on 
> > SMTC builds. The failure was caused by the early parsing of the 
> > idebus=xx argument. The argument parser ended up calling
> > pci_scan that unconditionally enabled interrupts prematurely.
> 
> Which at the time did also happen for x86 - it just happened to be a
> harmless bug there.

Hmm, I see.  Then I think no_pci_device() can be used to avoid such
case, as like as pci_find_subsys().

Anyway the commit 00cc123703425aa362b0af75616134cbad4e0689 may change
ide numbering for swarm or au1xxx (if those platform did not have ISA
brigdes).  How about this?


Subject: No ide_default_io_base() if PCI IDE was not found

Revert b5438582090406e2ccb4169d9b2df7c9939ae42b and add
no_pci_devices() check to avoid crash due to early calling of
pci_get_class().

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/mach-generic/ide.h b/include/asm-mips/mach-generic/ide.h
index 2b92857..a771283 100644
--- a/include/asm-mips/mach-generic/ide.h
+++ b/include/asm-mips/mach-generic/ide.h
@@ -29,6 +29,35 @@
 
 #define IDE_ARCH_OBSOLETE_DEFAULTS
 
+static __inline__ int ide_probe_legacy(void)
+{
+#ifdef CONFIG_PCI
+	struct pci_dev *dev;
+	/*
+	 * This can be called on the ide_setup() path, super-early in
+	 * boot.  But the down_read() will enable local interrupts,
+	 * which can cause some machines to crash.  So here we detect
+	 * and flag that situation and bail out early.
+	 */
+	if (no_pci_devices())
+		return 0;
+	dev = pci_get_class(PCI_CLASS_BRIDGE_EISA << 8, NULL);
+	if (dev)
+		goto found;
+	dev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
+	if (dev)
+		goto found;
+	return 0;
+found:
+	pci_dev_put(dev);
+	return 1;
+#elif defined(CONFIG_EISA) || defined(CONFIG_ISA)
+	return 1;
+#else
+	return 0;
+#endif
+}
+
 static __inline__ int ide_default_irq(unsigned long base)
 {
 	switch (base) {
@@ -45,6 +74,8 @@ static __inline__ int ide_default_irq(unsigned long base)
 
 static __inline__ unsigned long ide_default_io_base(int index)
 {
+	if (!ide_probe_legacy())
+		return 0;
 	/*
 	 *      If PCI is present then it is not safe to poke around
 	 *      the other legacy IDE ports. Only 0x1f0 and 0x170 are
