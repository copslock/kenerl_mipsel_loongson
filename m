Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g68HOxRw027948
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Jul 2002 10:24:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g68HOxYA027947
	for linux-mips-outgoing; Mon, 8 Jul 2002 10:24:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g68HOnRw027926;
	Mon, 8 Jul 2002 10:24:49 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA12281;
	Mon, 8 Jul 2002 10:29:05 -0700
Message-ID: <3D29CA34.1050306@mvista.com>
Date: Mon, 08 Jul 2002 10:21:56 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: "Kevin D. Kissell" <kevink@mips.com>, "H. J. Lu" <hjl@lucon.org>,
   linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Always use ll/sc for mips
References: <20020702114045.A16197@lucon.org> <20020702220651.B9566@dea.linux-mips.net> <00d401c22337$7e731580$10eca8c0@grendel> <20020704155726.A28268@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=1.3 required=5.0 tests=PORN_12,PORN_3,PORN_10 version=2.20
X-Spam-Level: *
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Thu, Jul 04, 2002 at 10:47:41AM +0200, Kevin D. Kissell wrote:
> 
> 
>>The R5900 kernel for the Playstation 2 does not use system
>>calls.  It uses a memory-mapped pseudo-device hack that
>>the guys at Sony came up with, which is much faster.  We
>>at MIPS came up with an even faster hack which uses 
>>the destruction of a "k" register value, but which requires 
>>the branch-likely instruction and thus only workson 
>>MIPS II CPUs and above (R39xxx, R4xxx, R5xxx,
>>but not the classic R3K).  See my message
>>"Re: patches for test-and-set without ll/sc" of January 22.
>>
>>I consider it to be very important for MIPS/Linux
>>that the embedded/workstation kernel and libraries
>>merge with the Playstation 2 "consumer" Linux, and
>>I don't think that will happen if we try to push the
>>PS2 people to use something far less efficient than
>>what they already have. "Entia non sunt multiplicanda 
>>praeter necessitatem", as a wise old guy once said,
>>but could we not consider a MIPS/Linux universe
>>where R3000 binaries use system calls, non-LL/SC
>>MIPSII+ binaries use k-register destruction, real,
>>manly, MIPS binaries use LL/SC instructions, and
>>where the MIPS/Linux kernel (a) supports an appropriate
>>system call, (b) makes a contract with userland to 
>>destroy k-regs predictably, and (c) contains the
>>emulation logic for LL/SC?  That should give us
>>full cross-platform binary compatibility, with optimal
>>performance on each platform when an appropriately
>>configured set of libraries and tools is installed.
>>
> 
> No, Sony's ABI isn't MP proof and will break silently on MP systems.  As
> such I can't consider it anything else but a hack.  sysmips(MIPS_ATOMIC_SET,
> ...) and ll/sc however are MP proof.
> 


sysmips(MIPS_ATOMIC_SET, ...) as it is is not MP-safe.  Two processors can set 
the variable at the same time since no spinlock is used to protect the access.

This is also a problem when I was writing preemptiable kernel patch.

Jun
