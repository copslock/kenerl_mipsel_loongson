Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Oct 2006 15:07:23 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:18426 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038485AbWJZOHQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Oct 2006 15:07:16 +0100
Received: from localhost (p7132-ipad209funabasi.chiba.ocn.ne.jp [58.88.118.132])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7BA9EB73A; Thu, 26 Oct 2006 23:07:10 +0900 (JST)
Date:	Thu, 26 Oct 2006 23:09:37 +0900 (JST)
Message-Id: <20061026.230937.41197595.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, m_lachwani@yahoo.com,
	creideiki+linux-mips@ferretporn.se
Subject: [PATCH] fix clocksource parameter for low frequency timer.
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
X-archive-position: 13102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The current shift value in clocksource was not suitable for low
frequency timer.  Find the shift value in runtime to avoid undesirable
overflow.  Also calculate a somewhat reasonable rating value based on
its frequency.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 2c6d52b..e535f86 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -324,22 +324,29 @@ static cycle_t read_mips_hpt(void)
 
 static struct clocksource clocksource_mips = {
 	.name		= "MIPS",
-	.rating		= 250,
 	.read		= read_mips_hpt,
-	.shift		= 24,
 	.is_continuous	= 1,
 };
 
 static void __init init_mips_clocksource(void)
 {
 	u64 temp;
+	u32 shift;
 
 	if (!mips_hpt_frequency || mips_hpt_read == null_hpt_read)
 		return;
 
-	temp = (u64) NSEC_PER_SEC << clocksource_mips.shift;
-	do_div(temp, mips_hpt_frequency);
-	clocksource_mips.mult = (unsigned)temp;
+	/* Calclate a somewhat reasonable rating value */
+	clocksource_mips.rating = 200 + mips_hpt_frequency / 10000000;
+	/* Find a shift value */
+	for (shift = 32; shift > 0; shift--) {
+		temp = (u64) NSEC_PER_SEC << shift;
+		do_div(temp, mips_hpt_frequency);
+		if ((temp >> 32) == 0)
+			break;
+	}
+	clocksource_mips.shift = shift;
+	clocksource_mips.mult = (u32)temp;
 	clocksource_mips.mask = mips_hpt_mask;
 
 	clocksource_register(&clocksource_mips);
