Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 17:36:38 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:1360 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20025032AbXLJRg3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Dec 2007 17:36:29 +0000
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id E09B48816; Mon, 10 Dec 2007 22:36:28 +0400 (SAMT)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH] Alchemy: fix off by two error in __fixup_bigphys_addr()
Date:	Mon, 10 Dec 2007 20:36:50 +0300
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200712102036.50247.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

he PCI specific code in this function doesn't check for the address range being
under the upper bound of the PCI memory window correctly -- fix this, somewhat
beautifying the code around the check, while at it...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
 arch/mips/au1000/common/setup.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

Index: linux-2.6/arch/mips/au1000/common/setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/setup.c
+++ linux-2.6/arch/mips/au1000/common/setup.c
@@ -137,12 +137,11 @@ phys_t __fixup_bigphys_addr(phys_t phys_
 
 #ifdef CONFIG_PCI
 	{
-		u32 start, end;
+		u32 start = (u32)Au1500_PCI_MEM_START;
+		u32 end   = (u32)Au1500_PCI_MEM_END;
 
-		start = (u32)Au1500_PCI_MEM_START;
-		end = (u32)Au1500_PCI_MEM_END;
-		/* check for pci memory window */
-		if ((phys_addr >= start) && ((phys_addr + size) < end))
+		/* Check for PCI memory window */
+		if (phys_addr >= start && (phys_addr + size - 1) <= end)
 			return (phys_t)
 			       ((phys_addr - start) + Au1500_PCI_MEM_START);
 	}
