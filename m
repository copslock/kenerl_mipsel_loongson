Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Sep 2009 17:47:37 +0200 (CEST)
Received: from mgw1.diku.dk ([130.225.96.91]:34420 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493169AbZIOPrb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Sep 2009 17:47:31 +0200
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 0CB0652C3CD;
	Tue, 15 Sep 2009 17:47:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YLAlXk30vsnt; Tue, 15 Sep 2009 17:47:26 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id DAF5C52C3CA;
	Tue, 15 Sep 2009 17:47:26 +0200 (CEST)
Received: from pc-004.diku.dk (pc-004.diku.dk [130.225.97.4])
	by nhugin.diku.dk (Postfix) with ESMTP
	id AE1436DF835; Tue, 15 Sep 2009 17:45:34 +0200 (CEST)
Received: by pc-004.diku.dk (Postfix, from userid 3767)
	id BE1F4383F7; Tue, 15 Sep 2009 17:47:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by pc-004.diku.dk (Postfix) with ESMTP id BB8DA3830C;
	Tue, 15 Sep 2009 17:47:26 +0200 (CEST)
Date:	Tue, 15 Sep 2009 17:47:26 +0200 (CEST)
From:	Julia Lawall <julia@diku.dk>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/8] arch/mips/txx9: introduce missing kfree, iounmap
In-Reply-To: <20090916.004525.74746264.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64.0909151747120.8549@pc-004.diku.dk>
References: <20090914.003321.160496287.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64.0909132113520.31000@ask.diku.dk> <Pine.LNX.4.64.0909150701170.11392@ask.diku.dk>
 <20090916.004525.74746264.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

On Wed, 16 Sep 2009, Atsushi Nemoto wrote:

> On Tue, 15 Sep 2009 07:03:42 +0200 (CEST), Julia Lawall <julia@diku.dk> wrote:
> > > +out_pdev:
> > > +	platform_device_put(pdev);
> > > +out_gpio:
> > > +	gpio_remove(&iocled->chip);
> > 
> > I just noticed that the prototype of gpio_remove has __must_check
> > I don't think there is anything to check here; since the thing is not 
> > fully initialized here, it is unlikely to be busy.  Should there be (void) 
> > in front of it?
> 
> The void casting does not silence the warning.  How about this?
> 
> 	if (gpiochip_remove(&iocled->chip))
> 		return;
> 
> In general, memory leak would be less serious than crash or data
> corruption ;)

OK, I will send an updated patch shortly.

julia
