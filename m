Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Aug 2004 17:04:41 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:1882 "EHLO avtrex.com")
	by linux-mips.org with ESMTP id <S8224930AbUHSQEg>;
	Thu, 19 Aug 2004 17:04:36 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 19 Aug 2004 09:01:24 -0700
Message-ID: <4124CED5.1020608@avtrex.com>
Date: Thu, 19 Aug 2004 09:01:25 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominic Sweetman <dom@mips.com>
CC: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: anybody tried NPTL?
References: <20040804152936.D6269@mvista.com> <16676.46694.564448.344602@arsenal.mips.com>
In-Reply-To: <16676.46694.564448.344602@arsenal.mips.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Aug 2004 16:01:24.0698 (UTC) FILETIME=[C720A3A0:01C48605]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Dominic Sweetman wrote:
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
All of this sounds good to me.  However my current concerns are how to
make my code run on a mips32[r2] core with no floating point.  We are
using several different systems with variations of this cpu type.

So for me, making sure that a soft-float variant of the ABI is well
specified is also important.  I suppose it would be to treat
float/double values as appropriate encoding of 32/64 bit integer values.

David Daney.
