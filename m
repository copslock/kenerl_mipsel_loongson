Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Sep 2009 17:45:37 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.28.14.163]:57215 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1493136AbZIOPpa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Sep 2009 17:45:30 +0200
Received: from localhost (p8092-ipad307funabasi.chiba.ocn.ne.jp [123.217.186.92])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 15FC66AE0; Wed, 16 Sep 2009 00:45:24 +0900 (JST)
Date:	Wed, 16 Sep 2009 00:45:25 +0900 (JST)
Message-Id: <20090916.004525.74746264.anemo@mba.ocn.ne.jp>
To:	julia@diku.dk
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/8] arch/mips/txx9: introduce missing kfree, iounmap
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64.0909150701170.11392@ask.diku.dk>
References: <20090914.003321.160496287.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64.0909132113520.31000@ask.diku.dk>
	<Pine.LNX.4.64.0909150701170.11392@ask.diku.dk>
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
X-archive-position: 24035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 15 Sep 2009 07:03:42 +0200 (CEST), Julia Lawall <julia@diku.dk> wrote:
> > +out_pdev:
> > +	platform_device_put(pdev);
> > +out_gpio:
> > +	gpio_remove(&iocled->chip);
> 
> I just noticed that the prototype of gpio_remove has __must_check
> I don't think there is anything to check here; since the thing is not 
> fully initialized here, it is unlikely to be busy.  Should there be (void) 
> in front of it?

The void casting does not silence the warning.  How about this?

	if (gpiochip_remove(&iocled->chip))
		return;

In general, memory leak would be less serious than crash or data
corruption ;)

---
Atsushi Nemoto
