Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 12:29:01 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:51562 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6902416Ab2JDK2rdSiAL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 12:28:47 +0200
Received: by mail-bk0-f49.google.com with SMTP id j4so186380bkw.36
        for <multiple recipients>; Thu, 04 Oct 2012 03:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=75mIkqo/C4sy2aR7OR7Xi7aAYjYB1tyDwAO2NgoMFQk=;
        b=AdT/H1WACbVKXxJ365mwahO9IZ7Si9mFUkVRrKA5Ji/CmS2lW3rQ22nyC3laLzR/xr
         e1LeITzf48IrbWpgo4J2ql3E+oAUwatcLigAgs8CBZ7eRhDLcXJGkCP5lA7Pho1dq71c
         dd94CyOvDpdTiBzOqm4do7R5j9ClFgM9R8QQXNvZg/1cImcLW6D1QHO3X1wSbpNL83SY
         AxY640DNwAMfFfEMdB2Job4iZiGGChbmowQZ4QHpKILmOvt9Hgr7U1umFf7HG7eQnitU
         DQkv02aheOU4Yef2d8XjHSkb4biEcoawOoQ+kpHHIYQEz+IGXnv18V6Vc8q7ls4kW0RO
         R2XQ==
Received: by 10.205.132.72 with SMTP id ht8mr633357bkc.72.1349277671904;
        Wed, 03 Oct 2012 08:21:11 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id z22sm3860924bkw.2.2012.10.03.08.21.09
        (version=SSLv3 cipher=OTHER);
        Wed, 03 Oct 2012 08:21:10 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        "David S. Miller" <davem@davemloft.net>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/25] MIPS: Alchemy: use the ehci platform driver
Date:   Wed, 03 Oct 2012 17:20:10 +0200
Message-ID: <5730774.qPbnpD5QP3@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.5 (Linux/3.2.0-24-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <CAOLZvyEfagtJSQyL7MHkw+40NYbmFtT35Y4b8pGNUNc6dTzS=Q@mail.gmail.com>
References: <1349276601-8371-1-git-send-email-florian@openwrt.org> <1349276601-8371-8-git-send-email-florian@openwrt.org> <CAOLZvyEfagtJSQyL7MHkw+40NYbmFtT35Y4b8pGNUNc6dTzS=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 34587
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

On Wednesday 03 October 2012 17:14:21 Manuel Lauss wrote:
> On Wed, Oct 3, 2012 at 5:03 PM, Florian Fainelli <florian@openwrt.org> wrote:
> > Use the ehci platform driver power_{on,suspend,off} callbacks to perform 
the
> > USB block gate enabling/disabling as what the ehci-au1xxx.c driver does.
> >
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> >  arch/mips/alchemy/common/platform.c |   23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/alchemy/common/platform.c 
b/arch/mips/alchemy/common/platform.c
> > index c0f3ce6..57335a2 100644
> > --- a/arch/mips/alchemy/common/platform.c
> > +++ b/arch/mips/alchemy/common/platform.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/serial_8250.h>
> >  #include <linux/slab.h>
> > +#include <linux/usb/ehci_pdriver.h>
> >
> >  #include <asm/mach-au1x00/au1000.h>
> >  #include <asm/mach-au1x00/au1xxx_dbdma.h>
> > @@ -122,6 +123,25 @@ static void __init alchemy_setup_uarts(int ctype)
> >  static u64 alchemy_ohci_dmamask = DMA_BIT_MASK(32);
> >  static u64 __maybe_unused alchemy_ehci_dmamask = DMA_BIT_MASK(32);
> >
> > +/* Power on callback for the ehci platform driver */
> > +static int alchemy_ehci_power_on(struct platform_device *pdev)
> > +{
> > +       return alchemy_usb_control(ALCHEMY_USB_EHCI0, 1);
> > +}
> > +
> > +/* Power off/suspend callback for the ehci platform driver */
> > +static void alchemy_ehci_power_off(struct platform_device *pdev)
> > +{
> > +       alchemy_usb_control(ALCHEMY_USB_EHCI0, 0);
> > +}
> > +
> > +static struct usb_ehci_pdata alchemy_ehci_pdata = {
> > +       .need_io_watchdog       = 0,
> 
> This member doesn't exist.

Thanks to get_maintainers.pl you did not get the patch that adds it, and it 
seems like the mailing-list archives did not get it everywhere too, I can 
ensure you that's is there, it's actually PATCH 6/25 of this serie.
--
Florian
