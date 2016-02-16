Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 01:30:12 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:37749 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012612AbcBPAaKdTQNH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Feb 2016 01:30:10 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (Postfix) with ESMTPS id DE750C804;
        Tue, 16 Feb 2016 00:30:03 +0000 (UTC)
Received: from [127.0.0.1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1G0U22I015186;
        Mon, 15 Feb 2016 19:30:02 -0500
Message-ID: <56C26D8A.9070401@redhat.com>
Date:   Tue, 16 Feb 2016 00:30:02 +0000
From:   Pedro Alves <palves@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@imgtec.com>,
        Luis Machado <lgustavo@codesourcery.com>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        gdb-patches@sourceware.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Expect SI_KERNEL si_code for a MIPS software breakpoint
 trap
References: <1442592647-3051-1-git-send-email-lgustavo@codesourcery.com> <alpine.LFD.2.20.1509181729100.10647@eddie.linux-mips.org> <56B9F7E6.5010006@codesourcery.com> <alpine.DEB.2.00.1602092020150.15885@tp.orcam.me.uk> <56BB329F.3080606@codesourcery.com> <alpine.DEB.2.00.1602152315540.15885@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.00.1602152315540.15885@tp.orcam.me.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <palves@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palves@redhat.com
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

On 02/15/2016 11:50 PM, Maciej W. Rozycki wrote:

>  FWIW, I maintain it's GDB that should be handling it.  What if TRAP_BRKPT 
> is reported for a breakpoint that has not been set by GDB in the first 
> place and is still there in code?  I take it either GDB or gdbserver, as 
> applicable, will just sit there looping indefinitely in an attempt to 
> discard the event while executing the breakpoint instruction over and over 
> again.

Nope.

> There's nothing stopping the user from having a MIPS `BREAK 5' 
> instruction or say INT3 for the x86 target already present in the 
> executable being debugged.

GDB only ignores the TRAP_BRKPT event if there's no "BREAK 5" instruction
hardcoded in the binary.  If there is, then the program is stopped and
a SIGTRAP is reported to the user.

>  What I think GDB ought to be doing here is caching addresses for recently 
> removed breakpoints and discarding spurious hits in that cache.

That does not work in general.  The most problematic archs are those that
leave the PC pointing after the breakpoint instruction, such as x86.
See more below.

> It may 
> actually be worth verifying, before discarding such a hit, that there is 
> no breakpoint instruction there anymore in target memory too -- a clever 
> user might have set a breakpoint on a breakpoint instruction already there 
> in code!

Yep, GDB does that already, and we have tests that cover this.
See gdb.base/bp-permanent.exp.

> 
>  It seems to me it'll be enough if the cache is only retained over a 
> single resumption step, per thread of course, as it does not appear to me 
> that the kernel might queue more than one software breakpoint signal at 
> once.

That wouldn't work, as a new thread GDB doesn't know about yet may report
a stop for the PC where a breakpoint used to be, and then you don't
know whether you need to adjust its PC.

Remembering whether a breakpoint was inserted was what GDB used to
do, and it was because it was problematic that "swbreak" was
invented.  See:

 https://sourceware.org/ml/gdb-patches/2015-02/msg00726.html

Particularly:

 https://sourceware.org/ml/gdb-patches/2015-02/msg00730.html

This was a previous attempt that tried to preserve moribund
locations, but was still not sufficient:
 https://sourceware.org/ml/gdb-patches/2014-10/msg00781.html

I'm really hoping that at some point all archs implement
TRAP_BRKPT and the moribund locations heuristic can be removed
from gdb.

Thanks,
Pedro Alves
