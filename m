Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Sep 2009 17:14:18 +0200 (CEST)
Received: from mgw1.diku.dk ([130.225.96.91]:51608 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492696AbZIMPOL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 13 Sep 2009 17:14:11 +0200
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 3ABAE52C325;
	Sun, 13 Sep 2009 17:14:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ojxZV+39Wxrn; Sun, 13 Sep 2009 17:14:06 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id E683E52C31C;
	Sun, 13 Sep 2009 17:14:06 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 7AE3D6DF835; Sun, 13 Sep 2009 17:12:17 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3767)
	id C6AE9F35A; Sun, 13 Sep 2009 17:14:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ask.diku.dk (Postfix) with ESMTP id BF1A9F0AB;
	Sun, 13 Sep 2009 17:14:06 +0200 (CEST)
Date:	Sun, 13 Sep 2009 17:14:06 +0200 (CEST)
From:	Julia Lawall <julia@diku.dk>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/8] arch/mips/txx9: introduce missing kfree, iounmap
In-Reply-To: <20090913.232548.253168283.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64.0909131708190.25903@ask.diku.dk>
References: <Pine.LNX.4.64.0909111820370.10552@pc-004.diku.dk>
 <20090913.232548.253168283.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

On Sun, 13 Sep 2009, Atsushi Nemoto wrote:

> On Fri, 11 Sep 2009 18:21:00 +0200 (CEST), Julia Lawall <julia@diku.dk> wrote:
> > From: Julia Lawall <julia@diku.dk>
> > 
> > Error handling code following a kzalloc should free the allocated data.
> > Error handling code following an ioremap should iounmap the allocated data.
> > 
> > The semantic match that finds the first problem is as follows:
> > (http://www.emn.fr/x-info/coccinelle/)
> 
> Thank you for finding this out.
> 
> This patch add some correctness, but obviously incomplete: there are
> more error pathes without iounmap/kfree/etc. in this function.

The only other error path that I see is:

       pdev = platform_device_alloc("leds-gpio", basenum);
        if (!pdev)
                return;

But at that point the call gpiochip_add(&iocled->chip) has already 
succeeded.  From looking at this function, I have the impression that it 
makes the iocled structure available from a global array, gpio_desc.  
Since the function containing the above code doesn't return any error 
code, perhaps the caller will not know whether this platform_device_alloc 
error occurred or not.  There would also be at least the problem of 
getting the pointer out of the gpio_desc structure.  I guess this could be 
done with gpiochip_remove?

I can certainly make a new patch using the goto style, but let me know 
what to do about the above issue.

thanks,
julia


> And I like goto-style cleanup, as Mark Brown said in reply for your
> sound/soc patch.
> 
> Could you make a new patch?
> 
> ---
> Atsushi Nemoto
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
