Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 07:39:10 +0200 (CEST)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:50476 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011418AbaJWFjHnvNjB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 07:39:07 +0200
Received: by mail-ie0-f181.google.com with SMTP id y20so304200ier.26
        for <linux-mips@linux-mips.org>; Wed, 22 Oct 2014 22:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rH9c7UWqRpagiUT4JnzG73pYO4PqzS/Qq2mtLsrnQFM=;
        b=ozaDclCppeS118hlUicolEDK4dyvF6AllOTiQhrHiIlOt1rTvijeV2/HJNfqC23ZIz
         enKC1c+QXefWbDsCWqJPBPTSF+RxWLA8CbvIqESpPibyMe1bIgez4u5o6UGaWjRbsfqJ
         7BAO7+y7FQJle25GRExKcCA01kiSRMTRx83ZxgOYXREyFlwFIZ+M234pirVnUmN2XV3t
         95Xg1eY+oBXRpLHRKI5SOAafPpew6kVjKhF6zX2edObrCRnBWNOdU1G8dzVyTZVTBJQR
         GkN4heC79JKardd3fyqMQsOxn+ngfZlB3/zMb8pBOdV2EqDvefWtS2cCf71AY/cqb5u+
         8RYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=rH9c7UWqRpagiUT4JnzG73pYO4PqzS/Qq2mtLsrnQFM=;
        b=BXAlQO9B+tLqjd4L9gWFUItp7L9+8oM5h+Pz0C/Oiy3e2xrSUyHOIfUEmF5SUhAxe6
         nMNucdWhfXlIBe8qxej3H1PoAkNIIai1/LRc/SrJurN87iffUiLI4xcannh9f0IjEO+m
         l1mIhMD13MarIjBu3gn3MnbND0MIWR0jjbqhFnqs2N9Fyw8TXMXqJNHjZOyUulFcBAtA
         x+uSQJ7kBP54FBu5ZNX690rIkA4/M5av8Jtp/QK1n1dyfqLj0dIcQm9vYPT9dKkxab7T
         H0Hh2MCQkLbjdBGJJIncMQrFFXVAdW3YAy17Mj8XH/PPy0XoKiyNaD5AMh4e3OhEVWEA
         D/YQ==
X-Gm-Message-State: ALoCoQmq0Qg8ZmFUJ7uOitty+oQ9HvfsTnL+ciT67GP1MYDuvw6k4sgWCj3uhT1yElu2idw8FFkj
X-Received: by 10.42.142.201 with SMTP id t9mr332565icu.60.1414042741678;
        Wed, 22 Oct 2014 22:39:01 -0700 (PDT)
Received: from google.com ([172.16.51.27])
        by mx.google.com with ESMTPSA id p62sm453944ioe.33.2014.10.22.22.38.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Oct 2014 22:39:01 -0700 (PDT)
Date:   Wed, 22 Oct 2014 23:38:58 -0600
From:   Bjorn Helgaas <bhelgaas@google.com>
To:     Yijing Wang <wangyijing@huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arch@vger.kernel.org, arnab.basu@freescale.com,
        Bharat.Bhushan@freescale.com, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Vrabel <david.vrabel@citrix.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Liviu Dudau <liviu@dudau.co.uk>
Subject: Re: [PATCH v3 09/27] arm/PCI: Clean unused pcibios_add_bus() and
 pcibios_remove_bus()
Message-ID: <20141023053858.GD11770@google.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-10-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413342435-7876-10-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

On Wed, Oct 15, 2014 at 11:06:57AM +0800, Yijing Wang wrote:
> MSI chip will be saved in pci_sys_data, now we can
> clean up pcibios_add_bus() and pcibios_remove_bus()
> in arm, and use pci_find_msi_chip() to get msi chip
> in core MSI code.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  arch/arm/include/asm/mach/pci.h |    4 ----
>  arch/arm/kernel/bios32.c        |   16 ----------------
>  drivers/pci/msi.c               |   11 +++--------
>  3 files changed, 3 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index 59b0d87..230b2c9 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -39,8 +39,6 @@ struct hw_pci {
>  					  resource_size_t start,
>  					  resource_size_t size,
>  					  resource_size_t align);
> -	void		(*add_bus)(struct pci_bus *bus);
> -	void		(*remove_bus)(struct pci_bus *bus);
>  };
>  
>  /*
> @@ -71,8 +69,6 @@ struct pci_sys_data {
>  					  resource_size_t start,
>  					  resource_size_t size,
>  					  resource_size_t align);
> -	void		(*add_bus)(struct pci_bus *bus);
> -	void		(*remove_bus)(struct pci_bus *bus);
>  	void		*private_data;	/* platform controller private data	*/
>  };
>  
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index a19038d..b1b872e 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -360,20 +360,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pcibios_fixup_bus);
>  
> -void pcibios_add_bus(struct pci_bus *bus)
> -{
> -	struct pci_sys_data *sys = bus->sysdata;
> -	if (sys->add_bus)
> -		sys->add_bus(bus);
> -}
> -
> -void pcibios_remove_bus(struct pci_bus *bus)
> -{
> -	struct pci_sys_data *sys = bus->sysdata;
> -	if (sys->remove_bus)
> -		sys->remove_bus(bus);
> -}
> -
>  /*
>   * Swizzle the device pin each time we cross a bridge.  If a platform does
>   * not provide a swizzle function, we perform the standard PCI swizzling.
> @@ -478,8 +464,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>  		sys->swizzle = hw->swizzle;
>  		sys->map_irq = hw->map_irq;
>  		sys->align_resource = hw->align_resource;
> -		sys->add_bus = hw->add_bus;
> -		sys->remove_bus = hw->remove_bus;
>  		INIT_LIST_HEAD(&sys->resources);
>  
>  		if (hw->private_data)

What do the core changes below have to do with the ARM changes above?
They should be a separate patch unless they can't be separated.

> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index f11108c..56e54ad 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -32,12 +32,10 @@ int pci_msi_ignore_mask;
>  
>  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>  {
> -	struct msi_chip *chip = dev->bus->msi;
> +	struct msi_chip *chip;
>  	int err;
>  
> -	if (!chip)
> -		chip = pci_msi_chip(dev->bus);
> -
> +	chip = pci_msi_chip(dev->bus);
>  	if (!chip || !chip->setup_irq)
>  		return -EINVAL;
>  
> @@ -51,10 +49,7 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>  void __weak arch_teardown_msi_irq(unsigned int irq)
>  {
>  	struct msi_desc *entry = irq_get_msi_desc(irq);
> -	struct msi_chip *chip = entry->dev->bus->msi;
> -
> -	if (!chip)
> -		chip = pci_msi_chip(entry->dev->bus);
> +	struct msi_chip *chip = pci_msi_chip(entry->dev->bus);
>  
>  	if (!chip || !chip->teardown_irq)
>  		return;
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
