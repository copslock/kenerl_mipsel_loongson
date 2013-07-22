Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jul 2013 19:14:31 +0200 (CEST)
Received: from mail-pb0-f52.google.com ([209.85.160.52]:44830 "EHLO
        mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824793Ab3GVROZmJwPt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Jul 2013 19:14:25 +0200
Received: by mail-pb0-f52.google.com with SMTP id xa12so7266814pbc.25
        for <multiple recipients>; Mon, 22 Jul 2013 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=F/SeiZsMDudGY0KK63pAj9pDh7ExM904xMMAQRw1KEg=;
        b=Z+WsL4rDhHNEmFiHp+F0uTdjzHPe6W7RdCMPjRwJSH9iZ0+TfkbunFvnXiY0jNv/rC
         eQT+NLXGyW5hNL/U5GlB4XF0z1n2zLB7OJUNNOxvmu4lTIKGWBuitHZ2hB2udYCSe+he
         DdkEB8EgdVVH93l6LxQ25aUbgtR+zF/R+4JQsE9JM5H6dzdpToj849uEGsgE7emdYmTz
         kO6P4lnFKHRhTZwz3GKaFNGEEM2TSqijRYGfy2OKGXTjXcH38pmZcStXyOkY9I+Z5XIi
         MIgaBHM0dSsoX+doLZtlzWRXRViwzExidlZLCiMqoNRrsrOmVK9yBfYchHM+cja5eVc+
         +LNw==
X-Received: by 10.66.253.40 with SMTP id zx8mr33376174pac.71.1374513257951;
        Mon, 22 Jul 2013 10:14:17 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id td5sm7866069pac.16.2013.07.22.10.14.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jul 2013 10:14:16 -0700 (PDT)
Message-ID: <51ED6866.1020702@gmail.com>
Date:   Mon, 22 Jul 2013 10:14:14 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <david.daney@cavium.com>,
        Faidon Liambotis <paravoid@debian.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: cavium-octeon: fix I/O space setup on non-PCI systems
References: <1374341931-10591-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1374341931-10591-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37342
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

On 07/20/2013 10:38 AM, Aaro Koskinen wrote:
> Fix I/O space setup, so that on non-PCI systems using inb()/outb()
> won't crash the system. Some drivers may try to probe I/O space and for
> that purpose we can just allocate some normal memory. Drivers trying to
> reserve a region will fail early as we set the size to 0.
>
> Tested with EdgeRouter Lite by enabling CONFIG_SERIO_I8042 that caused
> the originally reported crash.
>
> Reported-by: Faidon Liambotis <paravoid@debian.org>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

NACK.

This doesn't handle the following cases:

1) CONFIG_PCI=n

2) SoCs with PCIe


I think we need to move the 'if (!octeon_is_pci_host())' block to a 
place where it will always run.

David Daney

> ---
>   arch/mips/pci/pci-octeon.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
> index 95c2ea8..1bfdcc8c 100644
> --- a/arch/mips/pci/pci-octeon.c
> +++ b/arch/mips/pci/pci-octeon.c
> @@ -8,6 +8,7 @@
>   #include <linux/kernel.h>
>   #include <linux/init.h>
>   #include <linux/pci.h>
> +#include <linux/vmalloc.h>
>   #include <linux/interrupt.h>
>   #include <linux/time.h>
>   #include <linux/delay.h>
> @@ -587,13 +588,16 @@ static int __init octeon_pci_setup(void)
>   		octeon_dma_bar_type = OCTEON_DMA_BAR_TYPE_BIG;
>
>   	/* PCI I/O and PCI MEM values */
> -	set_io_port_base(OCTEON_PCI_IOSPACE_BASE);
> -	ioport_resource.start = 0;
> -	ioport_resource.end = OCTEON_PCI_IOSPACE_SIZE - 1;
>   	if (!octeon_is_pci_host()) {
>   		pr_notice("Not in host mode, PCI Controller not initialized\n");
> +		set_io_port_base((unsigned long)vzalloc(IO_SPACE_LIMIT));
> +		ioport_resource.start = MAX_RESOURCE;
> +		ioport_resource.end = 0;
>   		return 0;
>   	}
> +	set_io_port_base(OCTEON_PCI_IOSPACE_BASE);
> +	ioport_resource.start = 0;
> +	ioport_resource.end = OCTEON_PCI_IOSPACE_SIZE - 1;
>
>   	pr_notice("%s Octeon big bar support\n",
>   		  (octeon_dma_bar_type ==
>
