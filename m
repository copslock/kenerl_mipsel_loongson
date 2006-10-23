Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2006 13:32:37 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:56243 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039337AbWJWMcd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Oct 2006 13:32:33 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 51FF23ECA; Mon, 23 Oct 2006 05:32:25 -0700 (PDT)
Message-ID: <453CB658.9030307@ru.mvista.com>
Date:	Mon, 23 Oct 2006 16:32:24 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, tglx@linutronix.de, johnstul@us.ibm.com
Subject: Re: [PATCH] rest of works for migration to GENERIC_TIME
References: <20061023.033407.104640794.anemo@mba.ocn.ne.jp>	<453BC5B4.50005@ru.mvista.com> <20061023.120059.63742109.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20061023.120059.63742109.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> On Sun, 22 Oct 2006 23:25:40 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

>>> arch/mips/au1000/common/time.c          |   98 ----------

>>    If the generic implementation is working well, the Alchemy code doesn't 
>>need its own anymore. However, my patch that fixes the mips_hpt_frequency 
>>calculation needs to be applied first before deleing this code. I'll try to 
>>look into this and test some time...

> Hmm, mips_hpt_frequency would be bad than lesser resolution.

    Not sure I understood you but my wording was unclear as well: what I meant 
to say is the Alchemy code doesn't need its own timer handler anymore -- that 
was my assumption after I saw the changes you made to timer_interrupt()...

 > Please push your fix to Ralf again ;)

    Frankly, I'm too tired of that process. ;-)

>>>+static unsigned int jmr3927_hpt_read(void)
>>>+{
>>>+	unsigned int count;
>>>+	unsigned long j;
>>>+	/* read consistent jiffies and counter */
>>>+	do {
>>>+		count = jmr3927_tmrptr->trr;
>>>+		j = jiffies;
>>>+	} while (count > jmr3927_tmrptr->trr);
>>>+	return j * (JMR3927_TIMER_CLK / HZ) + count;
>>>+}

>>    That emulation trick looks very dubious. I'd suggest to implement a 
>>different clocksource driver instead, since this is, after all, is not a CPU 
>>counter. And this will get in the way of the clockevent implementation later. 
>>  Also, it's stops to be continuous this way. And I don't understand why you 
>>need this trick at all if you have the variable mips_hpt_mask...
>>    And the same complaint about BCM1480 code.

> This trick is due to range of TRR register.  The width of the counter
> field is 24bit, but the range is not 0 - 0xffffff.  It wraps at some
> non-all-F value.  So mips_hpt_mask can not help this.

    This happens not due to a nature of this timer itself but due to the fact 
that it's used to generate the jiffy interrupt, and therefore the comparator 
register (which is obviously set to non-0xFFFFFF value) guiding its behavior. 
There's no sense (or even need) in using it as a clock source -- TX3927 has 3 
timers! So, you need to just use some other timer than #0 and set the 
comparator A to 0xFFFFFF for it...

> But this loop is not correct indeed.  If it called without xtime_lock
> and interrupt disabled, it would return wrong value.  I should think
> again ...

    The whole idea of using such timer as TX39 has for both generating the 
interrupts and as a clocksource was wrong, I'm afraid.  You only can use a 
something similar to the MIPS counter which doesn't ever get auto-reloaded for 
both purposes at once.

>>    Well, I'd vote against the generic implementation. It's not
>>quite correct to call all the diverse timers here "MIPS", IMHO...

> How about calling it "MIPS-hpt" or something?

    The name is not a problem, I didn't like the whole generic approach. 
However, this seems a simpler way of doing this thing, so we probably should 
indeed stick to it...

> ---
> Atsushi Nemoto

WBR, Sergei
