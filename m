Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Dec 2004 17:25:34 +0000 (GMT)
Received: from coderock.org ([IPv6:::ffff:193.77.147.115]:63196 "EHLO
	trashy.coderock.org") by linux-mips.org with ESMTP
	id <S8225246AbULYRY6>; Sat, 25 Dec 2004 17:24:58 +0000
Received: by trashy.coderock.org (Postfix, from userid 780)
	id 979791F126; Sat, 25 Dec 2004 18:24:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 94AED1F124;
	Sat, 25 Dec 2004 18:24:46 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 3056B1F123;
	Sat, 25 Dec 2004 18:24:43 +0100 (CET)
Subject: [patch 2/9] delete unused file
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, domen@coderock.org
From: domen@coderock.org
Date: Sat, 25 Dec 2004 18:24:53 +0100
Message-Id: <20041225172443.3056B1F123@trashy.coderock.org>
Return-Path: <domen@coderock.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen@coderock.org
Precedence: bulk
X-list: linux-mips


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/arch/mips/pmc-sierra/yosemite/ht-irq.c |   53 ------------------------------
 1 files changed, 53 deletions(-)

diff -L arch/mips/pmc-sierra/yosemite/ht-irq.c -puN arch/mips/pmc-sierra/yosemite/ht-irq.c~remove_file-arch_mips_pmc_sierra_yosemite_ht_irq.c /dev/null
--- kj/arch/mips/pmc-sierra/yosemite/ht-irq.c
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
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
_
