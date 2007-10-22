Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2007 17:12:41 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:41180 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20024863AbXJVQMR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 Oct 2007 17:12:17 +0100
Received: from localhost (p4177-ipad307funabasi.chiba.ocn.ne.jp [123.217.182.177])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EFC649A0B; Tue, 23 Oct 2007 01:12:13 +0900 (JST)
Date:	Tue, 23 Oct 2007 01:14:06 +0900 (JST)
Message-Id: <20071023.011406.31449235.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Make c0_compare_int_usable more bullet proof
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Use write_c0_compare(read_c0_count()) to clear interrupt.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index a915e56..ae2984f 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -186,7 +186,7 @@ static int c0_compare_int_usable(void)
 	 * IP7 already pending?  Try to clear it by acking the timer.
 	 */
 	if (c0_compare_int_pending()) {
-		write_c0_compare(read_c0_compare());
+		write_c0_compare(read_c0_count());
 		irq_disable_hazard();
 		if (c0_compare_int_pending())
 			return 0;
@@ -202,7 +202,7 @@ static int c0_compare_int_usable(void)
 	if (!c0_compare_int_pending())
 		return 0;
 
-	write_c0_compare(read_c0_compare());
+	write_c0_compare(read_c0_count());
 	irq_disable_hazard();
 	if (c0_compare_int_pending())
 		return 0;
