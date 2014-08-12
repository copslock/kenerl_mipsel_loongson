Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2014 21:11:00 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:18834 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6821694AbaHLTK5qlI1s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Aug 2014 21:10:57 +0200
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id s7CJA0Jm022731
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 12 Aug 2014 19:10:03 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
        by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s7CJ9pUN017065
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Aug 2014 19:09:53 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s7CJ9oTt001080;
        Tue, 12 Aug 2014 19:09:50 GMT
Received: from laptop.dumpdata.com (/50.195.21.189)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Aug 2014 12:09:50 -0700
Received: by laptop.dumpdata.com (Postfix, from userid 1000)
        id CEEA8C2500; Tue, 12 Aug 2014 15:09:47 -0400 (EDT)
Date:   Tue, 12 Aug 2014 15:09:47 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Yijing Wang <wangyijing@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
        linux-pci@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@arm.linux.org.uk>,
        arnab.basu@freescale.com, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [RFC PATCH 07/20] x86/MSI: Use msi_chip instead of arch func to
 configure MSI/MSI-X
Message-ID: <20140812190947.GD13996@laptop.dumpdata.com>
References: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
 <1407828373-24322-8-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1407828373-24322-8-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Source-IP: acsinet22.oracle.com [141.146.126.238]
Return-Path: <konrad.wilk@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: konrad.wilk@oracle.com
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

On Tue, Aug 12, 2014 at 03:26:00PM +0800, Yijing Wang wrote:
> Introduce a new struct msi_chip apic_msi_chip instead of weak arch
> functions to configure MSI/MSI-X in x86.

Why not 'x86_msi_ops' (see  arch/x86/kernel/x86_init.c)
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  arch/x86/include/asm/pci.h     |    1 +
>  arch/x86/kernel/apic/io_apic.c |   20 ++++++++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index 0892ea0..878a06d 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -101,6 +101,7 @@ void native_teardown_msi_irq(unsigned int irq);
>  void native_restore_msi_irqs(struct pci_dev *dev);
>  int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
>  		  unsigned int irq_base, unsigned int irq_offset);
> +extern struct msi_chip *x86_msi_chip;
>  #else
>  #define native_setup_msi_irqs		NULL
>  #define native_teardown_msi_irq		NULL
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 2609dcd..eb8ab7c 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -3077,24 +3077,25 @@ int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
>  	return 0;
>  }
>  
> -int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> +int native_setup_msi_irqs(struct device *dev, int nvec, int type)
>  {
>  	struct msi_desc *msidesc;
>  	unsigned int irq;
>  	int node, ret;
> +	struct pci_dev *pdev = to_pci_dev(dev);
>  
>  	/* Multiple MSI vectors only supported with interrupt remapping */
>  	if (type == PCI_CAP_ID_MSI && nvec > 1)
>  		return 1;
>  
> -	node = dev_to_node(&dev->dev);
> +	node = dev_to_node(dev);
>  
> -	list_for_each_entry(msidesc, &dev->msi_list, list) {
> +	list_for_each_entry(msidesc, &pdev->msi_list, list) {
>  		irq = irq_alloc_hwirq(node);
>  		if (!irq)
>  			return -ENOSPC;
>  
> -		ret = setup_msi_irq(dev, msidesc, irq, 0);
> +		ret = setup_msi_irq(pdev, msidesc, irq, 0);
>  		if (ret < 0) {
>  			irq_free_hwirq(irq);
>  			return ret;
> @@ -3214,6 +3215,17 @@ int default_setup_hpet_msi(unsigned int irq, unsigned int id)
>  }
>  #endif
>  
> +struct msi_chip apic_msi_chip = {
> +	.setup_irqs = native_setup_msi_irqs,
> +	.teardown_irq = native_teardown_msi_irq,
> +};
> +
> +struct msi_chip *arch_get_match_msi_chip(struct device *dev)
> +{
> +	return x86_msi_chip;
> +}
> +
> +struct msi_chip *x86_msi_chip = &apic_msi_chip;
>  #endif /* CONFIG_PCI_MSI */
>  /*
>   * Hypertransport interrupt support
> -- 
> 1.7.1
> 
