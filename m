Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Feb 2015 11:09:15 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27012281AbbBFKJNbOWAG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Feb 2015 11:09:13 +0100
Date:   Fri, 6 Feb 2015 10:09:13 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Daniel Sanders <Daniel.Sanders@imgtec.com>
cc:     Toma Tabacu <Toma.Tabacu@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/5] MIPS: LLVMLinux: Fix an 'inline asm input/output
 type mismatch' error.
In-Reply-To: <E484D272A3A61B4880CDF2E712E9279F4591CDE8@hhmail02.hh.imgtec.org>
Message-ID: <alpine.LFD.2.11.1502060918480.22715@eddie.linux-mips.org>
References: <1422970639-7922-1-git-send-email-daniel.sanders@imgtec.com> <1422970639-7922-4-git-send-email-daniel.sanders@imgtec.com> <alpine.LFD.2.11.1502041151300.22715@eddie.linux-mips.org>
 <E484D272A3A61B4880CDF2E712E9279F4591CDE8@hhmail02.hh.imgtec.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45749
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

On Thu, 5 Feb 2015, Daniel Sanders wrote:

> Apologies for the slow response. I've had an excessive amount of 
> meetings in the last couple days.

 No worries, if anyone, it's not me in a hurry here. ;)

> >  This definitely looks like a bug in clang to me.  What this construct
> > means is both input #5 and output #1 live in the same register, and that
> > an `__u32' value is taken on input (from the result of the `htonl(proto)'
> > calculation) and an `unsigned short' value produced in the same register
> > on output, that'll be the value of the `proto' variable from there on.  A
> > perfectly valid arrangement.  This would be the right arrangement to use
> > with the MIPS16 SEH instruction for example.  Has this bug been reported
> > to clang maintainers?
> 
> I'm not convinced it's a bug, but I do at least agree that the use case sounds
> sensible. It makes sense to me that the focus should be on register allocations
> rather than on types. However, the relevant clang source is being very specific
> about the cases it is/isn't allowing which suggests it's deliberate. I've started a
> thread on the clang mailing list to try to find out more about why we currently
> reject it.

 I think it boils down to the register model implemented by a given 
architecture.  MIPS processors do not have subregisters for integer data 
quantities narrower than the size of the machine word.  The same GPR will 
hold a `char', a `short' or an `int', and therefore it is perfectly valid 
to arrange that it holds say an `int' on input and say a `short' on 
output.  So given an artificial example like this:

short foo(int i)
{
	short v;

	asm("frob %0" : "=r" (v) : "0" (i));
	return v;
}

the compiler knows it does not have to truncate the result of the 
calculation made in the asm before returning it to the caller, which it 
would unnecessarily have with this code:

short foo(int i)
{
	asm("frob %0" : "+r" (i));
	return i;
}

 This is unlike some other architectures.  On x86 for example you do have 
subregisters, so for example an `int' will be stored in %eax, a short will 
be stored in %ax, and a `char' will be stored in %al, or worse yet, %ah.  
Consequently you may not be able to alias an input operand and an output 
operand of a different width each to each other.

 Also I think it is important to note that in the (first) example above, 
`i' and `v' are separate data entities as far as C code is concerned.  
And that the operands of the asm merely tell the C compiler that the value 
of `i' must appear in a register (that need not be the variable's original 
storage location) on entry to the asm and the value to set `v' to will 
appear in a register (that again need not be the place where the actual 
variable lives) on exit from the asm, and that the two registers must be 
physically the same (presumably because of a machine limitation, such as 
one observed with the MIPS16 SEH instruction mentioned), but that does not 
mean the input and the output otherwise have anything in common.

 And last but not least, the extended asm feature is a GCC extension, so 
if clang developers chose to implement it for GCC compatibility, then I am 
afraid they need to follow the rules set by GCC.  So if GCC accepts it, 
they need too.

> Yes, that works for me on both GCC and Clang. I'll change the patch to this.
> Would you like a 'Suggested-By' in the patch description?

 Sure.

  Maciej
