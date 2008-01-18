Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jan 2008 01:05:17 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:30346 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S28585249AbYARBFI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Jan 2008 01:05:08 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 18 Jan 2008 10:05:06 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 5DCF142B6D;
	Fri, 18 Jan 2008 10:05:02 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 5238942B63;
	Fri, 18 Jan 2008 10:05:02 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id m0I151AF096003;
	Fri, 18 Jan 2008 10:05:01 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 18 Jan 2008 10:05:01 +0900 (JST)
Message-Id: <20080118.100501.07644721.nemoto@toshiba-tops.co.jp>
To:	gregor.waltz@raritan.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <478F8758.1010105@raritan.com>
References: <478E22A4.4070604@raritan.com>
	<20080117.010459.51867104.anemo@mba.ocn.ne.jp>
	<478F8758.1010105@raritan.com>
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
X-archive-position: 18093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 17 Jan 2008 11:50:32 -0500, Gregor Waltz <gregor.waltz@raritan.com> wrote:
> What ought to be done to fix the init_IRQ()/kmalloc problem?

Oops, that was my mistake.  The txx9_irq_init() assumes its baseaddr
can be remapped without TLB.  This is true but plat_ioremap for
jmr3927 was wrong.

Could you try this patch?  (can be used for 2.6.23 and current git)


Subject: [MIPS] Fix plat_ioremap for JMR3927

TX39XX's "reserved" segment in CKSEG3 area is 0xff000000-0xfffeffff.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/mach-jmr3927/ioremap.h b/include/asm-mips/mach-jmr3927/ioremap.h
index aa131ad..ac3be35 100644
--- a/include/asm-mips/mach-jmr3927/ioremap.h
+++ b/include/asm-mips/mach-jmr3927/ioremap.h
@@ -25,7 +25,7 @@ static inline void __iomem *plat_ioremap(phys_t offset, unsigned long size,
 {
 #define TXX9_DIRECTMAP_BASE	0xff000000ul
 	if (offset >= TXX9_DIRECTMAP_BASE &&
-	    offset < TXX9_DIRECTMAP_BASE + 0xf0000)
+	    offset < TXX9_DIRECTMAP_BASE + 0xff000)
 		return (void __iomem *)offset;
 	return NULL;
 }
