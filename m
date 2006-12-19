Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Dec 2006 16:24:11 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:31201 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28577296AbWLSQYH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Dec 2006 16:24:07 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 08A603ECA; Tue, 19 Dec 2006 08:24:01 -0800 (PST)
Message-ID: <4588121D.90505@ru.mvista.com>
Date:	Tue, 19 Dec 2006 19:23:57 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Daniel Laird <danieljlaird@hotmail.com>
Cc:	linux-mips@linux-mips.org, Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: 2.6.19 timer API changes
References: <7925588.post@talk.nabble.com> <7943218.post@talk.nabble.com> <20061219.233410.25911550.anemo@mba.ocn.ne.jp> <7948316.post@talk.nabble.com>
In-Reply-To: <7948316.post@talk.nabble.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Daniel Laird wrote:

> Atsushi Nemoto wrote:

>>Hmm, do the TIMER1 and CP0_COUNTER run at same speed?  If no, the
>>PNX8550 port should be broken (i.e. gettimeofday() did not work
>>properly) even without the timer API changes.  You should provide
>>custom clocksource.mips_read (previously named mips_hpt_read) function

    Meaning clocksource_mips.read... :-)

>>which returns TIMER1 counter value.  If the TIMER1 was not 32-bit
>>free-run counter, some trick would be required.  Refer sb1250 or
>>jmr3927 for example.

>>---
>>Atsushi Nemoto
>>
>>
>>
> 
> I am just starting to look into this (thankyou for your first comments).
> I have reduced the problem code, so if I change the following:
> /* For use both as a high precision timer and an interrupt source.  */
> static void __init c0_hpt_timer_init(void)
> {
> 	expirelo = read_c0_count() + cycles_per_jiffy;
> 	write_c0_compare(expirelo);
> } (the 2.6.19 version)
> to the following:
> /* For use both as a high precision timer and an interrupt source.  */
> static void __init c0_hpt_timer_init(void)
> {
>     unsigned int count = read_c0_count() - mips_hpt_read();

     Doesn't make sense to me... Should be 0 or near.

> 	expirelo = (count / cycles_per_jiffy + 1) * cycles_per_jiffy;
> 	write_c0_count(expirelo - cycles_per_jiffy);
> 	write_c0_compare(expirelo);
> 	write_c0_count(count);
> }

    This code just shouldn't be executing at all, since the interrupts are 
coming from the other source than standard CP0 count/compare registers (so, 
I'd assume mips_timer_state should need to be set -- but it doesn't)... and at 
the same time the handler writes to them... well, PNX8550 must have really 
weird timers...

> Then i get the system to boot up and all seems well.  I am new to this and
> am looking into why this change makes the system boot up.  As always though
> any help is appreciated.

> Cheers
> Dan

WBR, Sergei
