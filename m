Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jun 2006 18:53:24 +0200 (CEST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:26335 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133713AbWFAQxP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 Jun 2006 18:53:15 +0200
Received: from localhost (p1057-ipad212funabasi.chiba.ocn.ne.jp [58.91.165.57])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 49967B987; Fri,  2 Jun 2006 01:53:09 +0900 (JST)
Date:	Fri, 02 Jun 2006 01:54:04 +0900 (JST)
Message-Id: <20060602.015404.93020143.anemo@mba.ocn.ne.jp>
To:	geert@linux-m68k.org
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fix some compiler warnings (field width, unused
 variable)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.62.0605311840170.18323@chinchilla.sonytel.be>
References: <20060601.010003.39154219.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.62.0605311840170.18323@chinchilla.sonytel.be>
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
X-archive-position: 11634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 31 May 2006 18:47:54 +0200 (CEST), Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >  			printk("initrd extends beyond end of memory "
> >  			       "(0x%0*Lx > 0x%0*Lx)\ndisabling initrd\n",
> 
> `%L' is obsolete for long long, use `%ll' instead.
> 
> > -			       sizeof(long) * 2,
> > +			       (int)(sizeof(long) * 2),
> >  			       (unsigned long long)CPHYSADDR(initrd_end),
> 
> As CPHYSADDR() returns a ptrdiff_t, what about using `%t' instead?
> Ah, that one doesn't print hex (hmm, C99 doesn't seem to tell).
> 
> You can cast to `void *' and use `%p' to get hex, and the field width will
> automagically be `2*sizeof(void *)', according to lib/vsprintf.c.

Thanks.  Though Ralf already committed it with slight changes, this
patch will make kernel just a bit smaller.


[MIPS] simplify printk format string (use %p instead of %0*Lx)

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 397a70e..4ab4bd5 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -420,18 +420,15 @@ static inline void bootmem_init(void)
 	if (initrd_start) {
 		unsigned long initrd_size = ((unsigned char *)initrd_end) -
 			((unsigned char *)initrd_start);
-		const int width = sizeof(long) * 2;
 
 		printk("Initial ramdisk at: 0x%p (%lu bytes)\n",
 		       (void *)initrd_start, initrd_size);
 
 		if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
 			printk("initrd extends beyond end of memory "
-			       "(0x%0*Lx > 0x%0*Lx)\ndisabling initrd\n",
-			       width,
-			       (unsigned long long) CPHYSADDR(initrd_end),
-			       width,
-			       (unsigned long long) PFN_PHYS(max_low_pfn));
+			       "(0x%p > 0x%p)\ndisabling initrd\n",
+			       (void *)CPHYSADDR(initrd_end),
+			       (void *)PFN_PHYS(max_low_pfn));
 			initrd_start = initrd_end = 0;
 			initrd_reserve_bootmem = 0;
 		}
