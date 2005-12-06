Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2005 19:36:03 +0000 (GMT)
Received: from web411.biz.mail.mud.yahoo.com ([68.142.201.42]:1937 "HELO
	web411.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133728AbVLFTfp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Dec 2005 19:35:45 +0000
Received: (qmail 2584 invoked by uid 60001); 6 Dec 2005 19:35:22 -0000
Message-ID: <20051206193522.2582.qmail@web411.biz.mail.mud.yahoo.com>
Received: from [63.194.214.47] by web411.biz.mail.mud.yahoo.com via HTTP; Tue, 06 Dec 2005 11:35:22 PST
Date:	Tue, 6 Dec 2005 11:35:22 -0800 (PST)
From:	Peter Popov <ppopov@embeddedalley.com>
Subject: Re: [PATCH] Philips PNX8550 USB Host driver compile fix
To:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>,
	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
In-Reply-To: <4395D738.3080800@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips



I suppose the right solution is to be able to use the
on-chip usb controller as well as an external pci
controller. I don't think anyone will do that though.
I have one board with an external USB controller but
that was done in order to add usb 2.0 support, so the
on-chip usb controller is not used. So the simple fix
below works fine for me, but Ralf and David B. may
have higher standards ;)

Pete

--- "Vladimir A. Barinov" <vbarinov@ru.mvista.com>
wrote:

> Hello, Ralf, Pete,
> 
> The current ohci-hcd driver is a little defective.
> It's unable to use usb-ohci as modules in the case
> when PCI and on-chip 
> USB are enabled.
> It just will not be compiled since there are two
> calls if module_init in 
> ohci-hcd.
> 
> Please look at the patch attached.
> I 'm not sure is this patch well for this situation.
> Any suggestions are very appreciated.
> 
> TIA,
> Vladimir
> 
> 
> > --- linux-2.6.10.orig/drivers/usb/host/ohci-hcd.c
> 2005-12-02 16:37:59.000000000 +0300
> +++ linux-2.6.10/drivers/usb/host/ohci-hcd.c
> 2005-12-02 19:34:21.000000000 +0300
> @@ -906,8 +906,12 @@ MODULE_LICENSE ("GPL");
>  #endif
>  
>  #ifdef CONFIG_PNX8550
> +#if defined(CONFIG_PCI) &&
> defined(CONFIG_USB_OHCI_HCD_MODULE)
> +#error "unable to compile PNX8550 USB and PCI USB
> as modules simultaneously until usb hcd stack is
> rewritten"
> +#else
>  #include "ohci-pnx8550.c"
>  #endif
> +#endif
>  
>  #ifdef CONFIG_USB_OHCI_HCD_PPC_SOC
>  #include "ohci-ppc-soc.c"
> @@ -919,6 +923,7 @@ MODULE_LICENSE ("GPL");
>        || defined (CONFIG_ARCH_LH7A404) \
>        || defined (CONFIG_PXA27x) \
>        || defined (CONFIG_SOC_AU1X00) \
> +      || defined (CONFIG_PNX8550) \
>        || defined (CONFIG_USB_OHCI_HCD_PPC_SOC) \
>  	)
>  #error "missing bus glue for ohci-hcd"
> 
