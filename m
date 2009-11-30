Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2009 23:35:40 +0100 (CET)
Received: from vitalin.sorra.shikadi.net ([64.71.152.201]:2447 "EHLO
        vitalin.sorra.shikadi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492963AbZK3Wfh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2009 23:35:37 +0100
Received: from berkeloid.vlook.shikadi.net ([172.16.255.5])
        by vitalin.sorra.shikadi.net with esmtp (Exim 4.62)
        (envelope-from <a.nielsen@shikadi.net>)
        id 1NFEq8-0006Xr-Tt; Tue, 01 Dec 2009 08:35:29 +1000
Received: from korath.teln.shikadi.net ([192.168.0.14])
        by berkeloid.teln.shikadi.net with esmtp (Exim 4.68)
        (envelope-from <a.nielsen@shikadi.net>)
        id 1NFEq8-0006py-3f; Tue, 01 Dec 2009 08:35:28 +1000
Message-ID: <4B1448B0.6020100@shikadi.net>
Date:   Tue, 01 Dec 2009 08:35:28 +1000
From:   Adam Nielsen <a.nielsen@shikadi.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-GB; rv:1.8.1.22) Gecko/20090809 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
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
X-archive-position: 25213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.nielsen@shikadi.net
Precedence: bulk
X-list: linux-mips

>>    Determined physical RAM map:
>>     memory: 00800000 @ 40250000 (usable)
>>     memory: 00040000 @ 9fc00000 (ROM data)
>>    Wasting 8407552 bytes for tracking 262736 unused pages
>
> These are kernel messages, so you are getting into the kernel, but this
> looks odd to me.  The MIPS processor needs memory mapped in the first
> 512 MiB to execute. This first 512 MiB will be mapped as cached memory
> at virtual address 0x80000000 (known as kseg0) and as uncached memory at
> virtual address 0x0a0000000 (known as kseg1). Perhaps you system is like
> mine, where I have memory above 512 MiB aliased into the first 512 MiB
> of physical space.
>
> The second odd thing is the ROM data physical address. This is a good virtual
> address but as a physical address it is not accessible by the MIPS processor
> without mapping to with a TLB entry.

Are these supposed to be physical addresses?  Maybe that's where I'm going 
wrong.  I only know the virtual addresses from some experimentation, but I've 
got no idea how to find out the physical addresses.

The system won't accept the kernel unless its virtual load address is 
0x40020000.  If I use the 'sm' (show memory) command in the boot loader it 
tells me there is 16MB of RAM starting at 0x20000000 and 8MB starting at 
0x21000000, so but if memory is supposed to start at 0x0 then those don't look 
like physical addresses either.

>>    TLB refill exception PC = 40024094 address = 7FFFF000
>
> This is not too surprising since the kernel is executing at an address
> must have a TLB entry to be accessible.

 From my other experiments here, 0x40024094 is fine, the problem is that the 
kernel is trying to access the unmapped address at 0x7FFFF000 and I'm not sure 
why.  It looks like an unusual address - is it trying to trigger an exception 
to test whether some exception handler has been installed correctly?

> My guess, and since I don't have a lot of information this is a pretty
> wild guess, is that you are actually running your kernel at 0x40020000,
> and that the reason you can do this is that the bootloader has left the
> TLBs in such a state that the first few pages are mapped. Then, when it
> leaves the mapped area, it dies with the TLB refill exception.
>
> Another possibility is that you actually start off at reasonable 0x8xxxxxxx
> address, but then use a pointer that takes you off to 0x40024094.

I'm pretty sure execution starts at 0x40020000.  With some testing code I have 
successfully written at 0x40040000 so it looks like that's where the boot 
loader has mapped a fair chunk of memory.  0x40024094 shouldn't be a problem, 
but 0x7FFFF000 probably would be.

> One suggestion is to look at the code at 0x40024094 to see what it's doing.
> Then, use a JTAG debugger or add printk() statements to see exactly what's
> happening.

I think that's probably the best bet.  Unfortunately figuring out where that 
address ends up in the C source is a little tricky for me, and I'm still a bit 
slow at reading MIPS assembly!

Thanks for your helpful reply.

Cheers,
Adam.
