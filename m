Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2018 10:22:01 +0200 (CEST)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:52323
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990642AbeIRIV5nyEte (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Sep 2018 10:21:57 +0200
Received: by mail-it0-x241.google.com with SMTP id h3-v6so1986500ita.2;
        Tue, 18 Sep 2018 01:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=82vRu/g31Yh0GuR3OaliKBoHWmfp527kNQ5XHoMM4Uw=;
        b=uEUF4gGoKPijIdjAc1VLRBS0dpfUkQIHKDuWdM0RlnPM8tyBOj5BcuZxkKgwHs6DZg
         7ovezj41qTzrkWdigJou/dML/N3HsC3aGPQpt6yfd0MstMqbw2zDfRReAQszo65mrR6p
         t9pQTN8tIT/04/k7+Mf2rf/3DQz03qV0bbfqkgakJXC/zRq3E3CVeTQ0fVSiZHTAYW9P
         8LwjX/FQP9glqwPLZYAw6pR7x7TFBLnzje/SI5+mAcA6f0E7hNnK50HyPNVs4MH8OaGX
         tn01g2FiaoQp3AIPfwFk7gxKqXJTXyYj7NhzHyQZFJKxJU6GnOpJoC9flxh2RS+Y7qun
         UkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=82vRu/g31Yh0GuR3OaliKBoHWmfp527kNQ5XHoMM4Uw=;
        b=qFz6zf92p11WMxP/W8xqjbROJu2pW20ovdACZYLkJT0rp08Njq/7pqRpLXmkZdnO4x
         wxCmLeIGvQ5oHGabLcc/opHEGeo+g+IAJoGDtGhVI7sqtok0AzrLzufBKcu9qQUwW6J1
         9rON4WDEARVTTpye5ozakzqEsM096Vp8jV4gk9tOjb20uf8Y/rxYYI+Rm7V6seGXRaet
         3qjZhM7cHvKMMG4iPDttNcrovc1DKUdhWHZ6jOwRj6qx83k2qo5Uwik79CpbkkelLQJE
         PLCUWsQY8bxDjtYCwF4RuvjSd3eWn+KYcSq5I74fUKyiQZdVmrx0HYkpFCQL8NjPdC6A
         AEYA==
X-Gm-Message-State: APzg51CfT7d5d15k/1JxpNKnFHRGelqLcJu449XHR4dfaKhgrEMxHG3p
        ST1r7ZAuJUk9t6FfZwzIESEutIeuqJ3FATXRmxQ=
X-Google-Smtp-Source: ANB0VdaIVxCv7uFK8+Dv+IundCtmkT/wlNffbO2mSX7PukL7cYuY1rpYFmzVOwqZTPMgTki039vgvIUOgS+ALoalfm0=
X-Received: by 2002:a24:37d2:: with SMTP id r201-v6mr15421557itr.113.1537258911400;
 Tue, 18 Sep 2018 01:21:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1883:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 01:21:50
 -0700 (PDT)
In-Reply-To: <20180917191539.vxsv2vzqw65pbbnb@pburton-laptop>
References: <1536990690-17778-1-git-send-email-chenhc@lemote.com> <20180917191539.vxsv2vzqw65pbbnb@pburton-laptop>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Tue, 18 Sep 2018 16:21:50 +0800
X-Google-Sender-Auth: jDHr6JdwYMglRktCtVL7IROELf8
Message-ID: <CAAhV-H4e1FeoXAAmc1fNGE53q5HL=R0DHcUbRxRaJLMnVoaDqg@mail.gmail.com>
Subject: Re: [PATCH Resend] MIPS: Ensure VDSO pages mapped above STACK_TOP
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

On Tue, Sep 18, 2018 at 3:15 AM, Paul Burton <paul.burton@mips.com> wrote:
> Hi Huacai,
>
> On Sat, Sep 15, 2018 at 01:51:30PM +0800, Huacai Chen wrote:
>> Unlimited stack size (ulimit -s unlimited) causes kernel to use legacy
>> layout for applications. Thus, if VDSO isn't mapped above STACK_TOP, it
>> will be mapped at a very low address. This will probably cause an early
>> brk() failure, because the application's initial mm->brk is usually
>> below VDSO (especially when COMPAT_BRK is enabled) and there is no more
>> room to expand its heap.
>>
>> This patch reserve 4 MB space above STACK_TOP, and use the low 2 MB for
>> VDSO randomization (as a result, VDSO pages can use as much as 2 MB).
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/include/asm/processor.h |  5 +++--
>>  arch/mips/kernel/vdso.c           | 16 +++++++++++++++-
>>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> Could you give an example of a program that fails due to this?
>
> I'm able to reproduce that with ulimit -s unlimited the VDSO gets placed
> just above the heap, but the ELF interpreter & shared libraries get
> mapped nearby too so even with the VDSO moved a brk syscall would still
> presumably fail at around the same point. For example:
>
>   # ulimit -s unlimited; cat /proc/self/maps
>   00400000-004ec000 r-xp 00000000 08:00 71436      /usr/bin/coreutils
>   004fc000-004fd000 rwxp 000ec000 08:00 71436      /usr/bin/coreutils
>   004fd000-0050f000 rwxp 00000000 00:00 0
>   00cc3000-00ce4000 rwxp 00000000 00:00 0          [heap]
>   2ab75000-2ab96000 r-xp 00000000 08:00 44641      /lib/ld-linux-mipsn8.so.1
>   2ab96000-2ab98000 r--p 00000000 00:00 0          [vvar]
>   2ab98000-2ab99000 r-xp 00000000 00:00 0          [vdso]
>   2ab99000-2ab9d000 rwxp 00000000 00:00 0
>   2aba5000-2aba6000 r-xp 00020000 08:00 44641      /lib/ld-linux-mipsn8.so.1
>   2aba6000-2aba7000 rwxp 00021000 08:00 44641      /lib/ld-linux-mipsn8.so.1
>   2aba7000-2ad18000 r-xp 00000000 08:00 477163     /usr/lib/libcrypto.so.1.0.0
>   2ad18000-2ad27000 ---p 00171000 08:00 477163     /usr/lib/libcrypto.so.1.0.0
>   ...
>
> Are you running something statically linked to avoid that?
Yes, I use a statically linked binary, so heap expanding is only
affected by VDSO, but not by ld.so. However, in the legacy layout
case, both VDSO and ld.so are mapped begin with TASK_UNMAPPED_BASE
(0x2AAAB000), so a dynamically linked binary's heap will not probablly
hit VDSO/ld.so (because dynamically linked binaries are small).

>
> Apart from that I'm not keen on unconditionally taking away 4MB of
> address space. For o32 programs we already only have 2GB of user address
> space & it's not unheard of for programs to bump up against that limit,
> so reducing it further would need to be a last resort. If we did need to
> move VDSO to the top of the user address space we can do that with a
> hint to get_unmapped_area() without changing STACK_TOP.
The task stack is allocated very early, if without changing STACK_TOP,
get_unmapped_area() cannot assure that VDSO is above stack.

Huacai

>
> Thanks,
>     Paul
