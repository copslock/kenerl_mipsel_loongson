Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2011 14:45:06 +0200 (CEST)
Received: from qmta11.emeryville.ca.mail.comcast.net ([76.96.27.211]:58627
        "EHLO qmta11.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491101Ab1IMMoz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Sep 2011 14:44:55 +0200
Received: from omta10.emeryville.ca.mail.comcast.net ([76.96.30.28])
        by qmta11.emeryville.ca.mail.comcast.net with comcast
        id YCkP1h0030cQ2SLABCkh07; Tue, 13 Sep 2011 12:44:41 +0000
Received: from [192.168.1.13] ([76.106.65.35])
        by omta10.emeryville.ca.mail.comcast.net with comcast
        id YCkQ1h00L0leNgC8WCkR9L; Tue, 13 Sep 2011 12:44:27 +0000
Message-ID: <4E6F4FFB.7050704@gentoo.org>
Date:   Tue, 13 Sep 2011 08:43:39 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
MIME-Version: 1.0
To:     post@pfrst.de
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        attilio.fiandrotti@gmail.com
Subject: Re: [PATCH] Impact video driver for SGI Indigo2
References: <Pine.LNX.4.64.1109111200400.4146@Indigo2.Peter>
In-Reply-To: <Pine.LNX.4.64.1109111200400.4146@Indigo2.Peter>
X-Enigmail-Version: 1.2.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 31064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6354

On 09/11/2011 07:14, peter fuerst wrote:

> +#ifndef CONFIG_EARLY_PRINTK
> +        if (ctype && strstr(ctype, "impact=early"))
> +#endif


I think we can gut all the Impact early printk stuff.  Per Skylark, to use
it, you have to drop a function call into arch/mips/kernel/setup.c and
kernel/printk.c, so I don't think this is an easily-used feature.  In my
patchset for Gentoo's mips-sources, I actually broke both Impact and
Odyssey's early console bits out as separate drivers applied as patches if
one forces a debug mode on.  Because they're not really even real
consoles....just a way to get output out of offbeat systems like Octane,
which hides all the good stuff behind the broken (horifically broken) IOC3
metadevice.

Unless you've come up with a better way to do early printk that can work
shortly after the CPUs are brought up?


> +# elif defined(CONFIG_SGI_IP26)
> +#  define IPNR 26


I don't think IP26 will ever live.  I think the old R8000 TLB code was
removed a few years ago, too, so to get such systems to work, someone needs
to actually have one (I do), resurrect the old code, add in the TLB pieces
(the Manual is available, so this isn't beyond impossible now), and test it.
 But at 75MHz, these machines aren't exactly speed demons, compared even to
an R10K I2.

> +    /* CFIFO parameters */
> +    IMPACT_CFIFO_HW(mmio) = VAL_CFIFO_HW;
> +    IMPACT_CFIFO_LW(mmio) = VAL_CFIFO_LW;
> +    IMPACT_CFIFO_DELAY(mmio) = VAL_CFIFO_DELAY;


If I recall correctly, doesn't IMPACT_CFIFO_* break down to a pointer
dereference?  I was thinking it might be more readable to finally create a
static inline function called impact_write* and impact_read* to take care of
register access than doing pointer dereferences.  I got dinged on this when
trying to submit a driver for the RTC 1687-5 in O2 and Octane a few months ago.


> +    *cfifo = IMPACT_CMD_COLORMASKLSBSA(0xffffff);
> +    *cfifo = IMPACT_CMD_COLORMASKLSBSB(0xffffff);
> +    *cfifo = IMPACT_CMD_COLORMASKMSBS(0);
> +    *cfifo = IMPACT_CMD_XFRMASKLO(0xffffff);
> +    *cfifo = IMPACT_CMD_XFRMASKHI(0xffffff);


Ditto per the above.


Don't have a working IP22 board anymore.  Haven't setup my old IP28 in a
while, but it is intact and does have a SolidImpact in it.  I also have a
working IP26 (as noted above), but I would be surprised if anyone ever
tackled R8000 support, given the exotic nature of that CPU.

Yell if you ever pick up an Octane -- I could use some help getting that
beast to work again...

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
