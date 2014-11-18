Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2014 04:56:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27783 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007304AbaKRD4bZmYQl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Nov 2014 04:56:31 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A555C52157C28;
        Tue, 18 Nov 2014 03:56:23 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 18 Nov
 2014 03:56:24 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by klmail02.kl.imgtec.org
 (10.40.60.222) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 18 Nov
 2014 03:56:24 +0000
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 17 Nov
 2014 19:56:22 -0800
Message-ID: <546AC366.1070304@imgtec.com>
Date:   Mon, 17 Nov 2014 19:56:22 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@codesourcery.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: MIPS: c-r4k.c: Fix the 74K D-cache alias erratum workaround
References: <546A56C9.4060608@imgtec.com> <alpine.DEB.1.10.1411172321110.2881@tp.orcam.me.uk> <546A8EB3.3040504@imgtec.com> <alpine.DEB.1.10.1411180039100.2881@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.1.10.1411180039100.2881@tp.orcam.me.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 11/17/2014 05:16 PM, Maciej W. Rozycki wrote:
> On Tue, 18 Nov 2014, Leonid Yegoshin wrote:
>
>>>    I repeat, there is no use in the current kernel of the MIPS_CACHE_VTAG
>>> flag for the D-cache, there's no single piece of code throughout the
>>> kernel that would check the presence of this flag once it has been set
>>> and this erratum workaround piece is the only place where the flag is
>>> set for the D-cache.  The flag is completely ignored for the D-cache and
>>> the only existing uses of this flag are for the I-cache.
>> Please look into http://patchwork.linux-mips.org/patch/8459/
>> Look into cpu_has_vtag_dcache usage.
>> It is a second or 2rd (or 3rd etc) attempt to put using of that information
>> upstream for last 1.5 year.
>   That doesn't appear to have anything to do with ptrace(2) and
> cache-coherency issues seen around software breakpoints, and the buggy
> 74K is the only system of all that we have that shows that problem.  And
> the problem goes away with my fix.  So perhaps MIPS_CACHE_ALIASES is
> actually needed here, or maybe a more lightweight alternative fix, but
> an item that addresses HIGHMEM support is clearly irrelevant.

Again, the 74K errata has deal only if there is two mappings and one of 
that mappings switches to the same physaddr. In other words - TLB change 
is needed (some another conditions are also needed). It has nothing with 
generic cache aliasing. Switching ON cache aliasing support just masks 
the issue behind massive cache flushes.

If you have problem with ptrace(2) then it points to incorrect result of 
copy_to_user_page(), and most probably - with kmap() work. That HIGHMEM 
patch there takes care about address aliasings, so I assumed I took that 
case into account too but something may changes. I think it has sense to 
put the check of cpu_has_vtag_dcache in copy_to_user_page() - it 
definitely will enforce cache flashing after ptrace() write aka 
__access_remote_vm(..., true) and it doesn't harm the rest of system. 
And retest.

But it is needed to do after http://patchwork.linux-mips.org/patch/8459/ 
fix, without it it is futile.

>   This is easily reproduced by running the GDB test suite, I'd have to
> double-check old logs from before my fix, but it may be more prominent
> with MIPS16 code for some reason.  So I suggest that you run the GDB
> test suite, for the MIPS16 multilib and on the upstream kernel as it is,
> on a good and a bad 74K processor and compare results, and then see if
> any of your outstanding fixes makes any changes.
>
>   The symptoms are either spurious SIGTRAP signals delivered (if a stale
> breakpoint remaining in the I-cache was hit) or breakpoint misses (if a
> stale original instruction remaining in the I-cache was executed).
> Please note that these failures are not extensive, there'll be a couple
> across the whole test suite run (several thousands tests) -- it's not
> like software breakpoints are unusable.
>
>>>    Leonid, I spent several hours chasing cache coherency issues util I
>>> realised the workaround in its current form does not do anything, so
>>> unless you propose an alternative fix, this change is the only way known
>>> to bring systems affected to sanity.
>> You may ask me, I work last 3 years in MIPS (now IMG) on it and did a most of
>> coherency fixes all that time.
>   Well, I-cache coherency issues around ptrace(2), specifically the
> PTRACE_POKETEXT request, appear to persist -- how often do you verify
> your code by getting the GDB test suite run on it (e.g. by your
> toolchain team)?  Which so far is I believe the best way to trigger any
> I-cache coherency issues there, and I remember still seeing issues with
> software breakpoints in heavily threaded code across all processors I
> could check with (and GDB's Remote Serial Protocol logs indicated they
> were correctly propagated down to ptrace(2), so it was all up to the
> kernel to sort out), at least a 24Kc, a 74Kc and an M14Kc.
>
>   Please note that I test using gdbserver with GDB connecting remotely
> from another system, I don't normally run native testing on these
> boards, they are too weak for that.  It is an important detail as native
> testing implies much higher cache pressure (gdbserver is a lightweight
> agent while GDB itself is a large blob) where incoherent cache lines are
> much more likely to cure by themselves in the course of line replacement
> on cache fills.

Excuse me, I need more detailed instructions "how to", I am not GDB guru.

- Leonid Yegoshin.

>
>    Maciej
