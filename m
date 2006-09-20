Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2006 17:35:06 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:18634 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038746AbWITQfD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 Sep 2006 17:35:03 +0100
Received: from localhost (p5035-ipad201funabasi.chiba.ocn.ne.jp [222.146.68.35])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7A950A590; Thu, 21 Sep 2006 01:34:57 +0900 (JST)
Date:	Thu, 21 Sep 2006 01:37:02 +0900 (JST)
Message-Id: <20060921.013702.126573740.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] use proper hazard macro instead of BARRIER
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
X-archive-position: 12605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index a681f57..3bf5e8a 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -38,11 +38,6 @@ #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/fixmap.h>
 
-/* CP0 hazard avoidance. */
-#define BARRIER __asm__ __volatile__(".set noreorder\n\t" \
-				     "nop; nop; nop; nop; nop; nop;\n\t" \
-				     ".set reorder\n\t")
-
 /* Atomicity and interruptability */
 #ifdef CONFIG_MIPS_MT_SMTC
 
@@ -161,7 +156,7 @@ #ifdef CONFIG_MIPS_MT_SMTC
 	/* preload TLB instead of local_flush_tlb_one() */
 	mtc0_tlbw_hazard();
 	tlb_probe();
-	BARRIER;
+	tlb_probe_hazard();
 	tlbidx = read_c0_index();
 	mtc0_tlbw_hazard();
 	if (tlbidx < 0)
