Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4GHGTnC004291
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 16 May 2002 10:16:29 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4GHGTQv004290
	for linux-mips-outgoing; Thu, 16 May 2002 10:16:29 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4GHGMnC004287
	for <linux-mips@oss.sgi.com>; Thu, 16 May 2002 10:16:23 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA22517;
	Thu, 16 May 2002 10:15:08 -0700
Message-ID: <3CE3E8BA.8080002@mvista.com>
Date: Thu, 16 May 2002 10:13:30 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: Daniel Jacobowitz <dan@debian.org>, Matthew Dharm <mdharm@momenco.com>,
   Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
References: <NEBBLJGMNKKEEMNLHGAIOEPPCGAA.mdharm@momenco.com> <20020515214818.GA1991@nevyn.them.org> <3CE2DA46.3070402@mvista.com> <007a01c1fca9$86e14f70$10eca8c0@grendel>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Kevin D. Kissell wrote:

> Jun Sun wrote:
> 
>>Daniel Jacobowitz wrote:
>>
>>
>>>On Wed, May 15, 2002 at 02:34:47PM -0700, Matthew Dharm wrote:
>>>
>>>
>>>>So... I'm looking at porting Linux to a system with 1.5GiB of RAM.
>>>>That kinda blows the 32-bit MIPS port option right out of the water...
>>>>
>>>>
>>>Not unless you count bits differently than I do... 32-bit is 4 GiB.  Is
>>>there any reason MIPS has special problems in this area?
>>>
>>>
>>
>>MIPS has lower 2GB fixed for user space.  Then you have kseg0, .5GB for cached 
>>physical address 0-0.5GB, and kseg1, 0.5GB uncached mapping of the same area. 
>>  You can map another 1GB of RAM into kseg2/3, but you will then have no space 
>>left for IO.
>>
>>So you really can't do 1.5GB on 32 bit kernel.
>>
> 
> Is this to say that Linux cannot function unless all physical memory
> on the system is mapped at all times into kernel space? I would
> have thought that (a) all that really needs to be mapped is all
> memory used by the kernel itself, plus that of the currently active
> process (which is mapped in the 2GB kuseg), and that (b) one 
> could anyway manage kseg2 or 3 dynamically to provide a window 
> into a larger physical memory, and that this window could be
> used for any functions that need to do arbitrary phys-to-phys
> copies.
> 


You are right - my above statement is a grossly simplified way of saying "You 
can't really have 1.5GB system RAM accessible to kernel at the same time on a 
32bit MIPS kernel".

There is nothing preventing you from having more physical RAM and use 
dynamically by using HIGHMEM support.

BTW, I have been under the impression that demand for larger system RAM mainly 
comes from large router/switches to store routing table.  Does anybody know on 
such systems whether the routing code runs in kernel or user space and whether 
  it requires all the memory space accessible at the same time or can live 
with dynamically managed memory space?

Jun
