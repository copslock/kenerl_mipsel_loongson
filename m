Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 16:26:57 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:38882 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20044703AbXJSP0t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Oct 2007 16:26:49 +0100
Received: from localhost (p3184-ipad306funabasi.chiba.ocn.ne.jp [123.217.173.184])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F16CF9A35; Sat, 20 Oct 2007 00:26:43 +0900 (JST)
Date:	Sat, 20 Oct 2007 00:28:33 +0900 (JST)
Message-Id: <20071020.002833.93018600.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix calculation in clockevent_set_clock()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Received-SPF: none (mfgw104.ocn.ad.jp: 202.230.225.126 is neither permitted
 nor denied by domain of toshiba-tops.co.jp) client-ip=202.230.225.126;
 envelope-from=nemoto@toshiba-tops.co.jp; helo=topsns2.toshiba-tops.co.jp;
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
X-archive-position: 17131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index c4e6866..6c6849a 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -195,8 +195,8 @@ void __cpuinit clockevent_set_clock(struct clock_event_device *cd,
 
 	/* Find a shift value */
 	for (shift = 32; shift > 0; shift--) {
-		temp = (u64) NSEC_PER_SEC << shift;
-		do_div(temp, clock);
+		temp = (u64) clock << shift;
+		do_div(temp, NSEC_PER_SEC);
 		if ((temp >> 32) == 0)
 			break;
 	}
