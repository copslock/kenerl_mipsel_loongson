Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 22:38:50 +0100 (BST)
Received: from zrtps0kn.nortel.com ([47.140.192.55]:48869 "EHLO
	zrtps0kn.nortel.com") by ftp.linux-mips.org with ESMTP
	id S20043350AbYHEVio (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Aug 2008 22:38:44 +0100
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com [47.129.230.89])
	by zrtps0kn.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id m75LcVh08078;
	Tue, 5 Aug 2008 21:38:31 GMT
Received: from [47.130.64.132] ([47.130.64.132] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 Aug 2008 17:38:16 -0400
Message-ID: <4898C845.1060903@nortel.com>
Date:	Tue, 05 Aug 2008 15:38:13 -0600
From:	"Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Kaz Kylheku <KKylheku@zeugmasystems.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: looking for help interpreting softlockup/stack trace
References: <DDFD17CC94A9BD49A82147DDF7D545C5FC8DD5@exchange.ZeugmaSystems.local>
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C5FC8DD5@exchange.ZeugmaSystems.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Aug 2008 21:38:17.0104 (UTC) FILETIME=[92654900:01C8F743]
Return-Path: <CFRIESEN@nortel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cfriesen@nortel.com
Precedence: bulk
X-list: linux-mips

Kaz Kylheku wrote:
> Chris Friesem wrote:

>>In the trace below, is "epc" the program counter at the time of the
>>timer interrupt?  How does "ra" fit into this, given that the function
>>whose address it contains isn't seen in the stack trace until quite a
>>ways down?


> Mind you, these Linux MIPS stack traces are not completely
> trustworthy; the routine just walks the stack one word at a time
> and prints out anything that looks like the address of code.
> So the stack trace may include stale stack data from previous
> call chains that have already returned. It also might not
> include the full call chain, because the return address is not
> always stored on the stack. For instance, here it looks like
> RA is pointing into a kernel module. But you don't actually
> see this in the fake stack trace. Nowhere in the stack trace
> do you see _read_lock being called by c000000001b4ab9c.

Right...but it does look like it calls _read_unlock().

> I would proceed by inspecting this vnb module and its use of locks.

Yeah...I'll do that.

>>scheduler_tick() calls BUG: soft lockup detected on CPU#0!

One thing I've noticed, all the softlockups are on cpu0 even though 
other cpus are also complaining about scheduling delays.  Is there 
something special about cpu0?

>>Call Trace:
>>  [<ffffffff811a251c>] softlockup_tick+0x12c/0x158
>>  [<ffffffff811126dc>] timer_interrupt+0xd4/0x4c8
>>  [<ffffffff81112890>] timer_interrupt+0x288/0x4c8
>>  [<ffffffff81101d50>] octeon_main_timer_interrupt+0x78/0x90
>>  [<ffffffff811a2c24>] handle_IRQ_event+0x45c/0x1528
>>  [<ffffffff811a3dc4>] __do_IRQ+0xd4/0x230
>>  [<ffffffff8151e448>] _read_lock+0x0/0x20
> 
> 
> This read lock is almost certainly a red herring; it's
> stuff left over on the stack that hasn't been overwritten
> by new activation chains.

Wouldn't it be part of the do_IRQ call below?
>>  [<ffffffff8110c4a8>] do_IRQ+0x440/0x1520
> 
> 
> This is the timer interrupt going off, which ends up
> detecting the lockup. So the problem is above here.

I assume you mean "above" in terms of chronological order, since in 
terms of the call trace the problem would be below.

>>  [<ffffffff8139263c>] neigh_lookup+0xb4/0x128
> 
> 
> This may also be garbage. Basically, the stack
> trace is not that useful, except that it provides
> some additional circumstantial evidence implicating
> the vnb module.

It's unfortunate that the call trace isn't accurate.

Thanks for the help,

Chris
