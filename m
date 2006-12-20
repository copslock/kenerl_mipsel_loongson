Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2006 18:02:27 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:21001 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28583968AbWLTSCU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 Dec 2006 18:02:20 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id E31B33EC9; Wed, 20 Dec 2006 10:01:59 -0800 (PST)
Message-ID: <45897A93.9020903@ru.mvista.com>
Date:	Wed, 20 Dec 2006 21:01:55 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Daniel Laird <danieljlaird@hotmail.com>, linux-mips@linux-mips.org,
	Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: 2.6.19 timer API changes
References: <7925588.post@talk.nabble.com> <7943218.post@talk.nabble.com> <20061219.233410.25911550.anemo@mba.ocn.ne.jp> <20061220.000113.59033093.anemo@mba.ocn.ne.jp> <7949125.post@talk.nabble.com> <20061220.021508.97296486.anemo@mba.ocn.ne.jp> <7987092.post@talk.nabble.com> <458944B9.1050204@ru.mvista.com> <056f01c72446$31687b30$10eca8c0@grendel>
In-Reply-To: <056f01c72446$31687b30$10eca8c0@grendel>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Kevin D. Kissell wrote:

> they are referring to when they begin the next sentence with "When active".
> I can see how someone might think it advantageous to have a mode where
> the Count register auto-resets on a timer tick, so that there's no need to
> recalcuate Compare values.  But I've never seen that implemented on a
> MIPS processor.

    Toshiba TX3927 mentioned in that thread before is an example...

> Free-running Count registers have other uses that can
> be shared with the timer interrupts, so long as it's Compare and not Count
> that gets reprogrammed on an interrupt. I have a hard time believing that
> the 8550 has the auto-reset as default behavior.

    Yet the code suggests that it does. PNX8550 seems to be a strange beast... :-)

>>>If I do the following:
>>>static void __init c0_hpt_timer_init(void)
>>>{
>>>#ifdef CONFIG_SOC_PNX8550 /* pnx8550 resets to zero */
>>>    expirelo = cycles_per_jiffy;
>>>#else
>>>    expirelo = read_c0_count() + cycles_per_jiffy;
>>>#endif
>>>    write_c0_compare(expirelo);
>>>    write_c0_count(cycles_per_jiffy); //Added DJL
>>>}

> First of all, I think the conditional code is broken, even if you
> believe that Count is reset to zero on every interrupt.  This is
> the *init* code, that's getting called once at boot time to set
> up the clock.  It's not a clock interrupt handler.

> It is highly likely that the Count register has already gone

    This is called why the count is disabled -- this is done in 
arch_init_irq(). Only plat_timer_setup() re-enables it.

> beyond the value of cycles_per_jiffy by the time this code
> gets hit.  If that's true, programming Compare to zero+delta
> means waiting for the counter to wrap around before the first
> interrupt is delivered - a 10-second-ish hang.  Writing the same
> value to Count that you just wrote to Compare will, on many
> cores, cause a Count=Compare state and a prompt interrupt.

> But the real fix is almost certainly to get rid of the conditional.

    That would be too simple... :-)
    Moreover, with presumed auto-reload behavior it's likely to warrant the 
wrong expirelo value (which in turn will cause jiffies to be longer than 
intended) -- all because of Count register possible being non-zero at this 
point...

>             Kevin K.

WBR, Sergei
