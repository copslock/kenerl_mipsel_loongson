Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2008 23:26:03 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:5312 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28580049AbYAKXZY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jan 2008 23:25:24 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JDTFb-0002t5-00; Sat, 12 Jan 2008 00:25:23 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 64772C2F2A; Sat, 12 Jan 2008 00:25:14 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Fix ethernet interrupts for Cobalt RaQ1
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080111232514.64772C2F2A@solo.franken.de>
Date:	Sat, 12 Jan 2008 00:25:14 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

RAQ1 uses the same interrupt routing as qube2.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/pci/fixup-cobalt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pci/fixup-cobalt.c b/arch/mips/pci/fixup-cobalt.c
index f7df114..9553b14 100644
--- a/arch/mips/pci/fixup-cobalt.c
+++ b/arch/mips/pci/fixup-cobalt.c
@@ -177,7 +177,7 @@ static char irq_tab_raq2[] __initdata = {
 
 int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	if (cobalt_board_id < COBALT_BRD_ID_QUBE2)
+	if (cobalt_board_id <= COBALT_BRD_ID_QUBE1)
 		return irq_tab_qube1[slot];
 
 	if (cobalt_board_id == COBALT_BRD_ID_RAQ2)
