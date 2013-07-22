Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jul 2013 22:09:07 +0200 (CEST)
Received: from mail-gg0-f169.google.com ([209.85.161.169]:33790 "EHLO
        mail-gg0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825721Ab3GVUJFF2eF4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Jul 2013 22:09:05 +0200
Received: by mail-gg0-f169.google.com with SMTP id b1so2194506ggn.14
        for <multiple recipients>; Mon, 22 Jul 2013 13:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1InLe7v7NjYHXLBQ8G3rpRIS6+3D3UpshVdu4cvW1YE=;
        b=y36pr2CQr+Am2RQEYFJVJMMFBUNtODkzttcDbqciBP0jsgXqQbrdicFOIxQnftZpN+
         r75Yzcc5Xur6zm1lwcqCidlMifFxfWTfP3w6mS770LU8v+LOv3atCsZ/ejAT3g8S/jP8
         l5aY8wAXgqzPFsffXalVCw5zYIZqcfAUUFscKq6+3H5XBow5b9yms+FiIeIiSI9TGHaK
         RT4nkxm+CX8xmCam9PQpLbQYEZCvVcD9wiOwiCLvJWEH6nBbpLtCk3dT56XvsfK5pAEO
         iirdv8u2OtKj7sKW1sH5nhhgWDCKyPyQq224yU8vesW1JUHO9SMjcexLReOZuHDleNcZ
         w6DQ==
X-Received: by 10.236.137.142 with SMTP id y14mr14011567yhi.65.1374523738992;
        Mon, 22 Jul 2013 13:08:58 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id o32sm41094422yhi.5.2013.07.22.13.08.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jul 2013 13:08:58 -0700 (PDT)
Message-ID: <51ED9153.4080904@gmail.com>
Date:   Mon, 22 Jul 2013 13:08:51 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <david.daney@cavium.com>,
        Faidon Liambotis <paravoid@debian.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: cavium-octeon: fix I/O space setup on non-PCI
 systems
References: <1374522901-30290-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1374522901-30290-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37344
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

On 07/22/2013 12:55 PM, Aaro Koskinen wrote:
> Fix I/O space setup, so that on non-PCI systems using inb()/outb()
> won't crash the system. Some drivers may try to probe I/O space and for
> that purpose we can just allocate some normal memory initially. Drivers
> trying to reserve a region will fail early as we set the size to 0. If
> a real I/O space is present, the PCI/PCIe support code will re-adjust
> the values accordingly.
>
> Tested with EdgeRouter Lite by enabling CONFIG_SERIO_I8042 that caused
> the originally reported crash.
>
> Reported-by: Faidon Liambotis <paravoid@debian.org>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>
> 	v2: Address the issues found from the first version of the patch
> 	    (http://marc.info/?t=137434204000002&r=1&w=2).
>
>   arch/mips/cavium-octeon/setup.c | 28 ++++++++++++++++++++++++++++
>   arch/mips/pci/pci-octeon.c      |  9 +++++----
>   2 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index 48b08eb..6775bd1 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -8,6 +8,7 @@
>    *   written by Ralf Baechle <ralf@linux-mips.org>
>    */
>   #include <linux/compiler.h>
> +#include <linux/vmalloc.h>
>   #include <linux/init.h>
>   #include <linux/kernel.h>
>   #include <linux/console.h>
> @@ -1139,3 +1140,30 @@ static int __init edac_devinit(void)
>   	return err;
>   }
>   device_initcall(edac_devinit);
> +
> +static void __initdata *octeon_dummy_iospace;
> +
> +static int __init octeon_no_pci_init(void)
> +{
> +	/*
> +	 * Initially assume there is no PCI. The PCI/PCIe platform code will
> +	 * later re-initialize these to correct values if they are present.
> +	 */
> +	octeon_dummy_iospace = vzalloc(IO_SPACE_LIMIT);
> +	set_io_port_base((unsigned long)octeon_dummy_iospace);
> +	ioport_resource.start = MAX_RESOURCE;
> +	ioport_resource.end = 0;
> +	return 0;
> +}
> +arch_initcall(octeon_no_pci_init);
> +

Do we have any guarantee that this will happen before the 
arch/mips/pci/* arch_initcalls ?

If not, can we move this to a core_iitcall?

David Daney


> +static int __init octeon_no_pci_release(void)
> +{
> +	/*
> +	 * Release the allocated memory if a real IO space is there.
> +	 */
> +	if ((unsigned long)octeon_dummy_iospace != mips_io_port_base)
> +		vfree(octeon_dummy_iospace);
> +	return 0;
> +}
> +late_initcall(octeon_no_pci_release);
> diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
> index 95c2ea8..59cccd9 100644
> --- a/arch/mips/pci/pci-octeon.c
> +++ b/arch/mips/pci/pci-octeon.c
> @@ -586,15 +586,16 @@ static int __init octeon_pci_setup(void)
>   	else
>   		octeon_dma_bar_type = OCTEON_DMA_BAR_TYPE_BIG;
>
> -	/* PCI I/O and PCI MEM values */
> -	set_io_port_base(OCTEON_PCI_IOSPACE_BASE);
> -	ioport_resource.start = 0;
> -	ioport_resource.end = OCTEON_PCI_IOSPACE_SIZE - 1;
>   	if (!octeon_is_pci_host()) {
>   		pr_notice("Not in host mode, PCI Controller not initialized\n");
>   		return 0;
>   	}
>
> +	/* PCI I/O and PCI MEM values */
> +	set_io_port_base(OCTEON_PCI_IOSPACE_BASE);
> +	ioport_resource.start = 0;
> +	ioport_resource.end = OCTEON_PCI_IOSPACE_SIZE - 1;
> +
>   	pr_notice("%s Octeon big bar support\n",
>   		  (octeon_dma_bar_type ==
>   		  OCTEON_DMA_BAR_TYPE_BIG) ? "Enabling" : "Disabling");
>
