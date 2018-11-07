Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2018 08:34:56 +0100 (CET)
Received: from mail-lf1-x141.google.com ([IPv6:2a00:1450:4864:20::141]:40749
        "EHLO mail-lf1-x141.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990946AbeKGHePEuw7Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2018 08:34:15 +0100
Received: by mail-lf1-x141.google.com with SMTP id v5so5758735lfe.7
        for <linux-mips@linux-mips.org>; Tue, 06 Nov 2018 23:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eY3o894jFxAVpG3/rNrs3uyCqKXzBiAUwje6kIKndYM=;
        b=R6Y2TajZLWd2azMEqm5S30HFk3GQJlbShJSGHXgx4D82LuufxtElvfPMALbb93Nu8x
         fZK3shu1VEPdUHKVr8PRoV3k9FQzfGDm9PEnDDTM6jwAeVXZLcs5kw8sNBMDyr0Sf41t
         jK6Yz6ejmD4xxGV73E4UVG6PqQRq3MplW96jKsrJmIydsIzUG/4oFysFkSeV8iQhhuUO
         ZMTXgn6LHnT90Jq/hc/X5Y0uKFuug6tN6Cda5/AVPaMsAmCA7yXJ7zcewhYR7MnAUJm1
         CEymj2puzhvCg7RLWD2C90DreW0ltTt2D18yMoY/i1kRyq5k9VOiD1Ya72qfv5nCFcpW
         tX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eY3o894jFxAVpG3/rNrs3uyCqKXzBiAUwje6kIKndYM=;
        b=fJ1Dy/mCAx4t7GQ68pxs3b4/YQbJ/GD55Q2wBT/lJRbRxLoew6kK/6oh7xRJnI0oWZ
         Je/GHdoL0leDsNT9siZf0hScWihAHlAhYt5jAbXISd0QpI56izlpNCtZ1GS5Y7WP/7vj
         5uBJ3BXC3Sax1OG5F4YVn4+A8bdFTAHuYKVWHakHdszdMvYvMpWMO0+VsNN+CM7ax/aL
         DTbdvOLZm1y7TWhoLuauXJm35bUCsP3Jsey8i7VCOFlGU35U2LHvpMX/NZVk82VXA1Rn
         SBLt39TGTIuYjXRMm99ec1jfwANtQBaVNNdWdYqD3kVbBRDjCxOU7L5m2lT8OuS7IQab
         q9MA==
X-Gm-Message-State: AGRZ1gIhdEkttgIp9M14rlUEPTww0Y3wBCsD+sD8FyUK0Rk/nZD74Vzn
        9q8JU3/UAmim5oBGt6ttAW8uq6iU4ItPwEaytdA=
X-Google-Smtp-Source: AJdET5cqQMKwcP6/O4motqPz1HPHsBwxKn+sokHsRnH2+5s7FXN0NhF/ooIKMyTFOvzSITALcaZqQ/lB9xbXho5YVGY=
X-Received: by 2002:a19:7019:: with SMTP id h25-v6mr479554lfc.147.1541576054326;
 Tue, 06 Nov 2018 23:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20181106214416.11342-1-geert@linux-m68k.org> <20181106225829.5ecbe19e@bbrezillon>
 <CAMuHMdUQhsikcBzRFAvrCwZwzFK_Coh=fqpSihFP6jEtugCMQw@mail.gmail.com> <20181106233432.76df6bbf@bbrezillon>
In-Reply-To: <20181106233432.76df6bbf@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Wed, 7 Nov 2018 08:33:57 +0100
Message-ID: <CAPybu_0c115rhqO4RTa27H2j78t9z=rfOy9ukL1h4z18J8MBDQ@mail.gmail.com>
Subject: Re: [PATCH next] mtd: maps: physmap: Fix infinite loop crash in ROM
 type probing
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ricardo.ribalda@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricardo.ribalda@gmail.com
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

Hi Boris and Geert

On Tue, Nov 6, 2018 at 11:34 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Tue, 6 Nov 2018 23:19:14 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> > Hi Boris,
> >
> > On Tue, Nov 6, 2018 at 10:58 PM Boris Brezillon
> > <boris.brezillon@bootlin.com> wrote:
> > > On Tue,  6 Nov 2018 22:44:16 +0100
> > > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Toshiba RBTX4927, where map_probe is supposed to fail:
> > > >
> > > >     Creating 2 MTD partitions on "physmap-flash.0":
> > > >     0x000000c00000-0x000001000000 : "boot"
> > > >     0x000000000000-0x000000c00000 : "user"
> > > >     physmap-flash physmap-flash.1: physmap platform flash device: [mem 0x1e000000-0x1effffff]
> > > >     CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 80320f40, ra == 80321004
> > > >     ...
> > > >     Call Trace:
> > > >     [<80320f40>] get_mtd_chip_driver+0x30/0x8c
> > > >     [<80321004>] do_map_probe+0x20/0x90
> > > >     [<80328448>] physmap_flash_probe+0x484/0x4ec
> > > >
> > > > The access to rom_probe_types[] was changed from a sentinel-based loop
> > > > to an infinite loop, causing a crash when reaching the sentinel.
> > >
> > > Oops. Do you mind if I fix that in-place (squash your changes in
> > > Ricardo's original commit)?
>
> Done.
>
> >
> > No problem. Thanks!
>

Thanks to both of you for fixing this .
> Thanks for reporting/fixing the bug.
>
> Boris
>


-- 
Ricardo Ribalda
