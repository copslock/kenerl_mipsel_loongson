Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Feb 2015 21:01:00 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27006722AbbBUUA5UHMP1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Feb 2015 21:00:57 +0100
Date:   Sat, 21 Feb 2015 20:00:57 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Matt Turner <mattst88@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: what is the purpose of the following LE->BE patch to
 arch/mips/include/asm/io.h?
In-Reply-To: <alpine.LFD.2.11.1502210325450.8996@localhost>
Message-ID: <alpine.LFD.2.11.1502211904180.1995@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1502200445290.26212@localhost> <CAEdQ38HVxBug9ukgE1oXLo_e+8FDB_yuY0vn1d84puoThhdYCA@mail.gmail.com> <CAEdQ38F5jWX8Ujs4Jj6scxPAqtZw55gn4exL_rj9HCmf5YJgCA@mail.gmail.com> <alpine.LFD.2.11.1502210258580.5732@localhost>
 <CAOLZvyFKc4fu6F5qOuzaAJg9wvkKhYrFcV35Vn1Hzo_sYVYfvQ@mail.gmail.com> <alpine.LFD.2.11.1502210325450.8996@localhost>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sat, 21 Feb 2015, Robert P. J. Day wrote:

> > >   has anyone else ever needed to do this? or is this some weird,
> > > one-off hack that perhaps applies *only* to some bizarre feature of
> > > this board?
> >
> > My guess is that the peripherals attached to the internal bus
> > only undestand little endian, and the bus doesn't do byte swaps when
> > the core isn't configured for LE. I.e. the BE feature is only
> > implemented in the mips core and the rest was designed for LE only.
> 
>   ok, that makes sense ... so it's very likely a "issue with *this*
> particular board and setup" kind of thing. thanks.

 It looks to me like either a platform setup or a driver bug, as for this 
very purpose we have two sets of these access macros, one that preserves 
the bit ordering (IOW the value accessed) and another that preserves the 
byte ordering (but the value accessed may come out byte-swapped).  The 
former will usually be used for accessing MMIO registers of peripherals 
and the latter for byte streams exchanged between a peripheral and host 
memory via DMA.  This is so that generic code (e.g. a PCI device driver 
that will run on any processor or system it is thrown at) does not have to 
be concerned about the actual host bus endianness.

 The names of these macros reflect their usual purpose, and there's a 
pass-through set of macros too that never byte-swaps, so you'll use:

* `readl'/`writel'/etc. -- to access MMIO, preserving the bit ordering,

* `__mem_readl'/`__mem_writel'/etc. -- to access DMA memory, preserving 
  the byte ordering,

* `__raw_readl'/`__raw_writel'/etc. -- to access data as it shows on the 
  bus it comes from or goes to.

Please note that there is only ever any difference between these accessors 
if a platform has a bus whose endianness is fixed regardless of the host 
endianness.

 For example PCI is fixed at the little endianness and therefore all these 
macros pass data through unchanged on a little-endian host.  When the host 
bus is big-endian then `readl'/`writel' will byte-swap data unless byte 
lane swapping already happens at the PCI host bridge.  In that case it is 
likely that `__mem_readl'/`__mem_writel' will have to swap data instead.  
And then you'll use `__raw_readl'/`__raw_writel' to access host MMIO 
registers that are never swapped, e.g. on-chip SOC registers, or host-side 
registers of the PCI host bridge.

 All this is arranged in a system-specific manner with the use of a set of 
`*ioswab?' macros, that a platform has to define in `mangle-port.h' unless 
it wants to use the defaults.  See the existing examples for a reference.  
There's a set of `__swizzle_addr_?' macros there too, for systems that 
need to adjust the address accessed to account for byte lane swapping done 
in hardware.

 Overall it all is system dependent, and there are systems in existence 
for example that have an alternative byte-lane swapping address space and 
therefore for accesses that need to be swapped they can take advantage of 
that feature and switch the address space rather than shuffling bytes, for 
a small performance advantage.  We don't use this feature at the moment 
though; it would be most beneficial for string I/O where a single address 
adjustment operation would do for the whole transfer whereas byte-swapping 
has to be done for every individual piece of data transferred.

 In any case it looks very likely to me that either a driver uses the 
wrong set of macros to access a resource or the platform has failed to 
define its `*ioswab*' macros correctly.

 Feel free to let me know if you find anything of this unclear or have any 
further questions.

  Maciej
