Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2011 18:00:31 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:58323 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491140Ab1INQAX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Sep 2011 18:00:23 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <aba@not.so.argh.org>)
        id 1R3rsp-0007YW-K8; Wed, 14 Sep 2011 16:00:20 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1R3rsj-0007vE-Vk; Wed, 14 Sep 2011 18:00:13 +0200
Date:   Wed, 14 Sep 2011 18:00:13 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, wuzhangjin@gmail.com, r0bertz@gentoo.org,
        chenj@lemote.com
Subject: Re: [PATCH] MIPS: Add basic support for Loongson1B
Message-ID: <20110914160013.GH4110@mails.so.argh.org>
References: <1315997270-14332-1-git-send-email-keguang.zhang@gmail.com> <20110914113134.GS15003@mails.so.argh.org> <CAJhJPsUW+4fpJUSR07LBO=FDCyAw-KHKaZCt8G+sHCJtjts0oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhJPsUW+4fpJUSR07LBO=FDCyAw-KHKaZCt8G+sHCJtjts0oA@mail.gmail.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 31080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7220

* Kelvin Cheung (keguang.zhang@gmail.com) [110914 15:54]:
> 2011/9/14, Andreas Barth <aba@not.so.argh.org>:
> > * keguang.zhang@gmail.com (keguang.zhang@gmail.com) [110914 12:49]:
> >> This patch adds basic support for Loongson1B
> >> including serial, timer and interrupt handler.
> >
> > I have a couple of questions. One of them is if it shouldn't be
> > possible to add this as part of the loongson-platform, and if we
> > really need a new platform. Each platform comes with some maintainence
> > costs which we should try to avoid. Making things more generic is
> > usually the right answer.
> 
> I've tried to add Loongson1 to loongson-platform (acturally loongson2
> platform), but there is essential difference between them. The
> loongson2 platform is something like the PC's architecture, which has
> north and south bridge, while the loongson1 is SoC.
> So, I think it's better that adding loongson1 as a new platform.

I'm not convinced, but that's also not necessary.


> >> --- /dev/null
> >> +++ b/arch/mips/loongson1/common/clock.c
> >> @@ -0,0 +1,164 @@
> >> +/*
> >> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> >
> > Is this file not derived from any of the clock drivers we already have
> > in Linux?
> >
> > Doesn't any of the existing clock drivers work?
> >
> > Is this clock part of the CPU? Otherwise it would make sense to move
> > it out to the generic drivers section.

What's the answer to this questions?



> >> --- /dev/null
> >> +++ b/arch/mips/loongson1/common/irq.c
> >> @@ -0,0 +1,132 @@
> >> +/*
> >> + * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> >> + *
> >> + * Based on Copyright (C) 2009 Lemote Inc.
> >
> > same question here. Also, do you have permission from Lemote to put
> > the code within GPLv2?
> 
> These code are based on the loongson platform, which is part of the
> kernel code already.

In that case, it would make sense to say "derived from arch/mips/..."
so that other people can understand where it comes from.

> >> diff --git a/arch/mips/loongson1/common/prom.c
> >> b/arch/mips/loongson1/common/prom.c
> >> new file mode 100644
> >> index 0000000..84a25f6
> >> --- /dev/null
> >> +++ b/arch/mips/loongson1/common/prom.c
> >
> > Can't we re-use the prom-routines from the loongson platform here? Or
> > even better, factor them out somewhere else in the mips or even
> > generic linux tree?
> 
> Same reason as question 1.

Not really. Please try to de-duplicate code as far as possible, and to
generalize it's usage. Having some code of the form
+       while (((readb(PORT(UART_BASE, UART_LSR)) & UART_LSR_THRE) == 0)
+                       && (timeout-- > 0))
+               ;
+
+       writeb(c, PORT(UART_BASE, UART_TX));
here doesn't make too much sense to me. (Also questioning why this is
part of the prom.c file).




Andi
