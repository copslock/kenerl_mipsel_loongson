Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Sep 2009 16:02:13 +0200 (CEST)
Received: from rs1.rw-gmbh.net ([213.239.201.58]:53077 "EHLO rs1.rw-gmbh.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492235AbZIOOCH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Sep 2009 16:02:07 +0200
Received: from p50992dee.dip0.t-ipconnect.de ([80.153.45.238] helo=ximap.rw-gmbh.biz)
	by rs1.rw-gmbh.net with esmtp (Exim 4.69)
	(envelope-from <ralf.roesch@rw-gmbh.de>)
	id 1MnYbb-0002nN-SR; Tue, 15 Sep 2009 16:02:04 +0200
Received: from [192.168.178.44] (rr-2600 [192.168.178.44])
	by ximap.rw-gmbh.biz (Postfix) with ESMTP
	id 5B13F174B2E; Tue, 15 Sep 2009 16:04:31 +0200 (CEST)
Message-ID: <4AAF9E5B.5040909@rw-gmbh.de>
Date:	Tue, 15 Sep 2009 16:02:03 +0200
From:	=?windows-1252?Q?Ralf_R=F6sch?= <ralf.roesch@rw-gmbh.de>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	Julia Lawall <julia@diku.dk>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/8] arch/mips/txx9: introduce missing kfree, iounmap
References: <Pine.LNX.4.64.0909111820370.10552@pc-004.diku.dk> <20090913.232548.253168283.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64.0909131708190.25903@ask.diku.dk> <20090914.003321.160496287.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64.0909132113520.31000@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.0909132113520.31000@ask.diku.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ralf.roesch@rw-gmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf.roesch@rw-gmbh.de
Precedence: bulk
X-list: linux-mips

The gpio_remove is missing:
  arch/mips/txx9/generic/setup.c:838: error: implicit declaration of function ‘gpio_remove’

Should it be gpiochip_remove() instead?

--
Ralf Roesch


The Julia Lawall schrieb:
> From: Julia Lawall <julia@diku.dk>
>
> Error handling code following a kzalloc should free the allocated data.
> Error handling code following an ioremap should iounmap the allocated data.
>
> The semantic match that finds the first problem is as follows:
> (http://www.emn.fr/x-info/coccinelle/)
>
> // <smpl>
> @r exists@
> local idexpression x;
> statement S;
> expression E;
> identifier f,f1,l;
> position p1,p2;
> expression *ptr != NULL;
> @@
>
> x@p1 = \(kmalloc\|kzalloc\|kcalloc\)(...);
> ...
> if (x == NULL) S
> <... when != x
>      when != if (...) { <+...x...+> }
> (
> x->f1 = E
> |
>  (x->f1 == NULL || ...)
> |
>  f(...,x->f1,...)
> )
> ...>
> (
>  return \(0\|<+...x...+>\|ptr\);
> |
>  return@p2 ...;
> )
>
> @script:python@
> p1 << r.p1;
> p2 << r.p2;
> @@
>
> print "* file: %s kmalloc %s return %s" % (p1[0].file,p1[0].line,p2[0].line)
> // </smpl>
>
> Signed-off-by: Julia Lawall <julia@diku.dk>
> ---
>  arch/mips/txx9/generic/setup.c      |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
> index a205e2b..c860810 100644
> --- a/arch/mips/txx9/generic/setup.c
> +++ b/arch/mips/txx9/generic/setup.c
> @@ -782,7 +782,7 @@ void __init txx9_iocled_init(unsigned long baseaddr,
>  		return;
>  	iocled->mmioaddr = ioremap(baseaddr, 1);
>  	if (!iocled->mmioaddr)
> -		return;
> +		goto out_free;
>  	iocled->chip.get = txx9_iocled_get;
>  	iocled->chip.set = txx9_iocled_set;
>  	iocled->chip.direction_input = txx9_iocled_dir_in;
> @@ -791,13 +791,13 @@ void __init txx9_iocled_init(unsigned long baseaddr,
>  	iocled->chip.base = basenum;
>  	iocled->chip.ngpio = num;
>  	if (gpiochip_add(&iocled->chip))
> -		return;
> +		goto out_unmap;
>  	if (basenum < 0)
>  		basenum = iocled->chip.base;
>  
>  	pdev = platform_device_alloc("leds-gpio", basenum);
>  	if (!pdev)
> -		return;
> +		goto out_gpio;
>  	iocled->pdata.num_leds = num;
>  	iocled->pdata.leds = iocled->leds;
>  	for (i = 0; i < num; i++) {
> @@ -812,7 +812,16 @@ void __init txx9_iocled_init(unsigned long baseaddr,
>  	}
>  	pdev->dev.platform_data = &iocled->pdata;
>  	if (platform_device_add(pdev))
> -		platform_device_put(pdev);
> +		goto out_pdev;
> +	return;
> +out_pdev:
> +	platform_device_put(pdev);
> +out_gpio:
> +	gpio_remove(&iocled->chip);
> +out_unmap:
> +	iounmap(iocled->mmioaddr);
> +out_free:
> +	kfree(iocled);
>  }
>  #else /* CONFIG_LEDS_GPIO */
>  void __init txx9_iocled_init(unsigned long baseaddr,
>
>   
