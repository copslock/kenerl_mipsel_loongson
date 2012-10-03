Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 13:28:33 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:41112 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870813Ab2JDL2NWX0Nf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 13:28:13 +0200
Received: by mail-ee0-f49.google.com with SMTP id c1so304750eek.36
        for <multiple recipients>; Thu, 04 Oct 2012 04:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=G4YU9b/Gt7RoWBN9afM2713TFn0XYzD9ftk+1K/hKdc=;
        b=rL9dcbQw7ilLVl5QDC71X3RpYl6Alggm50ytwcm24e+O6OFgNVDslmJHJKvZtO/hv3
         8eA289lXVo/hRyHRAtImmsfBPfoBfcibDPZhrforsif5edQ3JwkjOiiznRDIVmjawjRQ
         LdQhgJDlUqgafaEExuH0YUBjLAfqI6S8tPQyM1heTLsB215zSd0cBf1+nru4+V4U41SA
         Dp4inrmhCroJZf6Uz0jRA241+TNmWZpc+NppXbP/fHuPO4+ERsqTvEWL/dEc4q5FmDXa
         gES3C1lLF8r9LDMDIagGWh+bwJwqnILgdJ2DWIrL7j++SD8OdOQ+xQHZtr5VKHXjUCgP
         Snnw==
Received: by 10.14.218.134 with SMTP id k6mr3506655eep.14.1349280897301;
        Wed, 03 Oct 2012 09:14:57 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id n45sm10479940eeo.14.2012.10.03.09.14.55
        (version=SSLv3 cipher=OTHER);
        Wed, 03 Oct 2012 09:14:56 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        "David S. Miller" <davem@davemloft.net>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/25] MIPS: Alchemy: use the OHCI platform driver
Date:   Wed, 03 Oct 2012 18:13:52 +0200
Message-ID: <1552014.pCMX6Sqj22@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.5 (Linux/3.2.0-24-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <CAOLZvyEcFePtAhcX4r32VvemWqriuyVfkE8b-AAL=xWOww+=7g@mail.gmail.com>
References: <1349276601-8371-1-git-send-email-florian@openwrt.org> <1349276601-8371-26-git-send-email-florian@openwrt.org> <CAOLZvyEcFePtAhcX4r32VvemWqriuyVfkE8b-AAL=xWOww+=7g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 34593
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

On Wednesday 03 October 2012 18:07:28 Manuel Lauss wrote:
> On Wed, Oct 3, 2012 at 5:03 PM, Florian Fainelli <florian@openwrt.org> wrote:
> > This also greatly simplifies the power_{on,off} callbacks and make them
> > work on platform device id instead of checking the OHCI controller base
> > address like what was done in ohci-au1xxx.c.
> >
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> >  arch/mips/alchemy/common/platform.c |   31 
+++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/arch/mips/alchemy/common/platform.c 
b/arch/mips/alchemy/common/platform.c
> > index 57335a2..cd12458 100644
> > --- a/arch/mips/alchemy/common/platform.c
> > +++ b/arch/mips/alchemy/common/platform.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/serial_8250.h>
> >  #include <linux/slab.h>
> >  #include <linux/usb/ehci_pdriver.h>
> > +#include <linux/usb/ohci_pdriver.h>
> >
> >  #include <asm/mach-au1x00/au1000.h>
> >  #include <asm/mach-au1x00/au1xxx_dbdma.h>
> > @@ -142,6 +143,34 @@ static struct usb_ehci_pdata alchemy_ehci_pdata = {
> >         .power_suspend          = alchemy_ehci_power_off,
> >  };
> >
> > +/* Power on callback for the ohci platform driver */
> > +static int alchemy_ohci_power_on(struct platform_device *pdev)
> > +{
> > +       int unit;
> > +
> > +       unit = (pdev->id == 1) ?
> > +               ALCHEMY_USB_OHCI1 : ALCHEMY_USB_OHCI0;
> > +
> > +       return alchemy_usb_control(unit, 1);
> > +}
> > +
> > +/* Power off/suspend callback for the ohci platform driver */
> > +static void alchemy_ohci_power_off(struct platform_device *pdev)
> > +{
> > +       int unit;
> > +
> > +       unit = (pdev->id == 1) ?
> > +               ALCHEMY_USB_OHCI1 : ALCHEMY_USB_OHCI0;
> > +
> > +       alchemy_usb_control(unit, 0);
> > +}
> > +
> > +static struct usb_ohci_pdata alchemy_ohci_pdata = {
> > +       .power_on               = alchemy_ohci_power_on,
> > +       .power_off              = alchemy_ohci_power_off,
> > +       .power_suspend          = alchemy_ohci_power_off,
> > +};
> > +
> >  static unsigned long alchemy_ohci_data[][2] __initdata = {
> >         [ALCHEMY_CPU_AU1000] = { AU1000_USB_OHCI_PHYS_ADDR, 
AU1000_USB_HOST_INT },
> >         [ALCHEMY_CPU_AU1500] = { AU1000_USB_OHCI_PHYS_ADDR, 
AU1500_USB_HOST_INT },
> > @@ -192,6 +221,7 @@ static void __init alchemy_setup_usb(int ctype)
> >         pdev->name = "au1xxx-ohci";
> 
> Should be "ohci-platform" (2x).  With this change USB works on all my
> Alchemy boards.

Yes, Hauke Merthens just pointed this issue at me.

> I'd also suggest to move drivers/usb/host/alchemy-common.c to
> arch/mips/alchemy/common/usb.c.
> (same for octeon2-common.c)

Ok, sounds good.
--
Florian
