Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 16:29:34 +0200 (CEST)
Received: from smtp.citrix.com ([66.165.176.89]:34757 "EHLO SMTP.CITRIX.COM"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008195AbaIEO3cPnnb9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Sep 2014 16:29:32 +0200
X-IronPort-AV: E=Sophos;i="5.04,473,1406592000"; 
   d="scan'208";a="168730226"
Message-ID: <5409C8C0.8020200@citrix.com>
Date:   Fri, 5 Sep 2014 15:29:20 +0100
From:   David Vrabel <david.vrabel@citrix.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
MIME-Version: 1.0
To:     Yijing Wang <wangyijing@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-mips@linux-mips.org>, <linux-ia64@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <Bharat.Bhushan@freescale.com>,
        <sparclinux@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-s390@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Joerg Roedel <joro@8bytes.org>, <x86@kernel.org>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <xen-devel@lists.xenproject.org>, <arnab.basu@freescale.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        Xinwei Hu <huxinwei@huawei.com>,
        Tony Luck <tony.luck@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <iommu@lists.linux-foundation.org>, Wuyun <wuyun.wu@huawei.com>,
        <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [Xen-devel] [PATCH v1 08/21] x86/xen/MSI: Use MSI chip framework
 to configure MSI/MSI-X irq
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com> <1409911806-10519-9-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1409911806-10519-9-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-DLP:  MIA1
Return-Path: <david.vrabel@citrix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.vrabel@citrix.com
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

On 05/09/14 11:09, Yijing Wang wrote:
> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
[...]
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
[...]
> @@ -418,9 +430,9 @@ int __init pci_xen_init(void)
>  #endif
>  
>  #ifdef CONFIG_PCI_MSI
> -	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
> -	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
> -	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
> +	xen_msi_chip.setup_irqs = xen_setup_msi_irqs;
> +	xen_msi_chip.teardown_irqs = xen_teardown_msi_irqs;
> +	x86_msi_chip = &xen_msi_chip;
>  	msi_chip.irq_mask = xen_nop_msi_mask;
>  	msi_chip.irq_unmask = xen_nop_msi_mask;

Why have these not been changed to set the x86_msi_chip.mask/unmask
fields instead?

David
