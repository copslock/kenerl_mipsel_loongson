Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g61IwLnC015768
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 1 Jul 2002 11:58:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g61IwLDv015767
	for linux-mips-outgoing; Mon, 1 Jul 2002 11:58:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.SGI.COM [204.94.214.10] (may be forged))
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g61IwEnC015745;
	Mon, 1 Jul 2002 11:58:14 -0700
Received: from lahoo.mshome.net (vsat-148-63-243-254.c004.g4.mrt.starband.net [148.63.243.254]) 
	by deliverator.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA09660; Mon, 1 Jul 2002 12:01:55 -0700 (PDT)
	mail_from (brad@ltc.com)
Received: from dev1.mshome.net ([192.168.0.245] helo=dev1)
	by lahoo.mshome.net with esmtp (Exim 3.12 #1 (Debian))
	id 17P6E9-0001VK-00; Mon, 01 Jul 2002 14:48:45 -0400
Received: from brad by dev1 with local (Exim 3.35 #1 (Debian))
	id 17P6FZ-00051a-00; Mon, 01 Jul 2002 14:50:13 -0400
Date: Mon, 1 Jul 2002 14:50:13 -0400
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: [PATCH] better bar size calculation
Message-ID: <20020701145012.A19315@dev1.ltc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: "Bradley D. LaRonde" <brad@ltc.com>
X-Spam-Status: No, hits=-3.7 required=5.0 tests=MAY_BE_FORGED,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

# 02/07/01	brad@dev1.(none)	1.72
# better bar size calculation

diff -Nru a/arch/mips/kernel/pci_auto.c b/arch/mips/kernel/pci_auto.c
--- a/arch/mips/kernel/pci_auto.c	Mon Jul  1 14:48:47 2002
+++ b/arch/mips/kernel/pci_auto.c	Mon Jul  1 14:48:47 2002
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/pci.h>
+#include <linux/bitops.h>
 
 #include <asm/pci_channel.h>
 
@@ -152,7 +153,7 @@
 
 
 		/* Calculate requested size */
-		bar_size = ~(bar_response & addr_mask) + 1;
+		bar_size = 1 << (ffs(bar_response & addr_mask) - 1);
 
 		/* Allocate a base address */
 		bar_value = ((*lower_limit - 1) & ~(bar_size - 1)) + bar_size;
