Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Oct 2009 05:50:46 +0200 (CEST)
Received: from www.tglx.de ([62.245.132.106]:36956 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491941AbZJTDui (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Oct 2009 05:50:38 +0200
Received: from localhost (www.tglx.de [127.0.0.1])
	by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id n9K3oMwF027228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Oct 2009 05:50:25 +0200
Date:	Tue, 20 Oct 2009 05:50:21 +0200 (CEST)
From:	Thomas Gleixner <tglx@linutronix.de>
To:	Linus Walleij <linus.walleij@stericsson.com>
cc:	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@linux-mips.org, Mikael Pettersson <mikpe@it.uu.se>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Make MIPS dynamic clocksource/clockevent clock code
 generic
In-Reply-To: <1255819715-19763-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <alpine.LFD.2.00.0910200454300.2863@localhost.localdomain>
References: <1255819715-19763-1-git-send-email-linus.walleij@stericsson.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: clamav-milter 0.95.1 at www.tglx.de
X-Virus-Status:	Clean
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Sun, 18 Oct 2009, Linus Walleij wrote:
> This moves the clocksource_set_clock() and clockevent_set_clock()
> from the MIPS timer code into clockchips and clocksource where
> it belongs. The patch was triggered by code posted by Mikael
> Pettersson duplicating this code for the IOP ARM system. The
> function signatures where altered slightly to fit into their
> destination header files, unsigned int changed to u32 and inlined.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mikael Pettersson <mikpe@it.uu.se>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
> Ralf has stated in earlier conversation that this should be moved,
> now we risk duplicating code so let's move it.

Please do not make that functions inline. They are too large and there
is no benefit of inlining them.

> +/**
> + * clockevent_set_clock - dynamically calculates an appropriate shift
> + *			  and mult value for a clocksource given a
> + *			  known clock frequency
> + * @dev:	Clockevent device to initialize
> + * @hz:		Clockevent clock frequency in Hz
> + */
> +static inline void clockevent_set_clock(struct clock_event_device *dev, u32 hz)
> +{
> +	u64 temp;
> +	u32 shift;
> +
> +	/* Find a shift value */
> +	for (shift = 32; shift > 0; shift--) {
> +		temp = (u64) hz << shift;
> +		do_div(temp, NSEC_PER_SEC);
> +		if ((temp >> 32) == 0)
> +			break;
> +	}
> +	dev->shift = shift;
> +	dev->mult = (u32) temp;
> +}
> +
> +
> +static inline void clocksource_set_clock(struct clocksource *cs, u32 hz)
> +{
> +	u64 temp;
> +	u32 shift;
> +
> +	/* Find a shift value */
> +	for (shift = 32; shift > 0; shift--) {
> +		temp = (u64) NSEC_PER_SEC << shift;
> +		do_div(temp, hz);
> +		if ((temp >> 32) == 0)
> +			break;
> +	}
> +	cs->shift = shift;
> +	cs->mult = (u32) temp;
> +}
> +

So that's the same function twice, right ? The reason for it are the
different data structures. So could you please do something like:

void calc_shift_mult(u32 *shift, u32 *mult, u32 hz)
{
	do the magic math
}

and have wrapper inline functions for clocksource and clockevents
around it.

Thanks,

	tglx
