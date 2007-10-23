Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 13:49:40 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:20989 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20030688AbXJWMtc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2007 13:49:32 +0100
Received: from localhost (p3228-ipad307funabasi.chiba.ocn.ne.jp [123.217.181.228])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7005A3EE1; Tue, 23 Oct 2007 21:49:26 +0900 (JST)
Date:	Tue, 23 Oct 2007 21:51:19 +0900 (JST)
Message-Id: <20071023.215119.25909456.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix cevt-r4k.c for 64-bit kernel
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
X-archive-position: 17178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The expression "(long)(read_c0_count() - cnt)" never be a negative
value on 64-bit kernel.  Cast to "int" before comparison.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/cevt-r4k.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index ae2984f..47c8c0e 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -28,7 +28,7 @@ static int mips_next_event(unsigned long delta,
 	cnt = read_c0_count();
 	cnt += delta;
 	write_c0_compare(cnt);
-	res = ((long)(read_c0_count() - cnt ) > 0) ? -ETIME : 0;
+	res = ((int)(read_c0_count() - cnt) > 0) ? -ETIME : 0;
 #ifdef CONFIG_MIPS_MT_SMTC
 	evpe(vpflags);
 	local_irq_restore(flags);
@@ -196,7 +196,7 @@ static int c0_compare_int_usable(void)
 	cnt += delta;
 	write_c0_compare(cnt);
 
-	while ((long)(read_c0_count() - cnt) <= 0)
+	while ((int)(read_c0_count() - cnt) <= 0)
 		;	/* Wait for expiry  */
 
 	if (!c0_compare_int_pending())
