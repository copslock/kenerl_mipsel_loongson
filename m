Received:  by oss.sgi.com id <S305170AbQATA4O>;
	Wed, 19 Jan 2000 16:56:14 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:7442 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305167AbQATAz4>;
	Wed, 19 Jan 2000 16:55:56 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA05724; Wed, 19 Jan 2000 16:57:27 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA78871
	for linux-list;
	Wed, 19 Jan 2000 16:49:08 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA00232
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 19 Jan 2000 16:48:57 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA00242
	for <linux@cthulhu.engr.sgi.com>; Wed, 19 Jan 2000 16:48:56 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id QAA11304;
	Wed, 19 Jan 2000 16:48:54 -0800 (PST)
Received: from thinkpad (par-c45-001-vty172.as.wcom.net [195.232.65.172])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id QAA28049;
	Wed, 19 Jan 2000 16:48:37 -0800 (PST)
Message-ID: <001601bf62e0$4f253ca0$ac41e8c3@thinkpad>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Jeff Harrell" <jharrell@ti.com>,
        "sgi-mips" <linux@cthulhu.engr.sgi.com>
Cc:     "Ralf Baechle" <ralf@oss.sgi.com>, "bbrown" <bbrown@ti.com>,
        "vwells" <vwells@ti.com>, "kmcdonald" <kmcdonald@ti.com>,
        "mhassler" <mhassler@ti.com>
Subject: Re: Question concerning cache coherency
Date:   Thu, 20 Jan 2000 01:49:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>I have an interesting issue that I would like to run past the MIPS/Linux
>newsgroup.  I am
>currently porting the MIPS/Linux code to a development board that has a
>IDT64475 MIPS
>core (64-bit R4xxx core).  I notice that this part does not have any
>method of maintaining
>cache coherency (i.e., no hardware support for cache coherency).  It is
>highly likely that we
>will be plugging in a network card on a PCI bus that would be DMA'ing to
>a shared memory
>space in SDRAM.  I assume that the problem of cache coherency is fixed
>by mapping the shared
>memory as uncached.  I have not dug into the network drivers (or the
>kernel) enough to know whether
>this is how the problem is addressed on typical MIPS architectures.  I
>guess I have two questions
>related to this issue;  Do devices that DMA, typically access uncached
>memory  and if so, is a second buffer
>required to copy from kernel to user space?  The second question is
>concerning the performance hit in
>running out of uncached memory,  Have people seen significant
>performance degradation when
>using uncached memory.  Any insight that anybody can provide would be
>greatly appreciated.


While some MIPS CPUs have mechanisms for hardware
cache coherence, many of them do not, and even systems
with coherent-I/O-capable CPUs often do not implement
the necessary protocol.

There are two basic options for dealing with caches
and DMA I/O:   flush the caches, or operate on
non-cached memory.  Sometimes one does both.  
A random  buffer being handed to a driver must be 
assumed  to have some portion of its contents cached, 
and  must be explicity flushed to memory (via 
hit_writeback_invalidate Cache instructions, or
dma_cache_wback_invalidate() calls in Linux) 
before being  presented to a DMA device.  

There's  a bit more discretion for data structures that 
are private to the driver/device.  If a data structure 
is going to be manipulated a great deal by the CPU 
before being DMAed, it will be worthwhile to treat it 
as cached and flush it out to memory when it is 
released to the I/O device.   If a data structure is
constantly shared between CPU and I/O, it is may be 
better to treat it as uncached rather than constantly
invoke the cache flush procedure.  There's a lot of
grey area in between where the optimal choice is
implementation and application dependent.

In an ethernet driver for a chip like a Lance or a Tulip ,
for example, which autonomously processes lists of 
buffers, the shared buffer descriptor lists might be treated 
as uncached  by the CPU, but transmit buffers coming 
in from further up the protocol stack and empty receive
buffers allocated from the general memory pool might 
be explicity flushed before being turned over to the I/O 
device.

Simple OS's like Linux (at least through 2.2.x) map the
kernel code and data through the kseg0/kseg1 mappings 
to physical memory, which makes it really simple to create 
an uncached data structure.  Including asm/io.h provides
a KSEG1ADDR() macro which just does an AND and an 
OR to generate an uncached alias.  This only works
for systems with 512M or less of memory, BTW.

Great care must be taken with uncached aliases, since
the behaviour of MIPS CPUs is not well defined if uncached
and cached accesses to the same location (or cache line)
are mixed.  I recommend allocating twice the maximum
cache line size (less 1 byte if you like) of kernel memory
in addition to the size of any data structure, and forcing
the alignment of the structure to the first cache line
boundary within the allocated block.  This should ensure
that no cached allocation of memory (or cached malloc
control structure) overlaps with the data structure, and
that it is thus safe to transform the pointer to the new
data structure to the kseg1 uncached form.  Of course,
if the structure is ever to be deallocated, the original
allocation address must be recoverable somehow.

            Regards,

            Kevin K.
.    
