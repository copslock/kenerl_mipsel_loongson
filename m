Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2006 08:30:29 +0000 (GMT)
Received: from outmx017.isp.belgacom.be ([195.238.4.116]:37310 "EHLO
	outmx017.isp.belgacom.be") by ftp.linux-mips.org with ESMTP
	id S8133361AbWBJIaU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Feb 2006 08:30:20 +0000
Received: from outmx017.isp.belgacom.be (localhost [127.0.0.1])
        by outmx017.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id k1A8a01M015963
        for <linux-mips@linux-mips.org>; Fri, 10 Feb 2006 09:36:01 +0100
        (envelope-from <tnt@246tNt.com>)
Received: from [10.0.0.132] (161-134.245.81.adsl.skynet.be [81.245.134.161])
        by outmx017.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id k1A8ZuRU015915;
	Fri, 10 Feb 2006 09:35:56 +0100
        (envelope-from <tnt@246tNt.com>)
Message-ID: <43EC50A3.1090007@246tNt.com>
Date:	Fri, 10 Feb 2006 09:36:51 +0100
From:	Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050610)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Herbert Valerio Riedel <hvr@gnu.org>
CC:	Jay Monkman <jtm@smoothsmoothie.com>, linux-mips@linux-mips.org
Subject: Re: USB on AU1550
References: <433B0299.8080507@smoothsmoothie.com> <1135425163.13029.13.camel@mini.intra>
In-Reply-To: <1135425163.13029.13.camel@mini.intra>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <tnt@246tNt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tnt@246tNt.com
Precedence: bulk
X-list: linux-mips

Maybe it's already in the code but That patch also activates the
OHCI_BIG_ENDIAN flag in the struct ohci_hcd. If not big endian mode
will be choosed only if USB_OHCI_LITTLE_ENDIAN is not selected as well
(both can be selected at once and if they are, it's that plag in the
hcd sruct that selects what to use)

	Sylvain

Herbert Valerio Riedel wrote:
> hello,
> 
> On Wed, 2005-09-28 at 15:52 -0500, Jay Monkman wrote:
> 
>>I'm trying to get USB working on my AU1550 board, and I'm getting an error I
>>don't understand. I've searched the web and the mailing list archives, but
>>haven't found anything relevant.
> 
> 
> there was a post of mine, dating back to 22 Nov 2004 which could have
> been relevant to your cause :-)
> 
> 
>>I'm using 2.6.12, in big-endian mode.
> 
> [..]
> 
>>Can anyone point me in the right direction to get this working?
> 
> 
> don't know whether you still require being pointed in to any direction;
> however, the following patch (against current GIT HEAD, works for me,
> YMMV :-) might provide a hint:
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index ed1899d..914b964 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -100,12 +100,14 @@ config USB_OHCI_HCD_PCI
>  config USB_OHCI_BIG_ENDIAN
>  	bool
>  	depends on USB_OHCI_HCD
> +	default y if SOC_AU1X00 && CPU_BIG_ENDIAN
>  	default n
>  
>  config USB_OHCI_LITTLE_ENDIAN
>  	bool
>  	depends on USB_OHCI_HCD
>  	default n if STB03xxx || PPC_MPC52xx
> +	default n if SOC_AU1X00 && CPU_BIG_ENDIAN
>  	default y
>  
>  config USB_UHCI_HCD
> diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
> index caacf14..bf18351 100644
> --- a/drivers/usb/host/ohci.h
> +++ b/drivers/usb/host/ohci.h
> @@ -462,6 +462,11 @@ static inline struct usb_hcd *ohci_to_hc
>  #define writel_be(val, addr)	out_be32((__force unsigned *)addr, val)
>  #endif
>  
> +#if defined(CONFIG_SOC_AU1X00)
> +#define readl_be(addr)          __raw_readl((__force u32 *)(addr))
> +#define writel_be(val, addr)    __raw_writel(val, (__force u32 *)(addr))
> +#endif
> +
>  static inline unsigned int ohci_readl (const struct ohci_hcd *ohci,
>  							__hc32 __iomem * regs)
>  {
> 
> 
> greetings,
