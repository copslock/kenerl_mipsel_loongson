Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 07:36:07 +0200 (CEST)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:57116 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011418AbaJWFgEzdKIa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 07:36:04 +0200
Received: by mail-ie0-f169.google.com with SMTP id tr6so322587ieb.14
        for <linux-mips@linux-mips.org>; Wed, 22 Oct 2014 22:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EG5CwkDYLMIPER1NzYWak7B4dIcs49OJN27xiKaKiJw=;
        b=AotD3IaPMGP9dq7lXO+uQsXvtml9Vv8wApQc/Z4cyQ34mRI+AT3whbpsjTkN54L8zO
         uuDPwYLMmgwd8MdWXpEch+QL+JOc6z/Ti5S6uYPWs+vIpXaxiTn33XqOifufMue07NbQ
         wy0OUhiNl8RbfcXWjOhNQK+S1uiIuchgni3FIYiDBLggftyaNInnTXjOLcy4IvygadUL
         /bOk9g4Z2sOHq0Ocox9LU4OYKyaPnnGRS2R87lP01u2YlpSBH5e13CueYp9AuqlqstwT
         BKasxuLQZUjmSLxvtxg4dZ99oPV32JBBj0B+56SWMR4pW5CofnQ+FKCRClasH1j4T3Ng
         12zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=EG5CwkDYLMIPER1NzYWak7B4dIcs49OJN27xiKaKiJw=;
        b=c437MUYCw0BkZAX8/WVqfkqke2J1d4z6ymkpYYzpJwlrAP5P+TkE0pCKz1xmayEPqj
         UqvqGnxGP4oGXECxT28Vfy6eXJn/ZijAXTJshWrUrY8Z+NEuPXUZ+SRdSTahUh4S6MGO
         EsmW9+nqmGKRirODNeMzJWCCBeOjyy1ZZgLMGOEMcYOLdiuwIb7sG9ui7cmTLUwkf5gL
         wScx6umu97qIMLRB8nMlR5e2E29AJbR1jqBf1yeOmh3+lJuoYJS9z5rUkzcTJFk15Rw4
         dv9cwNlDQ91HgVoMewvi8X8GVXRaagFFQspBYFVYeYLWK8JFAe8mxCuplFym5fUD1y6h
         kjOg==
X-Gm-Message-State: ALoCoQleHRxe+K59rgG+urHydUURhOU/CBaLZpyhDhaMRSc7gbBH7ZNOwvoHxkD14v7uKuo3xILP
X-Received: by 10.107.167.66 with SMTP id q63mr2682883ioe.23.1414042558767;
        Wed, 22 Oct 2014 22:35:58 -0700 (PDT)
Received: from google.com ([172.16.51.27])
        by mx.google.com with ESMTPSA id dx10sm711645igb.4.2014.10.22.22.35.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Oct 2014 22:35:58 -0700 (PDT)
Date:   Wed, 22 Oct 2014 23:35:55 -0600
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
Subject: Re: [PATCH v3 04/27] arm/MSI: Save MSI chip in pci_sys_data
Message-ID: <20141023053555.GC11770@google.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-5-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413342435-7876-5-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43522
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

