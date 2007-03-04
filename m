Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Mar 2007 15:43:05 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:38134 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038823AbXCDPnC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 Mar 2007 15:43:02 +0000
Received: from localhost (p4244-ipad29funabasi.chiba.ocn.ne.jp [221.184.71.244])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 13F58D31; Mon,  5 Mar 2007 00:41:39 +0900 (JST)
Date:	Mon, 05 Mar 2007 00:41:39 +0900 (JST)
Message-Id: <20070305.004139.89066671.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Remove redundant tx39_blast_icache() calls
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
X-archive-position: 14339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Apply commit 0550d9d13e02b30efa117d47fcadea450bb23d23 to c-tx39.c too.
And fix a warning in local_tx39_flush_data_cache_page().

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index f32ebde..560a6de 100644
--- a/arch/mips/mm/c-tx39.c
+++ b/arch/mips/mm/c-tx39.c
@@ -128,7 +128,6 @@ static inline void tx39_flush_cache_all(
 		return;
 
 	tx39_blast_dcache();
-	tx39_blast_icache();
 }
 
 static inline void tx39___flush_cache_all(void)
@@ -142,24 +141,19 @@ static void tx39_flush_cache_mm(struct m
 	if (!cpu_has_dc_aliases)
 		return;
 
-	if (cpu_context(smp_processor_id(), mm) != 0) {
-		tx39_flush_cache_all();
-	}
+	if (cpu_context(smp_processor_id(), mm) != 0)
+		tx39_blast_dcache();
 }
 
 static void tx39_flush_cache_range(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end)
 {
-	int exec;
-
+	if (!cpu_has_dc_aliases)
+		return;
 	if (!(cpu_context(smp_processor_id(), vma->vm_mm)))
 		return;
 
-	exec = vma->vm_flags & VM_EXEC;
-	if (cpu_has_dc_aliases || exec)
-		tx39_blast_dcache();
-	if (exec)
-		tx39_blast_icache();
+	tx39_blast_dcache();
 }
 
 static void tx39_flush_cache_page(struct vm_area_struct *vma, unsigned long page, unsigned long pfn)
@@ -218,7 +212,7 @@ static void tx39_flush_cache_page(struct
 
 static void local_tx39_flush_data_cache_page(void * addr)
 {
-	tx39_blast_dcache_page(addr);
+	tx39_blast_dcache_page((unsigned long)addr);
 }
 
 static void tx39_flush_data_cache_page(unsigned long addr)
