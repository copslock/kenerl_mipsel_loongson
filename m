Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2007 16:06:50 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:57814 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022864AbXICPGl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Sep 2007 16:06:41 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 9FDD7B9916;
	Mon,  3 Sep 2007 17:04:45 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1ISDTo-0007Nh-QN; Mon, 03 Sep 2007 16:04:44 +0100
Date:	Mon, 3 Sep 2007 16:04:44 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/7] AR7: core support
Message-ID: <20070903150444.GC29574@networkno.de>
References: <40101cc30709030623r4fb2d3caw146fa6dec16b283e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40101cc30709030623r4fb2d3caw146fa6dec16b283e@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Matteo Croce wrote:
[snip]
> diff --git a/arch/mips/ar7/clock.c b/arch/mips/ar7/clock.c
> new file mode 100644
> index 0000000..9edde34
> --- /dev/null
> +++ b/arch/mips/ar7/clock.c
> @@ -0,0 +1,472 @@
> +/*
> + * $Id: clock.c 8036 2007-07-18 13:42:24Z florian $

No CVS id strings, please.

> + * Copyright (C) 2007 OpenWrt.org

Does OpenWRT actually require copyright assignment? If not, this place
should list the Author(s) as the actual copyright holders.

[snip]
> +int ar7_afe_clock = 35328000;
> +int ar7_ref_clock = 25000000;
> +int ar7_xtal_clock = 24000000;
> +
> +int ar7_cpu_clock = 150000000;
> +EXPORT_SYMBOL(ar7_cpu_clock);
> +int ar7_bus_clock = 125000000;

Magic constants.

[snip]
> +EXPORT_SYMBOL(ar7_bus_clock);
> +int ar7_dsp_clock = 0;
> +EXPORT_SYMBOL(ar7_dsp_clock);
> +
> +static int gcd(int x, int y)
> +{
> +	if (x > y)
> +		return (x % y) ? gcd(y, x % y) : y;
> +	return (y % x) ? gcd(x, y % x) : x;
> +}
> +
> +static inline int ABS(int x)
> +{
> +	return (x >= 0) ? x : -x;
> +}

Isn't that already available in the generic kernel code?


Thiemo
