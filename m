Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Sep 2009 17:33:36 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.28.14.163]:52780 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492765AbZIMPda (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 13 Sep 2009 17:33:30 +0200
Received: from localhost (p5010-ipad310funabasi.chiba.ocn.ne.jp [123.217.207.10])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3059D66CA; Mon, 14 Sep 2009 00:33:21 +0900 (JST)
Date:	Mon, 14 Sep 2009 00:33:21 +0900 (JST)
Message-Id: <20090914.003321.160496287.anemo@mba.ocn.ne.jp>
To:	julia@diku.dk
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/8] arch/mips/txx9: introduce missing kfree, iounmap
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64.0909131708190.25903@ask.diku.dk>
References: <Pine.LNX.4.64.0909111820370.10552@pc-004.diku.dk>
	<20090913.232548.253168283.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64.0909131708190.25903@ask.diku.dk>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 13 Sep 2009 17:14:06 +0200 (CEST), Julia Lawall <julia@diku.dk> wrote:
> > This patch add some correctness, but obviously incomplete: there are
> > more error pathes without iounmap/kfree/etc. in this function.
> 
> The only other error path that I see is:
> 
>        pdev = platform_device_alloc("leds-gpio", basenum);
>         if (!pdev)
>                 return;
> 
> But at that point the call gpiochip_add(&iocled->chip) has already 
> succeeded.  From looking at this function, I have the impression that it 
> makes the iocled structure available from a global array, gpio_desc.  
> Since the function containing the above code doesn't return any error 
> code, perhaps the caller will not know whether this platform_device_alloc 
> error occurred or not.  There would also be at least the problem of 
> getting the pointer out of the gpio_desc structure.  I guess this could be 
> done with gpiochip_remove?
> 
> I can certainly make a new patch using the goto style, but let me know 
> what to do about the above issue.

Yes, this gpiochip is only used by leds-gpio driver.  So
gpiochip_remove() would be the right thing to do when something
failed.

Also there is one another error path: platform_device_add() failure at
the end of this function.

Thanks.
---
Atsushi Nemoto
