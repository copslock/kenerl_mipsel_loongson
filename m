Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 20:29:21 +0100 (CET)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:60680 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833252Ab3A1T3UnGhOZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Jan 2013 20:29:20 +0100
Received: by mail-pb0-f49.google.com with SMTP id xa12so1661780pbc.36
        for <multiple recipients>; Mon, 28 Jan 2013 11:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=42+RXv/su49z08SODHWgE6KfC1eYY36zc5msyjMS4aw=;
        b=I8lr9rKZFcIXR0ceM4nY+VDpwhKvL+E9ii9diZHlg4tzi32u3LLlj9k8Ijp9kMqmc2
         ALc2DOIEJm8gIIZzc2Hk8o4fs2DGUAZWuZHY0tDrsRszLVPQmusmBU2+2131Fr853QfB
         Ei9kXUJKSpWR/f7JEmroI1AHo36AV9WnP8ACwjrK2W6owC+W8uxpgXidvTlEG65WgFvS
         u/gN277BIfaAfCFcRwwjsBgMrxIZQJXVKuZVxvhHCq5sX0+FLETseSyza8aZUogXxNtg
         aTJ7jRHXWKho4Tqvu6e+tHlvZdraUF0gojiyMGl6iSuVvkpzFx4X5ZgK9H2bXB3sr5Ap
         nTtw==
X-Received: by 10.66.76.130 with SMTP id k2mr38318911paw.76.1359401353846;
        Mon, 28 Jan 2013 11:29:13 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ob9sm3125567pbb.73.2013.01.28.11.29.12
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 11:29:13 -0800 (PST)
Message-ID: <5106D187.80600@gmail.com>
Date:   Mon, 28 Jan 2013 11:29:11 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org, jogo@openwrt.org,
        mbizon@freebox.fr, cenerkee@gmail.com, blogic@openwrt.org
Subject: Re: [PATCH 08/13] MIPS: BCM63XX: introduce BCM63XX_EHCI configuration
 symbol
References: <1359399991-2236-1-git-send-email-florian@openwrt.org> <1359399991-2236-9-git-send-email-florian@openwrt.org>
In-Reply-To: <1359399991-2236-9-git-send-email-florian@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 01/28/2013 11:06 AM, Florian Fainelli wrote:
> This configuration symbol can be used by CPUs supporting the on-chip
> EHCI controller, and ensures that all relevant EHCI-related
> configuration options are selected. So far BCM6328, BCM6358 and BCM6368
> have an EHCI controller and do select this symbol. Update
> drivers/usb/host/Kconfig with BCM63XX to update direct unmet
> dependencies.
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>   arch/mips/bcm63xx/Kconfig |    9 +++++++++
>   drivers/usb/host/Kconfig  |    5 +++--
>   2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
> index 23b1ffd..b899359 100644
> --- a/arch/mips/bcm63xx/Kconfig
> +++ b/arch/mips/bcm63xx/Kconfig
> @@ -7,10 +7,17 @@ config BCM63XX_OHCI
>   	select USB_OHCI_BIG_ENDIAN_DESC if USB_OHCI_HCD
>   	select USB_OHCI_BIG_ENDIAN_MMIO if USB_OHCI_HCD
>
> +config BCM63XX_EHCI
> +	bool
> +	select USB_ARCH_HAS_EHCI
> +	select USB_EHCI_BIG_ENDIAN_DESC if USB_EHCI_HCD
> +	select USB_EHCI_BIG_ENDIAN_MMIO if USB_EHCI_HCD
> +
>   config BCM63XX_CPU_6328
>   	bool "support 6328 CPU"
>   	select HW_HAS_PCI
>   	select BCM63XX_OHCI
> +	select BCM63XX_EHCI
[...]
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index d6bb128..e16b2cb 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -115,14 +115,15 @@ config USB_EHCI_BIG_ENDIAN_MMIO
>   	depends on USB_EHCI_HCD && (PPC_CELLEB || PPC_PS3 || 440EPX || \
>   				    ARCH_IXP4XX || XPS_USB_HCD_XILINX || \
>   				    PPC_MPC512x || CPU_CAVIUM_OCTEON || \
> -				    PMC_MSP || SPARC_LEON || MIPS_SEAD3)
> +				    PMC_MSP || SPARC_LEON || MIPS_SEAD3 || \
> +				    BCM63XX)
>   	default y

This is a complete mess.

Can we get rid of the 'default y' and all those things after the '&&', 
and select USB_EHCI_BIG_ENDIAN_MMIO in the board Kconfig files?

I am as guilty as anyone here (see || CPU_CAVIUM_OCTEON above).  But 
this doesn't seem sustainable.  We should be trying to keep the 
configuration information for all this in one spot.

Now you have it spread across two files.  One to enable it, and the 
other to select it.  But do you really need to select it if it defaults 
to 'y'


>
>   config USB_EHCI_BIG_ENDIAN_DESC
>   	bool
>   	depends on USB_EHCI_HCD && (440EPX || ARCH_IXP4XX || XPS_USB_HCD_XILINX || \
>   				    PPC_MPC512x || PMC_MSP || SPARC_LEON || \
> -				    MIPS_SEAD3)
> +				    MIPS_SEAD3 || BCM63XX)
>   	default y
>


Same here.

Thanks,
David (on a mission against Kconfig insanity) Daney
