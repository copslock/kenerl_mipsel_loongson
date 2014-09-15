Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2014 16:45:04 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57615 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008869AbaIOOo7sd6Ic (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Sep 2014 16:44:59 +0200
Received: from weser.hi.pengutronix.de ([2001:67c:670:100:fa0f:41ff:fe58:4010])
        by metis.ext.pengutronix.de with esmtp (Exim 4.72)
        (envelope-from <l.stach@pengutronix.de>)
        id 1XTXVu-0003dE-NH; Mon, 15 Sep 2014 16:44:22 +0200
Message-ID: <1410792261.3314.9.camel@pengutronix.de>
Subject: Re: [PATCH v1 06/21] PCI/MSI: Refactor struct msi_chip to make it
 become more common
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
Date:   Mon, 15 Sep 2014 16:44:21 +0200
In-Reply-To: <1409911806-10519-7-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
         <1409911806-10519-7-git-send-email-wangyijing@huawei.com>
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
X-archive-position: 42567
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

Am Freitag, den 05.09.2014, 18:09 +0800 schrieb Yijing Wang:
> Now there are a lot of __weak arch functions in MSI code.
> These functions make MSI driver complex. Thierry Reding Introduced
> a new MSI chip framework to configure MSI/MSI-X irq in ARM. Use
> the new MSI chip framework to refactor all other platform MSI
> arch code to eliminate weak arch MSI functions. This patch add
> .restore_irq() and .setup_irqs() to make it become more common.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

This change looks good to me:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/msi.c   |   15 +++++++++++++++
>  include/linux/msi.h |    3 +++
>  2 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 539c11d..d78d637 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -63,6 +63,11 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  {
>  	struct msi_desc *entry;
>  	int ret;
> +	struct msi_chip *chip;
> +
> +	chip = arch_find_msi_chip(dev);
> +	if (chip && chip->setup_irqs)
> +		return chip->setup_irqs(dev, nvec, type);
>  
>  	/*
>  	 * If an architecture wants to support multiple MSI, it needs to
> @@ -105,6 +110,11 @@ void default_teardown_msi_irqs(struct pci_dev *dev)
>  
>  void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
>  {
> +	struct msi_chip *chip = arch_find_msi_chip(dev);
> +
> +	if (chip && chip->teardown_irqs)
> +		return chip->teardown_irqs(dev);
> +
>  	return default_teardown_msi_irqs(dev);
>  }
>  
> @@ -128,6 +138,11 @@ static void default_restore_msi_irq(struct pci_dev *dev, int irq)
>  
>  void __weak arch_restore_msi_irqs(struct pci_dev *dev)
>  {
> +	struct msi_chip *chip = arch_find_msi_chip(dev);
> +
> +	if (chip && chip->restore_irqs)
> +		return chip->restore_irqs(dev);
> +
>  	return default_restore_msi_irqs(dev);
>  }
>  
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 5650848..92a51e7 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -72,7 +72,10 @@ struct msi_chip {
>  	struct list_head list;
>  
>  	int (*setup_irq)(struct pci_dev *dev, struct msi_desc *desc);
> +	int (*setup_irqs)(struct pci_dev *dev, int nvec, int type);
>  	void (*teardown_irq)(unsigned int irq);
> +	void (*teardown_irqs)(struct pci_dev *dev);
> +	void (*restore_irqs)(struct pci_dev *dev);
>  };
>  
>  #endif /* LINUX_MSI_H */

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
