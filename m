Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2015 22:02:56 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27012657AbbBEVCxjc7Yp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Feb 2015 22:02:53 +0100
Date:   Thu, 5 Feb 2015 21:02:53 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
In-Reply-To: <54D399F5.5030402@gmail.com>
Message-ID: <alpine.LFD.2.11.1502051639110.22715@eddie.linux-mips.org>
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com> <54BF12B9.8000507@gentoo.org> <alpine.LFD.2.11.1501210347180.28301@eddie.linux-mips.org> <20150126131621.GB31322@linux-mips.org> <alpine.LFD.2.11.1501261358540.28301@eddie.linux-mips.org>
 <54C68429.4030701@gmail.com> <alpine.LFD.2.11.1501261904310.28301@eddie.linux-mips.org> <54C69FCE.80002@gmail.com> <alpine.LFD.2.11.1501262345320.28301@eddie.linux-mips.org> <54C7ED94.6070507@gmail.com> <alpine.LFD.2.11.1501272231190.28301@eddie.linux-mips.org>
 <54D399F5.5030402@gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45736
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

On Thu, 5 Feb 2015, David Daney wrote:

> >   Well, I do actually, I have a working machine driven by an R4000
> > processor.  It was the original implementation of the Status.RE feature
> > and therefore it can be used as the reference.  I don't feel tempted to
> > use my time to actually make any checks though.
> >
> >   What I did instead, I checked the R4000 manual  ...
> 
> You are still relying on your interpretation of the text, rather than actual
> behavior of the device.  It is not all surprising that your interpretation of
> the manual hasn't changed, but it doesn't persuade me.
> 
> I am sticking to my belief that OCTEON faithfully implements the specification
> with respect to the in-memory byte ordering of the various load and store
> instructions.  Switching the endianess of the processor results in byte arrays
> being scrambled such that the low-order 3 bits are XOR 7.  This implies that
> aligned 64-bit loads and stores (LD, SD, LLC, SCD) result in identical
> in-memory and in-register layout for either endianess.  This is quite handy
> when writing driver code for devices that have 64-bit registers.

 Fair enough, this helps interfacing fixed-endian peripherals such as a 
PCI bus.  Some MIPS-based SOCs map PCI/memory twice in the bus address 
space for the benefit of big-endian systems, once with a byte lane 
matching policy and again with a bit lane matching policy.  This results 
in a swapped memory view between the two mapping spaces as seen by PCI 
devices doing DMA.

 What you describe refers to the bit lane matching policy which has 
benefits for PIO and MMIO as values written to peripheral registers do not 
change with a host bus endianness change (as long as accesses are as you 
noted only made using a specific data width intended), in contrast to DMA 
where the byte lane matching policy makes more sense as it makes byte 
streams written to memory the same regardless of the host bus endianness.

 What does it have to do with the user mode though?  Device drivers do not 
usually run in the user mode and even if they do (such as X11 DDX), then 
what would be the benefit for them from running in the reverse-endian 
mode?  They'd have to cope with the rest of the environment being 
byte-swapped anyway.  Having say a MMIO resource mapped as a region 
configured in hardware for swapping with the bit lane matching policy 
would make more sense than having the whole user binary (here the X 
server) built for and run with the opposite endianness.

 The use of CP0.Status.RE is different and it has to be implemented such 
as to fulfil its purpose.  That for example may be running little-endian 
DEC Ultrix/MIPS user binaries under a foreign personality on a big-endian 
MIPS machine running SGI IRIX or Linux.  Of course with the demise of 
proprietary *nix systems for the MIPS processor such a feature seems 
little useful.

  Maciej
