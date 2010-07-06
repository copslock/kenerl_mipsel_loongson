Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2010 13:18:11 +0200 (CEST)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:41988 "EHLO
        tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491791Ab0GFLSH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jul 2010 13:18:07 +0200
Received: from mailgate3.nec.co.jp ([10.7.69.195])
        by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o66BI0if011071;
        Tue, 6 Jul 2010 20:18:00 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
        id o66BI0t17158; Tue, 6 Jul 2010 20:18:00 +0900 (JST)
Received: from relay51.aps.necel.com ([10.29.19.60]) by vgate01.nec.co.jp (8.11.7/3.7W-MAILSV-NEC) with ESMTP
        id o66BHx414172; Tue, 6 Jul 2010 20:17:59 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.36] [10.29.19.36]) by relay51.aps.necel.com with ESMTP; Tue, 6 Jul 2010 20:17:59 +0900
Received: from [10.114.180.181] ([10.114.180.181] [10.114.180.181]) by mbox02.aps.necel.com with ESMTP; Tue, 6 Jul 2010 20:17:59 +0900
Message-ID: <4C3310CD.2090309@renesas.com>
Date:   Tue, 06 Jul 2010 20:17:33 +0900
From:   Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.4) Gecko/20100608 Lightning/1.0b2 Thunderbird/3.1
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Shinya Kuribayashi <skuribay@pobox.com>,
        David VomLehn <dvomlehn@cisco.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: PowerTV: Use fls() carefully where static optimization
 is required
References: <4C2755A3.3080600@pobox.com> <20100630220124.GA576@dvomlehn-lnx2.corp.sa.net> <4C2DF427.7080508@pobox.com> <20100702213219.GA390@dvomlehn-lnx2.corp.sa.net> <4C2F49D0.60200@pobox.com> <alpine.LFD.2.00.1007031748350.11778@eddie.linux-mips.org> <4C312860.3020005@renesas.com> <alpine.LFD.2.00.1007050214210.11778@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.00.1007050214210.11778@eddie.linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi.px@renesas.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi.px@renesas.com
Precedence: bulk
X-list: linux-mips

On 7/5/2010 10:35 PM, Maciej W. Rozycki wrote:
>  Well, <asm/mach-malta/cpu-feature-overrides.h> seems to be getting this 
> right.  MIPS IV options are not included as quite rare compared to 
> MIPS32/64 ones and run-time determined defaults apply.  For MIPS32/64 
> configurations compile-time optimisations work as usually.

Good catch, I missed that point.  Then CONFIG_CPU_32/64 used at
irq_ffs() can be replaced with cpu_has_clo_clz without problems.
(eell-designed, anyway)

>>>  It might be simpler just to use __builtin_ffs() for this variant though.  
>>> Inline assembly is better avoided unless absolutely required.  Not even 
>>> mentioning readability.
>>
>> Hm.  It might be simpler, but it's not the purpose of irq_ffs(), IMHO.
> 
>  My point is whenever cpu_has_clo_clz is hardcoded to 1 GCC will expand 
> __builtin_ffs() to CLZ as expected and may potentially be able to optimise 
> it further.  For the fallback path I agree you do not want to use 
> __builtin_ffs() as you want to save processing time of the unneeded bits 

Got it.  I was too lazy, thanks for kind clarification.

As for __builtin_ffs(), in addition to Ralf's comments on GCC
versions, I was thinkg about two things:

1) Can we really get irq_ffs() optimized using __builtin_ffs/fls()?

  __builtin_ffs/fls() will emit CLZ if available, that's fine.
  But we don't want ffs/fls itself here.

  First, contrary to its name, current irq_ffs() implementation
  is very similar to __fls().  It's like a super-subset of __fls()
  only menat for CP0.Status check.  And ffs is basically achieved
  by fls(word & -word).  So __builtin_ffs/fls() could never be
  smaller than current irq_ffs().

  irq_ffs() < __fls() < __fls(w & -w) == __ffs()    # <asm/bitops.h>

  Consequently we can't obtain smaller irq_ffs() using
  __builtin_ffs/fls().

  IIUC, current form of irq_ffs() will be useful in the future.

2) How cpu_has_clo_clz should be handled in the kernel

  This is not limited to cpu_has_clo_clz, but more general issue.
  Using __builtin_foo features allow us to get a variety of GCC
  services, optimizations.  But also means that, it increases
  dependency on the GCC, strictly speaking, dependency on processor
  specifiers (-march=).

  For instance, when cpu_has_clo_clz is specified, we'd like to make
  it to the assembler CLZ, even if it's not supported.  Or we should
  not do that?

  This is already pointed out from Maciej in the previous comment:

  > ".set mips32" looks dodgy here.  For pre-MIPS32/64 platforms this 
  > code should never make it to the assembler and if it did, then a 
  > build-time error is better than a run-time problem.

  I know there's not always one answer, everything should be handled
  on a case by case basis.  I'm just wondering about such things for
  a while (no need to reply)

> -- there's no 8-bit FFS intrinsic let alone a 4-bit one (I'm assuming 
> there is a reason this piece of code does not check lower 4 interrupt 
> inputs).

Failed to understand what you say (sorry!), but as far as I examined
irq_ffs(), it returns from 7 to 0.  Perhaps the following "bits 12..15"
could be replaced with "bits 8..15"?  Or am I missing something?

> /*
>  * Version of ffs that only looks at bits 12..15.
>  */


Once things become clear (for me), I'll make a patchset incorporating
cpu-feature-overrieds.h against PowerTV (with David's SOB of course).
-- 
Shinya Kuribayashi
Renesas Electronics
