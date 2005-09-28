Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2005 12:58:18 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:42268 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8133567AbVI1L6B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Sep 2005 12:58:01 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 28 Sep 2005 11:58:00 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id AC7ED1FE17;
	Wed, 28 Sep 2005 20:57:58 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 96F291FE0F;
	Wed, 28 Sep 2005 20:57:58 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j8SBvwoj016658;
	Wed, 28 Sep 2005 20:57:58 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 28 Sep 2005 20:57:58 +0900 (JST)
Message-Id: <20050928.205758.32501424.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: missing data cache flush for signal trampoline on fork
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050928.203429.02302175.nemoto@toshiba-tops.co.jp>
References: <20050928.203429.02302175.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 9062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 28 Sep 2005 20:34:29 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> If I used indexed-flush for executable page in
anemo> flush_cache_page(), the problem disappear.  Is this a right
anemo> fix?

Sorry, this would corrupt cpu_has_ic_fills_f_dc case.  Revised.

diff -u linux-mips/arch/mips/mm/c-r4k.c linux/arch/mips/mm/c-r4k.c
--- linux-mips/arch/mips/mm/c-r4k.c	2005-09-22 10:38:23.000000000 +0900
+++ linux/arch/mips/mm/c-r4k.c	2005-09-28 20:55:55.000000000 +0900
@@ -409,8 +409,9 @@
 	 * for every cache flush operation.  So we do indexed flushes
 	 * in that case, which doesn't overly flush the cache too much.
 	 */
-	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID)) {
-		if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc)) {
+	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID) &&
+	    !(exec && !cpu_has_ic_fills_f_dc)) {
+		if (cpu_has_dc_aliases) {
 			r4k_blast_dcache_page(page);
 			if (exec && !cpu_icache_snoops_remote_store)
 				r4k_blast_scache_page(page);
diff -u linux-mips/arch/mips/mm/c-tx39.c linux/arch/mips/mm/c-tx39.c
--- linux-mips/arch/mips/mm/c-tx39.c	2005-09-05 10:16:59.000000000 +0900
+++ linux/arch/mips/mm/c-tx39.c	2005-09-28 18:51:43.000000000 +0900
@@ -213,12 +213,10 @@
 	 * for every cache flush operation.  So we do indexed flushes
 	 * in that case, which doesn't overly flush the cache too much.
 	 */
-	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID)) {
-		if (cpu_has_dc_aliases || exec)
+	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID) &&
+	    !exec) {
+		if (cpu_has_dc_aliases)
 			tx39_blast_dcache_page(page);
-		if (exec)
-			tx39_blast_icache_page(page);
-
 		return;
 	}
 

---
Atsushi Nemoto
