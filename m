Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIH29H22717
	for linux-mips-outgoing; Tue, 18 Dec 2001 09:02:09 -0800
Received: from sw.chaintech.com.tw (c249.h203149140.is.net.tw [203.149.140.249])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBIH20o22712;
	Tue, 18 Dec 2001 09:02:00 -0800
Received: from sw.chaintech.com.tw (root@localhost)
	by sw.chaintech.com.tw with ESMTP id fBIFxRK15050;
	Tue, 18 Dec 2001 23:59:27 +0800 (CST)
Received: from yahoo.com ([192.168.2.173])
	by sw.chaintech.com.tw with ESMTP id fBIFxPH15046;
	Tue, 18 Dec 2001 23:59:26 +0800 (CST)
Message-ID: <3C1EC004.20907@yahoo.com>
Date: Tue, 18 Dec 2001 12:03:16 +0800
From: hanishkvc <hanishkvc@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: jim@jtan.com
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
References: <20011217151515.A9188@neurosis.mit.edu> <20011217193432.A7115@dea.linux-mips.net> <20011218020344.A10509@neurosis.mit.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Jim,

If a device or a bus/Interface controller has some memory, then its up 
to the corresponding driver to make it available to the system. So yes 
If I am not wrong you should use ioremap to make this memory visible 
somewhere in the kernel address space. Inturn doing read/write on it 
should succeed.

I don't get the reason has to why u want to use isa_slot_offset. As you 
know the physical address range for ur interface/bus(and devices) you 
use that value in ioremap. This would give u a new virtual address which 
inturn you should/would use in your read/write calls.

However has I haven't worked on PCMCIA logic of linux, I may be wrong, 
if they have some of their own conventions interms has to where they map 
the memory and or what standard function/macro names they use.

Keep :-)
HanishKVC

Jim Paris wrote:

>My system (Vadem Clio 1000, vr4111) has a VG-469 (i82365) PCMCIA
>controller with IO port space at 0x14000000, and IO memory space
>at 0x10000000.
>
>3) it can use check/request/release_mem_region on I/O memory
> - this fails, because the iomem resource map contains the kernel:
>   > -more /proc/iomem
>   00000000-00ffffff : System Ram
>     00002000-001bc6af : Kernel code
>     001cf300-00299fff : Kernel data
> (this seems very wrong to me, since the kernel is most definately
>  not in the I/O memory space; real memory, of course, but I/O memory??)
>4) it can use ioremap, and then read[bwl] and write[bwl] with the result
> - this fails with the current ioremap; neither ioremap nor read/write[bwl]
>   take isa_slot_offset into account
>
>Am I misunderstanding how this stuff is supposed to work?  Is the
>i82365 driver doing anything wrong?
>
>(The i82365 driver also makes the incorrect assumption that PCMCIA IRQs
>directly correspond to system IRQs, but this is definately a problem
>with the driver and I've fixed that.)
>
>-jim
>
