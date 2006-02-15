Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2006 09:19:36 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:32619 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133478AbWBOJTZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Feb 2006 09:19:25 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 15 Feb 2006 18:25:51 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 84BBD20011;
	Wed, 15 Feb 2006 18:25:49 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 786B11F54C;
	Wed, 15 Feb 2006 18:25:49 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k1F9Pn4D081047;
	Wed, 15 Feb 2006 18:25:49 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 15 Feb 2006 18:25:48 +0900 (JST)
Message-Id: <20060215.182548.118975142.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] sc-rm7k.c cleanup
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
X-archive-position: 10466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Use blast_scache_range, blast_inv_scache_range for rm7k scache routine.
Output code should be logically same.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/sc-rm7k.c b/arch/mips/mm/sc-rm7k.c
index 9e8ff8b..3b6cc9b 100644
--- a/arch/mips/mm/sc-rm7k.c
+++ b/arch/mips/mm/sc-rm7k.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/bitops.h>
 
 #include <asm/addrspace.h>
 #include <asm/bcache.h>
@@ -43,14 +44,7 @@ static void rm7k_sc_wback_inv(unsigned l
 	/* Catch bad driver code */
 	BUG_ON(size == 0);
 
-	a = addr & ~(sc_lsize - 1);
-	end = (addr + size - 1) & ~(sc_lsize - 1);
-	while (1) {
-		flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
-		if (a == end)
-			break;
-		a += sc_lsize;
-	}
+	blast_scache_range(addr, addr + size);
 
 	if (!rm7k_tcache_enabled)
 		return;
@@ -74,14 +68,7 @@ static void rm7k_sc_inv(unsigned long ad
 	/* Catch bad driver code */
 	BUG_ON(size == 0);
 
-	a = addr & ~(sc_lsize - 1);
-	end = (addr + size - 1) & ~(sc_lsize - 1);
-	while (1) {
-		invalidate_scache_line(a);	/* Hit_Invalidate_SD */
-		if (a == end)
-			break;
-		a += sc_lsize;
-	}
+	blast_inv_scache_range(addr, addr + size);
 
 	if (!rm7k_tcache_enabled)
 		return;
@@ -143,11 +130,17 @@ struct bcache_ops rm7k_sc_ops = {
 
 void __init rm7k_sc_init(void)
 {
+	struct cpuinfo_mips *c = &current_cpu_data;
 	unsigned int config = read_c0_config();
 
 	if ((config & RM7K_CONF_SC))
 		return;
 
+	c->scache.linesz = sc_lsize;
+	c->scache.ways = 4;
+	c->scache.waybit= ffs(scache_size / c->scache.ways) - 1;
+	c->scache.waysize = scache_size / c->scache.ways;
+	c->scache.sets = scache_size / (c->scache.linesz * c->scache.ways);
 	printk(KERN_INFO "Secondary cache size %dK, linesize %d bytes.\n",
 	       (scache_size >> 10), sc_lsize);
 
diff --git a/include/asm-mips/r4kcache.h b/include/asm-mips/r4kcache.h
index 9632c27..42f7be2 100644
--- a/include/asm-mips/r4kcache.h
+++ b/include/asm-mips/r4kcache.h
@@ -302,5 +302,6 @@ __BUILD_BLAST_CACHE_RANGE(d, dcache, Hit
 __BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, )
 /* blast_inv_dcache_range */
 __BUILD_BLAST_CACHE_RANGE(inv_d, dcache, Hit_Invalidate_D, )
+__BUILD_BLAST_CACHE_RANGE(inv_s, scache, Hit_Invalidate_SD, )
 
 #endif /* _ASM_R4KCACHE_H */
