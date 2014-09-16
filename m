Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 12:30:23 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59981 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007194AbaIPKaQWygbn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 12:30:16 +0200
Received: from weser.hi.pengutronix.de ([2001:67c:670:100:fa0f:41ff:fe58:4010])
        by metis.ext.pengutronix.de with esmtp (Exim 4.72)
        (envelope-from <l.stach@pengutronix.de>)
        id 1XTq0g-0000qG-1S; Tue, 16 Sep 2014 12:29:22 +0200
Message-ID: <1410863349.2746.5.camel@pengutronix.de>
Subject: Re: [PATCH v1 03/21] MSI: Remove the redundant irq_set_chip_data()
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
Date:   Tue, 16 Sep 2014 12:29:09 +0200
In-Reply-To: <541792C0.9090303@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
                 <1409911806-10519-4-git-send-email-wangyijing@huawei.com>
         <1410789648.3314.5.camel@pengutronix.de> <541792C0.9090303@huawei.com>
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
X-archive-position: 42649
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

Am Dienstag, den 16.09.2014, 09:30 +0800 schrieb Yijing Wang:
> On 2014/9/15 22:00, Lucas Stach wrote:
> > Am Freitag, den 05.09.2014, 18:09 +0800 schrieb Yijing Wang:
> >> Currently, pcie-designware, pcie-rcar, pci-tegra drivers
> >> use irq chip_data to save the msi_chip pointer. They
> >> already call irq_set_chip_data() in their own MSI irq map
> >> functions. So irq_set_chip_data() in arch_setup_msi_irq()
> >> is useless.
> >>
> >> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> >> ---
> >>  drivers/pci/msi.c |    2 --
> >>  1 files changed, 0 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> >> index f6cb317..d547f7f 100644
> >> --- a/drivers/pci/msi.c
> >> +++ b/drivers/pci/msi.c
> >> @@ -41,8 +41,6 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> >>  	if (err < 0)
> >>  		return err;
> >>  
> >> -	irq_set_chip_data(desc->irq, chip);
> >> -
> >>  	return 0;
> >>  }
> >>  
> > 
> > arch_teardown_msi_irq() expects to find the msi_chip in the irq
> > chip_data field. As this means drivers don't have any reasonable other
> > possibility to stuff things into this field, I think it would make sense
> > to do the cleanup the other way around: keep the irq_set_chip_data
> > arch_setup_msi_irq() and rip it out of the individual drivers.
> 
> Hi Lucas, thanks for your review and comments!
> irq_set_chip_data() should not be placed in MSI core functions, because other arch like x86,
> use irq_data->chip_data to stores irq_cfg. So how to set the chip_data is arch dependent.
> And this series is mainly to use MSI chip framework in all platforms.
> Currently, only ARM platform MSI drivers use the chip_data to store msi_chip, and the drivers call
> irq_set_chip_data() in their driver already. So I thought we should clean up it in MSI core code.
> 
Okay I see your point, so the cleanup done this way is okay.

But then this still introduces a problem: arch_teardown_msi_irq()
expects to find the msi_chip in the chip_data field, which is okay for
all ARM PCI host drivers, but not for other arch MSI chips.

You fix this by completely removing arch_teardown_msi_irq() at the end
of the series, but this still has the potential to introduce issues for
other arches than ARM within the series. So this patch should include a
change to replace the line

struct msi_chip *chip = irq_get_chip_data(irq);

with something that doesn't rely on the msi_chip being in the irq
chip_data field.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
