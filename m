Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BFDKRw005977
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 08:13:20 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BFDKl7005976
	for linux-mips-outgoing; Thu, 11 Jul 2002 08:13:20 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BFD9Rw005959
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 08:13:09 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6BFGtXb012060;
	Thu, 11 Jul 2002 08:16:55 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id IAA17179;
	Thu, 11 Jul 2002 08:16:54 -0700 (PDT)
Message-ID: <003201c228ee$1377c8e0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1020711132652.7876D-100000@delta.ds2.pg.gda.pl>
Subject: Re: Sigcontext->sc_pc Passed to User
Date: Thu, 11 Jul 2002 17:16:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>

[snip]

>  I believe the resumption should happen with EPC unmodified.  A handler
> may set EPC differently if it wants (possibly with longjmp() or by
> interpreting code at EPC and modifying EPC appropriately).  For the three
> signal handling possibilities, I'd do that as follows (assuming SIGBUS,
> SIGSEGV, etc. lethal signals): 
> 
> - SIG_IGN: return to EPC with no action.  A program will loop
>   indefinitely, but if that's what a user wants...

I don't think that this is the right thing to do, philosophically.
Hanging in an infinite loop and making no forward progress
is not, to me "ignoring" an event. The old X/Open specs I've 
got say that SIGFPE, SIGILL, and SIGSEGV behavior is 
undefined if bound to SIG_IGN (curiously, they don't call 
out SIGBUS), but I think that in practical terms we need to 
provide whatever behavior people expect from Linux on
x86 and PPC.  What happens on those platforms?  A
quick look at the x86 kernel code makes me think that
they do, indeed, do the "wrong" thing and beat their
heads against the ignored event for all eternity, but I'm
insufficiently an expert in x86 trap semantics to know
for certain whether that's the case.  If it is, right or 
wrong, that's what we ought to do.

> - SIG_DFL: kill.
> 
> - HANDLER: call a handler with the signal context unmodified and let the
>   user code decide what to do.

Independently of what we do for the SIG_IGN cases,
this is important, and the user code cannot decide what
to do if it cannot know what instruction caused the fault.
Fixups on SIGFPE must be able to find the FP instruction,
which is not currently possible if it was in a branch delay
slot.  Similarly, user-mode emulation of "memory" via
signal handlers cannot work unless the loads and stores
can be identified.  But, having "done the deed", return
from the signal handler should resume at the instruction
*following* the one generating the fault, and not replay
the same instruction.  We *could* punt that to the signal
handler, but making every signal package carry its own
copy of compute_return_epc() to handle the branch
delay slot cases strikes me as being unfriendly to the
user and is arguably slightly less reliable.  I guess I'd like things 
to be rigged so that the sigcontext structure contains the address 
of the faulting instruction as the sc_pc, but where the return 
from signal goes to the address calculated by 
compute_return_epc().  But again, what do people expect 
in the "mainstream" world of x86 Linux?

            Regards,

            Kevin K.
