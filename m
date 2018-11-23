Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Nov 2018 03:39:58 +0100 (CET)
Received: from conssluserg-02.nifty.com ([210.131.2.81]:33570 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993072AbeKWCjxD9bFH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Nov 2018 03:39:53 +0100
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wAN2dWKZ027020
        for <linux-mips@linux-mips.org>; Fri, 23 Nov 2018 11:39:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wAN2dWKZ027020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542940772;
        bh=VWjvovRoFgpdnSblsfRHe1lJMd1lOaF4s9MvxqgDVX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UaV28s2h8BQzA1pDTWxCUh5ZYiBRZhcc8sm1zE5Lk/oLXXLwlYQaHyDttdv5y8cJg
         +dEMRnx5XBXXqe/XTE5a5L8EHo6I96VXl4u3yWgclDEzQzJndT1fP8lLeV08kUYOMo
         etXslrjgdIh4bSO/w6gF4eTq4F02L9Ua75Pgw1VU/638dxvffSy9QETgHsKiIbvbI/
         2VCO0zxEncWyAXR7vKU/xWt3P5NMK8/wg2kFCxx3i0FU5+q3GMTplO6M+PdUPk7vWR
         niNTDrcO24KqlH66fO9fZ9V12J834r/SY6MG1HMl2R8ln5L732B5GBoblQxsIGv4Id
         afmia0/k+PI3A==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id g68so6355619vsd.11
        for <linux-mips@linux-mips.org>; Thu, 22 Nov 2018 18:39:32 -0800 (PST)
X-Gm-Message-State: AGRZ1gKR0zragQ/EmaZr6NkzB1LKtvsbp5mGTNYrJX8+fL1ZKwwe48BQ
        K4Pld8WC3qA7X6Yk9KWP0epYva7MFzS9q0/NQro=
X-Google-Smtp-Source: AJdET5e1srPuacSBSRnMpISFk7oo2hmgsX3nPv3251fAuBn7xd1X1soEXtNFB6//3SgosqKKtXuMKOS97o9NQ43BUOQ=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr5691305vsm.181.1542940771602;
 Thu, 22 Nov 2018 18:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de> <20181115190538.17016-3-hch@lst.de>
In-Reply-To: <20181115190538.17016-3-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 23 Nov 2018 11:38:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQrOHhd-=BHtc1PQ4SCo=fUPaqOQsbxzv+VF8Zu4bJohA@mail.gmail.com>
Message-ID: <CAK7LNAQrOHhd-=BHtc1PQ4SCo=fUPaqOQsbxzv+VF8Zu4bJohA@mail.gmail.com>
Subject: Re: [PATCH 2/9] alpha: force PCI on for non-jensen configs
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
X-archive-position: 67464
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
> Without PCI support the kernel won't even compile, so force it on.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---


I do not understand this patch
because alpha already enables PCI forcibly.

'No prompt' + 'default y' means always on.

config PCI
        bool
        depends on !ALPHA_JENSEN
        select GENERIC_PCI_IOMAP
        default y


I squashed this patch to "PCI: consolidate PCI config entry ..."
because you will replace it to FORCE_PCI anyway.







>  arch/alpha/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 5b4f88363453..65f6d0bf69d4 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -6,6 +6,7 @@ config ALPHA
>         select ARCH_MIGHT_HAVE_PC_SERIO
>         select ARCH_NO_PREEMPT
>         select ARCH_USE_CMPXCHG_LOCKREF
> +       select PCI if !ALPHA_JENSEN
>         select HAVE_AOUT
>         select HAVE_IDE
>         select HAVE_OPROFILE
> --
> 2.19.1
>


--
Best Regards
Masahiro Yamada
