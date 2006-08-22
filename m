Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 13:15:59 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:18076 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038724AbWHVMP6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Aug 2006 13:15:58 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 22 Aug 2006 21:15:56 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 70DAD203C7;
	Tue, 22 Aug 2006 21:15:49 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 5CDA020327;
	Tue, 22 Aug 2006 21:15:49 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k7MCFlW0007125;
	Tue, 22 Aug 2006 21:15:49 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 22 Aug 2006 21:15:47 +0900 (JST)
Message-Id: <20060822.211547.92587044.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] remove redundant r4k_blast_icache() calls
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
X-archive-position: 12394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This patch remove some r4k_blast_icache() calls.

r4k_flush_cache_all() and r4k_flush_cache_mm() case: these are noop if
the CPU did not have dc_aliases.  It would mean we do not need to care
about icache here.

r4k_flush_cache_range case: if r4k_flush_cache_mm() did not need to
care about icache, it would be same for this function.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 4e14982..a9e2f84 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -323,7 +323,6 @@ static inline void r4k_blast_scache_setu
 static inline void local_r4k_flush_cache_all(void * args)
 {
 	r4k_blast_dcache();
-	r4k_blast_icache();
 }
 
 static void r4k_flush_cache_all(void)
@@ -359,21 +358,19 @@ static void r4k___flush_cache_all(void)
 static inline void local_r4k_flush_cache_range(void * args)
 {
 	struct vm_area_struct *vma = args;
-	int exec;
 
 	if (!(cpu_context(smp_processor_id(), vma->vm_mm)))
 		return;
 
-	exec = vma->vm_flags & VM_EXEC;
-	if (cpu_has_dc_aliases || exec)
-		r4k_blast_dcache();
-	if (exec)
-		r4k_blast_icache();
+	r4k_blast_dcache();
 }
 
 static void r4k_flush_cache_range(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end)
 {
+	if (!cpu_has_dc_aliases)
+		return;
+
 	r4k_on_each_cpu(local_r4k_flush_cache_range, vma, 1, 1);
 }
 
@@ -385,7 +382,6 @@ static inline void local_r4k_flush_cache
 		return;
 
 	r4k_blast_dcache();
-	r4k_blast_icache();
 
 	/*
 	 * Kludge alert.  For obscure reasons R4000SC and R4400SC go nuts if we
