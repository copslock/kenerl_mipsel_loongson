Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Sep 2004 10:18:11 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:64720 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8224845AbUIAJSG>;
	Wed, 1 Sep 2004 10:18:06 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i819I0S0019766;
	Wed, 1 Sep 2004 05:18:05 -0400
Received: from localhost (mail@vpn50-67.rdu.redhat.com [172.16.50.67])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i819Hr329256;
	Wed, 1 Sep 2004 05:17:55 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1C2RFQ-0001CU-00; Wed, 01 Sep 2004 10:17:44 +0100
To: Dominic Sweetman <dom@mips.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: anybody tried NPTL?
References: <20040804152936.D6269@mvista.com>
	<16676.46694.564448.344602@arsenal.mips.com>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Wed, 01 Sep 2004 10:17:44 +0100
In-Reply-To: <16676.46694.564448.344602@arsenal.mips.com> (Dominic
 Sweetman's message of "Thu, 19 Aug 2004 15:17:10 +0100")
Message-ID: <87zn4apcuf.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Dominic Sweetman <dom@mips.com> writes:
> In many ways it's easier to get away from the ingenious but
> troublesome stack-structure-based calling convention.  The "stack
> structure" trick was invented so that o32 could work without function
> prototypes - but function prototypes are now required, and something
> with fixed-size arguments is simpler.  Something like the old
> Cygnus/WRS EABI proposal, in fact...

Indeed, all of this:

> So we're proposing:
> [...]
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

...are pretty much what we already do for EABI.  There's some fuzziness
in what EABI considers to be "double and float arguments": things like
"struct { float f; }" are passed in the same way as scalar floats, for
example.  Complex integers are also returned by invisible reference
rather than in two GPRs.  But these are very much corner cases.

Rather than define new, slightly different, conventions, have you thought
about defining this new ABI as an extension of EABI?  I.e. taking EABI,
adding n32/n64-style PIC, and the all-important:

>   - we'll define some other register as a per-thread data pointer.

Richard
