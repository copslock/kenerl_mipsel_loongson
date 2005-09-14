Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 20:01:24 +0100 (BST)
Received: from mail.dvmed.net ([IPv6:::ffff:216.237.124.58]:44978 "EHLO
	mail.dvmed.net") by linux-mips.org with ESMTP id <S8225003AbVINTBI>;
	Wed, 14 Sep 2005 20:01:08 +0100
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EFcVA-0002eC-Hb; Wed, 14 Sep 2005 19:01:02 +0000
Message-ID: <4328736A.8040803@pobox.com>
Date:	Wed, 14 Sep 2005 15:00:58 -0400
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Alexey Dobriyan <adobriyan@gmail.com>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Scott Feldman <sfeldma@pobox.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] gt96100: stop using pci_find_device()
References: <20050914185136.GE19491@mipter.zuzino.mipt.ru>
In-Reply-To: <20050914185136.GE19491@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Alexey Dobriyan wrote:
> From: Scott Feldman <sfeldma@pobox.com>
> 
> Replace pci_find_device with pci_get_device/pci_dev_put to plug race
> with pci_find_device.
> 
> Signed-off-by: Scott Feldman <sfeldma@pobox.com>
> Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
> Signed-off-by: Domen Puncer <domen@coderock.org>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/net/gt96100eth.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> --- a/drivers/net/gt96100eth.c
> +++ b/drivers/net/gt96100eth.c
> @@ -615,9 +615,9 @@ static int gt96100_init_module(void)
>  	/*
>  	 * Stupid probe because this really isn't a PCI device
>  	 */
> -	if (!(pci = pci_find_device(PCI_VENDOR_ID_MARVELL,
> +	if (!(pci = pci_get_device(PCI_VENDOR_ID_MARVELL,
>  	                            PCI_DEVICE_ID_MARVELL_GT96100, NULL)) &&
> -	    !(pci = pci_find_device(PCI_VENDOR_ID_MARVELL,
> +	    !(pci = pci_get_device(PCI_VENDOR_ID_MARVELL,
>  		                    PCI_DEVICE_ID_MARVELL_GT96100A, NULL))) {
>  		printk(KERN_ERR __FILE__ ": GT96100 not found!\n");
>  		return -ENODEV;
> @@ -627,12 +627,14 @@ static int gt96100_init_module(void)
>  	if (cpuConfig & (1<<12)) {
>  		printk(KERN_ERR __FILE__
>  		       ": must be in Big Endian mode!\n");
> +		pci_dev_put(pci);
>  		return -ENODEV;

NAK -- convert it to use standard PCI driver API.

	Jeff
