Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2005 22:51:55 +0100 (BST)
Received: from coderock.org ([IPv6:::ffff:193.77.147.115]:4760 "EHLO
	trashy.coderock.org") by linux-mips.org with ESMTP
	id <S8225385AbVFTVun>; Mon, 20 Jun 2005 22:50:43 +0100
Received: by trashy.coderock.org (Postfix, from userid 780)
	id EC6731EDCD; Mon, 20 Jun 2005 23:50:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 298A61EDC7;
	Mon, 20 Jun 2005 23:50:40 +0200 (CEST)
Received: from nd47.coderock.org (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 79AD01EDBE;
	Mon, 20 Jun 2005 23:49:53 +0200 (CEST)
Received: (from domen@localhost)
	by nd47.coderock.org (8.13.3/8.13.3/Submit) id j5KLnrKg021582;
	Mon, 20 Jun 2005 23:49:53 +0200
Message-Id: <20050620214952.761755000@nd47.coderock.org>
Date:	Mon, 20 Jun 2005 23:49:53 +0200
From:	domen@coderock.org
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, domen@coderock.org
Subject: [patch 2/8] delete arch/mips/pmc-sierra/yosemite/ht-irq.c
Content-Disposition: inline; filename=remove_file-arch_mips_pmc_sierra_yosemite_ht_irq.c.patch
Return-Path: <domen@nd47.coderock.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen@coderock.org
Precedence: bulk
X-list: linux-mips




Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---
 ht-irq.c |   53 -----------------------------------------------------
 1 files changed, 53 deletions(-)

Index: quilt/arch/mips/pmc-sierra/yosemite/ht-irq.c
===================================================================
--- quilt.orig/arch/mips/pmc-sierra/yosemite/ht-irq.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * Copyright 2003 PMC-Sierra
- * Author: Manish Lachwani (lachwani@pmc-sierra.com)
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/version.h>
-#include <linux/init.h>
-#include <asm/pci.h>
-
-/*
- * HT Bus fixup for the Titan
- * XXX IRQ values need to change based on the board layout
- */
-void __init titan_ht_pcibios_fixup_bus(struct pci_bus *bus)
-{
-        struct pci_bus *current_bus = bus;
-        struct pci_dev *devices;
-        struct list_head *devices_link;
-
-	list_for_each(devices_link, &(current_bus->devices)) {
-                devices = pci_dev_b(devices_link);
-                if (devices == NULL)
-                        continue;
-	}
-
-	/*
-	 * PLX and SPKT related changes go here
-	 */
-
-}

--
