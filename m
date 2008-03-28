Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2008 15:26:14 +0100 (CET)
Received: from mba.ocn.ne.jp ([122.1.235.107]:21996 "EHLO smtp.mba.ocn.ne.jp")
	by lappi.linux-mips.net with ESMTP id S528733AbYC1O0G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Mar 2008 15:26:06 +0100
Received: from localhost (p8031-ipad209funabasi.chiba.ocn.ne.jp [58.88.119.31])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A8DBEA9A2; Fri, 28 Mar 2008 23:24:44 +0900 (JST)
Date:	Fri, 28 Mar 2008 23:25:27 +0900 (JST)
Message-Id: <20080328.232527.72707102.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org, ncoesel@DEALogic.nl
Subject: Re: Alchemy power managment code.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <47ECD828.8090600@ru.mvista.com>
References: <47E7BB4B.3080507@ru.mvista.com>
	<20080327223134.GA26997@linux-mips.org>
	<47ECD828.8090600@ru.mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 28 Mar 2008 14:36:08 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > Correct - and cevt-r4k won't be usable either.  I guess that means you
> > leave the user the choice between either these two or using wait.  Not
> > nice but ...
> 
>     The Alchemy code doesn't even try to use CP0 counter when CONFIG_PM=y if 
> you look into arch/mips/au1000/common/time.c... or at least it didn't before 
> Atsushi removed do_fast_pm_gettimeoffset().

Oh, yes. At that time I tried to implement clocksource drivers for
non-standard timers, but it seems I had missied Alchemy PM=y case.

The driver would be something like this?  Completely untested ;-)

static cycle_t au1000_hpt_read(void)
{
	return au_readl(SYS_TOYREAD);
}

struct clocksource au1000_clocksource = {
	.name	= "au1000-counter",
	.rating	= 200,
	.read	= au1000_hpt_read,
	.mask	= CLOCKSOURCE_MASK(32),
	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
};

void __init au1000_clocksource_init(unsinged long cpu_speed)
{
	struct clocksource *cs = &au1000_clocksource;

	clocksource_set_clock(cs, cpu_speed);
	clocksource_register(cs);
}

---
Atsushi Nemoto
