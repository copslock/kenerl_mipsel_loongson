Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2014 16:43:32 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57558 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008962AbaIOOn05SAxP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Sep 2014 16:43:26 +0200
Received: from weser.hi.pengutronix.de ([2001:67c:670:100:fa0f:41ff:fe58:4010])
        by metis.ext.pengutronix.de with esmtp (Exim 4.72)
        (envelope-from <l.stach@pengutronix.de>)
        id 1XTXUG-0003ZG-45; Mon, 15 Sep 2014 16:42:40 +0200
Message-ID: <1410792154.3314.7.camel@pengutronix.de>
Subject: Re: [PATCH v1 05/21] PCI/MSI: Introduce weak arch_find_msi_chip()
 to find MSI chip
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
Date:   Mon, 15 Sep 2014 16:42:34 +0200
In-Reply-To: <1409911806-10519-6-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
         <1409911806-10519-6-git-send-email-wangyijing@huawei.com>
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
X-archive-position: 42566
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
> Introduce weak arch_find_msi_chip() to find the match msi_chip.
> Currently, MSI chip associates pci bus to msi_chip. Because in
> ARM platform, there may be more than one MSI controller in system.
> Associate pci bus to msi_chip help pci device to find the match
> msi_chip and setup MSI/MSI-X irq correctly. But in other platform,
> like in x86. we only need one MSI chip, because all device use
> the same MSI address/data and irq etc. So it's no need to associate
> pci bus to MSI chip, just use a arch function, arch_find_msi_chip()
> to return the MSI chip for simplicity. The default weak
> arch_find_msi_chip() used in ARM platform, find the MSI chip
> by pci bus.
> 
Hm, while one weak function sounds much better than the plethora we have
now, I wonder how much work it would be to associate the msi_chip with
the pci bus on other arches the same way as done on ARM. This way we
could kill this calling into arch specific functions which would make
things a bit clearer to follow I think.

Regards,
Lucas

> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/msi.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index a77e7f7..539c11d 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -29,9 +29,14 @@ static int pci_msi_enable = 1;
>  
>  /* Arch hooks */
>  
> +struct msi_chip * __weak arch_find_msi_chip(struct pci_dev *dev)
> +{
> +	return dev->bus->msi;
> +}
> +
>  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>  {
> -	struct msi_chip *chip = dev->bus->msi;
> +	struct msi_chip *chip = arch_find_msi_chip(dev);
>  	int err;
>  
>  	if (!chip || !chip->setup_irq)

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
