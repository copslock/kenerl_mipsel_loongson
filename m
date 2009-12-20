Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Dec 2009 10:07:49 +0100 (CET)
Received: from vitalin.sorra.shikadi.net ([64.71.152.201]:4526 "EHLO
        vitalin.sorra.shikadi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492132AbZLTJHp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Dec 2009 10:07:45 +0100
Received: from berkeloid.vlook.shikadi.net ([172.16.255.5])
        by vitalin.sorra.shikadi.net with esmtp (Exim 4.62)
        (envelope-from <a.nielsen@shikadi.net>)
        id 1NMHlL-0008Sd-UO; Sun, 20 Dec 2009 19:07:40 +1000
Received: from korath.teln.shikadi.net ([192.168.0.14])
        by berkeloid.teln.shikadi.net with esmtp (Exim 4.68)
        (envelope-from <a.nielsen@shikadi.net>)
        id 1NMHlL-0005mM-4m; Sun, 20 Dec 2009 19:07:39 +1000
Message-ID: <4B2DE95B.20305@shikadi.net>
Date:   Sun, 20 Dec 2009 19:07:39 +1000
From:   Adam Nielsen <a.nielsen@shikadi.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-GB; rv:1.8.1.23) Gecko/20091130 Thunderbird/2.0.0.23 Mnenhy/0.7.5.0
MIME-Version: 1.0
To:     David VomLehn <dvomlehn@cisco.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Setting the physical RAM map
References: <4B1135FF.9050908@shikadi.net> <20091130190036.GA24581@dvomlehn-lnx2.corp.sa.net>
In-Reply-To: <20091130190036.GA24581@dvomlehn-lnx2.corp.sa.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <a.nielsen@shikadi.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.nielsen@shikadi.net
Precedence: bulk
X-list: linux-mips

Hi all,

I've done some more debugging and tracked down the problem a little further. 
I've also fixed up (I think) the memory mappings, from looking at the setup 
code from some of the other MIPS machines:

Determined physical RAM map:
  memory: 01800000 @ 00000000 (usable)
  memory: 00040000 @ 1fc00000 (ROM data)

>>    TLB refill exception PC = 40024094 address = 7FFFF000
>
> This is not too surprising since the kernel is executing at an address
> must have a TLB entry to be accessible.

The boot loader refuses to execute the ELF image unless the load address is 
set to 0x40020000 ("Load address out of range"), so it appears the kernel is 
being executed at this address.  The problem seems to be that there is nothing 
mapped at 0x7FFFF000.

I've tracked the code that accesses this memory address to the 
init_bootmem_core() function in mm/bootmem.c line ~109:

   memset(bdata->node_bootmem_map, 0xff, mapsize);

This is being executed as:

   memset(0x7ffff000, 0xff, 768);

Which is where the problem is coming from.  Working backwards, I have narrowed 
it down to arch/mips/kernel/setup.c line ~293.  This is a loop which does some 
calculations with memory (not sure exactly what) but the "mapstart" variable 
is initialised to ~0UL, and it never gets updated before being passed through 
to eventually the memset() line above.

The problem seems to be inside the loop.  These lines:

   if (end <= reserved_end)
     continue;

Cause the loop to break out *before* setting mapstart, and since there is only 
one RAM element in the array the loop does not run again.  It seems that the 
end of the kernel (reserved_end) is so big (it'll be 0x40020000 + size of 
kernel) that it sits way after the end of the RAM mapping (0x01800000).

I'm not sure how to solve this issue, and I'm still a bit confused about MIPS 
memory mapping (does the TLB mean that 0x40020000 could be mapped anywhere in 
memory?  Will this break things when Linux starts reprogramming it?  Or does 
Linux leave the TLB alone?)  I've tried changing the memory from appearing at 
offset 0 to offset 0x40020000 but it didn't change anything (just a message 
about 8MB wasted on tracking unused pages.)

Any pointers would be greatly appreciated!

Many thanks,
Adam.
