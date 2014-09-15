Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2014 16:47:47 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41006 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008962AbaIOOrpHU0qs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Sep 2014 16:47:45 +0200
Received: from weser.hi.pengutronix.de ([2001:67c:670:100:fa0f:41ff:fe58:4010])
        by metis.ext.pengutronix.de with esmtp (Exim 4.72)
        (envelope-from <l.stach@pengutronix.de>)
        id 1XTXYc-0003xy-Ij; Mon, 15 Sep 2014 16:47:10 +0200
Message-ID: <1410792430.3314.10.camel@pengutronix.de>
Subject: Re: [PATCH v1 21/21] PCI/MSI: Clean up unused MSI arch functions
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Yijing Wang <wangyijing@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
        Ralf Baechle <ralf@linux-mips.org>
Date:   Mon, 15 Sep 2014 16:47:10 +0200
In-Reply-To: <1409911806-10519-22-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
         <1409911806-10519-22-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <l.stach@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: l.stach@pengutronix.de
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

Am Freitag, den 05.09.2014, 18:10 +0800 schrieb Yijing Wang:
> Now we use struct msi_chip in all platforms to configure
> MSI/MSI-X. We can clean up the unused arch functions.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/iommu/irq_remapping.c |    2 +-
>  drivers/pci/msi.c             |   99 ++++++++++++++++-------------------------
>  include/linux/msi.h           |   14 ------
>  3 files changed, 39 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
> index 99b1c0f..6e645f0 100644
> --- a/drivers/iommu/irq_remapping.c
> +++ b/drivers/iommu/irq_remapping.c
> @@ -92,7 +92,7 @@ error:
>  
>  	/*
>  	 * Restore altered MSI descriptor fields and prevent just destroyed
> -	 * IRQs from tearing down again in default_teardown_msi_irqs()
> +	 * IRQs from tearing down again in teardown_msi_irqs()
>  	 */
>  	msidesc->irq = 0;
>  	msidesc->nvec_used = 0;
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index d78d637..e3e7f4f 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -34,50 +34,31 @@ struct msi_chip * __weak arch_find_msi_chip(struct pci_dev *dev)
>  	return dev->bus->msi;
>  }
>  
> -int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> -{
> -	struct msi_chip *chip = arch_find_msi_chip(dev);
> -	int err;
> -
> -	if (!chip || !chip->setup_irq)
> -		return -EINVAL;
> -
> -	err = chip->setup_irq(dev, desc);
> -	if (err < 0)
> -		return err;
> -
> -	return 0;
> -}
> -
> -void __weak arch_teardown_msi_irq(unsigned int irq)
> -{
> -	struct msi_chip *chip = irq_get_chip_data(irq);
> -
> -	if (!chip || !chip->teardown_irq)
> -		return;
> -
> -	chip->teardown_irq(irq);
> -}
> -
> -int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> +int setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  {
>  	struct msi_desc *entry;
>  	int ret;
>  	struct msi_chip *chip;
>  
>  	chip = arch_find_msi_chip(dev);
> -	if (chip && chip->setup_irqs)
> +	if (!chip)
> +		return -EINVAL;
> +
> +	if (chip->setup_irqs)
>  		return chip->setup_irqs(dev, nvec, type);
>  
>  	/*
>  	 * If an architecture wants to support multiple MSI, it needs to
> -	 * override arch_setup_msi_irqs()
> +	 * implement chip->setup_irqs().
>  	 */
>  	if (type == PCI_CAP_ID_MSI && nvec > 1)
>  		return 1;
>  
> +	if (!chip->setup_irq)
> +		return -EINVAL;
> +
>  	list_for_each_entry(entry, &dev->msi_list, list) {
> -		ret = arch_setup_msi_irq(dev, entry);
> +		ret = chip->setup_irq(dev, entry);
>  		if (ret < 0)
>  			return ret;
>  		if (ret > 0)
> @@ -87,13 +68,20 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  	return 0;
>  }
>  
> -/*
> - * We have a default implementation available as a separate non-weak
> - * function, as it is used by the Xen x86 PCI code
> - */
> -void default_teardown_msi_irqs(struct pci_dev *dev)
> +static void teardown_msi_irqs(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
> +	struct msi_chip *chip;
> +
> +	chip = arch_find_msi_chip(dev);
> +	if (!chip)
> +		return;
> +
> +	if (chip->teardown_irqs)
> +		return chip->teardown_irqs(dev);
> +
> +	if (!chip->teardown_irq)
> +		return;
>  
>  	list_for_each_entry(entry, &dev->msi_list, list) {
>  		int i, nvec;
> @@ -104,20 +92,10 @@ void default_teardown_msi_irqs(struct pci_dev *dev)
>  		else
>  			nvec = 1 << entry->msi_attrib.multiple;
>  		for (i = 0; i < nvec; i++)
> -			arch_teardown_msi_irq(entry->irq + i);
> +			chip->teardown_irq(entry->irq + i);
>  	}
>  }
>  
> -void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
> -{
> -	struct msi_chip *chip = arch_find_msi_chip(dev);
> -
> -	if (chip && chip->teardown_irqs)
> -		return chip->teardown_irqs(dev);
> -
> -	return default_teardown_msi_irqs(dev);
> -}
> -
>  static void default_restore_msi_irq(struct pci_dev *dev, int irq)
>  {
>  	struct msi_desc *entry;
> @@ -136,10 +114,18 @@ static void default_restore_msi_irq(struct pci_dev *dev, int irq)
>  		write_msi_msg(irq, &entry->msg);
>  }
>  
> -void __weak arch_restore_msi_irqs(struct pci_dev *dev)
> +static void default_restore_msi_irqs(struct pci_dev *dev)
>  {
> -	struct msi_chip *chip = arch_find_msi_chip(dev);
> +	struct msi_desc *entry = NULL;
> +
> +	list_for_each_entry(entry, &dev->msi_list, list) {
> +		default_restore_msi_irq(dev, entry->irq);
> +	}
> +}
>  
> +static void restore_msi_irqs(struct pci_dev *dev)
> +{
> +	struct msi_chip *chip = arch_find_msi_chip(dev);
>  	if (chip && chip->restore_irqs)
>  		return chip->restore_irqs(dev);
>  
> @@ -248,15 +234,6 @@ void unmask_msi_irq(struct irq_data *data)
>  	msi_set_mask_bit(data, 0);
>  }
>  
> -void default_restore_msi_irqs(struct pci_dev *dev)
> -{
> -	struct msi_desc *entry;
> -
> -	list_for_each_entry(entry, &dev->msi_list, list) {
> -		default_restore_msi_irq(dev, entry->irq);
> -	}
> -}
> -
>  void read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  {
>  	BUG_ON(entry->dev->current_state != PCI_D0);
> @@ -360,7 +337,7 @@ static void free_msi_irqs(struct pci_dev *dev)
>  			BUG_ON(irq_has_action(entry->irq + i));
>  	}
>  
> -	arch_teardown_msi_irqs(dev);
> +	teardown_msi_irqs(dev);
>  
>  	list_for_each_entry_safe(entry, tmp, &dev->msi_list, list) {
>  		if (entry->msi_attrib.is_msix) {
> @@ -430,7 +407,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
>  
>  	pci_intx_for_msi(dev, 0);
>  	msi_set_enable(dev, 0);
> -	arch_restore_msi_irqs(dev);
> +	restore_msi_irqs(dev);
>  
>  	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
>  	msi_mask_irq(entry, msi_mask(entry->msi_attrib.multi_cap),
> @@ -453,7 +430,7 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
>  	msix_clear_and_set_ctrl(dev, 0,
>  				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
>  
> -	arch_restore_msi_irqs(dev);
> +	restore_msi_irqs(dev);
>  	list_for_each_entry(entry, &dev->msi_list, list) {
>  		msix_mask_irq(entry, entry->masked);
>  	}
> @@ -624,7 +601,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
>  	list_add_tail(&entry->list, &dev->msi_list);
>  
>  	/* Configure MSI capability structure */
> -	ret = arch_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
> +	ret = setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
>  	if (ret) {
>  		msi_mask_irq(entry, mask, ~mask);
>  		free_msi_irqs(dev);
> @@ -740,7 +717,7 @@ static int msix_capability_init(struct pci_dev *dev,
>  	if (ret)
>  		return ret;
>  
> -	ret = arch_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
> +	ret = setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
>  	if (ret)
>  		goto out_avail;
>  
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 92a51e7..d6e1f7c 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -51,20 +51,6 @@ struct msi_desc {
>  	struct kobject kobj;
>  };
>  
> -/*
> - * The arch hooks to setup up msi irqs. Those functions are
> - * implemented as weak symbols so that they /can/ be overriden by
> - * architecture specific code if needed.
> - */
> -int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
> -void arch_teardown_msi_irq(unsigned int irq);
> -int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
> -void arch_teardown_msi_irqs(struct pci_dev *dev);
> -void arch_restore_msi_irqs(struct pci_dev *dev);
> -
> -void default_teardown_msi_irqs(struct pci_dev *dev);
> -void default_restore_msi_irqs(struct pci_dev *dev);
> -
>  struct msi_chip {
>  	struct module *owner;
>  	struct device *dev;

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
