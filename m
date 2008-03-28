Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2008 17:12:25 +0100 (CET)
Received: from h155.mvista.com ([63.81.120.155]:26489 "EHLO imap.sh.mvista.com")
	by lappi.linux-mips.net with ESMTP id S528891AbYC1QMT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Mar 2008 17:12:19 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id D81153ECA; Fri, 28 Mar 2008 09:11:44 -0700 (PDT)
Message-ID: <47ED1915.6040506@ru.mvista.com>
Date:	Fri, 28 Mar 2008 19:13:09 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Nico Coesel <ncoesel@DEALogic.nl>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: Alchemy power managment code.
References: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF9A2@dealogicserver.DEALogic.nl>
In-Reply-To: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF9A2@dealogicserver.DEALogic.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Nico Coesel wrote:

>>>>>Correct - and cevt-r4k won't be usable either.  I guess that means 
>>>>>you leave the user the choice between either these two or using wait.  

>>>>>Not nice but ...

>>>>   The Alchemy code doesn't even try to use CP0 counter when 
>>>>CONFIG_PM=y if you look into 

>>arch/mips/au1000/common/time.c... or at 

>>>>least it didn't before Atsushi removed do_fast_pm_gettimeoffset().

>>>Oh, yes. At that time I tried to implement clocksource drivers for 
>>>non-standard timers, but it seems I had missied Alchemy PM=y case.

>>>The driver would be something like this?  Completely untested ;-)

>>>static cycle_t au1000_hpt_read(void)
>>>{
>>>	return au_readl(SYS_TOYREAD);
>>>}

>>>struct clocksource au1000_clocksource = {
>>>	.name	= "au1000-counter",
>>>	.rating	= 200,

>>    Rating should be greater than that of CP0 counter...

>>>	.read	= au1000_hpt_read,
>>>	.mask	= CLOCKSOURCE_MASK(32),
>>>	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
>>>};

>>>void __init au1000_clocksource_init(unsinged long cpu_speed) {
>>>	struct clocksource *cs = &au1000_clocksource;
>>>
>>>	clocksource_set_clock(cs, cpu_speed);

>>    Not really, it's clocked by 32768 Hz input, so probably 
>>not very good as a clocksource.

> Why not? If a 32768Hz watch crystal is connected then you'll have a
> stable clocksource. IIRC watch crystals are more precise than the
> crystals used to generate the core frequency.

    32 KHz is too low a frequency. The same goes about using TOY as a 
clockevent -- HRT boasts microsecond resoultion which TOY can't provide.

> Nico Coesel

WBR, Sergei
