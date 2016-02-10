Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 13:53:04 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:38541 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008595AbcBJMxBwE3BJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 13:53:01 +0100
Received: from svr-orw-fem-06.mgc.mentorg.com ([147.34.97.120])
        by relay1.mentorg.com with esmtp 
        id 1aTUGL-0000cE-ST from Luis_Gustavo@mentor.com ; Wed, 10 Feb 2016 04:52:53 -0800
Received: from [172.30.10.142] (147.34.91.1) by SVR-ORW-FEM-06.mgc.mentorg.com
 (147.34.97.120) with Microsoft SMTP Server id 14.3.224.2; Wed, 10 Feb 2016
 04:52:53 -0800
Reply-To: Luis Machado <lgustavo@codesourcery.com>
Subject: Re: [PATCH] Expect SI_KERNEL si_code for a MIPS software breakpoint
 trap
References: <1442592647-3051-1-git-send-email-lgustavo@codesourcery.com>
 <alpine.LFD.2.20.1509181729100.10647@eddie.linux-mips.org>
 <56B9F7E6.5010006@codesourcery.com>
 <alpine.DEB.2.00.1602092020150.15885@tp.orcam.me.uk>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        <gdb-patches@sourceware.org>, <linux-mips@linux-mips.org>
From:   Luis Machado <lgustavo@codesourcery.com>
Message-ID: <56BB329F.3080606@codesourcery.com>
Date:   Wed, 10 Feb 2016 10:52:47 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1602092020150.15885@tp.orcam.me.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <Luis_Gustavo@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lgustavo@codesourcery.com
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

