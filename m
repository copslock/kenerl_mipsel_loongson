Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BGvRRw008831
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 09:57:27 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BGvR1p008830
	for linux-mips-outgoing; Thu, 11 Jul 2002 09:57:27 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BGvGRw008790;
	Thu, 11 Jul 2002 09:57:17 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA11090;
	Thu, 11 Jul 2002 10:01:25 -0700
Message-ID: <3D2DB826.6000208@mvista.com>
Date: Thu, 11 Jul 2002 09:53:58 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jon Burgess <Jon_Burgess@eur.3com.com>
CC: Carsten Langgaard <carstenl@mips.com>,
   "Gleb O. Raiko" <raiko@niisi.msk.ru>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
References: <80256BF3.00435388.00@notesmta.eur.3com.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jon Burgess wrote:

> 
>>>I don't wonder if other IDT CPUs also require this, including those that
>>>conform MIPS32.
>>>Basically, requirement of uncached run makes hadrware logic much simpler
>>>and allows  to save silicon a bit.
>>>
>>That could be true, but then again I suggest making specific cache routines for
>>
> those
> 
>>CPUs.
>>It would be a real performance hit for the rest of us, if we have to operate
>>
> from
> 
>>uncached space.
>>
> 
> I pulled together the relevant code to generate a module to test this problem
> and it looks like the CPU always misses 1 instruction following the end of the
> cache loop. If I add some nop's to change the alignment of the code it doesn't
> seem to make any difference. The same thing seems to happen even if I change the
> cache flush to a 'Hit_invalidate' of some completely different memory region.
> One thing I thought might happen is the CPU ending the loop early as soon as it
> invalidates the cacheline containing the current instructions, but this doesn't
> seem to be the case, the 'end' address is always correct. Perhaps this really is
> a hardware problem.
> 
> The test module below does a blast_icache then a few well known instructions and
> signifies if anything has been missed. I typically get the following on our
> board.
>      Cacheop skipped 1 instructions, end = 0x80004000



Here is the test results from Malta 4kc

Cacheop skipped 0 instructions, end = 0x80004000

root@10.0.18.6:~# cat /proc/cpuinfo
processor               : 0
cpu model               : MIPS 4Kc V0.1
BogoMIPS                : 79.66
wait instruction        : no
microsecond timers      : yes
extra interrupt vector  : yes
hardware watchpoint     : yes
VCED exceptions         : not available
VCEI exceptions         : not available


Jun
