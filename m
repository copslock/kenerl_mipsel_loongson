Received:  by oss.sgi.com id <S553767AbRBHK6m>;
	Thu, 8 Feb 2001 02:58:42 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:14493 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553761AbRBHK6e>;
	Thu, 8 Feb 2001 02:58:34 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA00667;
	Thu, 8 Feb 2001 11:54:57 +0100 (MET)
Date:   Thu, 8 Feb 2001 11:54:56 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     "Kevin D. Kissell" <kevink@mips.com>
cc:     Jun Sun <jsun@mvista.com>, Florian Lohoff <flo@rfc822.org>,
        linux-mips@oss.sgi.com, ralf@oss.sgi.com
Subject: Re: NON FPU cpus - way to go
In-Reply-To: <005101c09158$85941d40$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010208114254.29177D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 7 Feb 2001, Kevin D. Kissell wrote:

> Moving forward,  MIPS CPUs will have a specific FPU-present bit
> in one of the CP0 Config registers, as specified by MIPS32/MIPS64.

 Thanks for pointing this out -- this might prove useful.  Though the old
IDT detection method is not any more complicated and it's universal.  It
should work for MIPS32/MIPS64 anyway, right? 

> As other people have observed, having the FPU emulator in
> the kernel is necessary for full IEEE math even if one *has*
> an FPU.  When I bolted the Algorithmics emulator into the 2.2
> kernel at MIPS, I made it optional so that people could regress
> to Ralf's old not-fully-compliant mini-emulator if they were really
> desperate for memory and didn't need full IEEE.  Maybe I
> should have just nuked it and made the full emulator mandatory.

 How much of the emulator is really required for every system?  Can we
assume R[23]010 functionality if there is FP hw present?

> As far as the library-versus-kernel-emulation debate is
> concerned, yes, user-level emulation will always be faster.

 Why would be faster?  You need to handle SIGFPE, which needs a
user->kernel->user transition anyway.  I think a kernel emulation might be
marginally faster as we may skip signal interface handling (and such
details like an integer overflow/division by zero) and handle exceptions
directly. 

> However, you end up with a rather unpleasant configration
> management problem - every application and library
> distributed needs to be built both with and without FP.

 Nope -- you just require an emulator in glibc (or whatever libc you
decide to use).  No need to change application software -- FP opcodes will
just trap into libc.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
