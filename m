Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2009 20:00:52 +0100 (CET)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:19394 "EHLO
        sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492344AbZK3TAr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2009 20:00:47 +0100
Authentication-Results: sj-iport-4.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAP+kE0urRN+K/2dsb2JhbADCQpcEhDEEgXKBLg
X-IronPort-AV: E=Sophos;i="4.47,315,1257120000"; 
   d="scan'208";a="55468055"
Received: from sj-core-4.cisco.com ([171.68.223.138])
  by sj-iport-4.cisco.com with ESMTP; 30 Nov 2009 19:00:36 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
        by sj-core-4.cisco.com (8.13.8/8.14.3) with ESMTP id nAUJ0ajf002963;
        Mon, 30 Nov 2009 19:00:36 GMT
Date:   Mon, 30 Nov 2009 14:00:36 -0500
From:   David VomLehn <dvomlehn@cisco.com>
To:     Adam Nielsen <a.nielsen@shikadi.net>
Cc:     linux-mips@linux-mips.org
Subject: Re: Setting the physical RAM map
Message-ID: <20091130190036.GA24581@dvomlehn-lnx2.corp.sa.net>
References: <4B1135FF.9050908@shikadi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B1135FF.9050908@shikadi.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Sun, Nov 29, 2009 at 12:38:55AM +1000, Adam Nielsen wrote:
> Hi all,
>
> I'm attempting to port the Linux kernel to an NCD HMX, an R4600-based X-Terminal.
...
> It gets as far as printing the physical RAM map and then crashes, but I'm 
> not sure why:
>
>   Determined physical RAM map:
>    memory: 00800000 @ 40250000 (usable)
>    memory: 00040000 @ 9fc00000 (ROM data)
>   Wasting 8407552 bytes for tracking 262736 unused pages

These are kernel messages, so you are getting into the kernel, but this
looks odd to me.  The MIPS processor needs memory mapped in the first
512 MiB to execute. This first 512 MiB will be mapped as cached memory
at virtual address 0x80000000 (known as kseg0) and as uncached memory at
virtual address 0x0a0000000 (known as kseg1). Perhaps you system is like
mine, where I have memory above 512 MiB aliased into the first 512 MiB
of physical space.

The second odd thing is the ROM data physical address. This is a good virtual
address but as a physical address it is not accessible by the MIPS processor
without mapping to with a TLB entry.

>   TLB refill exception PC = 40024094 address = 7FFFF000

This is not too surprising since the kernel is executing at an address
must have a TLB entry to be accessible.

> The last message is from the boot monitor (the kernel is loaded at 
> address 0x40020000.)  I'm just guessing with the memory map, but I've 
> tried lots of different values with the same result, and I'm fairly sure 
> there is RAM mapped to the address I have used above (it's after the end 
> of the kernel.)  At any rate the error message is from a completely 
> different address, and it still happens if I flag that area as reserved 
> memory in the RAM map.
>
> Some of the MIPS devices don't seem to have code to create a memory map, 
> so I'm wondering whether this is necessary or if there's a generic MIPS 
> way to retrieve the current mapping.

Some MIPS processors do not have an MMU, though you'd need to consult
the documentation to determine this. In your case, you're getting a
TLB refill exception, so you do have an MMU.

> Also, if anyone has any ideas what the kernel is trying to do accessing 
> that invalid address I could use some hints!

My guess, and since I don't have a lot of information this is a pretty
wild guess, is that you are actually running your kernel at 0x40020000,
and that the reason you can do this is that the bootloader has left the
TLBs in such a state that the first few pages are mapped. Then, when it
leaves the mapped area, it dies with the TLB refill exception.

Another possibility is that you actually start off at reasonable 0x8xxxxxxx
address, but then use a pointer that takes you off to 0x40024094.

One suggestion is to look at the code at 0x40024094 to see what it's doing.
Then, use a JTAG debugger or add printk() statements to see exactly what's
happening.

-- 
David VL
