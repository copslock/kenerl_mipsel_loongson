Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2006 11:43:00 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:48769 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133781AbWFVKmv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Jun 2006 11:42:51 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 22 Jun 2006 19:42:49 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 2BAE0203CA;
	Thu, 22 Jun 2006 19:42:44 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 181A220408;
	Thu, 22 Jun 2006 19:42:44 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k5MAghW0039574;
	Thu, 22 Jun 2006 19:42:43 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 22 Jun 2006 19:42:43 +0900 (JST)
Message-Id: <20060622.194243.122255229.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] mips32/mips64 scache fix and cleanup
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Use blast_scache_range, blast_inv_scache_range for mips32/mips64
scache routine.
Also initialize waybit for mips32/mips64 scache.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index d3f92a9..42b5096 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -24,22 +24,7 @@ #include <asm/r4kcache.h>
  */
 static void mips_sc_wback_inv(unsigned long addr, unsigned long size)
 {
-	unsigned long sc_lsize = cpu_scache_line_size();
-	unsigned long end, a;
-
-	pr_debug("mips_sc_wback_inv[%08lx,%08lx]", addr, size);
-
-	/* Catch bad driver code */
-	BUG_ON(size == 0);
-
-	a = addr & ~(sc_lsize - 1);
-	end = (addr + size - 1) & ~(sc_lsize - 1);
-	while (1) {
-		flush_scache_line(a);		/* Hit_Writeback_Inv_SD */
-		if (a == end)
-			break;
-		a += sc_lsize;
-	}
+	blast_scache_range(addr, addr + size);
 }
 
 /*
@@ -47,22 +32,7 @@ static void mips_sc_wback_inv(unsigned l
  */
 static void mips_sc_inv(unsigned long addr, unsigned long size)
 {
-	unsigned long sc_lsize = cpu_scache_line_size();
-	unsigned long end, a;
-
-	pr_debug("mips_sc_inv[%08lx,%08lx]", addr, size);
-
-	/* Catch bad driver code */
-	BUG_ON(size == 0);
-
-	a = addr & ~(sc_lsize - 1);
-	end = (addr + size - 1) & ~(sc_lsize - 1);
-	while (1) {
-		invalidate_scache_line(a);	/* Hit_Invalidate_SD */
-		if (a == end)
-			break;
-		a += sc_lsize;
-	}
+	blast_inv_scache_range(addr, addr + size);
 }
 
 static void mips_sc_enable(void)
@@ -123,6 +93,7 @@ static inline int __init mips_sc_probe(v
 		return 0;
 
 	c->scache.waysize = c->scache.sets * c->scache.linesz;
+	c->scache.waybit = __ffs(c->scache.waysize);
 
 	c->scache.flags &= ~MIPS_CACHE_NOT_PRESENT;
 
