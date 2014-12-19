Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 09:03:23 +0100 (CET)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:51959 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007921AbaLSIDWZbXvF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 09:03:22 +0100
Received: by mail-lb0-f182.google.com with SMTP id f15so428039lbj.13;
        Fri, 19 Dec 2014 00:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CiL/07m7geCXb9xW3J9Lj/9yBhcf4H0KR04MHEotvcw=;
        b=snFk/42l0MTaRrwe/8tdly0b/PjtQNrD8AncghOHEuDxYOup0aqTXVhZF7hLLxzTPu
         Xp0pA6CmqQUDeOX+TP0A4JlAxMiF4Z0CXDN64dExW3jDmGv7s/pJm9bqs7ON031WpY55
         pKk7QavYBO/VGQUkaR9qbxkFERJ3fboj2aXhDyQEJ8+WmA7NXpMisThRjb22I2uy0quW
         WHpL1q/opYTaEJ/CeYkC2aiugN85hY97KbtBwtu06V0df/nXBs4g7sOc55cQaCONOKof
         IXpItBln0cy9NK52dZ9ExbH/zmepHq0fTEzEn0Np7sGPxzymg37u11gT3xA0xgMzKbqJ
         oTsQ==
MIME-Version: 1.0
X-Received: by 10.152.206.1 with SMTP id lk1mr4881634lac.92.1418976197037;
 Fri, 19 Dec 2014 00:03:17 -0800 (PST)
Received: by 10.152.106.178 with HTTP; Fri, 19 Dec 2014 00:03:16 -0800 (PST)
In-Reply-To: <1418849927.28384.1.camel@perches.com>
References: <1418849927.28384.1.camel@perches.com>
Date:   Fri, 19 Dec 2014 09:03:16 +0100
X-Google-Sender-Auth: AtGx1oe7xaXa028NVT69VsGu_5U
Message-ID: <CAMuHMdXGsUeAuV63hknXFkrwFoW+9_SR5wt5tzPJttGnCR_YDQ@mail.gmail.com>
Subject: Re: rfc: remove early_printk from a few arches? (blackfin, m68k, mips)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Finn Thain <fthain@telegraphics.com.au>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44826
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

On Wed, Dec 17, 2014 at 9:58 PM, Joe Perches <joe@perches.com> wrote:
> It seems like early_printk can be configured into
> a few architectures but also appear not to be used.
>
> $ git grep -w "early_printk"

[...]

> arch/m68k/kernel/Makefile:obj-$(CONFIG_EARLY_PRINTK)    += early_printk.o

[...]

> These seem to the only uses:
>
> arch/arm/mach-socfpga/socfpga.c:        early_printk("Early printk initialized\n");
> []
> arch/microblaze/kernel/cpu/cpuinfo-pvr-full.c:  early_printk("ERROR: Microblaze " x "-different for PVR and DTS\n");
> arch/microblaze/kernel/cpu/cpuinfo-static.c:    early_printk("ERROR: Microblaze " x "-different for kernel and DTS\n");
> []
> arch/tile/kernel/early_printk.c:        early_printk("Kernel panic - not syncing: %pV", &vaf);
> []
> arch/x86/kernel/e820.c: early_printk(msg);
> arch/x86/kernel/head64.c:               early_printk("Kernel alive\n");
> arch/x86/kernel/head_64.S:      call early_printk
> []
> kernel/events/core.c:           early_printk("perf interrupt took too long (%lld > %lld), lowering "
>
> So blackfin, m68k, and mips seems to have it possible to enable,
> but also don't appear at first glance to use it,
>
> Is early_printk really used by these architectures?
> Should it be removed?

The m68k "early_printk" match is not about the early_printk()
function, but about
the early printk functionality. Hence nothing to remove there.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
