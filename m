Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2009 22:32:56 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:52455 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S29032963AbZDUVbS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2009 22:31:18 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1LwNYj-0001ck-00; Tue, 21 Apr 2009 23:31:17 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 33937C32C0; Tue, 21 Apr 2009 23:31:12 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] IP27: Fix clash with NMI_OFFSET from hardirq.h
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20090421213112.33937C32C0@solo.franken.de>
Date:	Tue, 21 Apr 2009 23:31:12 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

There was already a define for NMI_OFFSET in asm/sn/addr.h, which now
clashes with linux/hardirq.h. Rename the one in sn/addr.h to fix IP27
builds..

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/include/asm/sn/addrs.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/sn/addrs.h b/arch/mips/include/asm/sn/addrs.h
index fec9bdd..3a56d90 100644
--- a/arch/mips/include/asm/sn/addrs.h
+++ b/arch/mips/include/asm/sn/addrs.h
@@ -359,11 +359,11 @@
 	TO_NODE_UNCAC((nasid), LAUNCH_OFFSET(nasid, slice))
 #define LAUNCH_SIZE(nasid)	KLD_LAUNCH(nasid)->size
 
-#define NMI_OFFSET(nasid, slice)					\
+#define SN_NMI_OFFSET(nasid, slice)					\
 	(KLD_NMI(nasid)->offset +					\
 	 KLD_NMI(nasid)->stride * (slice))
 #define NMI_ADDR(nasid, slice)						\
-	TO_NODE_UNCAC((nasid), NMI_OFFSET(nasid, slice))
+	TO_NODE_UNCAC((nasid), SN_NMI_OFFSET(nasid, slice))
 #define NMI_SIZE(nasid)	KLD_NMI(nasid)->size
 
 #define KLCONFIG_OFFSET(nasid)	KLD_KLCONFIG(nasid)->offset
