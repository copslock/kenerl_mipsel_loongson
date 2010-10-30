Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Oct 2010 14:40:03 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39184 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490958Ab0J3Mj7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Oct 2010 14:39:59 +0200
Date:   Sat, 30 Oct 2010 13:39:58 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Camm Maguire <camm@maguirefamily.org>
cc:     David Daney <ddaney@caviumnetworks.com>,
        linux-mips <linux-mips@linux-mips.org>,
        debian-mips@lists.debian.org, gcl-devel@gnu.org
Subject: Re: [Gcl-devel] Re: gdb for mips64
In-Reply-To: <874oc5c7y7.fsf@maguirefamily.org>
Message-ID: <alpine.LFD.2.00.1010301219150.25426@eddie.linux-mips.org>
References: <E1OwbkA-0006gv-Bi@localhost.m.enhanced.com>        <4C93D86D.5090201@caviumnetworks.com>        <87fwx4dwu5.fsf@maguirefamily.org>        <4C97D9A1.7050102@caviumnetworks.com>        <87lj6te9t1.fsf@maguirefamily.org>       
 <4C9A8BC9.1020605@caviumnetworks.com>        <4C9A9699.6080908@caviumnetworks.com>        <87pqvbs7oa.fsf@maguirefamily.org>        <4CB88D2C.8020900@caviumnetworks.com>        <87r5fksxby.fsf_-_@maguirefamily.org>        <4CBF1B1E.6050804@caviumnetworks.com>
        <8762wwlfen.fsf@maguirefamily.org>        <4CC06826.2070508@caviumnetworks.com>        <4CC0787C.2040902@caviumnetworks.com>        <878w1m3qmn.fsf_-_@maguirefamily.org>        <4CC5FA72.6080005@caviumnetworks.com>        <87k4l52eqb.fsf@maguirefamily.org>
 <87vd4or9v9.fsf@maguirefamily.org>        <alpine.LFD.2.00.1010281109480.25426@eddie.linux-mips.org>        <87vd4mm2hj.fsf@maguirefamily.org>        <alpine.LFD.2.00.1010290821040.25426@eddie.linux-mips.org> <874oc5c7y7.fsf@maguirefamily.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 29 Oct 2010, Camm Maguire wrote:

> OK see attachment below.

 Thanks.  This is the piece of code generated (I've snipped out the 
irrelevant bits:

	ld	$25,%got_disp(_IO_getc)($28)	# 208  load_gotdi	[length = 4]
	ld	$28,40($sp)	# 247  *movdi_64bit/4	[length = 4]
[...]
	jr	$25	# 116  sibcall_value_internal/1	[length = 4]
	daddiu	$sp,$sp,64	# 253  *adddi3/2	[length = 4]

As you can see this is a sibling (aka tail) call and GCC deliberately 
requests a GOT rather than a CALL reloc -- %got_disp(_IO_getc) means: 
"Give me _IO_getc with a R_MIPS_GOT_DISP reloc applied!".

 I have checked GCC sources and this is legitimate, because with the new 
ABIs the GOT pointer register ($gp aka $28) is call saved -- as you can 
see it's restored above to the value coming from the caller.  And the stub 
requires $gp to have been loaded with a pointer to the containing module's 
GOT and not (possibly) some other one.

 Here's the relevant comment from GCC:

  /* If we're generating PIC, and this call is to a global function,
     try to allow its address to be resolved lazily.  This isn't
     possible for NewABI sibcalls since the value of $gp on entry
     to the stub would be our caller's gp, not ours.  */

As this is something I had not considered before I was not aware of this 
new ABI limitation until now -- thanks for giving me the opportunity to 
get enlightened. :)

 You may not be seeing this with a newer version of GCC, because it may be 
refraining from emitting the sibling call for some reason -- essentially 
here we have a tradeoff between a one-time performance penalty at startup 
coming from the lack of the lazy stub and a per-call penalty coming from 
an extra return required if this was an ordinary call.  GCC may be able to 
assess the choice based on the likelihood of execution.  Just guessing 
though -- I'm not that much into GCC's internals ;) -- and the explanation 
may be as simple as -fno-optimize-sibling-calls sneaked in somewhere. ;)

> Its simple but rather unconventional.  GCL is a lisp system.  It loads
> compiled object files at runtime into memory, and executes therefrom.
> It can then save the expanded memory image to disk via unexec for
> later execution on the same or different machines.  Compiled code can

 Ah, that brings memories from the 1990s and the Perl's "undump" facility 
that allowed one to get executable machine code from otherwise interpreted 
code. ;)  I believe the functionality was lost with the transition from 
a.out to ELF and never revived -- for a change you seem to be doing the 
revival for Lisp, at least to some extent. :)

> reference symbols in external shared libraries.  These must be
> directed toward some trampoline in the initial final-linked
> executable, as otherwise the address loaded might not be valid in a
> later execution.  On mips, GCL adds a little stub to load the global
> got address from a local got table appended to the .o file, then to
> load the contents of this address, and then jump.  GCL ensures that
> LD_BIND_NOW is set at runtime via pushing the environment and execve()
> on startup.  On other systems, where .plt entries are available, GCL
> sets the address to the .plt which takes care of everything.  This is
> much cleaner as it requires no little machine-specific assembly.

 Interesting -- do you actually mean "compiled object files" are final 
executables (that may or may not have a PLT according to the ABI used) 
rather than .o files one would normally assume?

 Note that with current versions of the tools (GCC + binutils) you can get 
a PLT in MIPS code as an alternative as well (32-bit only; new ABIs are 
still limited to MIPS stubs only) coming from an ABI modification made for 
performance gain; I reckon -mplt is the GCC switch to request it.  I'm not 
entirely sure what the exact timeline of these changes was, but GCC 4.4 
should most certainly provide it and when it comes to binutils, as noted 
previously, you are best running the most recent version anyway.

 Still the use of PLTs would not solve the issue where a PLT would not, 
for some reason, be generated at all, such as with the LD's "-z now" 
option, or for a given function call, such as with MIPS new ABI's sibling 
calls (which I am fairly sure will be subject to the same limitation if 
ever implemented), would it?

> In the cvs version of GCL, such external calls are made through a C
> pointer, which is redirected at startup to the correct address via
> dlsym().  A little faster, and makes the loader a little simpler.

 It sounds cleaner to me if I'm getting the overall picture right here.

> Thankfully thus far this has not proved necessary.  But ia64 and hppa
> are the only targets yet unimplemented, so who knows.

 Hmm, the Itanic sounds like a problem by definition. ;)  Is anybody still 
using it anyway?  Can't comment on HP-PA.

  Maciej
