Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA11AhT26063
	for linux-mips-outgoing; Wed, 31 Oct 2001 17:10:43 -0800
Received: from dea.linux-mips.net (a1as05-p109.stg.tli.de [195.252.187.109])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA11Aa026057
	for <linux-mips@oss.sgi.com>; Wed, 31 Oct 2001 17:10:37 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fA116WH05633;
	Thu, 1 Nov 2001 02:06:32 +0100
Date: Thu, 1 Nov 2001 02:06:32 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Green <greeen@iii.org.tw>
Cc: LinuxEmbeddedMailList <linux-embedded@waste.org>,
   LinuxKernelMailList <linux-kernel@vger.kernel.org>,
   MipsMailList <linux-mips@fnet.fr>, linux-mips@oss.sgi.com
Subject: Re: Discontinuous memory!!
Message-ID: <20011101020632.A5076@dea.linux-mips.net>
References: <00c701c1612b$4c133620$4c0c5c8c@trd.iii.org.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00c701c1612b$4c133620$4c0c5c8c@trd.iii.org.tw>; from greeen@iii.org.tw on Tue, Oct 30, 2001 at 06:11:43PM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Oct 30, 2001 at 06:11:43PM +0800, Green wrote:

> I am porting Linux to R3912. 
> 
> There are two memory block on my target board. 
> 
> One is 16MB                  from 0x8000 0000 to 0x8100 0000.
> 
> The other one is 16MB   from 0x8200 0000 to 0x8300 0000.
> 
> But I found kernel just managed the first memory block.
> 
> How could I modify the kernel to support 32MB discontinuous memory?
> 
> Now I am trying to add entries to page table.
> It will halt at decompressing ramdisk.
> 
> Has anyone resolve this kind of problem before?

The kernel support this type of memory architecture if you enable
CONFIG_DISCONTIGMEM.  One machine which uses this feature is the Origin,
grep in arch/mips64 for CONFIG_DISCONTIGMEM.  There are also several
ARM system using it.

As support for CONFIG_DISCONTIGMEM is less than perfect you should check
if your system allows for reconfiguration of memory as a single physically
contiguous chunk.

Don't use add_memory_region() in this case; that code only works well
for small holes in memory address space.  Your holes are fairly large
so memory management would waste about 2mb if you would not use
CONFIG_DISCONTIGMEM.

  Ralf
