Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 10:48:25 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:57230 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817088Ab2JWIsTWwKy- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 10:48:19 +0200
Received: by mail-bk0-f49.google.com with SMTP id j4so1138508bkw.36
        for <multiple recipients>; Tue, 23 Oct 2012 01:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=jf2x8C+WGmf1DpXNYBuRapWqudF/ezw41FT+57nLL3c=;
        b=NkydHE6mYdBHKhF18QCUy69pz+Qbs/AhbASRxfe6bIgW+gnKkvjGe0FgYJG0EOROjH
         lkEZatmBoQzXmubiUPtbAvcduPupfyGNJEhABf0jjggqMQVtUrbcu//ac7l2wVd9JFZS
         3xxcA4NG+msxPga8M1cm99fDbgvUABqfhiCxPgWwb4XD8LInr83stnfKPRQ9pur+Jm2Y
         /OzfEyDMBq4hGcWOMTy+2FTowcIWYA9O5qDWxzNryCDl9TY8oA0odV/NtztXiAvcrimo
         pcuhWRvd7/NIkI8HfFVqd34cStYdwB710jh+y7tNx1YEoTxUwtWhTJ9cIbf4uKidk06L
         Md6g==
Received: by 10.204.149.2 with SMTP id r2mr3513261bkv.0.1350982088273;
        Tue, 23 Oct 2012 01:48:08 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id v14sm4999684bkv.10.2012.10.23.01.48.07
        (version=SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 01:48:07 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/32 v4] MIPS: Loongson 1B: use ehci-platform instead of ehci-ls1x.
Date:   Tue, 23 Oct 2012 10:46:50 +0200
Message-ID: <36521520.iGJ91Agxac@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.5 (Linux/3.2.0-24-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <CAJhJPsV5mFmOgU38ZpnYqUTNuOPmvRXjsf31XdFUqNOzsd_Edg@mail.gmail.com>
References: <1349701906-16481-1-git-send-email-florian@openwrt.org> <1349701906-16481-4-git-send-email-florian@openwrt.org> <CAJhJPsV5mFmOgU38ZpnYqUTNuOPmvRXjsf31XdFUqNOzsd_Edg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 34744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Kelvin,

On Tuesday 23 October 2012 16:13:01 Kelvin Cheung wrote:
> Thank Florian.
> It looks great.
> However, you forget to remove corresponding section in
> drivers/usb/host/ehci-hcd.c
> ...
> #ifdef CONFIG_MACH_LOONGSON1
> #include "ehci-ls1x.c"
> #define PLATFORM_DRIVER         ehci_ls1x_driver
> #endif

Indeed, my bad I will follow up with some fixes for this patchset anyway.
Thank you!

> ...
> 
> 2012/10/8 Florian Fainelli <florian@openwrt.org>
> 
> > The Loongson 1B EHCI driver does nothing more than what the EHCI platform
> > driver already does, so use the generic implementation.
> >
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> > Changes in v4:
> > - rebased against greg's latest usb-next
> >
> > No changes since v1
> >
> >  arch/mips/configs/ls1b_defconfig      |    1 +
> >  arch/mips/loongson1/common/platform.c |    8 +++++++-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/configs/ls1b_defconfig
> > b/arch/mips/configs/ls1b_defconfig
> > index 80cff8b..7eb7554 100644
> > --- a/arch/mips/configs/ls1b_defconfig
> > +++ b/arch/mips/configs/ls1b_defconfig
> > @@ -76,6 +76,7 @@ CONFIG_HID_GENERIC=m
> >  CONFIG_USB=y
> >  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> >  CONFIG_USB_EHCI_HCD=y
> > +CONFIG_USB_EHCI_HCD_PLATFORM=y
> >  # CONFIG_USB_EHCI_TT_NEWSCHED is not set
> >  CONFIG_USB_STORAGE=m
> >  CONFIG_USB_SERIAL=m
> > diff --git a/arch/mips/loongson1/common/platform.c
> > b/arch/mips/loongson1/common/platform.c
> > index e92d59c..2874bf2 100644
> > --- a/arch/mips/loongson1/common/platform.c
> > +++ b/arch/mips/loongson1/common/platform.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/phy.h>
> >  #include <linux/serial_8250.h>
> >  #include <linux/stmmac.h>
> > +#include <linux/usb/ehci_pdriver.h>
> >  #include <asm-generic/sizes.h>
> >
> >  #include <loongson1.h>
> > @@ -107,13 +108,18 @@ static struct resource ls1x_ehci_resources[] = {
> >         },
> >  };
> >
> > +static struct usb_ehci_pdata ls1x_ehci_pdata = {
> > +       .port_power_off = 1,
> > +};
> > +
> >  struct platform_device ls1x_ehci_device = {
> > -       .name           = "ls1x-ehci",
> > +       .name           = "ehci-platform",
> >         .id             = -1,
> >         .num_resources  = ARRAY_SIZE(ls1x_ehci_resources),
> >         .resource       = ls1x_ehci_resources,
> >         .dev            = {
> >                 .dma_mask = &ls1x_ehci_dmamask,
> > +               .platform_data = &ls1x_ehci_pdata,
> >         },
> >  };
> >
> > --
> > 1.7.9.5
> >
> >
> 
> 
> -- 
> Best Regards!
> Kelvin Cheung
