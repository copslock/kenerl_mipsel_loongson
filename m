Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6GFAxRw032472
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 08:10:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6GFAxvq032471
	for linux-mips-outgoing; Tue, 16 Jul 2002 08:10:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mta7.pltn13.pbi.net (mta7.pltn13.pbi.net [64.164.98.8])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6GFAqRw032462;
	Tue, 16 Jul 2002 08:10:52 -0700
Received: from adsl.pacbell.net ([63.194.214.47])
 by mta7.pltn13.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GZC008PNL2C3J@mta7.pltn13.pbi.net>; Tue,
 16 Jul 2002 08:15:48 -0700 (PDT)
Date: Tue, 16 Jul 2002 08:15:56 -0700
From: Pete Popov <ppopov@mvista.com>
Subject: Re: PATCH
In-reply-to: <20020716170741.E31186@dea.linux-mips.net>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
Message-id: <1026832557.3552.3.camel@adsl.pacbell.net>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1026772150.15665.145.camel@zeus.mvista.com>
 <20020716170741.E31186@dea.linux-mips.net>
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2002-07-16 at 08:07, Ralf Baechle wrote:
> On Mon, Jul 15, 2002 at 03:29:10PM -0700, Pete Popov wrote:
> 
> > --- include/asm-mips/pgtable.h.old	Fri Jul 12 17:25:19 2002
> > +++ include/asm-mips/pgtable.h	Fri Jul 12 17:25:36 2002
> > @@ -332,7 +332,9 @@
> >  
> >  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> >  {
> > -	return __pte(((pte).pte_low & _PAGE_CHG_MASK) | pgprot_val(newprot));
> > +	pte.pte_low &= _PAGE_CHG_MASK;
> > +	pte.pte_low |= pgprot_val(newprot);
> > +	return pte;
> >  }
> 
> This patch certainly doesn't apply to oss.  Seems somebody did copy all
> the x86 pte_t and stuff into your tree without too much thinking ...

That's right, I forgot you don't have the 36 bit code that uses pte_low
and pte_high.  

Pete
