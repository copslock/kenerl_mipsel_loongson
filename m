Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Nov 2018 03:39:30 +0100 (CET)
Received: from conssluserg-05.nifty.com ([210.131.2.90]:26584 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993053AbeKWCj0EnQtH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Nov 2018 03:39:26 +0100
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wAN2cu5x016911
        for <linux-mips@linux-mips.org>; Fri, 23 Nov 2018 11:38:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wAN2cu5x016911
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542940737;
        bh=RwCL9Ri+CN8GV/mcouXy7Bn2m5DMHOHs2NKrn7tRBFs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MYhJUu0L0a+CSKTHu66tCSIlEPx+cikVX1ZeeFJJJm+V/LS62+QKlo0YuU3BlAbbw
         AsWTdHqbqdveA+kVvHdFVvyOuwFaH8+owiGVG4pVsSpFbI97zO2nPbIrDm9G8w+JJA
         HQJBZ6OaYZqSTOmFr3ri2G48XmixRLG+GICPONonqugmiLwoeF6GXdpFb+zWI52b3n
         +Y/q6MvJjeUsBEWsY/sIEaEPQ+fX+mycQqY7B6OtENsc5C3eCOVeov8yPQZYqRumiY
         G/yEfSi/YD5kR1o+R1Vy4v9aP/E9epQ21KXaYMb/2lBHJJByu1kQlaB3xOQU5okA1+
         XTsn9lvMF8w/g==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id h18so6367444vsj.4
        for <linux-mips@linux-mips.org>; Thu, 22 Nov 2018 18:38:56 -0800 (PST)
X-Gm-Message-State: AGRZ1gLRHwTj9M3aG4kzRmlJy6OhlFfLbjYhJWVeKQt9PGuuAUJZVorw
        IFwf4vf8C9vO9pITr9xkMNjz/11YNxKG7sJBZhQ=
X-Google-Smtp-Source: AJdET5f4wWYkg8NhA/njL96dQLq3mhUgERT/Zv/ehLhsyoNXgp6lt+kzLsJHDfpawOK7kvxkQQ7+Im2odf8doeLp64Y=
X-Received: by 2002:a67:a858:: with SMTP id r85mr5688337vse.215.1542940735781;
 Thu, 22 Nov 2018 18:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de> <20181115190538.17016-2-hch@lst.de>
In-Reply-To: <20181115190538.17016-2-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 23 Nov 2018 11:38:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT+gHJcxhb=ufzzHHcfWqNOAJXaOAp2aJP9dGYxBkqQFw@mail.gmail.com>
Message-ID: <CAK7LNAT+gHJcxhb=ufzzHHcfWqNOAJXaOAp2aJP9dGYxBkqQFw@mail.gmail.com>
Subject: Re: [PATCH 1/9] arm: remove EISA kconfig option
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
X-archive-position: 67463
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

On Fri, Nov 16, 2018 at 4:06 AM Christoph Hellwig <hch@lst.de> wrote:
>
> No arm config enables EISA, and arm does not include drivers/eisa/Kconfig
> which provides support for things like PCI to EISA bridges, so it is most
> likely dead.

As I said before, this is absolutely dead.

Only the difference between arch/powerpc/Kconfig and arch/arm/Kconfig
is the presence of ---help--- property.


I squashed this to "eisa: consolidate EISA ..."


> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/Kconfig | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 91be74d8df65..f24a7435d19a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -163,21 +163,6 @@ config HAVE_PROC_CPU
>  config NO_IOPORT_MAP
>         bool
>
> -config EISA
> -       bool
> -       ---help---
> -         The Extended Industry Standard Architecture (EISA) bus was
> -         developed as an open alternative to the IBM MicroChannel bus.
> -
> -         The EISA bus provided some of the features of the IBM MicroChannel
> -         bus while maintaining backward compatibility with cards made for
> -         the older ISA bus.  The EISA bus saw limited use between 1988 and
> -         1995 when it was made obsolete by the PCI bus.
> -
> -         Say Y here if you are building a kernel for an EISA-based machine.
> -
> -         Otherwise, say N.
> -
>  config SBUS
>         bool
>
> --
> 2.19.1
>


--
Best Regards
Masahiro Yamada
