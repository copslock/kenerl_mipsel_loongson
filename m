Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2008 16:13:52 +0100 (CET)
Received: from h155.mvista.com ([63.81.120.155]:8567 "EHLO imap.sh.mvista.com")
	by lappi.linux-mips.net with ESMTP id S528798AbYC1PNq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Mar 2008 16:13:46 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 4F0203ECB; Fri, 28 Mar 2008 08:13:12 -0700 (PDT)
Message-ID: <47ED0B5C.9060003@ru.mvista.com>
Date:	Fri, 28 Mar 2008 18:14:36 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org, ncoesel@DEALogic.nl
Subject: Re: Alchemy power managment code.
References: <47E7BB4B.3080507@ru.mvista.com>	<20080327223134.GA26997@linux-mips.org>	<47ECD828.8090600@ru.mvista.com> <20080328.232527.72707102.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080328.232527.72707102.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>>Correct - and cevt-r4k won't be usable either.  I guess that means you
>>>leave the user the choice between either these two or using wait.  Not
>>>nice but ...

>>    The Alchemy code doesn't even try to use CP0 counter when CONFIG_PM=y if 
>>you look into arch/mips/au1000/common/time.c... or at least it didn't before 
>>Atsushi removed do_fast_pm_gettimeoffset().

> Oh, yes. At that time I tried to implement clocksource drivers for
> non-standard timers, but it seems I had missied Alchemy PM=y case.

> The driver would be something like this?  Completely untested ;-)

> static cycle_t au1000_hpt_read(void)
> {
> 	return au_readl(SYS_TOYREAD);
> }

> struct clocksource au1000_clocksource = {
> 	.name	= "au1000-counter",
> 	.rating	= 200,

    Rating should be greater than that of CP0 counter...

> 	.read	= au1000_hpt_read,
> 	.mask	= CLOCKSOURCE_MASK(32),
> 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
> };

> void __init au1000_clocksource_init(unsinged long cpu_speed)
> {
> 	struct clocksource *cs = &au1000_clocksource;
> 
> 	clocksource_set_clock(cs, cpu_speed);

    Not really, it's clocked by 32768 Hz input, so probably not very good as a 
clocksource.

> 	clocksource_register(cs);
> }

WBR, Sergei
