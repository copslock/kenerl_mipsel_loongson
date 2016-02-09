Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 22:01:25 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20488 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011766AbcBIVBXdbg7b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 22:01:23 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 2E0DEA866ABBC;
        Tue,  9 Feb 2016 21:01:14 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Tue, 9 Feb 2016
 21:01:16 +0000
Date:   Tue, 9 Feb 2016 20:55:34 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Luis Machado <lgustavo@codesourcery.com>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        <gdb-patches@sourceware.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Expect SI_KERNEL si_code for a MIPS software breakpoint
 trap
In-Reply-To: <56B9F7E6.5010006@codesourcery.com>
Message-ID: <alpine.DEB.2.00.1602092020150.15885@tp.orcam.me.uk>
References: <1442592647-3051-1-git-send-email-lgustavo@codesourcery.com> <alpine.LFD.2.20.1509181729100.10647@eddie.linux-mips.org> <56B9F7E6.5010006@codesourcery.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51924
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

On Tue, 9 Feb 2016, Luis Machado wrote:

> I'm finally getting back to this. Sorry for the delay.

 No problem, thanks for keeping a track of it.

> >   I'm not convinced however that it is safe to assume all SIGTRAPs come
> > from breakpoints -- this signal is sent by the kernel for both BREAK and
> > trap (multiple mnemonics, e.g. TEQ, TGEI, etc.) instructions which may
> > have been placed throughout code for some reason, for example to serve as
> > cheap assertion checks.
> > 
> >   Is there a separate check made afterwards like `bpstat_explains_signal'
> > to validate the source of the signal here?
> 
> In my specific example we are dealing with two breakpoint hits by different
> threads. The first one is reported just fine and the one we have problems with
> is the queued one that is reported afterwards when we attempt to move the
> other thread.
> 
> We do rely on bpstat_explains_signal when gdbserver/the remote target notifies
> gdb about a stop. In the case of a queued breakpoint hit, it doesn't even get
> reported back to gdb and is just ignored by gdbserver if it is recognized as a
> breakpoint hit.

 I'm not sure I understand what's going on here, why is a breakpoint hit
required to be ignored by gdbserver?

 From what you say I infer GDB controls a multi-threaded program and there 
it sets a software breakpoint which, by its nature, is global to all the 
threads.  Then multiple threads hit the breakpoint simultaneously (or 
nearly simultaneously) and the hits are delivered to GDB one by one, via 
gdbserver.  So why is GDB not prepared for that?

 It set the breakpoint itself so it should expect it to hit sometime, and 
if there are multiple threads, then there can be multiple hits at once or 
almost at once because, even in the all-stop mode, there is no guaranteed 
way to stop the threads all at once.  The threads may be spread across 
different processors in an SMP system for example, all trapping literally 
at once -- and then the kernel queueing the signals according to its own 
internal schedule before delivering them to the debugger (that, from the 
kernel's point of view, being gdbserver in this case).

> With the proposed change, even the hardcoded traps will initially be
> recognized as breakpoints, albeit maybe recognized as permanent breakpoints
> for some opcodes. It may cause gdbserver to ignore a second hardcoded trap
> hit, which is not desirable.

 So why does gdbserver have to be taught which breakpoints may have 
potentially been set by GDB and which may have not?  Why not to deliver 
them all and leave it up to GDB to decide?  I believe it will be the right 
thing to let GDB know that more than one thread has hit the same 
breakpoint.

 Did I miss anything?  How is this situation handled in a native debug 
scenario?

> >   Perhaps we should make it a part of the ABI and teach MIPS/Linux about
> > the breakpoint encoding used by GDB, which is `BREAK 5' (aka BRK_SSTEPBP
> > in kernel-speak, a misnomer I'm afraid), and make it set `si_code' to
> > TRAP_BRKPT, as expected.  This won't fix history of course, but at least
> > it will make debugging a little bit easier to handle in the future.
> > Cc-ing `linux-mips' for further input.
> 
> This is the best solution in my opinion and will definitely make the
> debugger's life easier if it can tell the difference between multiple
> seemingly equivalent SIGTRAP's.
> 
> Does this involve handling BRK_SSTEPBP inside
> arch/mips/kernel/traps.c:do_trap_or_bp?

 No, as I noted in my reply to David elsewhere in this thread, this would 
have to be in `do_bp' instead, to exclude trap instructions (e.g. TEQ, 
etc.) from being treated as breakpoints.  I can implement this change 
myself for you, but we need to agree first what the right solution for GDB 
is.  So far it looks to me we'd be only papering over a problem elsewhere.

  Maciej
