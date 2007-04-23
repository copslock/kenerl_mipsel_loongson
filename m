Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2007 15:09:33 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:63222 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021652AbXDWOJb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Apr 2007 15:09:31 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id BDCE43ECA; Mon, 23 Apr 2007 07:08:58 -0700 (PDT)
Message-ID: <462CBE33.2060208@ru.mvista.com>
Date:	Mon, 23 Apr 2007 18:09:55 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] IOC3: Switch to pci refcounting safe APIs
References: <20070423150640.1faf693f@the-village.bc.nu>
In-Reply-To: <20070423150640.1faf693f@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Alan Cox wrote:
> Untested as I don't have any IOC3 hardware so if someone could give this
> a check that would be great.

> Signed-off-by: Alan Cox <alan@redhat.com>
 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc6-mm1/drivers/net/ioc3-eth.c linux-2.6.21-rc6-mm1/drivers/net/ioc3-eth.c
> --- linux.vanilla-2.6.21-rc6-mm1/drivers/net/ioc3-eth.c	2007-04-12 14:15:04.000000000 +0100
> +++ linux-2.6.21-rc6-mm1/drivers/net/ioc3-eth.c	2007-04-23 11:49:32.708000752 +0100
> @@ -1103,20 +1103,30 @@
>   * MiniDINs; all other subdevices are left swinging in the wind, leave
>   * them disabled.
>   */
> -static inline int ioc3_is_menet(struct pci_dev *pdev)
> + 
> +static int ioc3_adjacent_is_ioc3(struct pci_dev *pdev, int dev)
> +{
> +	struct pci_dev *dev = pci_get_bus_and_slot(pdev->bus->number, 
> +							PCI_DEVFN(dev, 0));

   The same question: isn't pci_get_bus() better in this case?

> +	int ret = 0;
> +	
> +	if (dev) {
> +		if (dev->vendor == PCI_VENDOR_ID_SGI &&
> +			dev->device == PCI_DEVICE_ID_SGI_IOC3)
> +			ret = 1;
> +		pci_dev_put(dev);
> +	}
> +	return ret;
> +}
> +
> +static int ioc3_is_menet(struct pci_dev *pdev)
>  {
>  	struct pci_dev *dev;
>  
> -	return pdev->bus->parent == NULL
> -	       && (dev = pci_find_slot(pdev->bus->number, PCI_DEVFN(0, 0)))
> -	       && dev->vendor == PCI_VENDOR_ID_SGI
> -	       && dev->device == PCI_DEVICE_ID_SGI_IOC3
> -	       && (dev = pci_find_slot(pdev->bus->number, PCI_DEVFN(1, 0)))
> -	       && dev->vendor == PCI_VENDOR_ID_SGI
> -	       && dev->device == PCI_DEVICE_ID_SGI_IOC3
> -	       && (dev = pci_find_slot(pdev->bus->number, PCI_DEVFN(2, 0)))
> -	       && dev->vendor == PCI_VENDOR_ID_SGI
> -	       && dev->device == PCI_DEVICE_ID_SGI_IOC3;
> +	return pdev->bus->parent == NULL &&
> +	       ioc3_adjacent_is_ioc3(pdev, 0) &&
> +	       ioc3_adjacent_is_ioc3(pdev, 1) &&
> +	       ioc3_adjacent_is_ioc3(pdev, 2));
>  }

   I don't see the point of using refcounting API in such cases but well...

WBR, Sergei
