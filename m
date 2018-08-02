Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2018 10:57:22 +0200 (CEST)
Received: from mail-vk0-f68.google.com ([209.85.213.68]:45473 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991082AbeHBI5S5kRSg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2018 10:57:18 +0200
Received: by mail-vk0-f68.google.com with SMTP id b78-v6so655099vka.12
        for <linux-mips@linux-mips.org>; Thu, 02 Aug 2018 01:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnfuOU09Jho7uAOPmUzxI27oipwwmBPhP36T/yBpbu4=;
        b=C7Sc3QUJ1ZxzgreFlbQAoSuYiaOBncQEOXwoZFTKhu29KBwZ1kEtGZ9kuWPf+PZ3b0
         wNXMuk5R+yZt401fQagXQjYHa+y25QJipUzoQxrQ3Jgzah/dixWjbQE0HLX2ZnDeBktH
         dkZ6M331aYIma7tf1GieALmxb/SCfIjWUe8p92KC1Y4ln/uAZ9YDDY9IFT+DFNODERvk
         xjIck84V+TeIF8hZ23TwBI4HHzgqESw3zQTUOfYpfLxuRdJmMXJrSjDA5RMtapMuAMfA
         U7Wi0c9+VCG/8TJ5sHu5iH1mzWpeDp8dr+qpRIY51D0qUAbUjlagI63kOhm4xxzDawAV
         J0nQ==
X-Gm-Message-State: AOUpUlGxxV+wGEgcivrEYbuLM08Lrexlk/588pJ+yrONYD9IChMChrib
        giPzmq+0U1qvGpJEEbZK3C7AudIT717mU6G3G1Q=
X-Google-Smtp-Source: AAOMgpeBVICBroV+RVl/dyuHiz+z9TTLjsLkVu6TtZO+tq93OaASat77u+eAft1P+guYNvDJJTs0CVeXMakLX7HgX0I=
X-Received: by 2002:a1f:8ad3:: with SMTP id m202-v6mr1093776vkd.9.1533200231711;
 Thu, 02 Aug 2018 01:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180731142954.30345-1-acolin@isi.edu> <20180731142954.30345-7-acolin@isi.edu>
 <20180801095404.GA17585@infradead.org> <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
In-Reply-To: <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Aug 2018 10:57:00 +0200
Message-ID: <CAMuHMdVDra1MKcuuD0SqEYXSggr0iVFcbcjL33z7JuiE1_y8yw@mail.gmail.com>
Subject: Re: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
To:     alex.bou9@gmail.com
Cc:     Christoph Hellwig <hch@infradead.org>, acolin@isi.edu,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jwalters@isi.edu, Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65351
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

Hi Alex,

On Wed, Aug 1, 2018 at 3:16 PM Alex Bounine <alex.bou9@gmail.com> wrote:
> On 2018-08-01 05:54 AM, Christoph Hellwig wrote:
> > On Tue, Jul 31, 2018 at 10:29:54AM -0400, Alexei Colin wrote:
> >> Platforms with a PCI bus will be offered the RapidIO menu since they may
> >> be want support for a RapidIO PCI device. Platforms without a PCI bus
> >> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> >> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> >>
> >> Tested that kernel builds for arm64 with RapidIO subsystem and
> >> switch drivers enabled, also that the modules load successfully
> >> on a custom Aarch64 Qemu model.
> >
> > As said before, please include it from drivers/Kconfig so that _all_
> > architectures supporting PCI (or other Rapidio attachements) get it
> > and not some arbitrary selection of architectures.

+1

> As it was replied earlier this is not a random selection of
> architectures but only ones that implement support for RapidIO as system
> bus. If other architectures choose to adopt RapidIO we will include them
> as well.
>
> On some platforms RapidIO can be the only system bus available replacing
> PCI/PCIe or RapidIO can coexist with PCIe.
>
> As it is done now, RapidIO is configured in "Bus Options" (x86/PPC) or
> "Bus Support" (ARMs) sub-menu and from system configuration option it
> should be kept this way.
>
> Current location of RAPIDIO configuration option is familiar to users of
> PowerPC and x86 platforms, and is similarly available in some ARM
> manufacturers kernel code trees.
>
> drivers/Kconfig will be used for configuring drivers for peripheral
> RapidIO devices if/when such device drivers will be published.

Everything in drivers/rapidio/Kconfig depends on RAPIDIO (probably it should
use a big if RAPIDIO/endif instead), so it can just be included from
drivers/Kconfig now.

The sooner you do that, the less treewide changes are needed (currently
limited to mips, powerpc, and x86; your patch adds arm64).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
