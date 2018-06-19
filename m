Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2018 08:50:01 +0200 (CEST)
Received: from mail-ua0-f196.google.com ([209.85.217.196]:38604 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990392AbeFSGtydlwmJ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Jun 2018 08:49:54 +0200
Received: by mail-ua0-f196.google.com with SMTP id 59-v6so12363624uas.5
        for <linux-mips@linux-mips.org>; Mon, 18 Jun 2018 23:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m2gDu0XSF/WPMGmedQyekAg5F5c1qY2HsIb0aP3WIZY=;
        b=fEsaDBN30eeEobFCTwZoGpG34CGJcaeEKH4bmpEzsUNPsyF1UMnv5j2yTxpuCL/NkT
         LJ8joT7gHz3ZMHG35uy3C2qtC/HEq7Pdlt4aaCuH1uUsyGkvMHIDVzD5O0hWWSShP426
         HCI75k6N789I2BvbhwpomSHN92iWYD37NsqIq8Vi0p6Rx0BocA/QcQVtltGHiaJi3IGM
         y2Dqi8Sa4jkunlQQOXHR2ecFsAaUgc/GFSqA1qs8DSOfEp3uVwjEeOz3znTU0pjmYywz
         LRh9lW9zfbmzIWLDwjUHJznXB16GJsRnzOqSXvP5hu+C6g4hkI3ycdbY/S4AOr3Amhbu
         kNXQ==
X-Gm-Message-State: APt69E1HOYcneQqOhMtEMomiOpQSkek4dmHkoLedC2fUzGFfjOJvd4kV
        OEDgM9pEdO+1p1/w0ly3bIthBVhIVAqCHFDGKLM=
X-Google-Smtp-Source: ADUXVKJ6VDkYvaNJidzLsu9H7IQQCYVAu37cPvCTVS3cBiW2EwjOkWXdKEVsZK8ZV4imov5z0865aJ8Md68802s+X68=
X-Received: by 2002:ab0:265:: with SMTP id 92-v6mr10488434uas.26.1529390988171;
 Mon, 18 Jun 2018 23:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180618091729.11091-1-geert@linux-m68k.org> <CAMuHMdULmiArTvYsEqnyg5SB6PqjZnNANLAyYcqqYeYmHKJ5Dw@mail.gmail.com>
 <87vaafxp0k.fsf@concordia.ellerman.id.au>
In-Reply-To: <87vaafxp0k.fsf@concordia.ellerman.id.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jun 2018 08:49:36 +0200
Message-ID: <CAMuHMdUfHJS-ykNr-vPPUDfGLsGr62c4R=EThw33-DFNj9ZQNg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.18-rc1
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64362
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

Hi Michael,

On Tue, Jun 19, 2018 at 8:35 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Mon, Jun 18, 2018 at 11:18 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> >> Below is the list of build error/warning regressions/improvements in
> >> v4.18-rc1[1] compared to v4.17[2].

> >>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_alloc_try_nid':  => 1413:15
> >>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_alloc_try_nid_nopanic':  => 1377:15
> >>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_alloc_try_nid_raw':  => 1340:15
> >
> > ia64/ia64-defconfig
> > mips/bigsur_defconfig
> > mips/cavium_octeon_defconfig
> > mips/ip22_defconfig
> > mips/ip27_defconfig
> > mips/ip32_defconfig
> > mips/malta_defconfig
> > mips/mips-allmodconfig
> > mips/mips-allnoconfig
> > mips/mips-defconfig
> > mipsel/mips-allmodconfig
> > mipsel/mips-allnoconfig
> > mipsel/mips-defconfig
>
> These are now fixed in Linus' tree by:
>
>   6cc22dc08a24 ("revert "mm/memblock: add missing include <linux/bootmem.h>"")

Good.

> >>   + error: ".radix__flush_pwc_lpid" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
> >>   + error: ".radix__flush_tlb_lpid_page" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
> >>   + error: ".radix__local_flush_tlb_lpid_guest" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
> >>   + error: "radix__flush_pwc_lpid" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
> >>   + error: "radix__flush_tlb_lpid_page" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
> >>   + error: "radix__local_flush_tlb_lpid_guest" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
> >
> > powerpc/ppc64_defconfig+NO_RADIX
> > ppc64le/powernv_defconfig+NO_RADIX (what's in a name ;-)
>
> Can you tell we don't test that combination very often :/

That's why you have a special config for it? ;-)

> >>   + {standard input}: Error: offset to unaligned destination:  => 2268, 2316, 1691, 1362, 1455, 1598, 2502, 1645, 1988, 1927, 1409, 2615, 1548, 2409, 1268, 2363, 1314, 1208, 1785, 2034, 2222, 2661, 1880, 2552, 1161, 2082, 1833, 2455, 2176, 2129, 1501, 1738
> >
> > sh4/sh-randconfig (doesn't seem to be a new issue, seen before on v4.12-rc3)
>
> I think I'll disable that one, it's been broken more often that not and
> I doubt anyone is that motivated to fix sh4 randconfig breakages?

Probably not. Usually I ignore the commonly seen issues.
This one was more uncommon, so I kept it.

> Relatedly I might move all the randconfig targets from Linus' tree into
> a separate "linus-rand" tree, so that they don't pollute the results, as
> I've done for linux-next.

Sounds look a good thing.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
