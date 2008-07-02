Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2008 20:06:17 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:33459 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S23869175AbYGBTGH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Jul 2008 20:06:07 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KE7eW-0000rd-00; Wed, 02 Jul 2008 21:06:04 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 26B63C214C; Wed,  2 Jul 2008 21:06:03 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Enable FAST-20 for onboard scsi
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080702190603.26B63C214C@solo.franken.de>
Date:	Wed,  2 Jul 2008 21:06:03 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Both onboard controller of the O2 support FAST-20 transfer speeds,
but the bit, which signals that to the aic driver, isn't set. Instead
of adding detection code to the scsi driver, we just fake the missing
bit in the PCI config space of the scsi chips.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/pci/ops-mace.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/pci/ops-mace.c b/arch/mips/pci/ops-mace.c
index e958818..1cfb558 100644
--- a/arch/mips/pci/ops-mace.c
+++ b/arch/mips/pci/ops-mace.c
@@ -61,6 +61,13 @@ mace_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	/* ack possible master abort */
 	mace->pci.error &= ~MACEPCI_ERROR_MASTER_ABORT;
 	mace->pci.control = control;
+	/*
+	 * someone forgot to set the ultra bit for the onboard
+	 * scsi chips; we fake it here
+	 */
+	if (bus->number == 0 && reg == 0x40 && size == 4 &&
+	    (devfn == (1 << 3) || devfn == (2 << 3)))
+		*val |= 0x1000;
 
 	DPRINTK("read%d: reg=%08x,val=%02x\n", size * 8, reg, *val);
 
