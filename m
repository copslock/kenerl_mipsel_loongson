Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2007 15:59:14 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:15342 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037670AbXBQP7J (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2007 15:59:09 +0000
Received: from localhost (p5247-ipad204funabasi.chiba.ocn.ne.jp [222.146.92.247])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 73740B8DD; Sun, 18 Feb 2007 00:57:48 +0900 (JST)
Date:	Sun, 18 Feb 2007 00:57:48 +0900 (JST)
Message-Id: <20070218.005748.27954771.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Declare highstart_pfn, highend_pfn only if CONFIG_HIGHMEM=y
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
X-archive-position: 14140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 125a4a8..60104e2 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -61,7 +61,9 @@
 
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
+#ifdef CONFIG_HIGHMEM
 unsigned long highstart_pfn, highend_pfn;
+#endif
 
 /*
  * We have up to 8 empty zeroed pages so we can map one of the right colour
