Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6GHssRw009073
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 10:54:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6GHss58009072
	for linux-mips-outgoing; Tue, 16 Jul 2002 10:54:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6GHsgRw009060;
	Tue, 16 Jul 2002 10:54:42 -0700
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA18561;
	Tue, 16 Jul 2002 10:59:32 -0700
Subject: Re: PATCH
From: Pete Popov <ppopov@mvista.com>
To: Joe George <joeg@clearcore.net>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <3D345B45.50001@clearcore.net>
References: <1026772150.15665.145.camel@zeus.mvista.com>
	<20020716170741.E31186@dea.linux-mips.net>
	<1026832557.3552.3.camel@adsl.pacbell.net>  <3D345B45.50001@clearcore.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 16 Jul 2002 11:00:16 -0700
Message-Id: <1026842416.15665.199.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2002-07-16 at 10:43, Joe George wrote:
> I'll disagree with both of you so I may learn from the flames. :-)
 
> First it's true the patch wasn't formatted for oss and should have
> been rejected on that basis.  At least my patches would be. :)

Well, my agreement with Ralf was that the patch wasn't formatted for the
oss tree, not that it's not applicable.
 
> But Vivien Chappelier said it fixed his X server problem in mips64.
> CONFIG_64BIT_PHYS_ADDR is applicable to both 36 and 64
> bit code, I think.
> 
> So the crux of my question is, if an unsigned long long pte is
> and'ed with an unsigned long PAGE_CHG_MASK what happens
> to the upper 32 bits of pte.  On a 64 bit processor is PAGE_CHG_MASK
> sign extended so everything is fine, or does it zero the upper
> 32 bits?

I think the upper 32 bits get zeroed out.  The fact that it fixed Vivien's
problem confirms this (he was running oss, right?)

Pete

 
> Joe
> 
> 
> Pete Popov wrote:
> > On Tue, 2002-07-16 at 08:07, Ralf Baechle wrote:
> > 
> >>On Mon, Jul 15, 2002 at 03:29:10PM -0700, Pete Popov wrote:
> >>
> >>
> >>>--- include/asm-mips/pgtable.h.old	Fri Jul 12 17:25:19 2002
> >>>+++ include/asm-mips/pgtable.h	Fri Jul 12 17:25:36 2002
> >>>@@ -332,7 +332,9 @@
> >>> 
> >>> static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> >>> {
> >>>-	return __pte(((pte).pte_low & _PAGE_CHG_MASK) | pgprot_val(newprot));
> >>>+	pte.pte_low &= _PAGE_CHG_MASK;
> >>>+	pte.pte_low |= pgprot_val(newprot);
> >>>+	return pte;
> >>> }
> >>>
> >>This patch certainly doesn't apply to oss.  Seems somebody did copy all
> >>the x86 pte_t and stuff into your tree without too much thinking ...
> >>
> > 
> > That's right, I forgot you don't have the 36 bit code that uses pte_low
> > and pte_high.  
> > 
> > Pete
> > 
> 
> 
