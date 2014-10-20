Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 09:18:24 +0200 (CEST)
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34326 "EHLO
        mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011870AbaJTHSV3o9kT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 09:18:21 +0200
Received: by mail-lb0-f179.google.com with SMTP id l4so3322522lbv.24
        for <multiple recipients>; Mon, 20 Oct 2014 00:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vsrixRys8QRXNWex6FMK6ITkFF3FLTNC4LqCQbl4078=;
        b=xp3S4OHVBIHnvzLjoUiOiPv0fsE5ileSrcm9qUyce450Cfj9tIaVtlB8Ibbdj8L6J6
         BhLd9ny5//IIrVlbvv7hIgR1iltF7IL/vUZfKCTKC9Vq9pm5adV9dlW8FOpSJwMdLc0n
         wvDyq+EHAQlcpbVN9JPUXqv1+rSoaiw4vi+OXTMv+5g484mx9PnYxYlrO+CRkjKse06I
         wOxyHy7fpGSEhjSNYj4thHBTuibtxPjIqKfJxHCPVeSiZZPDUe/cClYvwBisUwgDnULq
         J6ruelVgs7Pz/bzz5qHt/xVfsE6A0DIsx+gRnRpOda3WPX/KnbVjGYiSbjkloDzb0ajp
         IYcg==
MIME-Version: 1.0
X-Received: by 10.112.118.78 with SMTP id kk14mr7059830lbb.83.1413789495993;
 Mon, 20 Oct 2014 00:18:15 -0700 (PDT)
Received: by 10.152.30.34 with HTTP; Mon, 20 Oct 2014 00:18:15 -0700 (PDT)
In-Reply-To: <1413740594-15579-1-git-send-email-stefan.hengelein@fau.de>
References: <1413740594-15579-1-git-send-email-stefan.hengelein@fau.de>
Date:   Mon, 20 Oct 2014 09:18:15 +0200
X-Google-Sender-Auth: 3T5RL7B41iKuzZoU3ocCEblimOQ
Message-ID: <CAMuHMdV3cGsW3iONgHHsMgVcoOqjLDoiE5u-+62M=6+fOYsj4Q@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ath79: fix compilation error when CONFIG_PCI is disabled
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Stefan Hengelein <stefan.hengelein@fau.de>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43347
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

On Sun, Oct 19, 2014 at 7:43 PM, Stefan Hengelein
<stefan.hengelein@fau.de> wrote:
> When CONFIG_PCI is disabled, 'db120_pci_init()' had a different
> signature than when was enabled. Therefore, compilation failed when
> CONFIG_PCI was not present.
>
> arch/mips/ath79/mach-db120.c:132: error: too many arguments to function 'db120_pci_init'
>
> Signed-off-by: Stefan Hengelein <stefan.hengelein@fau.de>
> ---
>  arch/mips/ath79/mach-db120.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/ath79/mach-db120.c b/arch/mips/ath79/mach-db120.c
> index 4d661a1..d1a783d 100644
> --- a/arch/mips/ath79/mach-db120.c
> +++ b/arch/mips/ath79/mach-db120.c
> @@ -112,8 +112,6 @@ static void __init db120_pci_init(u8 *eeprom)
>         ath79_pci_set_plat_dev_init(db120_pci_plat_dev_init);
>         ath79_register_pci();
>  }
> -#else
> -static inline void db120_pci_init(void) {}

Please fix the prototype above, instead of removing it and its caller.

>  #endif /* CONFIG_PCI */
>
>  static void __init db120_setup(void)
> @@ -129,7 +127,9 @@ static void __init db120_setup(void)
>                            ARRAY_SIZE(db120_spi_info));
>         ath79_register_usb();
>         ath79_register_wmac(art + DB120_WMAC_CALDATA_OFFSET);
> +#ifdef CONFIG_PCI
>         db120_pci_init(art + DB120_PCIE_CALDATA_OFFSET);
> +#endif
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
