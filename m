Received:  by oss.sgi.com id <S305177AbQAFPM4>;
	Thu, 6 Jan 2000 07:12:56 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:30591 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305175AbQAFPMf>;
	Thu, 6 Jan 2000 07:12:35 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA06591; Thu, 6 Jan 2000 07:13:20 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA92400
	for linux-list;
	Thu, 6 Jan 2000 06:27:32 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA12685
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 6 Jan 2000 06:27:21 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA04230
	for <linux@cthulhu.engr.sgi.com>; Thu, 6 Jan 2000 06:27:09 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-22.uni-koblenz.de (cacc-22.uni-koblenz.de [141.26.131.22])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id PAA08137;
	Thu, 6 Jan 2000 15:26:39 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407892AbQAFO0M>;
	Thu, 6 Jan 2000 15:26:12 +0100
Date:   Thu, 6 Jan 2000 15:26:12 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Florian Lohoff <flo@rfc822.org>, linux@cthulhu.engr.sgi.com
Subject: Re: Decstation 5000/150 2.3.21 Boot successs
Message-ID: <20000106152612.B16947@uni-koblenz.de>
References: <000601bf5826$273af500$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <000601bf5826$273af500$0ceca8c0@satanas.mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Jan 06, 2000 at 10:12:21AM +0100, Kevin D. Kissell wrote:

> The "setting flush to zero/Unimlemented exception"
> problem is almost certainly due to the fact that the
> DECstation binaries were compiled for R3000-based
> platforms with R3K-style FPUs which have 32 single-precision
> FP regs that can also be treated pairwise as 16
> double-precision registers.  I didn't know that the 5000 line
> had R4000 CPUs in them, but on the basis of your reported
> CPU revision number, that's what you've got.
> 
> The default SGI/MIPS Linux kernel startup sets the
> "FR" bit in the CP0.Status register, which enables
> R4000-style FPU registers, which is to say a full
> compliment of 32 double-precision registers.  This
> has the side-effect of making the kernel incompatible
> with the distributed mipsel binaries and the distributed
> DECstation root file system, since those binaries which
> do double-precision floating point load their initial values
> from memory as two singles.  That works on an R3000
> or an R4000-with-FR=0, but not on an R4000-with-FR=1.
> If FR=1, the data in the registers is garbage, the FP
> ops trap on unimplemented exceptions, which first
> retry the instruction with flush-to-zero mode in a
> desperate hope that that will solve the problem,
> then call the fragmentatary SW emulator in the
> kernel, which only handles a few cases, then
> skip the instruction, printing the console message
> that it "should" have sent a SIGFPE.   Hence the
> output.  And hence the bizzare behaviour of awk,
> ps, and a number of other basic programs that do
> minimal FP as the system comes up (procps?).
> 
> It took me a while to figure this out when I ran into
> it doing a little-endian port of Linux 2.2.12 to an R5260,
> as you might imagine.   Unless things have been drastically
> scrambled for 2.3.x,  the code controlling this is in
> arch/mips/kernel/head.S.   What we did at MIPS was
> to add a config option to determine which FPU model
> is desired.   The truly elegant thing would be to examine
> the a.out file and manage Status.FR dynamically, but
> a quick inspection turned up no clean mechanism in
> the Linux kernel for passing such architecture-dependent
> information from the generic a.out file parsing to the
> thread creation machinery, so that will be a later
> exercise.   Thoward the end of the kernel entry point
> (kernel_entry), our revised code looks a bit like this:

Linux _never_ changes the FR flag.  In fact it's living in the assumption
that once the firmware hands over the control to the kernel the FR flag
has been configured apropriately.  For a 32-bit kernel the binaries available
out there more or less conform to the MIPS ABI which uses the 16/32
register model, that is the kernel expects the FR flag to be cleared.

In firm assumption that due all the practical problems involved with
a non-standard execution model (i.e. 32-bit, o32-style ELF, 32/32
register model and 32-bit gprs) I decieded that in practice nobody will
use this and dumped all the support for it from later 2.3 kernels.  That
is the scheduler will no longer try to handle context switching for
the 32/32 fpr model correctly etc.

If that's desired, how about providing a syscall which allows to manipulate
this and possibly other bits?

Btw...  Thanks for posting.  You pointed my nose at the fact that this bug
actually exists for the 64-bit kernel - and there is actually a real world
bug because we can mix 32-bit and 64-bit binaries.

  Ralf
