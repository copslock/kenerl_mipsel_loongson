Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 16:18:09 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:10698 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225202AbTDNPSH>; Mon, 14 Apr 2003 16:18:07 +0100
Received: from localhost (p5186-ip02funabasi.chiba.ocn.ne.jp [61.214.4.186])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EA32D37AA; Tue, 15 Apr 2003 00:17:54 +0900 (JST)
Date: Tue, 15 Apr 2003 00:24:25 +0900 (JST)
Message-Id: <20030415.002425.74756927.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: minor c-r4k.c cleanup
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

r4k_dma_cache_xxx should not flush icache ?

diff -u linux-mips/arch/mips/mm/c-r4k.c linux.new/arch/mips/mm
--- linux-mips/arch/mips/mm/c-r4k.c	Mon Apr 14 23:08:02 2003
+++ linux.new/arch/mips/mm/c-r4k.c	Tue Apr 15 00:12:27 2003
@@ -514,7 +514,7 @@
 	unsigned long end, a;
 
 	if (size >= dcache_size) {
-		r4k_flush_pcache_all();
+		r4k_blast_dcache();
 	} else {
 		unsigned long dc_lsize = current_cpu_data.dcache.linesz;
 		R4600_HIT_CACHEOP_WAR_DECL;
@@ -539,7 +539,8 @@
 	unsigned long end, a;
 
 	if (size >= scache_size) {
-		r4k_flush_scache_all();
+		r4k_blast_dcache();
+		r4k_blast_scache();
 		return;
 	}
 
@@ -558,7 +559,7 @@
 	unsigned long end, a;
 
 	if (size >= dcache_size) {
-		r4k_flush_pcache_all();
+		r4k_blast_dcache();
 	} else {
 		unsigned long dc_lsize = current_cpu_data.dcache.linesz;
 		R4600_HIT_CACHEOP_WAR_DECL;
@@ -583,7 +584,8 @@
 	unsigned long end, a;
 
 	if (size >= scache_size) {
-		r4k_flush_scache_all();
+		r4k_blast_dcache();
+		r4k_blast_scache();
 		return;
 	}
 
---

And I wonder why r4k_flush_pcache_mm (and r4k_flush_pcache_all) does
nothing if cpu_has_dc_aliases was not true.  I'm still
investigating...

---
Atsushi Nemoto
