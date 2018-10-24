Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2018 17:07:32 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:49244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994640AbeJXPHUBa2HU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Oct 2018 17:07:20 +0200
Received: from linux-8ccs (ip5f5adbf3.dynamic.kabel-deutschland.de [95.90.219.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C9F2207DD;
        Wed, 24 Oct 2018 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540393633;
        bh=WwOBXOwgr297l+RWsTyqJULARk5/y8fdD0bCYYLlECE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2k0TtMomizu5+xtvT3as/BmHXvNPYVS1yHuFMg/3gfpIy5LZ5xFh36I/vNQalJvS
         R5opRNXCktXi8X11V2h1uTjAjFtgBhGLJWyE0c+wG/xqigzLd979tjgIc60d9jZtMM
         +8sHAgf8/5Ru0VWPtGfcHTREjs84ZJ0X2TS3Z0KQ=
Date:   Wed, 24 Oct 2018 17:07:06 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: [PATCH RFC v3 0/3] Rlimit for module space
Message-ID: <20181024150706.jewcclhhh756tupn@linux-8ccs>
References: <20181019204723.3903-1-rick.p.edgecombe@intel.com>
 <CAKv+Gu_AgPv2o4=U0-7pnpgtSufEobnta8oKhhGfCdCxM82B5Q@mail.gmail.com>
 <6b1017c450d163539d2b974657baaaf697f0a138.camel@intel.com>
 <CAKv+Gu-Rk-SQVOQ63L3DkF3=EVik3pHXzpNp5r5TrgDajTM_iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-Rk-SQVOQ63L3DkF3=EVik3pHXzpNp5r5TrgDajTM_iQ@mail.gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.16-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Return-Path: <jeyu@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeyu@kernel.org
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

+++ Ard Biesheuvel [23/10/18 08:54 -0300]:
>On 22 October 2018 at 20:06, Edgecombe, Rick P
><rick.p.edgecombe@intel.com> wrote:
>> On Sat, 2018-10-20 at 19:20 +0200, Ard Biesheuvel wrote:
>>> Hi Rick,
>>>
>>> On 19 October 2018 at 22:47, Rick Edgecombe <rick.p.edgecombe@intel.com>
>>> wrote:
>>> > If BPF JIT is on, there is no effective limit to prevent filling the entire
>>> > module space with JITed e/BPF filters.
>>>
>>> Why do BPF filters use the module space, and does this reason apply to
>>> all architectures?
>>>
>>> On arm64, we already support loading plain modules far away from the
>>> core kernel (i.e. out of range for ordinary relative jump/calll
>>> instructions), and so I'd expect BPF to be able to deal with this
>>> already as well. So for arm64, I wonder why an ordinary vmalloc_exec()
>>> wouldn't be more appropriate.
>> AFAIK, it's like you said about relative instruction limits, but also because
>> some predictors don't predict past a certain distance. So performance as well.
>> Not sure the reasons for each arch, or if they all apply for BPF JIT. There seem
>> to be 8 by my count, that have a dedicated module space for some reason.
>>
>>> So before refactoring the module alloc/free routines to accommodate
>>> BPF, I'd like to take one step back and assess whether it wouldn't be
>>> more appropriate to have a separate bpf_alloc/free API, which could be
>>> totally separate from module alloc/free if the arch permits it.
>>>
>> I am not a BPF JIT expert unfortunately, hopefully someone more authoritative
>> will chime in. I only ran into this because I was trying to increase
>> randomization for the module space and wanted to find out how many allocations
>> needed to be supported.
>>
>> I'd guess though, that BPF JIT is just assuming that there will be some arch
>> specific constraints about where text can be placed optimally and they would
>> already be taken into account in the module space allocator.
>>
>> If there are no constraints for some arch, I'd wonder why not just update its
>> module_alloc to use the whole space available. What exactly are the constraints
>> for arm64 for normal modules?
>>
>
>Relative branches and the interactions with KAsan.
>
>We just fixed something similar in the kprobes code: it was using
>RWX-mapped module memory to store kprobed instructions, and we
>replaced that with a simple vmalloc_exec() [and code to remap it
>read-only], which was possible given that relative branches are always
>emulated by arm64 kprobes.
>
>So it depends on whether BPF code needs to be in relative branching
>range from the calling code, and whether the BPF code itself is
>emitted using relative branches into other parts of the code.
>
>> It seems fine to me for architectures to have the option of solving this a
>> different way. If potentially the rlimit ends up being the best solution for
>> some architectures though, do you think this refactor (pretty close to just a
>> name change) is that intrusive?
>>
>> I guess it could be just a BPF JIT per user limit and not touch module space,
>> but I thought the module space limit was a more general solution as that is the
>> actual limited resource.
>>
>
>I think it is wrong to conflate the two things. Limiting the number of
>BPF allocations and the limiting number of module allocations are two
>separate things, and the fact that BPF reuses module_alloc() out of
>convenience does not mean a single rlimit for both is appropriate.

Hm, I think Ard has a good point. AFAIK, and correct me if I'm wrong,
users of module_alloc() i.e. kprobes, ftrace, bpf, seem to use it
because it is an easy way to obtain executable kernel memory (and
depending on the needs of the architecture, being additionally
reachable via relative branches) during runtime. The side effect is
that all these users share the "module" memory space, even though this
memory region is not exclusively used by modules (well, personally I
think it technically should be, because seeing module_alloc() usage
outside of the module loader is kind of a misuse of the module API and
it's confusing for people who don't know the reason behind its usage
outside of the module loader).

Right now I'm not sure if it makes sense to impose a blanket limit on
all module_alloc() allocations when the real motivation behind the
rlimit is related to BPF, i.e., to stop unprivileged users from
hogging up all the vmalloc space for modules with JITed BPF filters.
So the rlimit has more to do with limiting the memory usage of BPF
filters than it has to do with modules themselves.

I think Ard's suggestion of having a separate bpf_alloc/free API makes
a lot of sense if we want to keep track of bpf-related allocations
(and then the rlimit would be enforced for those). Maybe part of the
module mapping space could be carved out for bpf filters (e.g. have
BPF_VADDR, BPF_VSIZE, etc like how we have it for modules), or
continue sharing the region but explicitly define a separate bpf_alloc
API, depending on an architecture's needs. What do people think?

Thanks,

Jessica
