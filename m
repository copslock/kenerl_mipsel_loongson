Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 03:33:28 +0200 (CEST)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:33449
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeIFBdXRAZfP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Sep 2018 03:33:23 +0200
Received: by mail-it0-x241.google.com with SMTP id j198-v6so18406475ita.0;
        Wed, 05 Sep 2018 18:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KM7hZ4BvFc++RQiO+b4wexlVqjL6bE7SclX/BJsaGBM=;
        b=KqKbzyDouOYr5IgCzgsZuB28PEdXFLD6ycm4uOp+2MhztCGR8Mdr4yztYKRbdr6NCA
         O2HE7nAmclJBHbUBSEYn76sZSkVEI86FOY+FdyVrPkwgmdhTTKujLILchD2KkBLjBJHO
         /rgORyyWbYMMRCRqy8GRfaDvMwQijfFzdDJR7d1KPBVxJsockP27fJINJosJtIQ41h5L
         HfqMrsTfd4EF7OjqjTwZneRyrA0vr4GAR9eHAu2QvxZpYzdoMuN9dri2DyXyQ6bInR/w
         XVbJ0lmtOKPd99QasG5MZqIsxN57B8d3v0/Ptmf/9xcv2BfbkmW3cxW+S/yLBlOTvtjn
         cXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KM7hZ4BvFc++RQiO+b4wexlVqjL6bE7SclX/BJsaGBM=;
        b=noEmsIi0lspcOZsu+FVvWOpOaW3TuhH1kio2ojuJjNKuR/8//KY0FWt/VnmRHDjBqM
         eaxEyfTKR+6r9JmLx0PFbjYGzbPifKzTqIQ8/PDiI+wqapiYmz3K5T8X2m48Y5K58H2p
         1cj8M5hNhO2cqBfm9I/btYkIWZ9XfcIaT7pIV0EQRjdHyQbfygh3J+wElxSbM+yVavjB
         HPpsKSRW2QV6rnicNWbflWGugqS6u9ptFfH4J5g3fRnxQEtj++NSMzq1KLBnUFg9q9T8
         1+CBe7JcoRaAzfIGk7jY3FriDrsC+jKrkyL1PcTNGCsig1On8pnqPLAihabEkJZ5QRMo
         vv9A==
X-Gm-Message-State: APzg51BFu/+SATM5Laf9YbF2hT07ckxK5TTSUXc3QGI2n4nc40vI3m2T
        LZLjFN9aVtFjPjINemEEYajQliXmfpn8wNPEbWM=
X-Google-Smtp-Source: ANB0Vdb+6tKAWRHzxFwMf8wjD4okQ9pHao0WMZDob6QG/4oopujzLlQcML4Dn57VHvp6hS0+3TqJjoouJrlxJT2p7O0=
X-Received: by 2002:a24:19d5:: with SMTP id b204-v6mr943016itb.25.1536197597013;
 Wed, 05 Sep 2018 18:33:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:988f:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 18:33:15 -0700 (PDT)
In-Reply-To: <20180905165438.cqdr5cq36pbujtjc@pburton-laptop>
References: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
 <1536139990-11665-2-git-send-email-chenhc@lemote.com> <20180905165438.cqdr5cq36pbujtjc@pburton-laptop>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Thu, 6 Sep 2018 09:33:15 +0800
X-Google-Sender-Auth: Qpj7EaeVkZ7RUKNYvp5bU_NnQj4
Message-ID: <CAAhV-H7vuFKK+H77EnF0P2ae50FMo0DeUniBLoTcagn4xO0QnA@mail.gmail.com>
Subject: Re: [PATCH V4 01/10] MIPS: Loongson-3: Enable Store Fill Buffer at runtime
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
X-archive-position: 65999
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

On Thu, Sep 6, 2018 at 12:54 AM, Paul Burton <paul.burton@mips.com> wrote:
> Hi Huacai,
>
> On Wed, Sep 05, 2018 at 05:33:01PM +0800, Huacai Chen wrote:
>> New Loongson-3 (Loongson-3A R2, Loongson-3A R3, and newer) has SFB
>> (Store Fill Buffer) which can improve the performance of memory access.
>> Now, SFB enablement is controlled by CONFIG_LOONGSON3_ENHANCEMENT, and
>> the generic kernel has no benefit from SFB (even it is running on a new
>> Loongson-3 machine). With this patch, we can enable SFB at runtime by
>> detecting the CPU type (the expense is war_io_reorder_wmb() will always
>> be a 'sync', which will hurt the performance of old Loongson-3).
>
> This looks unchanged since v3, and I didn't see a response to my email
> here:
>
>     https://marc.info/?l=linux-mips&m=153248530725061&w=2
>
> I still haven't seen any explanation for why you can't just do this as a
> one-liner in C, the same way we enable tons of other CPU features during
> cpu_probe().
>
> I'm not saying I'll never accept the assembly version, but I want an
> explanation for why it's necessary first. If that's not something you
> can give, at least describe in the commit message what goes wrong when
> you try to do it in C as justification for not doing it that way.
In practise, I found that sometimes there are boot failures if I
enable SFB/LPA in cpu_probe(). I don't know why because processorr
designers also haven't give me an explaination, but I think this may
have some relationships to speculative execution.

Huacai

>
> Thanks,
>     Paul
