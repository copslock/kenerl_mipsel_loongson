Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Aug 2004 15:17:40 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:41225 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224912AbUHSORg>;
	Thu, 19 Aug 2004 15:17:36 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1BxnuJ-0001ra-00; Thu, 19 Aug 2004 15:28:47 +0100
Received: from arsenal.mips.com ([192.168.192.197])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Bxnj5-0007yB-00; Thu, 19 Aug 2004 15:17:11 +0100
Received: from dom by arsenal.mips.com with local (Exim 3.35 #1 (Debian))
	id 1Bxnj4-0001MT-00; Thu, 19 Aug 2004 15:17:10 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16676.46694.564448.344602@arsenal.mips.com>
Date: Thu, 19 Aug 2004 15:17:10 +0100
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: anybody tried NPTL?
In-Reply-To: <20040804152936.D6269@mvista.com>
References: <20040804152936.D6269@mvista.com>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.348, required 4, AWL,
	BAYES_00, J_BACKHAIR_46)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Jun Sun,

> I am looking into porting NPTL to MIPS.  Just curious if
> anybody has tried this before.
> 
> I notice there was a discussion about the ABI extension
> for TLS (thread local storage) support.  Before that support
> becomes a reality it seems one can still use NPTL with 
> the help of additional system calls.

Well, this is an area of substantial interest to MIPS Technologies.
We are working on our multi-threading extension to the MIPS
architecture, and one of our longer-term aims is to achieve really
good NPTL performance.

As you said, this motivates a revision of the ABI.  Any incompatible
change to the ABI is painful, since everything has to be recompiled;
so our reasoning at the moment is that we might as well be radical...

MIPS Technologies would write up the definition; make and circulate
changes to the compiler, binutils and debugger; and make and circulate
supporting changes to the kernel and glibc.  We're aware this is only
a part of the problem, so we do need to figure out what will attract
community approval.

A few years ago I was volubly arguing in favour of keeping o32 until
we could move to n32/n64.  But times change: SGI compatibility
no longer seems important, and Linux on 32-bit MIPS CPUs needs
long-term support.

In many ways it's easier to get away from the ingenious but
troublesome stack-structure-based calling convention.  The "stack
structure" trick was invented so that o32 could work without function
prototypes - but function prototypes are now required, and something
with fixed-size arguments is simpler.  Something like the old
Cygnus/WRS EABI proposal, in fact...

So we're proposing:

o The register name<->number mapping is that of n64.

o Calling convention: register-, not slot-based. Each argument is
  represented by a register value. Arguments 0-7 travel in registers
  a0-7 (or fa0-7 as required for floating point types). If there are
  more than eight arguments, further ones are formed as if put in a
  register and then saved on the stack into a 64-bit slot (more than 8
  arguments is rare enough that we can afford to standardise on the
  big slots).
  
o Use floating point registers for double and float arguments, and
  integer registers for all integer/pointer values which will
  fit. Larger or structured data items are implicitly passed by
  reference: to maintain pass-by-value semantics, the compiler uses a
  copy-on-write trick if software writes a by-reference argument (or
  takes its address).  I'm told gcc is happy enough to do that.

o The return value comes back in two registers, with the second
  return-register used only when the return value consists of two
  scalars (ie a complex or double-precision number). [Folklore insists
  this is essential for Fortran support of complex numbers, and I
  don't want to fight folklore].

  All other non-scalar return values are returned via a pointer
  specified by the caller as an implicit first argument.

o Reserved registers: all the traditional ones. But now:

  - gp will be the GOT pointer in Linux, and should be defined as
    saved (ie a function must preserve values in this registers, which
    means it will need to save-and-restore the register if it is
    written locally).
    
  - we'll define some other register as a per-thread data pointer.

Some details are still to be worked out.  But do you think this is on
the right lines?  And who would like to take an active part in
specifying or reviewing?

--
Dominic Sweetman
MIPS Technologies
