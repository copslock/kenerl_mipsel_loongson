Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2018 23:20:16 +0100 (CET)
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37073 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992824AbeKFWT2BvK4T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2018 23:19:28 +0100
Received: by mail-vs1-f68.google.com with SMTP id h18so8327795vsj.4
        for <linux-mips@linux-mips.org>; Tue, 06 Nov 2018 14:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQqBvSf2K+0TeJcISEsQOASNwwNH/SfmS+R8MJdBLMo=;
        b=YZynh53xyKDVyCkHTacQlc5CBo5Iykvj1jR5xQeB447MNQG4bFcWDb9FpgLIBdqNNw
         L2EbkU9qD8s1iaNP+o57Cwa2987Tajqb9aghFHhMMUfROTX0X7OOsS8H8JJ/ygLKsXbV
         GcjiGO59EhHxaHRHjfJdjHTgLPuLy2kvAa7L65Gd0ONzSqcmyuG+vEP1FuVgvOaqOQho
         szI2hovfogYyLPeqsoTopRM+unbUXmdN1XJevnR+66hVVSR/S3amo0qb4OgRfKJozymc
         rfT2EsVnQ7TfTGH9O8EvbXV5l6QKE0wrnvucFdYT8WRUg2oqvdsvqBuywtco5JrgZrgq
         Q0tg==
X-Gm-Message-State: AGRZ1gKC6Dl4V7d/Kbkt8BCbiJxEhvjTaQ9kUowLKsAULG8gTpj5u1UK
        sQdOjxQalecqJpRwiAKUkoAD5S4jF/SQTtWBzf4=
X-Google-Smtp-Source: AJdET5d//gNbsRFPyV2otQsL4wBpytotw6ctYjhuVEQMpgM3OhHZPbiEzN1eBsWflm6kpKh1rawVckku9NHvWC4qF1Y=
X-Received: by 2002:a67:c202:: with SMTP id i2mr10962178vsj.11.1541542767169;
 Tue, 06 Nov 2018 14:19:27 -0800 (PST)
MIME-Version: 1.0
References: <20181106214416.11342-1-geert@linux-m68k.org> <20181106225829.5ecbe19e@bbrezillon>
In-Reply-To: <20181106225829.5ecbe19e@bbrezillon>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Nov 2018 23:19:14 +0100
Message-ID: <CAMuHMdUQhsikcBzRFAvrCwZwzFK_Coh=fqpSihFP6jEtugCMQw@mail.gmail.com>
Subject: Re: [PATCH next] mtd: maps: physmap: Fix infinite loop crash in ROM
 type probing
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linus Walleij <linus.walleij@linaro.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67107
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

Hi Boris,

On Tue, Nov 6, 2018 at 10:58 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Tue,  6 Nov 2018 22:44:16 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Toshiba RBTX4927, where map_probe is supposed to fail:
> >
> >     Creating 2 MTD partitions on "physmap-flash.0":
> >     0x000000c00000-0x000001000000 : "boot"
> >     0x000000000000-0x000000c00000 : "user"
> >     physmap-flash physmap-flash.1: physmap platform flash device: [mem 0x1e000000-0x1effffff]
> >     CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 80320f40, ra == 80321004
> >     ...
> >     Call Trace:
> >     [<80320f40>] get_mtd_chip_driver+0x30/0x8c
> >     [<80321004>] do_map_probe+0x20/0x90
> >     [<80328448>] physmap_flash_probe+0x484/0x4ec
> >
> > The access to rom_probe_types[] was changed from a sentinel-based loop
> > to an infinite loop, causing a crash when reaching the sentinel.
>
> Oops. Do you mind if I fix that in-place (squash your changes in
> Ricardo's original commit)?

No problem. Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
