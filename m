Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Feb 2016 17:21:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26960 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007113AbcBSQV2sfXgS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Feb 2016 17:21:28 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id C13C61435C942;
        Fri, 19 Feb 2016 16:21:19 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Fri, 19 Feb 2016
 16:21:21 +0000
Date:   Fri, 19 Feb 2016 16:21:21 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Pedro Alves <palves@redhat.com>
CC:     Luis Machado <lgustavo@codesourcery.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <gdb-patches@sourceware.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Expect SI_KERNEL si_code for a MIPS software breakpoint
 trap
In-Reply-To: <56C26D8A.9070401@redhat.com>
Message-ID: <alpine.DEB.2.00.1602182328160.15885@tp.orcam.me.uk>
References: <1442592647-3051-1-git-send-email-lgustavo@codesourcery.com> <alpine.LFD.2.20.1509181729100.10647@eddie.linux-mips.org> <56B9F7E6.5010006@codesourcery.com> <alpine.DEB.2.00.1602092020150.15885@tp.orcam.me.uk> <56BB329F.3080606@codesourcery.com>
 <alpine.DEB.2.00.1602152315540.15885@tp.orcam.me.uk> <56C26D8A.9070401@redhat.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Tue, 16 Feb 2016, Pedro Alves wrote:

> >  FWIW, I maintain it's GDB that should be handling it.  What if TRAP_BRKPT 
> > is reported for a breakpoint that has not been set by GDB in the first 
> > place and is still there in code?  I take it either GDB or gdbserver, as 
> > applicable, will just sit there looping indefinitely in an attempt to 
> > discard the event while executing the breakpoint instruction over and over 
> > again.
> 
> Nope.
> 
> > There's nothing stopping the user from having a MIPS `BREAK 5' 
> > instruction or say INT3 for the x86 target already present in the 
> > executable being debugged.
> 
> GDB only ignores the TRAP_BRKPT event if there's no "BREAK 5" instruction
> hardcoded in the binary.  If there is, then the program is stopped and
> a SIGTRAP is reported to the user.

 Ah, that makes a fundamental difference to me!  I missed this detail from 
Luis's description and concluded that GDB/gdbserver never passes along 
TRAP_BRKPT events it cannot associate with a breakpoint set by itself.

> >  What I think GDB ought to be doing here is caching addresses for recently 
> > removed breakpoints and discarding spurious hits in that cache.
> 
> That does not work in general.  The most problematic archs are those that
> leave the PC pointing after the breakpoint instruction, such as x86.
> See more below.

 [etc.] Fair enough.  Thanks for the extra explanation.

> Remembering whether a breakpoint was inserted was what GDB used to
> do, and it was because it was problematic that "swbreak" was
> invented.  See:
> 
>  https://sourceware.org/ml/gdb-patches/2015-02/msg00726.html
> 
> Particularly:
> 
>  https://sourceware.org/ml/gdb-patches/2015-02/msg00730.html

 OK, I can see you peek at target text in `program_breakpoint_here_p' to 
see if there's a breakpoint there.  With this in mind I think Luis's 
change is conceptually good as it stands, although I think we should move 
the MIPS case along PowerPC right away, because TRAP_BRKPT is the right 
code to use here and the MIPS port has never produced it so far and 
therefore there's no backwards compatibility concern if we accept both 
SI_KERNEL and TRAP_BRKPT.

 Luis, such an updated change is preapproved as far as I am concerned, 
feel free to commit it without another review round.

 As to the kernel side with the observations made in this discussion I 
think we should set the trap code for SIGTRAP signals issued with BREAK 
instructions to TRAP_BRKPT unconditionally, regardless of the code used.  
This won't of course affect encodings which send a different signal such 
as SIGFPE.

 We're lacking a code suitable for (conditional) trap instructions.  I 
think TRAP_TRAP or suchlike needs to be added.

> > But currently there is no easy way to tell a software breakpoint hit and 
> > a hardcoded trap (and maybe even a hardware breakpoint hit?) apart.
> 
> Software breakpoint hits or hardcoded traps are handled the same.  Even if GDB
> plants the breakpoint instruction itself with direct memory pokes (instead of
> z0 packets), the target should report "swbreak" stops, so that gdb can do
> the right thing.

 Manual planting is historical AFAIK, gdbserver and other stubs used not 
to support `z' packets.  Now we have the right infrastructure in place and 
GDB passes MIPS breakpoint encoding requirements along (although I note 
that the encoding for microMIPS BREAK16 has changed with R6, so this will 
have to be updated) so we could have software breakpoint support added to 
MIPS gdbserver as well.

> Hardware breakpoint hits are distinguished from software breakpoint hits,
> because they're reported with "hwbreak", not "swbreak":
> 
>  @item hwbreak
>  The packet indicates the target stopped for a hardware breakpoint.
>  The @var{r} part must be left empty.

 Umm, any requirements for this?  We have MIPS data hardware breakpoint 
support in the Linux kernel (regrettably not for instructions, but that 
could be added sometime), but I can't see TRAP_HWBKPT being set for them, 
they just use generic SI_KERNEL as everything else right now.

 Thanks for your patience in explaining this all to me.

  Maciej
