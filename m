Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 14:53:07 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:47359 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903752Ab1KUNw7 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 14:52:59 +0100
Received: by vbbfs19 with SMTP id fs19so517607vbb.36
        for <multiple recipients>; Mon, 21 Nov 2011 05:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4arO8rjdDe6oypB5o7W9kZ7jIN1DXv4FvfRID1lHwNk=;
        b=e3EsSJEP8F+7/Uyntw700AGmmYhW4wnrLM/QU/fbCUFjmOoCnImGj+g9Ug3JnyRO31
         MhsKilOPtXrWHeUMvOYPfKn2enH2eBkiUyE0g7Bom30g5XtEFpJGdhWzs42ttUZP6gdP
         h6kOkKu1V16f+RR/gr3tWPBmvMfPbkPdo+Kzg=
MIME-Version: 1.0
Received: by 10.182.73.71 with SMTP id j7mr2992128obv.55.1321883573595; Mon,
 21 Nov 2011 05:52:53 -0800 (PST)
Received: by 10.182.36.133 with HTTP; Mon, 21 Nov 2011 05:52:53 -0800 (PST)
In-Reply-To: <1321825151-16053-6-git-send-email-juhosg@openwrt.org>
References: <1321825151-16053-1-git-send-email-juhosg@openwrt.org>
        <1321825151-16053-6-git-send-email-juhosg@openwrt.org>
Date:   Mon, 21 Nov 2011 14:52:53 +0100
Message-ID: <CAEWqx5_Lz4okXmmCc7KktjM6rf+zAnuMnNu=RnkveWhAnwRofQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] MIPS: ath79: rename pci-ath724x.c to make it
 reflect the real SoC name
From:   =?UTF-8?Q?Ren=C3=A9_Bolldorf?= <xsecute@googlemail.com>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17304

Acked-by: Rene Bolldorf <xsecute@googlemail.com>

On Sun, Nov 20, 2011 at 10:39 PM, Gabor Juhos <juhosg@openwrt.org> wrote:
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> ---
> v3: - no changes
> v2: - no changes
> ---
>  arch/mips/pci/Makefile                        |    2 +-
>  arch/mips/pci/{pci-ath724x.c => pci-ar724x.c} |    0
>  2 files changed, 1 insertions(+), 1 deletions(-)
>  rename arch/mips/pci/{pci-ath724x.c => pci-ar724x.c} (100%)
>
> diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
> index c3ac4b0..172277c 100644
> --- a/arch/mips/pci/Makefile
> +++ b/arch/mips/pci/Makefile
> @@ -19,7 +19,7 @@ obj-$(CONFIG_BCM47XX)         += pci-bcm47xx.o
>  obj-$(CONFIG_BCM63XX)          += pci-bcm63xx.o fixup-bcm63xx.o \
>                                        ops-bcm63xx.o
>  obj-$(CONFIG_MIPS_ALCHEMY)     += pci-alchemy.o
> -obj-$(CONFIG_SOC_AR724X)       += pci-ath724x.o
> +obj-$(CONFIG_SOC_AR724X)       += pci-ar724x.o
>
>  #
>  # These are still pretty much in the old state, watch, go blind.
> diff --git a/arch/mips/pci/pci-ath724x.c b/arch/mips/pci/pci-ar724x.c
> similarity index 100%
> rename from arch/mips/pci/pci-ath724x.c
> rename to arch/mips/pci/pci-ar724x.c
> --
> 1.7.2.1
>
>
