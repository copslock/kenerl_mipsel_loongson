Received:  by oss.sgi.com id <S305170AbQASXeD>;
	Wed, 19 Jan 2000 15:34:03 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:28793 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305167AbQASXdj>; Wed, 19 Jan 2000 15:33:39 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA06139; Wed, 19 Jan 2000 15:37:59 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA68385
	for linux-list;
	Wed, 19 Jan 2000 15:26:24 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA52558
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 19 Jan 2000 15:26:22 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA05550
	for <linux@cthulhu.engr.sgi.com>; Wed, 19 Jan 2000 15:26:20 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-27.uni-koblenz.de (cacc-27.uni-koblenz.de [141.26.131.27])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id AAA19111;
	Thu, 20 Jan 2000 00:26:13 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQASXWU>;
	Thu, 20 Jan 2000 00:22:20 +0100
Date:   Thu, 20 Jan 2000 00:22:20 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jeff Harrell <jharrell@ti.com>
Cc:     sgi-mips <linux@cthulhu.engr.sgi.com>, bbrown <bbrown@ti.com>,
        vwells <vwells@ti.com>, kmcdonald <kmcdonald@ti.com>,
        mhassler <mhassler@ti.com>
Subject: Re: Question concerning cache coherency
Message-ID: <20000120002219.A22596@uni-koblenz.de>
References: <3885ED9B.C8969F26@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3885ED9B.C8969F26@ti.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Jan 19, 2000 at 10:00:11AM -0700, Jeff Harrell wrote:

> I have an interesting issue that I would like to run past the MIPS/Linux
> newsgroup.  I am currently porting the MIPS/Linux code to a development
> board that has a IDT64475 MIPS core (64-bit R4xxx core).  I notice that
> this part does not have any method of maintaining cache coherency (i.e.,
> no hardware support for cache coherency).  It is highly likely that we
> will be plugging in a network card on a PCI bus that would be DMA'ing to a
> shared memory space in SDRAM.  I assume that the problem of cache
> coherency is fixed by mapping the shared memory as uncached.  I have not
> dug into the network drivers (or the kernel) enough to know whether this
> is how the problem is addressed on typical MIPS architectures.  I guess I
> have two questions related to this issue; Do devices that DMA, typically
> access uncached memory and if so, is a second buffer required to copy from
> kernel to user space?  The second question is concerning the performance
> hit in running out of uncached memory, Have people seen significant
> performance degradation when using uncached memory.  Any insight that
> anybody can provide would be greatly appreciated.

The performance hit by using uncached memory is tremenduous.  Avoid it, if
you can.  Even if you cannot exploit the locality effects of caches you will
still gain from cached access because of prefetch / burst access and write
gathering.

The is one special case where you can not use caching, that is a cacheline
worth of data might concurrently be manipulated both by both processor and a
DMA device.  The typical example are processors with 32-byte cache lines
like the R4000 and a Ethernet chip like the Sonic which has ring entries of
only 16 byte size.  For such a configuration there is a case where

  1)  processor fetches cacheline
  2)                                   NIC write to that cacheline
  3)  processor writes cacheline back

-> the processor just corrupted the NIC written data.

The only way you can deal with that is by either stopping the NIC which you
don't want to or by using uncached access.

Take a look at the bottom of <asm/io.h> which defines three functions which
do the cache flushing for you.  On machines that are cache coherent by
hardware like SGI's Origins these functions will simply be no-ops.

  Ralf
