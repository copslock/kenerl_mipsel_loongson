Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Aug 2004 23:16:55 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:39153 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224990AbUHSWQt>;
	Thu, 19 Aug 2004 23:16:49 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i7JMGk7T008908;
	Thu, 19 Aug 2004 15:16:46 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i7JMGkH8008907;
	Thu, 19 Aug 2004 15:16:46 -0700
Date: Thu, 19 Aug 2004 15:16:46 -0700
From: Jun Sun <jsun@mvista.com>
To: Dominic Sweetman <dom@mips.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: anybody tried NPTL?
Message-ID: <20040819221646.GC8737@mvista.com>
References: <20040804152936.D6269@mvista.com> <16676.46694.564448.344602@arsenal.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16676.46694.564448.344602@arsenal.mips.com>
User-Agent: Mutt/1.4i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Aug 19, 2004 at 03:17:10PM +0100, Dominic Sweetman wrote:
> 
> Jun Sun,
> 
> > I am looking into porting NPTL to MIPS.  Just curious if
> > anybody has tried this before.
> > 
> > I notice there was a discussion about the ABI extension
> > for TLS (thread local storage) support.  Before that support
> > becomes a reality it seems one can still use NPTL with 
> > the help of additional system calls.
> 
> Well, this is an area of substantial interest to MIPS Technologies.
> We are working on our multi-threading extension to the MIPS
> architecture, and one of our longer-term aims is to achieve really
> good NPTL performance.
> 
> As you said, this motivates a revision of the ABI.  Any incompatible
> change to the ABI is painful, since everything has to be recompiled;
> so our reasoning at the moment is that we might as well be radical...
> 
> MIPS Technologies would write up the definition; make and circulate
> changes to the compiler, binutils and debugger; and make and circulate
> supporting changes to the kernel and glibc.  We're aware this is only
> a part of the problem, so we do need to figure out what will attract
> community approval.
> 
> A few years ago I was volubly arguing in favour of keeping o32 until
> we could move to n32/n64.  But times change: SGI compatibility
> no longer seems important, and Linux on 32-bit MIPS CPUs needs
> long-term support.
> 
> In many ways it's easier to get away from the ingenious but
> troublesome stack-structure-based calling convention.  The "stack
> structure" trick was invented so that o32 could work without function
> prototypes - but function prototypes are now required, and something
> with fixed-size arguments is simpler.  Something like the old
> Cygnus/WRS EABI proposal, in fact...
> 
> So we're proposing:
> 
> o The register name<->number mapping is that of n64.
> 
> o Calling convention: register-, not slot-based. Each argument is
>   represented by a register value. Arguments 0-7 travel in registers
>   a0-7 (or fa0-7 as required for floating point types). If there are
>   more than eight arguments, further ones are formed as if put in a
>   register and then saved on the stack into a 64-bit slot (more than 8
>   arguments is rare enough that we can afford to standardise on the
>   big slots).
>   
> o Use floating point registers for double and float arguments, and
>   integer registers for all integer/pointer values which will
>   fit. Larger or structured data items are implicitly passed by
>   reference: to maintain pass-by-value semantics, the compiler uses a
>   copy-on-write trick if software writes a by-reference argument (or
>   takes its address).  I'm told gcc is happy enough to do that.
> 
> o The return value comes back in two registers, with the second
>   return-register used only when the return value consists of two
>   scalars (ie a complex or double-precision number). [Folklore insists
>   this is essential for Fortran support of complex numbers, and I
>   don't want to fight folklore].
> 
>   All other non-scalar return values are returned via a pointer
>   specified by the caller as an implicit first argument.
> 
> o Reserved registers: all the traditional ones. But now:
> 
>   - gp will be the GOT pointer in Linux, and should be defined as
>     saved (ie a function must preserve values in this registers, which
>     means it will need to save-and-restore the register if it is
>     written locally).
>     
>   - we'll define some other register as a per-thread data pointer.
> 
> Some details are still to be worked out.  But do you think this is on
> the right lines?  And who would like to take an active part in
> specifying or reviewing?
>

I am not against any of those.  However, from NPTL implementation
point of view I really just care about the per-thread register.
What is the motivation of other changes?  Taking this chance to make
things all right in one shot?

Jun
