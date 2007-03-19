Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 13:37:35 +0000 (GMT)
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:776 "EHLO
	kraid.nerim.net") by ftp.linux-mips.org with ESMTP
	id S20021775AbXCSNha (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 13:37:30 +0000
Received: from arrakis.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by kraid.nerim.net (Postfix) with SMTP id A515F415A6;
	Mon, 19 Mar 2007 14:36:58 +0100 (CET)
Date:	Mon, 19 Mar 2007 14:36:12 +0100
From:	Jean Delvare <khali@linux-fr.org>
To:	Ladislav Michl <ladis@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Marc St-Jean <stjeanma@pmc-sierra.com>,
	akpm@linux-foundation.org, linux-mips@linux-mips.org,
	i2c@lm-sensors.org
Subject: Re: [PATCH 8/12] drivers: PMC MSP71xx TWI driver]
Message-Id: <20070319143612.f14d770b.khali@linux-fr.org>
In-Reply-To: <20070319104155.GA16362@michl.2n.cz>
References: <20070316230333.GA17478@linux-mips.org>
	<20070317085244.f99aad86.khali@linux-fr.org>
	<20070319104155.GA16362@michl.2n.cz>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Ladislav,

On Mon, 19 Mar 2007 11:41:55 +0100, Ladislav Michl wrote:
> On Sat, Mar 17, 2007 at 08:52:44AM +0100, Jean Delvare wrote:
> [snip]
> > Why are you making a separate algorithm driver? This should really only
> > be done when the algorithm is very generic. This is the exception, not
> > the rule. These days I tend to move algorithm code back into the only
> > bus driver that uses them (i2c-algo-sibyte done recently, i2c-algo-sgi
> > is next on my list.)
> 
> Please remove i2c-algo-sgi from your list. This algorithm is used by
> the VINO asic (drivers/media/video/vino.c) present in SGI Indy machines as
> well as by the MACE asic (no driver exist yet) present in SGI O2 machines.

OK, thanks for the info. It's hard to tell for sure without seeing the
missing code for the MACE, but I still think that the split between the
different source files is not correct. I think that you want to have
one platform-based i2c bus driver (not just algorithm), which works
with both the VINO and the MACE, one dedicated driver for the Indy
which glues the I2C bus, the SAA7191 and the Indycam together, and
another dedicated driver for the O2 which glues the I2C bus and whatever
chips are on it, together.

BTW, the vino driver is on my (now very short) list of drivers which
create i2c busses without a valid parent. It doesn't seem to fit in the
Linux 2.6 device driver model at all. If you have supported hardware,
could you please fix this? You probably simply need to create a
platform driver and device for the VINO chip, and use that as the
parent of the i2c bus.

> You may consider applying this patch (also removes trailing whitespace).
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> 
> --- linux-omap-2.6.git/drivers/i2c/algos/i2c-algo-sgi.c.orig	2007-03-19 11:26:30.000000000 +0100
> +++ linux-omap-2.6.git/drivers/i2c/algos/i2c-algo-sgi.c	2007-03-19 11:39:00.000000000 +0100
> @@ -1,6 +1,7 @@
>  /*
> - * i2c-algo-sgi.c: i2c driver algorithms for SGI adapters.
> - * 
> + * i2c-algo-sgi.c: i2c driver algorithm used by the VINO (SGI Indy) and
> + * MACE (SGI O2) chips.
> + *
>   * This file is subject to the terms and conditions of the GNU General Public
>   * License version 2 as published by the Free Software Foundation.
>   *
> @@ -162,8 +163,8 @@
>  	.functionality	= sgi_func,
>  };
>  
> -/* 
> - * registering functions to load algorithms at runtime 
> +/*
> + * registering functions to load algorithms at runtime
>   */
>  int i2c_sgi_add_bus(struct i2c_adapter *adap)
>  {

OK, I'll apply this, it cannot hurt.

Thanks,
-- 
Jean Delvare
