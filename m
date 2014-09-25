Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 12:39:13 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:55881 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008971AbaIYKjLKP3mc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2014 12:39:11 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1XX6RY-0006WH-GL; Thu, 25 Sep 2014 12:38:36 +0200
Date:   Thu, 25 Sep 2014 12:38:34 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Yijing Wang <wangyijing@huawei.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
        Wuyun <wuyun.wu@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arch@vger.kernel.org, arnab.basu@freescale.com,
        Bharat.Bhushan@freescale.com, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
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
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 06/22] PCI/MSI: Introduce weak arch_find_msi_chip()
 to find MSI chip
In-Reply-To: <1411614872-4009-7-git-send-email-wangyijing@huawei.com>
Message-ID: <alpine.DEB.2.10.1409251220570.4604@nanos>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com> <1411614872-4009-7-git-send-email-wangyijing@huawei.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Thu, 25 Sep 2014, Yijing Wang wrote:

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

This is really backwards. On one hand you try to get rid of the weak
arch functions zoo and then you invent new ones for no good
reason. Why can't x86 store the chip in the pci bus?

Looking deeper, I'm questioning the whole notion of different
msi_chips. Are this really different MSI controllers with a different
feature set or are this defacto multiple instances of the same
controller which just need a different data set?

Thanks,

	tglx
