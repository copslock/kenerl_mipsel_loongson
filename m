Received:  by oss.sgi.com id <S42300AbQHBWnx>;
	Wed, 2 Aug 2000 15:43:53 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:24124 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42290AbQHBWn2>; Wed, 2 Aug 2000 15:43:28 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA09939
	for <linux-mips@oss.sgi.com>; Wed, 2 Aug 2000 15:48:51 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA83501
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 2 Aug 2000 15:42:40 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA06846
	for <linux@cthulhu.engr.sgi.com>; Wed, 2 Aug 2000 15:42:39 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id PAA05710;
	Wed, 2 Aug 2000 15:41:27 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id PAA06909;
	Wed, 2 Aug 2000 15:41:27 -0700 (PDT)
Message-ID: <027f01bffcd3$3279b800$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Jun Sun" <jsun@mvista.com>
Cc:     <linux@cthulhu.engr.sgi.com>, <linux-mips@fnet.fr>,
        <ralf@oss.sgi.com>
Subject: Re: PROPOSAL : multi-way cache support in Linux/MIPS
Date:   Thu, 3 Aug 2000 00:44:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.1
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>> It's possible to write code that is compatible with an R4000 but
>> not MIPS32, and vice versa, but they are 99% identical.
>
>Is that possible you can list the 1% difference here?  
>
>I have always been confused by MIPS32/MIPS64 vs R3000/R4000/etc.  (And
>on top of it, there is also MIPS I, II, III, IV, etc...).  I am sure I
>am not the only one.


MIPS I, II, III, IV, and V are ISAs, instruction-set architectures.
R3000, R4000, R5000, R6000, R7000, R8000 et. al.
are microprocessor designs that conform (more-or-less)
to one of those ISAs.   The ISAs were defined in such a
way as to be strict supersets of one another.  Any MIPS
processor can run MIPS I code.  Any MIPS IV processor
can run MIPS I, II, III, and IV code, etc.  To oversimplify
slightly:

MIPS I - basic 32-bit RISC ISA
MIPS II - add branch-likely and Test instructions
MIPS III - add 64-bit address and 64-bit data support
MIPS IV - add FP MAC, Prefetch
MIPS V - add "paired single" SIMD FP instructions

As defined by MIPS in the beginning, the ISA - i.e. MIPS I, 
MIPS II, etc. - described the machine as seen from the 
standpoint of a user-mode application program.  The 
CP0 instructions and registers weren't considered a part 
of it.  This gave chip designers a lot of freedom and OS
writers a lot of headaches.  The R8000, for example, was
the first MIPS IV CPU, and is 100% (well, maybe 99.99%)
compatible with the MIPS IV R10000 at the user binary level.
But while the R10000 has a CP0 organization that is
a straightforward extrapolation of the R4000 - they
wanted it to run NT, after all - the R8000 is just bizzare.

Another problem with the way things had been done
in the MIPS I/II/III days was that, due to the strict supersetting
rules, any new feature had to ride on the back of all the
other cool new features that came before it.  As a specific
example, PREFetch is a MIPS IV instruction. But MIPS IV 
implies MIPS III, and MIPS III implies a 64-bit CPU.  So a 
32-bit CPU supporting prefetch, which is a fairly obviously 
useful thing, does not fit neatly into the model.  So...

When MIPS Technologies spun back out of SGI, one of
the first things that was done was to set about defining
standard architectures for 32 and 64-bit CPUs that
solved these problems.  These new standard architectures
are "MIPS32" and "MIPS64".   These architectures include
both the ISA and the privileged resource architecture, or
PRA, so that CP0 is finally standardised - with some amount
of permitted subsetting and implementation-specific details
allowed, just the same.  The MIPS32 ISA includes features
from MIPS I, II, III, IV, and V, as well as some stuff like
integer MADD, MSUB, CLZ, and CLO that had never
made it into the standard user mode ISA.  But MIPS32
has no 64-bit operations.  MIPS64 is the full-blown 64-bit 
MIPS I-V+ ISA plus a PRA that is a strict superset of the 
MIPS32 PRA.

So, to get back to Linux, a MIPS32 part can *almost*
run the standard MIPS R4K kernel.  Almost.  What had
to be fixed was essentially:

    - ensuring that TLB initialization and invalidation never
       write identical (even though invalid) entries to the TLB.
       MIPS32 parts are allowed to complain about that, and
       some of them do.
    - ensuring that no 64-bit instructions are ever used.  This
       necessitated my rewriting the semaphore support code.
    - eliminating certain assumptions about the relationship
       between cache size, line size, and associativity.

Note that none of this stuff is incompatible with an R4xxx
or an R5xxx, its just a matter of being a little more generic.
And of course the flip side is that we don't use prefetch,
MADD, or CLZ in the kernel either, because the MIPS III-IV
parts can't handle them (well, OK, some of them can).

            Hope this helps,

            Keivn K.
