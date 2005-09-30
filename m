Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 04:33:18 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:8474 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8133675AbVI3Dcs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Sep 2005 04:32:48 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 30 Sep 2005 03:32:46 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 88DFF1F693;
	Fri, 30 Sep 2005 12:32:42 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 7418B1F569;
	Fri, 30 Sep 2005 12:32:42 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j8U3Wgoj024609;
	Fri, 30 Sep 2005 12:32:42 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 30 Sep 2005 12:32:41 +0900 (JST)
Message-Id: <20050930.123241.72709288.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: missing data cache flush for signal trampoline on fork
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050928.205758.32501424.nemoto@toshiba-tops.co.jp>
References: <20050928.203429.02302175.nemoto@toshiba-tops.co.jp>
	<20050928.205758.32501424.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 9083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 28 Sep 2005 20:57:58 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> Sorry, this would corrupt cpu_has_ic_fills_f_dc case.  Revised.

The patch was overkill.  The indexed-flush is required only for
d-cache.  Revised.

diff -u linux-mips/arch/mips/mm/c-r4k.c linux/arch/mips/mm/c-r4k.c
--- linux-mips/arch/mips/mm/c-r4k.c	2005-09-22 10:38:23.000000000 +0900
+++ linux/arch/mips/mm/c-r4k.c	2005-09-30 12:25:14.000000000 +0900
@@ -410,7 +410,11 @@
 	 * in that case, which doesn't overly flush the cache too much.
 	 */
 	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID)) {
-		if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc)) {
+		if (exec && !cpu_has_ic_fills_f_dc) {
+			r4k_blast_dcache_page_indexed(page);
+			if (!cpu_icache_snoops_remote_store)
+				r4k_blast_scache_page_indexed(page);
+		} else if (cpu_has_dc_aliases) {
 			r4k_blast_dcache_page(page);
 			if (exec && !cpu_icache_snoops_remote_store)
 				r4k_blast_scache_page(page);
diff -u linux-mips/arch/mips/mm/c-tx39.c linux/arch/mips/mm/c-tx39.c
--- linux-mips/arch/mips/mm/c-tx39.c	2005-09-05 10:16:59.000000000 +0900
+++ linux/arch/mips/mm/c-tx39.c	2005-09-30 12:26:23.000000000 +0900
@@ -214,7 +214,9 @@
 	 * in that case, which doesn't overly flush the cache too much.
 	 */
 	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID)) {
-		if (cpu_has_dc_aliases || exec)
+		if (exec)
+			tx39_blast_dcache_page_indexed(page);
+		else if (cpu_has_dc_aliases)
 			tx39_blast_dcache_page(page);
 		if (exec)
 			tx39_blast_icache_page(page);

---
Atsushi Nemoto
