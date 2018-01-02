Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 11:22:49 +0100 (CET)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:46472
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992368AbeABKWmt6RYu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 11:22:42 +0100
Received: by mail-qk0-x241.google.com with SMTP id b132so30872212qkc.13
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 02:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DupaeiNXsDWygiRVgtfsKPUINeaJaV348XGOK9lsg80=;
        b=lCk9wujKfZymYa7JqYtJXtn2/ROYLa/vzw2Okj5z+vUnEEsITFufJ1lwwfIkj3A2YC
         K8++Du8YII+O5w3D4VeU62pmXJejEZND/rQ5mqNkU/X8YoT1y5/JgKF9hqaBXFXeb9c1
         b66Qr5iB8ZDH/Y9WMVq/I3DBRzExUUhvPSXY4yv+Jtzf+jyqjrKFdHoH7Hnkmr+sDktL
         FltAdE4sHBWGAyJ2Dew1ACkDBrbZuV2Fl60t4skSGcJ97Wt98miLsNx+u9GzIABzDrOv
         Bj4VyZD1lKqjUj2EG0VehXHac86unszodSAxbe6DUYol+NQO9HrSKC5uI0IKEzd4KpjI
         4ZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DupaeiNXsDWygiRVgtfsKPUINeaJaV348XGOK9lsg80=;
        b=fKRvV6bYKpTvbyfz4QUNjm8/0nFnWLPISg1UPRRALf5TgZ9V02EcIEe8hXcG+sOZVH
         fuYEpSt5Q+RZP5Bfmw5zAjNzr/BQWyuPG4nvXK6m00ewBgWCF6VIZq3v7vT4l96Ej0bh
         NdWNs9Q54knKdofiR8rKnFqE5nMJIJdPb6QpEEhO3sbT5AfsmbMZkh9pXiHjZhXD67tn
         uNouKti95DlA1YHgRJlB0/f8Net28timUlDj7J0Lwkr3jOoycBAJqfwBmyqtXg9/9AAC
         /Y/M3LjlI5wFH4VaNcJyO3VpuQF4XxqYpkdVvT3JVev/cjPYIk+uOPtyAjn5306lDbtI
         em6w==
X-Gm-Message-State: AKGB3mJNgx2w5jx2Kz5sGxsJfoGAFTbzr5nGgF7WOtNrV/cycAW1blKY
        UQiIG3D4Ou2Kf5CpFf5gXvCdrHZtpdTyQXTLrA8=
X-Google-Smtp-Source: ACJfBotpUn04/iPHRmqXRSAZsei+qXeww2+evIQPQqX9pZWkSC+cn8CI1RCizr+dMgmSftgyTZq2OI1MLeWI2jEYTIk=
X-Received: by 10.55.99.140 with SMTP id x134mr46992825qkb.35.1514888556259;
 Tue, 02 Jan 2018 02:22:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.44.66 with HTTP; Tue, 2 Jan 2018 02:22:35 -0800 (PST)
In-Reply-To: <878tdgtwzp.fsf@concordia.ellerman.id.au>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-17-hch@lst.de>
 <878tdgtwzp.fsf@concordia.ellerman.id.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Jan 2018 11:22:35 +0100
X-Google-Sender-Auth: bAs4gokVWCk_l9xeOiP8R7Xf4Lg
Message-ID: <CAMuHMdWWus2kNSOzS94k-3678826W1YjKwCWTquu3hBLZ80cvw@mail.gmail.com>
Subject: Re: [PATCH 16/67] powerpc: rename dma_direct_ to dma_nommu_
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        patches@groups.riscv.org,
        "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Cris <linux-cris-kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Tue, Jan 2, 2018 at 10:45 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Christoph Hellwig <hch@lst.de> writes:
>
>> We want to use the dma_direct_ namespace for a generic implementation,
>> so rename powerpc to the second best choice: dma_nommu_.
>
> I'm not a fan of "nommu". Some of the users of direct ops *are* using an
> IOMMU, they're just setting up a 1:1 mapping once at init time, rather
> than mapping dynamically.
>
> Though I don't have a good idea for a better name, maybe "1to1",
> "linear", "premapped" ?

"identity"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
