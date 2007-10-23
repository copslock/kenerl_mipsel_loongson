Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 13:54:02 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:53211 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20030714AbXJWMxy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2007 13:53:54 +0100
Received: from localhost (p3228-ipad307funabasi.chiba.ocn.ne.jp [123.217.181.228])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7F58E9E20; Tue, 23 Oct 2007 21:53:49 +0900 (JST)
Date:	Tue, 23 Oct 2007 21:55:42 +0900 (JST)
Message-Id: <20071023.215542.59032245.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Make c0_compare_int_usable faster
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20071022210400.GB20038@linux-mips.org>
References: <20071023.011416.61947729.anemo@mba.ocn.ne.jp>
	<20071022210400.GB20038@linux-mips.org>
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
X-archive-position: 17179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 22 Oct 2007 22:04:00 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Use delta value based on its speed for faster probing.
> 
> Still the same issue, it breaks with Qemu.  You probably don't see this
> if you're testing on a desktop where the TSC is used for timing but on
> a laptop it breaks big time.  I need to increase the shift value to at
> least like 15 to get it to work more or less reliably with Qemu, so a
> somewhat different approach is needed.

OK, Here is the different approach.

---
Subject: [PATCH] Make c0_compare_int_usable faster (take 2)

Try to increase delta value step by step until we can make sure the
counter is not expired.

 arch/mips/kernel/cevt-r4k.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 47c8c0e..fa3b9b2 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -179,7 +179,7 @@ static int c0_compare_int_pending(void)
 
 static int c0_compare_int_usable(void)
 {
-	const unsigned int delta = 0x300000;
+	unsigned int delta;
 	unsigned int cnt;
 
 	/*
@@ -192,9 +192,15 @@ static int c0_compare_int_usable(void)
 			return 0;
 	}
 
-	cnt = read_c0_count();
-	cnt += delta;
-	write_c0_compare(cnt);
+	for (delta = 0x10; delta <= 0x400000; delta <<= 1) {
+		cnt = read_c0_count();
+		cnt += delta;
+		write_c0_compare(cnt);
+		irq_disable_hazard();
+		if ((int)(read_c0_count() - cnt) < 0)
+		    break;
+		/* increase delta if the timer was already expired */
+	}
 
 	while ((int)(read_c0_count() - cnt) <= 0)
 		;	/* Wait for expiry  */
