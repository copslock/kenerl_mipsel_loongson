Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 00:50:28 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19590 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007227AbcBOXu0WrA9g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Feb 2016 00:50:26 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id A84B28D46E5FC;
        Mon, 15 Feb 2016 23:50:13 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Mon, 15 Feb 2016
 23:50:16 +0000
Date:   Mon, 15 Feb 2016 23:50:16 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Luis Machado <lgustavo@codesourcery.com>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        <gdb-patches@sourceware.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Expect SI_KERNEL si_code for a MIPS software breakpoint
 trap
In-Reply-To: <56BB329F.3080606@codesourcery.com>
Message-ID: <alpine.DEB.2.00.1602152315540.15885@tp.orcam.me.uk>
References: <1442592647-3051-1-git-send-email-lgustavo@codesourcery.com> <alpine.LFD.2.20.1509181729100.10647@eddie.linux-mips.org> <56B9F7E6.5010006@codesourcery.com> <alpine.DEB.2.00.1602092020150.15885@tp.orcam.me.uk> <56BB329F.3080606@codesourcery.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52077
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

On Wed, 10 Feb 2016, Luis Machado wrote:

> I went through the data again and i was partially mistaken about the above.
> Here's a detailed description of the events that take place in the reported
> situation.
> 
> 1 - A breakpoint is inserted by GDB at some code that is executed by multiple
> threads.
> 2 - Two threads, let us call them 1 and 2, happen to hit the same software
> breakpoint, so both SIGTRAP's get sent by the kernel and gdbserver picks one
> of them to process.
> 3 - gdbserver figures out this is from a breakpoint hit, since it knows there
> is a breakpoint inserted at that PC, and sends a swbreak stop reply back to
> gdb.
> 4 - GDB gets the swbreak stop reply and notifies the user about the breakpoint
> hit for thread 1, displays the frame information etc.
> 
> Now, the user goes and deletes that specific breakpoint that triggered the
> previous event and switches the context to thread 2 and then attempts to
> continue execution.
> 
> 5 - In gdbserver, thread 2 still has a pending SIGTRAP that was not yet
> handled.
> 6 - gdbserver proceeds to handle it, sees it is a SIGTRAP but cannot map that
> event back to a software breakpoint hit due to the removal of such breakpoint
> and because gdbserver doesn't expect SI_KERNEL to mean "software breakpoint
> hit".
> 7 - gdbserver then assumes this is a generic trap and reports it as such to
> GDB, in a new stop reply.
> 8 - GDB receives the stop reply and displays a generic trace/breakpoint
> SIGTRAP since it also cannot map the trap back to a software breakpoint, i.e.
> bpstat_explains_signal returns 0 and random_signal is non-zero.
> 
> Patching gdbserver to recognize a si_code of SI_KERNEL as a software
> breakpoint trap causes changes starting from 6.
> 
> 6 - gdbserver proceeds to handle it, sees it is a SIGTRAP and that its si_code
> is SI_KERNEL, meaning a software breakpoint hit now, even though we can't
> recognize a breakpoint hit by checking for an underlying breakpoint
> instruction.
> 7 - gdbserver sends a swbreak stop reply back to GDB.
> 8 - GDB receives the stop reply and notices it is a delayed breakpoint hit.
> According to its logic, GDB discards this as useless and the program continues
> its execution properly. Here random_signal is non-zero and
> target_stopped_by_sw_breakpoint () returns 1 (because gdbserver told GDB so).
> 
> The problem of forcing gdbserver to recognize all traps with
> si_code==SI_KERNEL is that even hardcoded traps will be reported back to GDB
> as a swbreak event, which is not ideal.
> 
> But currently there is no easy way to tell a software breakpoint hit and a
> hardcoded trap (and maybe even a hardware breakpoint hit?) apart.

 Thanks for the detailed explanation.

 FWIW, I maintain it's GDB that should be handling it.  What if TRAP_BRKPT 
is reported for a breakpoint that has not been set by GDB in the first 
place and is still there in code?  I take it either GDB or gdbserver, as 
applicable, will just sit there looping indefinitely in an attempt to 
discard the event while executing the breakpoint instruction over and over 
again.  There's nothing stopping the user from having a MIPS `BREAK 5' 
instruction or say INT3 for the x86 target already present in the 
executable being debugged.

 What I think GDB ought to be doing here is caching addresses for recently 
removed breakpoints and discarding spurious hits in that cache.  It may 
actually be worth verifying, before discarding such a hit, that there is 
no breakpoint instruction there anymore in target memory too -- a clever 
user might have set a breakpoint on a breakpoint instruction already there 
in code!

 It seems to me it'll be enough if the cache is only retained over a 
single resumption step, per thread of course, as it does not appear to me 
that the kernel might queue more than one software breakpoint signal at 
once.

 NB conceptually this is similar to handling spurious hardware interrupts 
in the kernel, where the kernel interrogates all possible interrupt 
sources for the reporting interrupt line, which might be a physical shared 
wire, a shared vector, etc., before discarding them as invalid.  Such 
interrupts are sometimes delivered when the originating device pulls its 
request away before it's been handled.

> >   Did I miss anything?  How is this situation handled in a native debug
> > scenario?
> 
> I take it native debugging will display the same sympthoms because the
> definitions of si_code are shared between GDB and gdbserver, from
> nat/linux-ptrace.h. Native also uses a similar function to check for
> breakpoint hits, namely gdb/linux-nat.c:check_stopped_by_breakpoint. I did not
> test this with a native debugger though.

 OK, noted.  Thanks!

> > > >    Perhaps we should make it a part of the ABI and teach MIPS/Linux
> > > > about
> > > > the breakpoint encoding used by GDB, which is `BREAK 5' (aka BRK_SSTEPBP
> > > > in kernel-speak, a misnomer I'm afraid), and make it set `si_code' to
> > > > TRAP_BRKPT, as expected.  This won't fix history of course, but at least
> > > > it will make debugging a little bit easier to handle in the future.
> > > > Cc-ing `linux-mips' for further input.
> > > 
> > > This is the best solution in my opinion and will definitely make the
> > > debugger's life easier if it can tell the difference between multiple
> > > seemingly equivalent SIGTRAP's.
> > > 
> > > Does this involve handling BRK_SSTEPBP inside
> > > arch/mips/kernel/traps.c:do_trap_or_bp?
> > 
> >   No, as I noted in my reply to David elsewhere in this thread, this would
> > have to be in `do_bp' instead, to exclude trap instructions (e.g. TEQ,
> > etc.) from being treated as breakpoints.  I can implement this change
> > myself for you, but we need to agree first what the right solution for GDB
> > is.  So far it looks to me we'd be only papering over a problem elsewhere.
> 
> Hopefully the above makes what we're facing more clear.

 I think we could do this as well, so as to save GDB from the need to 
verify truly irrelevant traps against its cache.  Though I don't think it 
buys us anything short-term as we'll have to continue support kernels 
which have no notion of TRAP_BRKPT.  So no need to rush doing this IMHO.

  Maciej
