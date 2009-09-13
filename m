Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Sep 2009 17:49:48 +0200 (CEST)
Received: from mgw2.diku.dk ([130.225.96.92]:42942 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492783AbZIMPtm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 13 Sep 2009 17:49:42 +0200
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id B758719BB3D;
	Sun, 13 Sep 2009 17:49:41 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31179-14; Sun, 13 Sep 2009 17:49:40 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 7B73719BB3B;
	Sun, 13 Sep 2009 17:49:40 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 067166DF84F; Sun, 13 Sep 2009 17:47:51 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3767)
	id 5D812F35C; Sun, 13 Sep 2009 17:49:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ask.diku.dk (Postfix) with ESMTP id 5525FF017;
	Sun, 13 Sep 2009 17:49:40 +0200 (CEST)
Date:	Sun, 13 Sep 2009 17:49:40 +0200 (CEST)
From:	Julia Lawall <julia@diku.dk>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/8] arch/mips/txx9: introduce missing kfree, iounmap
In-Reply-To: <20090914.003321.160496287.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64.0909131749150.25903@ask.diku.dk>
References: <Pine.LNX.4.64.0909111820370.10552@pc-004.diku.dk>
 <20090913.232548.253168283.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64.0909131708190.25903@ask.diku.dk>
 <20090914.003321.160496287.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: amavisd-new at diku.dk
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

On Mon, 14 Sep 2009, Atsushi Nemoto wrote:

> On Sun, 13 Sep 2009 17:14:06 +0200 (CEST), Julia Lawall <julia@diku.dk> wrote:
> > > This patch add some correctness, but obviously incomplete: there are
> > > more error pathes without iounmap/kfree/etc. in this function.
> > 
> > The only other error path that I see is:
> > 
> >        pdev = platform_device_alloc("leds-gpio", basenum);
> >         if (!pdev)
> >                 return;
> > 
> > But at that point the call gpiochip_add(&iocled->chip) has already 
> > succeeded.  From looking at this function, I have the impression that it 
> > makes the iocled structure available from a global array, gpio_desc.  
> > Since the function containing the above code doesn't return any error 
> > code, perhaps the caller will not know whether this platform_device_alloc 
> > error occurred or not.  There would also be at least the problem of 
> > getting the pointer out of the gpio_desc structure.  I guess this could be 
> > done with gpiochip_remove?
> > 
> > I can certainly make a new patch using the goto style, but let me know 
> > what to do about the above issue.
> 
> Yes, this gpiochip is only used by leds-gpio driver.  So
> gpiochip_remove() would be the right thing to do when something
> failed.
> 
> Also there is one another error path: platform_device_add() failure at
> the end of this function.

OK, I see.  I will submit an improved patch.  Thanks for the explanations.

julia
