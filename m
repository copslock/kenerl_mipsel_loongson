Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2005 12:25:24 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:38171 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8133658AbVI1LZG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Sep 2005 12:25:06 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 28 Sep 2005 11:25:04 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id EBC0E1FE19;
	Wed, 28 Sep 2005 20:24:59 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id D6C061F1F6;
	Wed, 28 Sep 2005 20:24:59 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j8SBOwoj016520;
	Wed, 28 Sep 2005 20:24:59 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 28 Sep 2005 20:24:58 +0900 (JST)
Message-Id: <20050928.202458.32344678.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: sync c-tx39.c with c-r4k.c
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

tx39_flush_cache_range() do nothing if !cpu_has_dc_aliases.  It should
flush d-cache and invalidate i-cache since TX39(H2) has separate I/D
cache.

Here is a patch.  

diff -u linux-mips/arch/mips/mm/c-tx39.c linux/arch/mips/mm/c-tx39.c
--- linux-mips/arch/mips/mm/c-tx39.c	2005-09-05 10:16:59.000000000 +0900
+++ linux/arch/mips/mm/c-tx39.c	2005-09-28 18:51:43.000000000 +0900
@@ -167,15 +167,16 @@
 static void tx39_flush_cache_range(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end)
 {
-	struct mm_struct *mm = vma->vm_mm;
+	int exec;
 
-	if (!cpu_has_dc_aliases)
+	if (!(cpu_context(smp_processor_id(), vma->vm_mm)))
 		return;
 
-	if (cpu_context(smp_processor_id(), mm) != 0) {
+	exec = vma->vm_flags & VM_EXEC;
+	if (cpu_has_dc_aliases || exec)
 		tx39_blast_dcache();
+	if (exec)
 		tx39_blast_icache();
-	}
 }
 
 static void tx39_flush_cache_page(struct vm_area_struct *vma, unsigned long page, unsigned long pfn)

---
Atsushi Nemoto
