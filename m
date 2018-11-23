Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Nov 2018 03:34:06 +0100 (CET)
Received: from conssluserg-05.nifty.com ([210.131.2.90]:19286 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992969AbeKWCd4400xH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Nov 2018 03:33:56 +0100
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wAN2XSgS013936
        for <linux-mips@linux-mips.org>; Fri, 23 Nov 2018 11:33:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wAN2XSgS013936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542940409;
        bh=v6HVFbHmz+zgQDnWdeO9p7xqte9YKegL49VxXFqdC5k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uNJywPJ2yLV5U9yma0ObudH5v0rbcZwm7HLKFX1Wu8l+UqdP5PlA95KZmD2sJAVwv
         MR7phm3FXNONKzfrkZ2tfvDWNw/f8I9DLHub+88Y+bqo80tNQy1iJiix7nyLJVOALw
         nd8m2XNoSW/DK0CMW3qp/VictsOdTSO7VNOuAFYL8n+ynWHkGlVn0+UdARtrlOF0Vk
         3w5wQHcWOy3PPIw4Rfj392QWInlf0iCzMsDnAD+It8xUA378QniVmihvLE3wDn9sxx
         q8qjzNIJHNuKQeRSZYNS2vfR7hWRAIF+GkDSx6KvU2HUtgA1hL9B4eJbMFg65ERwAw
         pCAoFzZcXKe4Q==
X-Nifty-SrcIP: [209.85.221.172]
Received: by mail-vk1-f172.google.com with SMTP id t127so2367039vke.8
        for <linux-mips@linux-mips.org>; Thu, 22 Nov 2018 18:33:29 -0800 (PST)
X-Gm-Message-State: AA+aEWaVxH7xRjMr+N2PVm9y9ai1H5Aq7MqfLzDY7ZqykVb5U8lSGwiX
        0JO5VbIyiF+aR/THOoPqJ1qH67Xx3+0CLxbE3xo=
X-Google-Smtp-Source: AFSGD/WOaShAZWgbrF6drzEtDB7BJ8RrCSWMcw9Fa+4aDXL3U8vMURobcUXawjUcWKuzRTy8b7seybF2eyBenVK7VOk=
X-Received: by 2002:a1f:6bc8:: with SMTP id k69mr5479162vki.84.1542940408247;
 Thu, 22 Nov 2018 18:33:28 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de>
In-Reply-To: <20181115190538.17016-1-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 23 Nov 2018 11:32:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNARL8yZexzXiEaT77U_rdwhr5uENXbSaSTGHU33HbSmW6g@mail.gmail.com>
Message-ID: <CAK7LNARL8yZexzXiEaT77U_rdwhr5uENXbSaSTGHU33HbSmW6g@mail.gmail.com>
Subject: Re: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/ v4
To:     Christoph Hellwig <hch@lst.de>
Cc:     mporter@kernel.crashing.org, Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pci@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-alpha@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

Hi Christoph,


On Fri, Nov 16, 2018 at 4:08 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> currently every architecture that wants to provide on of the common
> periphal busses needs to add some boilerplate code and include the
> right Kconfig files.   This series instead just selects the presence
> (when needed) and then handles everything in the bus-specific
> Kconfig file under drivers/.


Thanks for this work!


I applied this series, and it is available at

git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
kconfig2


I made local fixups in some parts,
where I left comments in individual patches.





> Changes since v3:
>  - drop the patches already merged
>  - fix a typo in the PCI help text
>  - split the always enable PCI on alpha change into a separate patch
>  - remove the mips HT_PCI symbol
>  - add a new FORCE_PCI symbol to easily allow selecting PCI support
>  - new patch to consolidate PCI_DOMAINS
>  - new patch to consolidate PCI_SYSCALL
>
> Changes since v2:
>  - depend on HAVE_PCI for PCIe endpoint code
>  - fix some commit message typos
>  - remove CONFIG_PCI from xtensa iss defconfig
>  - drop EISA support from arm
>  - clean up EISA selection for alpha
>
> Changes since v1:
>  - rename all HAS_* Kconfig symbols to HAVE_*
>  - drop the CONFIG_PCI_QSPAN option entirely
>  - drop duplicate select from powerpc
>  - restore missing selection of PCI_MSI for riscv
>  - update x86 and riscv defconfigs to include PCI
>  - actually inclue drivers/eisa/Kconfig
>  - adjust some captilizations



--
Best Regards
Masahiro Yamada