On 02/09/2016 06:55 PM, Maciej W. Rozycki wrote:
> On Tue, 9 Feb 2016, Luis Machado wrote:
>
>> I'm finally getting back to this. Sorry for the delay.
>
>   No problem, thanks for keeping a track of it.
>
>>>    I'm not convinced however that it is safe to assume all SIGTRAPs come
>>> from breakpoints -- this signal is sent by the kernel for both BREAK and
>>> trap (multiple mnemonics, e.g. TEQ, TGEI, etc.) instructions which may
>>> have been placed throughout code for some reason, for example to serve as
>>> cheap assertion checks.
>>>
>>>    Is there a separate check made afterwards like `bpstat_explains_signal'
>>> to validate the source of the signal here?
>>
>> In my specific example we are dealing with two breakpoint hits by different
>> threads. The first one is reported just fine and the one we have problems with
>> is the queued one that is reported afterwards when we attempt to move the
>> other thread.
>>
>> We do rely on bpstat_explains_signal when gdbserver/the remote target notifies
>> gdb about a stop. In the case of a queued breakpoint hit, it doesn't even get
>> reported back to gdb and is just ignored by gdbserver if it is recognized as a
>> breakpoint hit.
>
>   I'm not sure I understand what's going on here, why is a breakpoint hit
> required to be ignored by gdbserver?
>
>   From what you say I infer GDB controls a multi-threaded program and there
> it sets a software breakpoint which, by its nature, is global to all the
> threads.  Then multiple threads hit the breakpoint simultaneously (or
> nearly simultaneously) and the hits are delivered to GDB one by one, via
> gdbserver.  So why is GDB not prepared for that?
>
>   It set the breakpoint itself so it should expect it to hit sometime, and
> if there are multiple threads, then there can be multiple hits at once or
> almost at once because, even in the all-stop mode, there is no guaranteed
> way to stop the threads all at once.  The threads may be spread across
> different processors in an SMP system for example, all trapping literally
> at once -- and then the kernel queueing the signals according to its own
> internal schedule before delivering them to the debugger (that, from the
> kernel's point of view, being gdbserver in this case).
>

I went through the data again and i was partially mistaken about the 
above. Here's a detailed description of the events that take place in 
the reported situation.

1 - A breakpoint is inserted by GDB at some code that is executed by 
multiple threads.
2 - Two threads, let us call them 1 and 2, happen to hit the same 
software breakpoint, so both SIGTRAP's get sent by the kernel and 
gdbserver picks one of them to process.
3 - gdbserver figures out this is from a breakpoint hit, since it knows 
there is a breakpoint inserted at that PC, and sends a swbreak stop 
reply back to gdb.
4 - GDB gets the swbreak stop reply and notifies the user about the 
breakpoint hit for thread 1, displays the frame information etc.

Now, the user goes and deletes that specific breakpoint that triggered 
the previous event and switches the context to thread 2 and then 
attempts to continue execution.

5 - In gdbserver, thread 2 still has a pending SIGTRAP that was not yet 
handled.
6 - gdbserver proceeds to handle it, sees it is a SIGTRAP but cannot map 
that event back to a software breakpoint hit due to the removal of such 
breakpoint and because gdbserver doesn't expect SI_KERNEL to mean 
"software breakpoint hit".
7 - gdbserver then assumes this is a generic trap and reports it as such 
to GDB, in a new stop reply.
8 - GDB receives the stop reply and displays a generic trace/breakpoint 
SIGTRAP since it also cannot map the trap back to a software breakpoint, 
i.e. bpstat_explains_signal returns 0 and random_signal is non-zero.

Patching gdbserver to recognize a si_code of SI_KERNEL as a software 
breakpoint trap causes changes starting from 6.

6 - gdbserver proceeds to handle it, sees it is a SIGTRAP and that its 
si_code is SI_KERNEL, meaning a software breakpoint hit now, even though 
we can't recognize a breakpoint hit by checking for an underlying 
breakpoint instruction.
7 - gdbserver sends a swbreak stop reply back to GDB.
8 - GDB receives the stop reply and notices it is a delayed breakpoint 
hit. According to its logic, GDB discards this as useless and the 
program continues its execution properly. Here random_signal is non-zero 
and target_stopped_by_sw_breakpoint () returns 1 (because gdbserver told 
GDB so).

The problem of forcing gdbserver to recognize all traps with 
si_code==SI_KERNEL is that even hardcoded traps will be reported back to 
GDB as a swbreak event, which is not ideal.

But currently there is no easy way to tell a software breakpoint hit and 
a hardcoded trap (and maybe even a hardware breakpoint hit?) apart.

>> With the proposed change, even the hardcoded traps will initially be
>> recognized as breakpoints, albeit maybe recognized as permanent breakpoints
>> for some opcodes. It may cause gdbserver to ignore a second hardcoded trap
>> hit, which is not desirable.
>
>   So why does gdbserver have to be taught which breakpoints may have
> potentially been set by GDB and which may have not?  Why not to deliver
> them all and leave it up to GDB to decide?  I believe it will be the right
> thing to let GDB know that more than one thread has hit the same
> breakpoint.
>
>   Did I miss anything?  How is this situation handled in a native debug
> scenario?
>

I take it native debugging will display the same sympthoms because the 
definitions of si_code are shared between GDB and gdbserver, from 
nat/linux-ptrace.h. Native also uses a similar function to check for 
breakpoint hits, namely gdb/linux-nat.c:check_stopped_by_breakpoint. I 
did not test this with a native debugger though.

>>>    Perhaps we should make it a part of the ABI and teach MIPS/Linux about
>>> the breakpoint encoding used by GDB, which is `BREAK 5' (aka BRK_SSTEPBP
>>> in kernel-speak, a misnomer I'm afraid), and make it set `si_code' to
>>> TRAP_BRKPT, as expected.  This won't fix history of course, but at least
>>> it will make debugging a little bit easier to handle in the future.
>>> Cc-ing `linux-mips' for further input.
>>
>> This is the best solution in my opinion and will definitely make the
>> debugger's life easier if it can tell the difference between multiple
>> seemingly equivalent SIGTRAP's.
>>
>> Does this involve handling BRK_SSTEPBP inside
>> arch/mips/kernel/traps.c:do_trap_or_bp?
>
>   No, as I noted in my reply to David elsewhere in this thread, this would
> have to be in `do_bp' instead, to exclude trap instructions (e.g. TEQ,
> etc.) from being treated as breakpoints.  I can implement this change
> myself for you, but we need to agree first what the right solution for GDB
> is.  So far it looks to me we'd be only papering over a problem elsewhere.

Hopefully the above makes what we're facing more clear.
