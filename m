Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Sep 2009 16:35:39 +0200 (CEST)
Received: from mgw1.diku.dk ([130.225.96.91]:54290 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492725AbZIOOfb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Sep 2009 16:35:31 +0200
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 8563E52C47B;
	Tue, 15 Sep 2009 16:35:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1acEjmLDqTIZ; Tue, 15 Sep 2009 16:35:26 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id CA6F752C3C3;
	Tue, 15 Sep 2009 16:35:26 +0200 (CEST)
Received: from pc-004.diku.dk (pc-004.diku.dk [130.225.97.4])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 932496DF823; Tue, 15 Sep 2009 16:33:34 +0200 (CEST)
Received: by pc-004.diku.dk (Postfix, from userid 3767)
	id 9472C383F5; Tue, 15 Sep 2009 16:35:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by pc-004.diku.dk (Postfix) with ESMTP id 8FE7238330;
	Tue, 15 Sep 2009 16:35:26 +0200 (CEST)
Date:	Tue, 15 Sep 2009 16:35:26 +0200 (CEST)
From:	Julia Lawall <julia@diku.dk>
To:	=?windows-1252?Q?Ralf_R=F6sch?= <ralf.roesch@rw-gmbh.de>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/8] arch/mips/txx9: introduce missing kfree, iounmap
In-Reply-To: <4AAF9E5B.5040909@rw-gmbh.de>
Message-ID: <Pine.LNX.4.64.0909151634030.8549@pc-004.diku.dk>
References: <Pine.LNX.4.64.0909111820370.10552@pc-004.diku.dk>
 <20090913.232548.253168283.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64.0909131708190.25903@ask.diku.dk>
 <20090914.003321.160496287.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64.0909132113520.31000@ask.diku.dk>
 <4AAF9E5B.5040909@rw-gmbh.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-511572895-1888724175-1253025326=:8549"
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---511572895-1888724175-1253025326=:8549
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 15 Sep 2009, Ralf Rösch wrote:

> The gpio_remove is missing:
>  arch/mips/txx9/generic/setup.c:838: error: implicit declaration of function
>  ?gpio_remove?
> 
> Should it be gpiochip_remove() instead?

Oops, sorry about that.  That is indeed the function I was looking at.

I can submit a revised patch, but I sent another question asking about 
whether something should be done about the fact that gpiochip_remove is 
declared as follows:

extern int __must_check gpiochip_remove(struct gpio_chip *chip);

I don't think the call can fail at this point, but should something be 
done to avoid a compiler warning?

thanks,
julia


> --
> Ralf Roesch
> 
> 
> The Julia Lawall schrieb:
> > From: Julia Lawall <julia@diku.dk>
> >
> > Error handling code following a kzalloc should free the allocated data.
> > Error handling code following an ioremap should iounmap the allocated data.
> >
> > The semantic match that finds the first problem is as follows:
> > (http://www.emn.fr/x-info/coccinelle/)
> >
> > // <smpl>
> > @r exists@
> > local idexpression x;
> > statement S;
> > expression E;
> > identifier f,f1,l;
> > position p1,p2;
> > expression *ptr != NULL;
> > @@
> >
> > x@p1 = \(kmalloc\|kzalloc\|kcalloc\)(...);
> > ...
> > if (x == NULL) S
> > <... when != x
> >      when != if (...) { <+...x...+> }
> > (
> > x->f1 = E
> > |
> >  (x->f1 == NULL || ...)
> > |
> >  f(...,x->f1,...)
> > )
> > ...>
> > (
> >  return \(0\|<+...x...+>\|ptr\);
> > |
> >  return@p2 ...;
> > )
> >
> > @script:python@
> > p1 << r.p1;
> > p2 << r.p2;
> > @@
> >
> > print "* file: %s kmalloc %s return %s" % (p1[0].file,p1[0].line,p2[0].line)
> > // </smpl>
> >
> > Signed-off-by: Julia Lawall <julia@diku.dk>
> > ---
> >  arch/mips/txx9/generic/setup.c      |   17 +++++++++++++----
> >  1 files changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
> > index a205e2b..c860810 100644
> > --- a/arch/mips/txx9/generic/setup.c
> > +++ b/arch/mips/txx9/generic/setup.c
> > @@ -782,7 +782,7 @@ void __init txx9_iocled_init(unsigned long baseaddr,
> >   	return;
> >   iocled->mmioaddr = ioremap(baseaddr, 1);
> >   if (!iocled->mmioaddr)
> > -		return;
> > +		goto out_free;
> >   iocled->chip.get = txx9_iocled_get;
> >   iocled->chip.set = txx9_iocled_set;
> >   iocled->chip.direction_input = txx9_iocled_dir_in;
> > @@ -791,13 +791,13 @@ void __init txx9_iocled_init(unsigned long baseaddr,
> >   iocled->chip.base = basenum;
> >   iocled->chip.ngpio = num;
> >   if (gpiochip_add(&iocled->chip))
> > -		return;
> > +		goto out_unmap;
> >   if (basenum < 0)
> >    basenum = iocled->chip.base;
> >  
> >   pdev = platform_device_alloc("leds-gpio", basenum);
> >   if (!pdev)
> > -		return;
> > +		goto out_gpio;
> >   iocled->pdata.num_leds = num;
> >   iocled->pdata.leds = iocled->leds;
> >   for (i = 0; i < num; i++) {
> > @@ -812,7 +812,16 @@ void __init txx9_iocled_init(unsigned long baseaddr,
> >   }
> >   pdev->dev.platform_data = &iocled->pdata;
> >   if (platform_device_add(pdev))
> > -		platform_device_put(pdev);
> > +		goto out_pdev;
> > +	return;
> > +out_pdev:
> > +	platform_device_put(pdev);
> > +out_gpio:
> > +	gpio_remove(&iocled->chip);
> > +out_unmap:
> > +	iounmap(iocled->mmioaddr);
> > +out_free:
> > +	kfree(iocled);
> >  }
> >  #else /* CONFIG_LEDS_GPIO */
> >  void __init txx9_iocled_init(unsigned long baseaddr,
> >
> >   
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
---511572895-1888724175-1253025326=:8549--
