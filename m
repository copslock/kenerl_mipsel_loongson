Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2016 18:26:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63610 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992996AbcF3Q0IOhba8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2016 18:26:08 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5E061484CC24C;
        Thu, 30 Jun 2016 17:25:57 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 30 Jun 2016 17:26:01 +0100
Received: from [127.0.0.1] (10.100.200.219) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 30 Jun
 2016 17:26:00 +0100
Subject: Re: [RFC PATCH v3 2/2] MIPS: non-exec stack & heap when non-exec
 PT_GNU_STACK is present
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Faraz Shahbazker <Faraz.Shahbazker@imgtec.com>
References: <20160629143830.526-1-paul.burton@imgtec.com>
 <20160629143830.526-3-paul.burton@imgtec.com>
 <6D39441BF12EF246A7ABCE6654B023537E465A74@HHMAIL01.hh.imgtec.org>
 <fb77e2f2-801d-8dd5-6121-73909ebbd227@imgtec.com>
 <6D39441BF12EF246A7ABCE6654B023537E465F8E@HHMAIL01.hh.imgtec.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Raghu Gandham" <Raghu.Gandham@imgtec.com>,
        Maciej Rozycki <Maciej.Rozycki@imgtec.com>
From:   Paul Burton <paul.burton@imgtec.com>
Message-ID: <96de1cb3-7bb7-769d-e032-5bd10a3d1633@imgtec.com>
Date:   Thu, 30 Jun 2016 17:25:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <6D39441BF12EF246A7ABCE6654B023537E465F8E@HHMAIL01.hh.imgtec.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.219]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On 30/06/16 13:04, Matthew Fortune wrote:
>>> There will be some extra work on top of this to inform user-mode that
>>> no-exec-stack support is actually safe. I'm a bit fuzzy on the exact
>>> details though as I have not been directly involved for a while.
>>>
>>> https://www.sourceware.org/ml/libc-alpha/2016-01/msg00719.html
>>>
>>> Adding Faraz who worked on the user-mode side and Maciej who has been
>>> reviewing.
>>
>> Hi Matthew,
>>
>> Interesting. That glibc patch seems to imply that the kernel already
>> supports this, which isn't true. It makes use of a
>> "AV_FLAGS_MIPS_GNU_STACK" constant & says that's taken from Linux, but
>> it doesn't exist. Are you using an experimental patch for the kernel
>> side (perhaps Leonid's?). I'm not sure why you'd use AT_FLAGS for this,
>> which Linux currently unconditionally sets to 0 for all architectures.
>> Would a HWCAP bit for RIXI perhaps be more suitable?
>
> We are/were under the assumption that a pre-existing kernel will honor
> the PT_GNU_STACK marker overriding the arch specific read-implies-exec
> logic:
>
> http://lxr.free-electrons.com/source/fs/binfmt_elf.c?v=3.2#L689
> http://lxr.free-electrons.com/source/fs/exec.c?v=3.2#L703
>
> This means that if we produce tools which have PT_GNU_STACK with executable
> stack disabled then older kernels will crash as they will obey it and
> the FPU emulator will break.
>
> Is this incorrect? I.e. does today's MIPS kernel do absolutely nothing
> when PT_GNU_STACK is seen?

Hi Matthew,

No I believe what you've described there is correct, existing kernels on 
systems with RIXI will make the stack non-executable for binaries with a 
non-executable PT_GNU_STACK, and that will cause problems for the 
kernels delay slot emulation code (used by the FPU emulator & pre-MIPSr6 
emulation on MIPSr6 systems).

> The "AV_FLAGS_MIPS_GNU_STACK" is a proposal of how to handle the
> transition from a kernel that does as I describe above to one that safely
> supports no-exec-stack. I don't know if this has to be an AT_FLAGS or
> whether a HWCAP would do. I think we perhaps latched on to the idea of
> AT_FLAGS as we have used that as part of the nan2008 work but we can
> work through that detail later. The user-mode work is still very much in
> review. There is no kernel with this feature yet.

This part is probably something we need to discuss - though I suppose it 
could if needed go in after these kernel changes, just not before them. 
Having gone digging I see Maciej used AT_FLAGS in some NaN support that 
hasn't yet been submitted for merging. There was this RFC:

     https://patchwork.linux-mips.org/patch/11490/
     https://patchwork.linux-mips.org/patch/11491/
     https://patchwork.linux-mips.org/patch/11492/
     https://patchwork.linux-mips.org/patch/11493/

...but no non-RFC submission so the code isn't yet in the kernel. Right 
now AT_FLAGS is unconditionally 0 in Linux, for all architectures:

 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/binfmt_elf.c?id=v4.7-rc5#n241

Presuming it's still the plan to get this NaN code into mainline the use 
of AT_FLAGS seems less odd to me. I still think a HWCAP bit would be a 
sane alternative though as this patchset can be seen as completing 
kernel support for RIXI, so indicating that a system properly supports 
RIXI makes sense (& implies that the stack may be non-executable).

> Faraz: Did I explain that correctly?

I'd love to get your input on this too Faraz.

Thanks,
     Paul
