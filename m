Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2018 12:30:16 +0100 (CET)
Received: from mail-vk0-x243.google.com ([IPv6:2607:f8b0:400c:c05::243]:37547
        "EHLO mail-vk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992781AbeAWLaJcUIMy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Jan 2018 12:30:09 +0100
Received: by mail-vk0-x243.google.com with SMTP id g83so84455vki.4;
        Tue, 23 Jan 2018 03:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=iG+J32n2Upy+N9hS1I+V7cSzYlZHtlZlQVSYTW9SRZQ=;
        b=hQSr//eSYFa31l+0k3gbxCJHog+0fJCFyzlcX20XbgJ0p7vVTaKyH+eQ3tGjbrrVKt
         EG24uQRDfQeigslfa80/pJg8LqlQTmG+f99Ov9PySdlYhp21RfGLwycnNtYyqm+hSBdl
         5pk3sJle0jQCXhari21rGiVItEl4GVCXouCpupl9c3ZHtNO60e/20wL6HfBrKDKL4CYs
         XAYTTpvOAXp6Jr2eCemxNkwzMxcLYilj0lXgbZcW8B20iICtf3aJgzOkuCZsJLOmke62
         Wwd6WMz5z9OSzLfxjky9vD7n4RaihDQtRy+Vlqy+vjAle2S7nSAEoy+RthnbVqx76Fvv
         YRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=iG+J32n2Upy+N9hS1I+V7cSzYlZHtlZlQVSYTW9SRZQ=;
        b=B+9PGT0y8bNahEaCw/RzTHvWKwNWxyoO25Hho9W8V+dv2bBRrLDEURFlhU6skpucpv
         PsJev0NQN+AG6lg857BuSsz2SKldBjR8Kuynqe+ZgG7EUn7pmNpteb+8Z25vgFHzvbt3
         iLVyeN+ljEI5aAUicDHD6JHhMfTPDVac5th3mfPGLw0OapdCCWQRtx40XVLTqYYUqmkz
         5mE8wo9qFrcMi7sYo3zCqEB1c5hCknXlTdg3Nyr2dL+wafXIoV1AUwttvgspaxfOI4Pk
         hV61bQEOKeG081G9kXmVLEbmHrYoy14fXkNf5BPLn3e3o44sU8bO5xilnqwZ50jG86iw
         vOjg==
X-Gm-Message-State: AKwxytdxAM8d9I2YB0hjSrgcs7tp+r7x19FzA80oz0jfAiQJcgx/v6J2
        4yfZ4br23dh3xaOpEzTHVqP00FBPYKhIhQoJhdI=
X-Google-Smtp-Source: AH8x224iS9RGAwpIapY117o5Wlj1NLvTqdBzgX2dV+x/cigFmQSFjGuXP/cA1/V16ajMszdslF3C6CKkmXYdu5d1/K0=
X-Received: by 10.31.96.196 with SMTP id u187mr1472047vkb.75.1516707003019;
 Tue, 23 Jan 2018 03:30:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.78.22 with HTTP; Tue, 23 Jan 2018 03:29:42 -0800 (PST)
In-Reply-To: <2fd1f530-e6c6-a528-5827-c3ecc8b4a81c@mips.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com> <2fd1f530-e6c6-a528-5827-c3ecc8b4a81c@mips.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 23 Jan 2018 12:29:42 +0100
X-Google-Sender-Auth: Zwaperx3-y--ypKcdUjRZo83Qyg
Message-ID: <CA+7wUszvJfqCfii59zppSbkGsVNyLDM2Jk8F3zrzr_NJxvFsWw@mail.gmail.com>
Subject: Re: [PATCH 00/14] MIPS: memblock: Switch arch code to NO_BOOTMEM
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        James Hogan <jhogan@kernel.org>, goran.ferenc@mips.com,
        David Daney <david.daney@cavium.com>,
        paul.gortmaker@windriver.com, Paul Burton <paul.burton@mips.com>,
        alex.belits@cavium.com, Steven.Hill@cavium.com,
        alexander.sverdlin@nokia.com, kumba@gentoo.org,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        James Hogan <James.hogan@mips.com>,
        Peter Wotton <Peter.Wotton@mips.com>,
        Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Hi Matt,

On Mon, Jan 22, 2018 at 5:36 PM, Matt Redfearn <matt.redfearn@mips.com> wrote:
>
> Hi Serge,
>
>
> On 17/01/18 22:22, Serge Semin wrote:
>>
>> Even though it's common to see the architecture code using both
>> bootmem and memblock early memory allocators, it's not good for
>> multiple reasons. First of all, it's redundant to have two
>> early memory allocator while one would be more than enough from
>> functionality and stability points of view. Secondly, some new
>> features introduced in the kernel utilize the methods of the most
>> modern allocator ignoring the older one. It means the architecture
>> code must keep the both subsystems up synchronized with information
>> about memory regions and reservations, which leads to the code
>> complexity increase, that obviously increases bugs probability.
>> Finally it's better to keep all the architectures code unified for
>> better readability and code simplification. All these reasons lead
>> to one conclusion - arch code should use just one memory allocator,
>> which is supposed to be memblock as the most modern and already
>> utilized by the most of the kernel platforms. This patchset is
>> mostly about it.
>>
>> One more reason why the MIPS arch code should finally move to
>> memblock is a BUG somewhere in the initialization process, when
>> CMA is activated:
>>
>> [    0.248762] BUG: Bad page state in process swapper/0  pfn:01f93
>> [    0.255415] page:8205b0ac count:0 mapcount:-127 mapping:  (null) index:0x1
>> [    0.263172] flags: 0x40000000()
>> [    0.266723] page dumped because: nonzero mapcount
>> [    0.272049] Modules linked in:
>> [    0.275511] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.88-module #5
>> [    0.282900] Stack : 00000000 00000000 80b6dd6a 0000003a 00000000 00000000 80930000 8092bff4
>>            86073a14 80ac88c7 809f21ac 00000000 00000001 80b6998c 00000400 00000000
>>            80a00000 801822e8 80b6dd68 00000000 00000002 00000000 809f8024 86077ccc
>>            80b80000 801e9328 809fcbc0 00000000 00000400 00010000 86077ccc 86073a14
>>            00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>            ...
>> [    0.323148] Call Trace:
>> [    0.325935] [<8010e7c4>] show_stack+0x8c/0xa8
>> [    0.330859] [<80404814>] dump_stack+0xd4/0x110
>> [    0.335879] [<801f0bc0>] bad_page+0xfc/0x14c
>> [    0.340710] [<801f0e04>] free_pages_prepare+0x1f4/0x330
>> [    0.346632] [<801f36c4>] __free_pages_ok+0x2c/0x104
>> [    0.352154] [<80b23a40>] init_cma_reserved_pageblock+0x5c/0x74
>> [    0.358761] [<80b29390>] cma_init_reserved_areas+0x1b4/0x240
>> [    0.365170] [<8010058c>] do_one_initcall+0xe8/0x27c
>> [    0.370697] [<80b14e60>] kernel_init_freeable+0x200/0x2c4
>> [    0.376828] [<808faca4>] kernel_init+0x14/0x104
>> [    0.381939] [<80107598>] ret_from_kernel_thread+0x14/0x1c
>>
>> The bugus pfn seems to be the one allocated for bootmem allocator
>> pages and hasn't been freed before letting the CMA working with its
>> areas. Anyway the bug is solved by this patchset.
>>
>> Another reason why this patchset is useful is that it fixes the fdt
>> reserved-memory nodes functionality for MIPS. Really it's bug to have
>> the fdt reserved nodes scanning before the memblock is
>> fully initialized (calling early_init_fdt_scan_reserved_mem before
>> bootmem_init is called). Additionally no-map flag of the
>> reserved-memory node hasn't been taking into account. This patchset
>> fixes all of these.
>>
>> As you probably remember I already did another attempt to merge a
>> similar functionality into the kernel. This time the patchset got
>> to be less complex (14 patches vs 21 last time) and fixes the
>> platform code like SGI IP27 and Loongson3, which due to being
>> NUMA introduce its own memory initialization process. Although
>> I have much doubt in SGI IP27 code operability in the first place,
>> since it got prom_meminit() method of early memory initialization,
>> which hasn't been called at any other place in the kernel. It must
>> have been left there unrenamed after arch/mips/mips-boards/generic
>> code had been discarded.
>>
>> Here are the list of folks, who agreed to perform some tests of
>> the patchset:
>> Alexander Sverdlin <alexander.sverdlin@nokia.com> - Octeon2
>> Matt Redfearn <matt.redfearn@mips.com> - Loongson3, etc
>
>
>
> I have applied and tested these patches on various platforms that we have available here, and the kernel appears to boot and get to userspace as normal on the following platforms:
>
> UTM8 (Cavium Octeon III)
> Creator CI20

A bit off-topic, but could you please Acked one of Marcin's patch that
I re-submitted:

https://patchwork.linux-mips.org/patch/17986/

I believe CI20 wont boot from upstream kernel, since you are testing
patch I am guessing you have a running system (unless of course you
tweaked your u-boot env vars or use another different patch).

Thanks for your help
