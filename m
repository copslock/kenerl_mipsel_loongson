Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2007 15:40:39 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:20680 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20025609AbXFAOkg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Jun 2007 15:40:36 +0100
Received: from localhost (p8230-ipad205funabasi.chiba.ocn.ne.jp [222.146.103.230])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 399C0AF8E; Fri,  1 Jun 2007 23:40:32 +0900 (JST)
Date:	Fri, 01 Jun 2007 23:40:59 +0900 (JST)
Message-Id: <20070601.234059.72707771.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix IP27 build
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 15217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

IP27 does not have ZONE_DMA now.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index fe8a106..e5e023f 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -517,7 +517,7 @@ void __init paging_init(void)
 		pfn_t start_pfn = slot_getbasepfn(node, 0);
 		pfn_t end_pfn = node_getmaxclick(node) + 1;
 
-		zones_size[ZONE_DMA] = end_pfn - start_pfn;
+		zones_size[ZONE_NORMAL] = end_pfn - start_pfn;
 		free_area_init_node(node, NODE_DATA(node),
 				zones_size, start_pfn, NULL);
 
