Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2006 15:48:55 +0000 (GMT)
Received: from www.nabble.com ([72.21.53.35]:30405 "EHLO talk.nabble.com")
	by ftp.linux-mips.org with ESMTP id S28583463AbWLTPsn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 Dec 2006 15:48:43 +0000
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50)
	id 1Gx3gQ-0007YC-T7
	for linux-mips@linux-mips.org; Wed, 20 Dec 2006 07:48:42 -0800
Message-ID: <7992312.post@talk.nabble.com>
Date:	Wed, 20 Dec 2006 07:48:42 -0800 (PST)
From:	Daniel Laird <danieljlaird@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: 2.6.19 timer API changes
In-Reply-To: <20061221.004017.21363332.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: danieljlaird@hotmail.com
References: <7925588.post@talk.nabble.com> <7943218.post@talk.nabble.com> <20061219.233410.25911550.anemo@mba.ocn.ne.jp> <20061220.000113.59033093.anemo@mba.ocn.ne.jp> <7949125.post@talk.nabble.com> <20061220.021508.97296486.anemo@mba.ocn.ne.jp> <458948C5.4050909@ru.mvista.com> <20061221.004017.21363332.anemo@mba.ocn.ne.jp>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips




Atsushi Nemoto wrote:
> 
> On Wed, 20 Dec 2006 17:29:25 +0300, Sergei Shtylyov
> <sshtylyov@ru.mvista.com> wrote:
>> > How about this?  You should still fix pnx8550_hpt_read() anyway, but I
>> > suppose gettimeofday() on PNX8550 was broken long time.
>> 
>>     And nobody noticed. :-)
> 
> I changed my mind a bit.  The pre-clocksource gettimeofday() might
> work well on PNX8550.  There was timerlo variable which hold COUNT
> value on last timer interrupt and fixed_gettimeoffset() subtracted
> timerlo from COUNT value at the time.
> 
> On Wed, 20 Dec 2006 17:29:25 +0300, Sergei Shtylyov
> <sshtylyov@ru.mvista.com> wrote:
> 
>> > +static cycle_t pnx8550_hpt_read(void)
>> > +{
>> > +	/* FIXME: we should use timer2 or timer3 as freerun counter */
>> > +	return read_c0_count();
>>  > +}
>> 
>>     I'd suggest read_c0_count2() here, possibly adding an interrupt
>> handler for it since it will interrupt upon hitting compare2
>> reg. value (but we could probably just mask the IRQ off), and
>> enabling the timer 2, of course (the current code disables it)...
> 
> It would be right direction.  And we should set set count2 frequency
> to mips_hpt_frequency.  But I cannot test it by myself so I'd like to
> leave it for others.  Good exercise ;)
> 
> ---
> Atsushi Nemoto
> 
> 
> 
It seems likely that this did work in previous releases, however it will
obviously need to work on this release and so once I have solved the startup
issues by using your second proposed patch I will do some testing to see if
I can get this to work (if it is indeed broken)
Cheers
Dan
-- 
View this message in context: http://www.nabble.com/2.6.19-timer-API-changes-tf2838715.html#a7992312
Sent from the linux-mips main mailing list archive at Nabble.com.
