Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Apr 2003 15:49:04 +0100 (BST)
Received: from p508B5403.dip.t-dialin.net ([IPv6:::ffff:80.139.84.3]:38630
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225192AbTDSOtC>; Sat, 19 Apr 2003 15:49:02 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3JEmsL16668;
	Sat, 19 Apr 2003 16:48:54 +0200
Date: Sat, 19 Apr 2003 16:48:54 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Erik J. Green" <erik@greendragon.org>
Cc: linux-mips@linux-mips.org
Subject: Re: TLB mapping questions
Message-ID: <20030419164854.A15699@linux-mips.org>
References: <1050730370.3ea0df8263a21@my.visi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1050730370.3ea0df8263a21@my.visi.com>; from erik@greendragon.org on Sat, Apr 19, 2003 at 05:32:50AM +0000
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 19, 2003 at 05:32:50AM +0000, Erik J. Green wrote:

> I *think* I understand how the TLB translates addresses for ckseg2 in mips64. 
> Can someone tell me if my understanding is correct?  
> 
> Given: Physical memory starts at 0x0000000020004000;
> 
> Therefore, an offset 0x2000 from the start of physical memory should be at 
> 
> 0x0000000020006000, or 0xa000000020006000 as a 64 bit xkphys address.
> 
> So if I construct a TLB entry such that cp0_entryhi is 0xffffffffc0002000, and
> cp0_entrylo0 has a PFN address of 0x0000000020006, giving it the correct ASID
> (0) and valid bitflags(VG), I should be able to access the physical memory
> offset above using the ckseg2 virtual address 0xffffffffc0002000?  

You also want to set the dirty flag or otherwise the page is not writable.

Which page size have you been using?

The physical address must be a multiple of the page size of the page and
the virtual address must be a multiple of the double of the page size of
entry - remember that each TLB entry maps a pair of adjacent pages!

The entrylo value is computed by shifting the physical address right by
6 bits then inserting the right flag bits into the low 6 bits.  In your
case you want to set the valid, dirty and global bits.  You also need to
set the 3 coherency bits.  We want cachable coherent, the same mode as
used in the 0xa8... portion of XKPHYS.  So we set them to 5.  So:

 c0_entrylo0 = (phyaddr >> 6) | cacheable_coherent | dirty | valid | global

 c0_entrylo0 = 0x800180 | 0x28 | 0x4 | 0x2 | 0x1

 c0_entrylo0 = 0x8001af

An extra word about the global bit - there exists only one global bit in
the TLB entry though both c0_entrylo0 and c0_entrylo1 have a global bit.
The way this works is that the global bit of the TLB entry is written
as tlb[entry].g = (c0_entrylo0.g & c0_entrylo1.g) when writing an entry
and when read is copied into both entrylo global bits.  In other words
writing a TLB entry with only one of the G bits in the entrylo register
pair set will result in a TLB entry with the G bit cleared.

For your example this means:

  c0_entryhi   = 0xc0000000:00002000
  c0_entrylo0  = 0x00000000:008001af
  c0_entrylo1  = 0x00000000:00000001
  c0_pagemask  = 0x00000000				# 4kB pages
  c0_framemask = 0x00000000
  c0_index     = 0x00000000
  c0_wired     = 0x00000001
  tlbwi

would generated the mapping and make sure the entry won't be overwritten
by random TLB writes.

> Of course, the reason I discuss all this is that the above doesn't work. =)  

Every Linux port has started in a state as advanced as where you are so
keep up :-)

  Ralf
