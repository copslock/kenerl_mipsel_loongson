Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2002 19:13:04 +0200 (CEST)
Received: from gateway-1237.mvista.com ([12.44.186.158]:16124 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S1122977AbSICRND>;
	Tue, 3 Sep 2002 19:13:03 +0200
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA08296;
	Tue, 3 Sep 2002 10:10:36 -0700
Message-ID: <3D74EA66.6020906@mvista.com>
Date: Tue, 03 Sep 2002 09:59:18 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Matthew Dharm <mdharm@momenco.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: time.c CP0_COMPARE (and SMP IPI rambling) 
References: <NEBBLJGMNKKEEMNLHGAIEEKHCIAA.mdharm@momenco.com> <20020829142133.A3905@bacchus.dhis.org> <3D6E5C58.405@mvista.com> <20020902183053.E15618@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Aug 29, 2002 at 10:39:36AM -0700, Jun Sun wrote:
> 
> 
>>Ralf Baechle wrote:
> 
> 
>>> c0_compare = c0_count + mips_counter_frequency / HZ.
>>>
>>>That's what the individual boards are currently doing themselves though that
>>>should be done in generic code.
>>>
>>
>>Good idea.
>>
>>The attached patch attempts to set the first interrupt. It should be benign 
>>even if a system is not using CPU counter as timer interrupt.
>>
>>I also updated the time.README, including a new section about implementation 
>>on a SMP machine.
> 
> 
> Applied though I think that this should also be done via start_secondary
> that is we'll need some per_cpu_time_init analog to per_cpu_trap_init.

Right now setting per-cpu timers is totally left to the board-dependent code. 
  Once we see more SMP boxes using this approach, I think it starts to be 
interesting to make some abstraction and support it in a systematic way, 
including support for using CPU counter as the per-cpu timer interrupt.

Using local_timer_emulation sounds like an attractive alternative to me, as we 
only need to set up one system-wide timer interrupt.  Conceptually it probably 
takes a little longer to run through timer_interrupt (due to IPI calls).  But 
if the hit on performance is very negligible, the simplicity might make it 
worthwile.

BTW, since I am here, I like to ramble on a little bit further.  Currently 
Linux supports two kinds of IPI (inter-processor interrupt) deliveries:

1) sender waiting for the interrupt handler to start
2) sender waiting for the interrupt handler to start and complete

I think we really should the third kind:

3) sender does not wait at all.  Just delivers the interrupt.

With this support, the emulated local timer approach would have no performance 
penalty at all.

Jun
