Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2014 10:38:28 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51510 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008572AbaI2Ii00hWN4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Sep 2014 10:38:26 +0200
Received: from weser.hi.pengutronix.de ([2001:67c:670:100:fa0f:41ff:fe58:4010])
        by metis.ext.pengutronix.de with esmtp (Exim 4.72)
        (envelope-from <l.stach@pengutronix.de>)
        id 1XYWSo-0003Uq-PP; Mon, 29 Sep 2014 10:37:46 +0200
Message-ID: <1411979850.2625.7.camel@pengutronix.de>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Yijing Wang <wangyijing@huawei.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Liviu Dudau <liviu@dudau.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
        Wuyun <wuyun.wu@huawei.com>,
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
        David Vrabel <david.vrabel@citrix.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date:   Mon, 29 Sep 2014 10:37:30 +0200
In-Reply-To: <5427A6A0.5040703@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
         <20140925074235.GN12423@ulmo> <20140925144855.GB31157@bart.dudau.co.uk>
         <20140925164937.GB30382@ulmo> <20140925171612.GC31157@bart.dudau.co.uk>
         <542505B3.7040208@huawei.com> <20140926085430.GG31106@ulmo>
         <20140926090537.GH31106@ulmo> <54277327.6070500@huawei.com>
         <5427A6A0.5040703@huawei.com>
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
X-archive-position: 42874
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

Am Sonntag, den 28.09.2014, 14:11 +0800 schrieb Yijing Wang:
> On 2014/9/28 10:32, Yijing Wang wrote:
> > On 2014/9/26 17:05, Thierry Reding wrote:
> >> On Fri, Sep 26, 2014 at 10:54:32AM +0200, Thierry Reding wrote:
> >> [...]
> >>> At least for Tegra it's trivial to just hook it up in tegra_pcie_scan_bus()
> >>> directly (patch attached).
> >>
> >> Really attached this time.
> >>
> >> Thierry
> >>
> > 
> > It looks good to me, so I will update the arm pci hostbridge driver to assign
> > pci root bus the msi chip instead of current pcibios_add_bus(). But for other
> > platforms which only have a one msi chip, I will kept the arch_find_msi_chip()
> > temporarily for more comments, especially from Bjorn.
> 
> Oh, sorry, I found designware and rcar use pci_scan_root_bus(), so we can not simply
> assign msi chip to root bus in all host drivers's scan functions.

Designware will switch away from pci_scan_root_bus() in the 3.18 cycle
and I would think it would be no problem to to the same with rcar.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
