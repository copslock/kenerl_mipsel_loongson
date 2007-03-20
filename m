Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 15:57:49 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:9187 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022197AbXCTP5s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Mar 2007 15:57:48 +0000
Received: from localhost (p1076-ipad02funabasi.chiba.ocn.ne.jp [61.214.21.76])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0F203B5D8; Wed, 21 Mar 2007 00:56:29 +0900 (JST)
Date:	Wed, 21 Mar 2007 00:56:28 +0900 (JST)
Message-Id: <20070321.005628.118975639.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix potential SPARSEMEM bug
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The first pfn of zones should be min_low_pfn, not 0.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index f08ae71..25abe91 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -377,7 +377,7 @@ void __init paging_init(void)
 #ifdef CONFIG_FLATMEM
 	free_area_init(zones_size);
 #else
-	pfn = 0;
+	pfn = min_low_pfn;
 	for (i = 0; i < MAX_NR_ZONES; i++)
 		for (j = 0; j < zones_size[i]; j++, pfn++)
 			if (!page_is_ram(pfn))
