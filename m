Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 13:36:11 +0200 (CEST)
Received: from e06smtp10.uk.ibm.com ([195.75.94.106]:46439 "EHLO
        e06smtp10.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007194AbaIPLgFxDl3t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 13:36:05 +0200
Received: from /spool/local
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <sebott@linux.vnet.ibm.com>;
        Tue, 16 Sep 2014 12:36:00 +0100
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp10.uk.ibm.com (192.168.101.140) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 16 Sep 2014 12:35:57 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 06B2417D8056;
        Tue, 16 Sep 2014 12:38:00 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id s8GBZuIN44892248;
        Tue, 16 Sep 2014 11:35:56 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s8GBZsiP004269;
        Tue, 16 Sep 2014 05:35:56 -0600
Received: from dyn-9-152-212-91.boeblingen.de.ibm.com (dyn-9-152-212-91.boeblingen.de.ibm.com [9.152.212.91])
        by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id s8GBZrmo004225
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 16 Sep 2014 05:35:53 -0600
Date:   Tue, 16 Sep 2014 13:35:53 +0200 (CEST)
From:   Sebastian Ott <sebott@linux.vnet.ibm.com>
X-X-Sender: sebott@denkbrett
To:     Yijing Wang <wangyijing@huawei.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
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
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v1 16/21] s390/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
In-Reply-To: <1409911806-10519-17-git-send-email-wangyijing@huawei.com>
Message-ID: <alpine.LFD.2.11.1409161325280.1618@denkbrett>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com> <1409911806-10519-17-git-send-email-wangyijing@huawei.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH_=2F_Vorsitzende_des_Aufsichtsrats=3A_Martina_Koederitz_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Registergericht?=
 =?ISO-8859-15?Q?=3A_Amtsgericht_Stuttgart=2C_HRB_243294=22?=
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14091611-4966-0000-0000-00000158FAD2
Return-Path: <sebott@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebott@linux.vnet.ibm.com
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

Hello,

On Fri, 5 Sep 2014, Yijing Wang wrote:
> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  arch/s390/pci/pci.c |   18 ++++++++++++++----
>  1 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 2fa7b14..da5316e 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -358,7 +358,7 @@ static void zpci_irq_handler(struct airq_struct *airq)
>  	}
>  }
> 
> -int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> +int zpci_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  {
>  	struct zpci_dev *zdev = get_zdev(pdev);
>  	unsigned int hwirq, msi_vecs;
> @@ -434,7 +434,7 @@ out:
>  	return rc;
>  }
> 
> -void arch_teardown_msi_irqs(struct pci_dev *pdev)
> +static void zpci_teardown_msi_irqs(struct pci_dev *pdev)
>  {
>  	struct zpci_dev *zdev = get_zdev(pdev);
>  	struct msi_desc *msi;
> @@ -448,9 +448,9 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
>  	/* Release MSI interrupts */
>  	list_for_each_entry(msi, &pdev->msi_list, list) {
>  		if (msi->msi_attrib.is_msix)
> -			default_msix_mask_irq(msi, 1);
> +			__msix_mask_irq(msi, 1);
>  		else
> -			default_msi_mask_irq(msi, 1, 1);
> +			__msi_mask_irq(msi, 1, 1);

The default_msi_mask_irq to __msi_mask_irq renaming is hidden in your
patch "x86/xen/MSI: Eliminate arch_msix_mask_irq() and arch_msi_mask_irq()"

This means that between that patch and this one s390 will not compile.
Could you please move this hunk to the other patch or even make an extra
patch with the renaming. Other than that:

Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>

Regards,
Sebastian

>  		irq_set_msi_desc(msi->irq, NULL);
>  		irq_free_desc(msi->irq);
>  		msi->msg.address_lo = 0;
> @@ -464,6 +464,16 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
>  	airq_iv_free_bit(zpci_aisb_iv, zdev->aisb);
>  }
> 
> +static struct msi_chip zpci_msi_chip = {
> +	.setup_irqs = zpci_setup_msi_irqs,
> +	.teardown_irqs = zpci_teardown_msi_irqs,
> +};
> +
> +struct msi_chip *arch_find_msi_chip(struct pci_dev *dev)
> +{
> +	return &zpci_msi_chip;
> +}
> +
>  static void zpci_map_resources(struct zpci_dev *zdev)
>  {
>  	struct pci_dev *pdev = zdev->pdev;
> -- 
> 1.7.1
> 
> 
