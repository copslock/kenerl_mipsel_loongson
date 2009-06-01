Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 18:56:52 +0100 (WEST)
Received: from h155.mvista.com ([63.81.120.155]:56773 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20025719AbZFAR4p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 18:56:45 +0100
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 6C5573ECB; Mon,  1 Jun 2009 10:56:41 -0700 (PDT)
Message-ID: <4A2416A4.4070902@ru.mvista.com>
Date:	Mon, 01 Jun 2009 21:57:56 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH 10/10] bcm63xx: clarify meaning of the magical value in
 ehci-bcm63xx.c
References: <1243876918-9905-1-git-send-email-mbizon@freebox.fr> <1243876918-9905-11-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1243876918-9905-11-git-send-email-mbizon@freebox.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Maxime Bizon wrote:

> USB maintainer asked for clarification of the magic value used during
> USB init. Be clear about the source of it.

> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> ---
>  drivers/usb/host/ehci-bcm63xx.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

> diff --git a/drivers/usb/host/ehci-bcm63xx.c b/drivers/usb/host/ehci-bcm63xx.c
> index 8a62c0a..5a03fdd 100644
> --- a/drivers/usb/host/ehci-bcm63xx.c
> +++ b/drivers/usb/host/ehci-bcm63xx.c
> @@ -78,7 +78,9 @@ static int __devinit ehci_hcd_bcm63xx_drv_probe(struct platform_device *pdev)
>  	reg |= USBH_PRIV_SWAP_EHCI_ENDN_MASK;
>  	bcm_rset_writel(RSET_USBH_PRIV, reg, USBH_PRIV_SWAP_REG);
>  
> -	/* don't ask... */
> +	/* the magic value comes for the original vendor BSP and is
> +	 * needed for USB to work. Datasheet does not help, so the
> +	 * magic value is used as-is. */
>  	bcm_rset_writel(RSET_USBH_PRIV, 0x1c0020, USBH_PRIV_TEST_REG);
>  
>  	hcd = usb_create_hcd(&ehci_bcm63xx_hc_driver, &pdev->dev, "bcm63xx");

    Documentation/CodingStyle, chapter 8:

The preferred style for long (multi-line) comments is:
 

         /*
          * This is the preferred style for multi-line
          * comments in the Linux kernel source code.
          * Please use it consistently.
          *
          * Description:  A column of asterisks on the left side,
          * with beginning and ending almost-blank lines.
          */

WBR, Sergei
