Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 15:30:11 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:60274 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011379AbcBIOaKRcIa6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 15:30:10 +0100
Received: from svr-orw-fem-06.mgc.mentorg.com ([147.34.97.120])
        by relay1.mentorg.com with esmtp 
        id 1aT9Ip-0005VN-KW from Luis_Gustavo@mentor.com ; Tue, 09 Feb 2016 06:30:03 -0800
Received: from [172.30.10.142] (147.34.91.1) by SVR-ORW-FEM-06.mgc.mentorg.com
 (147.34.97.120) with Microsoft SMTP Server id 14.3.224.2; Tue, 9 Feb 2016
 06:30:03 -0800
Reply-To: Luis Machado <lgustavo@codesourcery.com>
Subject: Re: [PATCH] Expect SI_KERNEL si_code for a MIPS software breakpoint
 trap
References: <1442592647-3051-1-git-send-email-lgustavo@codesourcery.com>
 <alpine.LFD.2.20.1509181729100.10647@eddie.linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     <gdb-patches@sourceware.org>, <linux-mips@linux-mips.org>
From:   Luis Machado <lgustavo@codesourcery.com>
Message-ID: <56B9F7E6.5010006@codesourcery.com>
Date:   Tue, 9 Feb 2016 12:29:58 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1509181729100.10647@eddie.linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <Luis_Gustavo@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51904
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

Hi Maciej,

I'm finally getting back to this. Sorry for the delay.

On 09/18/2015 01:56 PM, Maciej W. Rozycki wrote:
> Hi Luis,
>
>> I tracked this down to the lack of a proper definition of what MIPS' kernel
>> returns in the si_code for a software breakpoint trap.
>>
>> Though i did not find documentation about this, tests showed that we should
>> check for SI_KERNEL, just like i386. I've cc-ed Maciej, just to be sure this
>> is indeed correct.
>
>   Hmm, the MIPS/Linux port does not set any particular code for SIGTRAP,
> all such signals will have the SI_KERNEL default, so you may well return
> TRUE unconditionally.
>

That is unfortunate. It would be nice to have a well defined standard of 
communicating these events from kernels to debuggers. All is not lost 
though, since that can be improved.

>   I'm not convinced however that it is safe to assume all SIGTRAPs come
> from breakpoints -- this signal is sent by the kernel for both BREAK and
> trap (multiple mnemonics, e.g. TEQ, TGEI, etc.) instructions which may
> have been placed throughout code for some reason, for example to serve as
> cheap assertion checks.
>
>   Is there a separate check made afterwards like `bpstat_explains_signal'
> to validate the source of the signal here?
>

In my specific example we are dealing with two breakpoint hits by 
different threads. The first one is reported just fine and the one we 
have problems with is the queued one that is reported afterwards when we 
attempt to move the other thread.

We do rely on bpstat_explains_signal when gdbserver/the remote target 
notifies gdb about a stop. In the case of a queued breakpoint hit, it 
doesn't even get reported back to gdb and is just ignored by gdbserver 
if it is recognized as a breakpoint hit.

With the proposed change, even the hardcoded traps will initially be 
recognized as breakpoints, albeit maybe recognized as permanent 
breakpoints for some opcodes. It may cause gdbserver to ignore a second 
hardcoded trap hit, which is not desirable.

>   Perhaps we should make it a part of the ABI and teach MIPS/Linux about
> the breakpoint encoding used by GDB, which is `BREAK 5' (aka BRK_SSTEPBP
> in kernel-speak, a misnomer I'm afraid), and make it set `si_code' to
> TRAP_BRKPT, as expected.  This won't fix history of course, but at least
> it will make debugging a little bit easier to handle in the future.
> Cc-ing `linux-mips' for further input.

This is the best solution in my opinion and will definitely make the 
debugger's life easier if it can tell the difference between multiple 
seemingly equivalent SIGTRAP's.

Does this involve handling BRK_SSTEPBP inside 
arch/mips/kernel/traps.c:do_trap_or_bp?

>
>   I was wondering where these SIGTRAPs come from too BTW, thanks for
> investigating it.  And thanks for the heads-up!

You're welcome.
