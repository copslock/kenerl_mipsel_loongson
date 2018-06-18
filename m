Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2018 11:28:56 +0200 (CEST)
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33502 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993997AbeFRJ2tnaDf- convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jun 2018 11:28:49 +0200
Received: by mail-ua0-f193.google.com with SMTP id m21-v6so10252185uan.0
        for <linux-mips@linux-mips.org>; Mon, 18 Jun 2018 02:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SosZ0YsLsULH5E4e9xd0UrKl0hgJTpXULyo0IONNOkc=;
        b=NmXVWxCyRxZ/4nuHCJdk2/W1xnN/unBfqMA8M4DA8WDhfFyNJ1pt59MrpiZtO8AzPK
         WprPYKQAYPS5CUTDolM7IkrgtXnJd0jFGVQ7+tkYn7Hh/4iI0PbrT1Va2Db9VEcN4gIZ
         URVA6VjTcfED0z9c0Uqrxs4SB0T1Szx/BAomKfVlxVp/uWizA3nZjzRxfVAkd4JqJCr6
         j30bNmYeYntnZ8hd9sPX7S7GsW9/Ms4Fe31iTRBFDPuVlJ7YAR2hYoB8sonm6jOYZio/
         InYueS+RJUta6pA/7Y9f8YjQbxCSj43dsAnVwiiujxcWYe28Pzd1x+xCdqdeP09X/eSZ
         iqwg==
X-Gm-Message-State: APt69E2IPGcTNQK2jc0xWPVWYcypBzuVec4pn6/ha1BIZaGkeKefYWLO
        vmkxNh+lyHN7BEQnaC539ftjpf1b1et+i1dc30A=
X-Google-Smtp-Source: ADUXVKL0WXPSR4IcUugCMsp58d4eyGzYHedZjIpWbcZqvLbc+xGbNj8smVSZlY69MLA+Hp3UA6pYu7Hu1VbXa2k8yZs=
X-Received: by 2002:ab0:5105:: with SMTP id e5-v6mr7783867uaa.33.1529314123676;
 Mon, 18 Jun 2018 02:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180618091729.11091-1-geert@linux-m68k.org>
In-Reply-To: <20180618091729.11091-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Jun 2018 11:28:32 +0200
Message-ID: <CAMuHMdULmiArTvYsEqnyg5SB6PqjZnNANLAyYcqqYeYmHKJ5Dw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.18-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64349
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

On Mon, Jun 18, 2018 at 11:18 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.18-rc1[1] compared to v4.17[2].
>
> Summarized:
>   - build errors: +11/-1

> [1] http://kisskb.ellerman.id.au/kisskb/head/ce397d215ccd07b8ae3f71db689aedb85d56ab40/ (233 out of 244 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/29dcea88779c856c7dc92040a0c01233263101d4/ (all 244 configs)

> 11 error regressions:
>   + /kisskb/src/drivers/ata/pata_ali.c: error: implicit declaration of function 'pci_domain_nr' [-Werror=implicit-function-declaration]:  => 469:38

sparc64/sparc-allmodconfig

>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_alloc_try_nid':  => 1413:15
>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_alloc_try_nid_nopanic':  => 1377:15
>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_alloc_try_nid_raw':  => 1340:15

ia64/ia64-defconfig
mips/bigsur_defconfig
mips/cavium_octeon_defconfig
mips/ip22_defconfig
mips/ip27_defconfig
mips/ip32_defconfig
mips/malta_defconfig
mips/mips-allmodconfig
mips/mips-allnoconfig
mips/mips-defconfig
mipsel/mips-allmodconfig
mipsel/mips-allnoconfig
mipsel/mips-defconfig

>   + error: ".radix__flush_pwc_lpid" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
>   + error: ".radix__flush_tlb_lpid_page" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
>   + error: ".radix__local_flush_tlb_lpid_guest" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
>   + error: "radix__flush_pwc_lpid" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
>   + error: "radix__flush_tlb_lpid_page" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
>   + error: "radix__local_flush_tlb_lpid_guest" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A

powerpc/ppc64_defconfig+NO_RADIX
ppc64le/powernv_defconfig+NO_RADIX (what's in a name ;-)

>   + {standard input}: Error: offset to unaligned destination:  => 2268, 2316, 1691, 1362, 1455, 1598, 2502, 1645, 1988, 1927, 1409, 2615, 1548, 2409, 1268, 2363, 1314, 1208, 1785, 2034, 2222, 2661, 1880, 2552, 1161, 2082, 1833, 2455, 2176, 2129, 1501, 1738

sh4/sh-randconfig (doesn't seem to be a new issue, seen before on v4.12-rc3)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
