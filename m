Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Feb 2010 12:31:50 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44672 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491850Ab0BTLbq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 20 Feb 2010 12:31:46 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1KBVcxr004265;
        Sat, 20 Feb 2010 12:31:40 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1KBVaUI004151;
        Sat, 20 Feb 2010 12:31:36 +0100
Date:   Sat, 20 Feb 2010 12:31:34 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org, Yoichi Yuasa <yuasa@linux-mips.org>,
        Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Reverting old hack
Message-ID: <20100220113134.GA27194@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Below 9f7670e4ddd940d95e48997c2da51614e5fde2cf, an old hack which I
committed in December '07 I think mostly for Cobalt machines.  This is
now getting in the way - in fact the whole loop in
pcibios_fixup_device_resources() may have to go.  So I wonder if this
old hack is still necessary.  Only testing can answer so I'm going to
put a patch to revert this into the -queue tree for 2.6.34.

  Ralf

[MIPS] PCI: Make pcibios_fixup_device_resources ignore legacy resources.

There might be other reasons why a resource might be marked as fixed
such as a PCI UART holding the system console but until we use
IORESOURCE_PCI_FIXED that way also this will work.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 589b745..6e6981f 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -242,6 +242,8 @@ static void pcibios_fixup_device_resources(struct pci_dev *dev,
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		if (!dev->resource[i].start)
 			continue;
+		if (dev->resource[i].flags & IORESOURCE_PCI_FIXED)
+			continue;
 		if (dev->resource[i].flags & IORESOURCE_IO)
 			offset = hose->io_offset;
 		else if (dev->resource[i].flags & IORESOURCE_MEM)