On Wed, Oct 15, 2014 at 11:06:52AM +0800, Yijing Wang wrote:
> Saving msi chip in pci_sys_data can make pci bus and
> devices don't need to know msi chip detail, it also
> make pci enumeration code be decoupled from msi chip.
> In fact, all pci devices under the same pci hostbridge
> share same msi chip. So msi chip should be seen as one
> of resources or attributes to be initialized in pci host
> bridge driver. Currently, pci hostbridge drivers create
> pci_host_bridge in pci_create_root_bus(), and pass arch
> specific pci sysdata to core pci scan functions. So pci
> arch sysdata is good place to save msi chip.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  arch/arm/include/asm/mach/pci.h |    6 ++++++
>  arch/arm/include/asm/pci.h      |    9 +++++++++
>  arch/arm/kernel/bios32.c        |    3 +++
>  drivers/pci/msi.c               |    6 ++++++
>  include/linux/pci.h             |    9 +++++++++
>  5 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index 7fc4278..59b0d87 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -22,6 +22,9 @@ struct hw_pci {
>  #ifdef CONFIG_PCI_DOMAINS
>  	int		domain;
>  #endif
> +#ifdef CONFIG_PCI_MSI
> +	struct msi_chip *msi_chip;
> +#endif
>  	struct pci_ops	*ops;
>  	int		nr_controllers;
>  	void		**private_data;
> @@ -47,6 +50,9 @@ struct pci_sys_data {
>  #ifdef CONFIG_PCI_DOMAINS
>  	int		domain;
>  #endif
> +#ifdef CONFIG_PCI_MSI
> +	struct msi_chip *msi_chip;
> +#endif
>  	struct list_head node;
>  	int		busnr;		/* primary bus number			*/
>  	u64		mem_offset;	/* bus->cpu memory mapping offset	*/
> diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
> index 7e95d85..b562c09 100644
> --- a/arch/arm/include/asm/pci.h
> +++ b/arch/arm/include/asm/pci.h
> @@ -31,6 +31,15 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  }
>  #endif /* CONFIG_PCI_DOMAINS */
>  
> +#ifdef CONFIG_PCI_MSI
> +static inline struct msi_chip *pci_msi_chip(struct pci_bus *bus)
> +{
> +	struct pci_sys_data *root = bus->sysdata;
> +
> +	return root->msi_chip;
> +}
> +#endif
> +
>  /*
>   * The PCI address space does equal the physical memory address space.
>   * The networking and block device layers use this boolean for bounce
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 17a26c1..a19038d 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -471,6 +471,9 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>  #ifdef CONFIG_PCI_DOMAINS
>  		sys->domain  = hw->domain;
>  #endif
> +#ifdef CONFIG_PCI_MSI
> +		sys->msi_chip = hw->msi_chip;
> +#endif
>  		sys->busnr   = busnr;
>  		sys->swizzle = hw->swizzle;
>  		sys->map_irq = hw->map_irq;
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 22e413c..f11108c 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -35,6 +35,9 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>  	struct msi_chip *chip = dev->bus->msi;
>  	int err;
>  
> +	if (!chip)
> +		chip = pci_msi_chip(dev->bus);
> +
>  	if (!chip || !chip->setup_irq)
>  		return -EINVAL;
>  
> @@ -50,6 +53,9 @@ void __weak arch_teardown_msi_irq(unsigned int irq)
>  	struct msi_desc *entry = irq_get_msi_desc(irq);
>  	struct msi_chip *chip = entry->dev->bus->msi;
>  
> +	if (!chip)
> +		chip = pci_msi_chip(entry->dev->bus);
> +
>  	if (!chip || !chip->teardown_irq)
>  		return;
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9cd2721..7a48b40 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1433,6 +1433,15 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>  
>  #include <asm/pci.h>
>  
> +/* Just avoid compile error, will be clean up later */
> +#ifdef CONFIG_PCI_MSI
> +
> +#ifndef pci_msi_chip
> +#define pci_msi_chip(bus)	NULL
> +#endif
> +#endif

I don't like the mixture of ARM changes and PCI core changes in the same
patch.  Can you split this into a core patch that does something like this:

  struct msi_chip * __weak pcibios_msi_controller(struct pci_bus *bus)
  {
    return NULL;
  }

  struct msi_chip *pci_msi_controller(struct pci_bus *bus)
  {
    msi_chip *controller = bus->msi;

    if (controller)
      return controller;
    return pcibios_msi_controller(bus);
  }

followed by an ARM patch that puts the msi_chip pointer in struct hw_pci
and implements pcibios_msi_controller()?

I know you're trying to *remove* weak functions, and this adds one, but
this section of the series is more about getting rid of the ARM
pcibios_add_bus() because all it was used for was setting the bus->msi
pointer.

Eventually we might have a way to stash an MSI controller pointer in the
generic pci_host_bridge struct, and then the pcibios_msi_controller()
interface could go away.

> +
>  /* these helpers provide future and backwards compatibility
>   * for accessing popular PCI BAR info */
>  #define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)
> -- 
> 1.7.1
> 
