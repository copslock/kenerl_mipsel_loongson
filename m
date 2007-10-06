Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Oct 2007 18:58:24 +0100 (BST)
Received: from host79-217-dynamic.0-79-r.retail.telecomitalia.it ([79.0.217.79]:42936
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20025923AbXJFR6P (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 6 Oct 2007 18:58:15 +0100
Received: from giuseppe by eppesuigoccas.homedns.org with local (Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IeDrj-0002u6-2B; Sat, 06 Oct 2007 19:55:03 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]v2 mips/ip32: enable PCI bridges
Cc:	linux-mips@linux-mips.org
Message-Id: <E1IeDrj-0002u6-2B@eppesuigoccas.homedns.org>
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Date:	Sat, 06 Oct 2007 19:55:03 +0200
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Correct a typo in previous patch.

Signed-off-by: Giuseppe Sacco <eppesuig@debian.org>
---

Hi Ralf and linux-mips list,
I recompiled the kernel once again, after having update my git repository
and figured out an error in my previous patch. This should fix it.

Bye,
Giuseppe

diff --git a/arch/mips/pci/ops-mace.c b/arch/mips/pci/ops-mace.c
index 2025f1f..fe54514 100644
--- a/arch/mips/pci/ops-mace.c
+++ b/arch/mips/pci/ops-mace.c
@@ -33,7 +33,7 @@ static inline int mkaddr(struct pci_bus *bus, unsigned int devfn,
 	unsigned int reg)
 {
 	return ((bus->number & 0xff) << 16) |
-		(devfn & 0xff) << 8) |
+		((devfn & 0xff) << 8) |
 		(reg & 0xfc);
 }
 
