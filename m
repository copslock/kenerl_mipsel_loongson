Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 19:49:14 +0000 (GMT)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:51603 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225196AbTA1TtN>;
	Tue, 28 Jan 2003 19:49:13 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h0SJmt67013084;
	Tue, 28 Jan 2003 11:48:55 -0800 (PST)
Received: from uhler-linux.mips.com (uhler-linux [192.168.11.222])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id LAA25336;
	Tue, 28 Jan 2003 11:48:55 -0800 (PST)
Received: from uhler-linux.mips.com (uhler@localhost)
	by uhler-linux.mips.com (8.11.2/8.9.3) with ESMTP id h0SJmug29073;
	Tue, 28 Jan 2003 11:48:56 -0800
Message-Id: <200301281948.h0SJmug29073@uhler-linux.mips.com>
X-Authentication-Warning: uhler-linux.mips.com: uhler owned process doing -bs
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Jun Sun <jsun@mvista.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
cc: uhler@mips.com
Reply-To: uhler@mips.com
Subject: Re: unaligned load in branch delay slot 
In-reply-to: Your message of "Tue, 28 Jan 2003 09:53:47 PST."
             <20030128095347.W11633@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 Jan 2003 11:48:56 -0800
From: "Mike Uhler" <uhler@mips.com>
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips


> 
> Geert,
> 
> I had exactly the same problem with Vr4120A chip!
> 
> I have narrowed it down to be a hardware bug.  Basically under
> certain conditions, BD flag won't get set.
> 
> You can verify that by inserting various number of "nop" just
> before the faulting places and observe certain address alignment
> would show/hide this bug.
> 
> Further more I wrote a standalone kernel code and could not
> reproduce it, which means it requires more conditions than just
> address alignment.
> 
> NEC Europe knows about this problem.  Not sure if they passed
> it to Japan where the chip is designed.  Their engineers
> even had difficulty to understand what I was talking about. 

Let me give the list some background on this to aid in understanding.

When the MIPS I Architecture was originally defined (back in
1984), it included the architecturally-visible branch delay slot
that exists in the architecture today.  The Coprocessor 0
EPC register was defined to be the PC at which to restart after
an exception or an interrupt.  However, because an exception or
interrupt could occur while attempting to execute the instruction
in a branch delay slot, EPC could not simply point at that
instruction, because if the branch or jump was taken, restarting
at the delay slot PC doesn't account for the taken branch/jump.
As such, the architecture was specified such that if an exception
or interrupt was detected while attempting to execution the
instruction in a branch delay slot, EPC was defined to receive
the PC of the branch, and the BD bit was set in the Coprocessor 0
Cause register.  Most implementations of the MIPS Architecture did
exactly this.

In a few implementations of the MIPS Architecture (and I can't confirm
nor deny that this is the case with the NEC VR 41xx chips - I simply don't
know), the implementors observed that the restart PC could, in fact,
be the PC of the instruction in the delay slot, but only if the preceding
branch was known to be not-taken.  Restarting a not-taken branch
at the branch is equivalent to restarting at the delay slot in
terms of PC flow.  Note that this assumes that restarting at the
branch would not cause a different decision on the restart as
on the original execution, and this is required by the architecture.

Since the MIPS architecture has no not-taken jump instructions, there
should never be a case in which EPC points at the delay slot of a
jump, nor should there ever be a case in which EPC points at the
delay slot of a taken branch.

In the MIPS32 and MIPS64 Architecture, we explicitly require that the
value in EPC point at the branch/jump and that the BD bit be set in
the Cause register if an exception is detected in the delay slot.
Our compliance testing tests for this, and there are no compliant
implementations of the MIPS32 or MIPS64 Architecture which will
cause EPC to point to the delay slot of the branch (subject, of coure,
to an obscure bug).

As I mentioned earlier, there are some number of implementations of
earlier versions of the MIPS Architecture which apparently have
decided to point EPC at the delay slot instruction in the case of
a not-taken branch.  I can't give you a list of such implementations
because they pre-date our formal MIPS32/MIPS64 compliance testing.
I would hope that the users manual and/or errata sheets for chips
that do this would mention this as an issue.

So, the proposed code that went by on this list earlier can almost
certainly remove the jumps (they are always taken), and only adjust
PC if the previous instruction was a branch.

One word of warning, however:  Note that branch delay slots are
defined as DYNAMIC, not STATIC instructions.  Consider the following
example:

	...
5:	b	20f
	nop
	...
10:	b	someplace
20:	instruction-that-causes-exception

If the PC flow goes executions the branch at label 10 and detects
an exception on the instruction at label 20, EPC should point at
label 10, and the BD bit in Cause should be set.  However, if the branch
at label 5, with the nop in its delay slot, goes directly to the
excepting instruction at label 20, that instruction IS NOT in a
branch delay slot (remember, it's a dynamic relationship, not a
static one), so EPC would point at label 20 and the BD bit in cause
would not be set.

If the patch assumes that one can look backward by one instruction
in the STATIC code to determine if the instruction is in a
delay slot, one can not have code that jumps directly to the
instruction following another branch, as this would cause the
code to assume that it was in the delay slot of the branch.

This is exactly the reason why the architecture is defined in the
way that it is.

If anyone has any other questions, let me know.

/gmu

-- 

  =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
  Michael Uhler, VP, Systems, Architecture, and Software Products 
  MIPS Technologies, Inc.   Email: uhler@mips.com   Pager: uhler_p@mips.com
  1225 Charleston Road      Voice:  (650)567-5025   FAX:   (650)567-5225
  Mountain View, CA 94043   Mobile: (650)868-6870   Admin: (650)567-5085
