Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2012 11:07:31 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:48702 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903599Ab2EWJHU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 May 2012 11:07:20 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q4N97BOL012869;
        Wed, 23 May 2012 02:07:12 -0700
Received: from [192.168.225.107] (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Wed, 23 May 2012
 02:07:07 -0700
Message-ID: <4FBCA8B9.8060604@mips.com>
Date:   Wed, 23 May 2012 17:07:05 +0800
From:   Deng-Cheng Zhu <dczhu@mips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.27) Gecko/20120216 Lightning/1.0b2 Thunderbird/3.1.19
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     John Crispin <john@phrozen.org>, <linux-mips@linux-mips.org>,
        <kevink@paralogos.com>
Subject: Re: [PATCH v2 1/2] MIPS: fix/enrich 34K APRP (APSP) functionalities
References: <1337244680-29968-1-git-send-email-dczhu@mips.com> <1337244680-29968-2-git-send-email-dczhu@mips.com> <4FB4EF81.10005@phrozen.org> <4FB60403.3080700@mips.com> <4FB68FA2.1030404@phrozen.org> <alpine.LFD.2.00.1205202231400.3701@eddie.linux-mips.org> <4FB9B52F.908@mips.com> <alpine.LFD.2.00.1205212350070.3701@eddie.linux-mips.org> <4FBB3AD2.1040802@mips.com> <alpine.LFD.2.00.1205222251580.3701@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.00.1205222251580.3701@eddie.linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: 3+Gi1o67q3ob4Ahnu8Pizg==
X-archive-position: 33435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Thanks for your detailed explanation! Please see my comments below.

On 05/23/2012 06:12 AM, Maciej W. Rozycki wrote:
> On Tue, 22 May 2012, Deng-Cheng Zhu wrote:
>
>>>    Hmm, there's nothing platform-specific there, the file is pretty generic,
>>> it could be moved to arch/mips/kernel/ or thereabouts.  That applies to
>>> <asm/mips-boards/launch.h>   too, before you ask
>>
>> Yeah, agree with you. I didn't do it simply because I'm not sure :)
>
>   I can see you've copied the whole contents over to arch/mips/kernel/vpe.c
> now.  Please don't do that.  This code is modular for a reason.  Either
> modify original code to suit your needs while preserving functionality or,
> if infeasible, copy it over to a new module selected based on
> configuration.  Common parts should be abstracted and extracted to a
> common dependency, either a shared header or another module, as
> applicable.

OK. Good advice!

>>> (you may want to use alloc_bootmem or suchlike instead of hardcoding the
>>> trampoline page, though it's probably pretty safe to assume the end of
>>> the exception handler page is available everywhere).
>>
>> I'm not quite clear about this. Do you mean to bypass the arbitrary monitor
>> in vpe_run() (in other words, to directly bring up the vpe in vpe_run())?
>> Why do we need to worry about writing to the cpulaunch data?
>
>   The location of RAM is platform-specific, CKSEG0ADDR mustn't be used to
> "allocate" kernel memory.  But as I say the exception handlers' page is
> generally pretty safe, although the addition of the CP0 EBase register to
> the architecture stopped it being guaranteed at one point.
>
>   Ultimately I think this memory should be properly allocated, but this is
> preexisting code, so there is no requirement that you fix that on this
> occasion (or at all), unless you'd really like to.

OK. I'll let it be for now.

>>>    There's nothing platform-specific referred to from arch/mips/kernel/vpe.c
>>> AFAICT (and I trust in Beth having got this piece right).  I reckon it
>>> used to work with CONFIG_MIPS_SIM too, though I could imagine the
>>> configuration got neglected a bit as it is somewhat unusual.
>>
>> Oh, When I said IRQ related stuff I meant the interrupt specific changes in
>> rtlx.c (not vpe.c) which correspond to those in malta-int.c. They are
>> there to resolve some issues (Please refer to the code changes and added
>> comments in these 2 files in PATCH #1 and #2.).
>
>   I still can't see anything platform-specific in rtlx.c (also written by
> Beth, BTW) -- it's all software interrupts that are architectural.  What
> pieces of code and comments are you specifically referring to?

I meant some interrupt specific changes in rtlx.c correspond to platform-
specific ones in malta-int.c. You may simply refer to the latter for the
issues I addressed. The changes to malta-int.c led to the platform
dependency and it seems the issues could not be tackled in generic layer.

>   Also in some places you do stuff like:
>
> #ifdef CONFIG_MIPS_CMP
> int foo(void)
> {
> [something...]
> }
> #else
> int foo(void)
> {
> [something else...]
> }
> #endif
>
> Please don't.  Again these pieces should be separate modules selected by
> configuration, e.g. rtlx.c, rtlx-mt.c and rtlx-cmp.c with the former
> holding the common stuff, and the two latters non-CMP- and CMP-specific
> pieces, respectively (assuming that they are mutually exclusive and can't
> be enabled both at a time in a single kernel binary for some reason).

Thanks, good point.

>   It may make sense to move this whole stuff to a subdirectory at one
> point.

Do you mean to move things like vpe.c, kspd.c and rtlx.c (and the proposed
-mt/-cmp variants) into a directory such as arch/mips/kernel/aprp/?


Deng-Cheng
