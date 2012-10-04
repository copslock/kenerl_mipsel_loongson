Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 16:51:16 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:44585 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870436Ab2JDOvHQNoCK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 16:51:07 +0200
Received: by mail-ee0-f49.google.com with SMTP id c1so482105eek.36
        for <multiple recipients>; Thu, 04 Oct 2012 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=JjLVEC83aUm193mWZqA5NFPkQN1lKu4EaqyGiq0vWkA=;
        b=Otrrt8vLztKnsgqu4Ew4k5K9irT+a1hSn5GG5q7IxcWXjNCEjVT5KPI84+ifqDltna
         uncdbi3NPGV5g7Ou9K2HvnYWoRR+zQiVr73BF014znOoZKg6i+BQo91h0pC7a9AYsfpm
         q0qJomzNC8RDArZReUKP7p+L7AHxQZSSh0eXWAoxL0DQ3yTyYNWUmBHmPwrYqsrFZ39X
         MGhk640MuL7U4/A8Mu102oWUoGTUR/2C86DmRpdcRBW8XxmrL1gDtIe/ytZeiZq+Tx+A
         Lfb1Ry431okm1t18M3nfRV6vljc1FO6IGbsOd7ubcKdTtZaMuJnfuloxfAClGt9XXHU3
         FqtA==
Received: by 10.14.193.129 with SMTP id k1mr8150657een.13.1349362261823;
        Thu, 04 Oct 2012 07:51:01 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id 7sm14799378eej.13.2012.10.04.07.51.00
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 07:51:01 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Jayachandran C <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/25] MIPS: Netlogic: use ehci-platform driver
Date:   Thu, 04 Oct 2012 07:51:01 -0700 (PDT)
Message-ID: <17094030.Jd6tWHquEF@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.5 (Linux/3.2.0-24-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <Pine.LNX.4.44L0.1210031151300.1441-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1210031151300.1441-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 34600
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

On Wednesday 03 October 2012 12:47:58 Alan Stern wrote:
> On Wed, 3 Oct 2012, Florian Fainelli wrote:
> 
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> 
> IMO, patches should always have a non-empty changelog.  Even if it is 
> relatively trivial.  The same comment applies to several other patches 
> in this series.
> 
> > ---
> >  arch/mips/netlogic/xlr/platform.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> Does this need to enable CONFIG_USB_EHCI_HCD_PLATFORM is some 
> defconfig file, like you did with the MIPS Loongson 1B?

Netlogic platforms have USB disabled by default in their defconfig, so I'd say 
no, but only for them.

> 
> And likewise for quite a few of the other patches in this series.
> 
> > diff --git a/arch/mips/netlogic/xlr/platform.c 
b/arch/mips/netlogic/xlr/platform.c
> > index 71b44d8..1731dfd 100644
> > --- a/arch/mips/netlogic/xlr/platform.c
> > +++ b/arch/mips/netlogic/xlr/platform.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/serial_8250.h>
> >  #include <linux/serial_reg.h>
> >  #include <linux/i2c.h>
> > +#include <linux/usb/ehci_pdriver.h>
> >  
> >  #include <asm/netlogic/haldefs.h>
> >  #include <asm/netlogic/xlr/iomap.h>
> > @@ -123,6 +124,10 @@ static u64 xls_usb_dmamask = ~(u32)0;
> >  		},							\
> >  	}
> >  
> > +static struct usb_ehci_pdata xls_usb_ehci_pdata = {
> > +	.caps_offset	= 0,
> > +};
> > +
> >  static struct platform_device xls_usb_ehci_device =
> >  			 USB_PLATFORM_DEV("ehci-xls", 0, PIC_USB_IRQ);
> >  static struct platform_device xls_usb_ohci_device_0 =
> > @@ -172,6 +177,7 @@ int xls_platform_usb_init(void)
> >  	memres = CPHYSADDR((unsigned long)usb_mmio);
> >  	xls_usb_ehci_device.resource[0].start = memres;
> >  	xls_usb_ehci_device.resource[0].end = memres + 0x400 - 1;
> > +	xls_usb_ehci_device.dev.platform_data = &xls_usb_ehci_pdata;
> >  
> >  	memres += 0x400;
> >  	xls_usb_ohci_device_0.resource[0].start = memres;
> 
> Don't you need to change/set the pdev name also?  Likewise for patch 
> 20/25 and 24/25.
> 
> Alan Stern
> 
