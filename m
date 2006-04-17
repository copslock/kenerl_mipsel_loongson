Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 13:12:36 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:11555 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133475AbWDQMM1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Apr 2006 13:12:27 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 17 Apr 2006 21:24:51 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id CA1CC207C0;
	Mon, 17 Apr 2006 21:24:49 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id BE7F520728;
	Mon, 17 Apr 2006 21:24:49 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k3HCOn4D087121;
	Mon, 17 Apr 2006 21:24:49 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 17 Apr 2006 21:24:49 +0900 (JST)
Message-Id: <20060417.212449.51866545.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] use __ffs() instead of ffs() in ip32_irq0()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 11132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

With recent rewrite for generic bitops, ffs() is defined the same way
as the libc and compiler built-in routines (returns int instead of
unsigned long).  Use __ffs() for 64bit value.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/sgi-ip32/ip32-irq.c b/arch/mips/sgi-ip32/ip32-irq.c
index 22a6df9..de01c98 100644
--- a/arch/mips/sgi-ip32/ip32-irq.c
+++ b/arch/mips/sgi-ip32/ip32-irq.c
@@ -507,13 +507,14 @@ static void ip32_irq0(struct pt_regs *re
 	int irq = 0;
 
 	crime_int = crime->istat & crime_mask;
-	irq = ffs(crime_int);
-	crime_int = 1 << (irq - 1);
+	irq = __ffs(crime_int);
+	crime_int = 1 << irq;
 
 	if (crime_int & CRIME_MACEISA_INT_MASK) {
 		unsigned long mace_int = mace->perif.ctrl.istat;
-		irq = ffs(mace_int & maceisa_mask) + 32;
+		irq = __ffs(mace_int & maceisa_mask) + 32;
 	}
+	irq++;
 	DBG("*irq %u*\n", irq);
 	do_IRQ(irq, regs);
 }
