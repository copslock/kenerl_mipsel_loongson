Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Oct 2014 15:04:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33843 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010814AbaJYNEtjaL-n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 25 Oct 2014 15:04:49 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9PD4cPV017193;
        Sat, 25 Oct 2014 15:04:38 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9PD4SBu017184;
        Sat, 25 Oct 2014 15:04:28 +0200
Date:   Sat, 25 Oct 2014 15:04:28 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yijing Wang <wangyijing@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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
        Lucas Stach <l.stach@pengutronix.de>,
        David Vrabel <david.vrabel@citrix.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Liviu Dudau <liviu@dudau.co.uk>
Subject: Re: [PATCH v3 16/27] Mips/MSI: Save msi chip in pci sysdata
Message-ID: <20141025130428.GD16738@linux-mips.org>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-17-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413342435-7876-17-git-send-email-wangyijing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Oct 15, 2014 at 11:07:04AM +0800, Yijing Wang wrote:

> +static inline struct msi_chip *pci_msi_chip(struct pci_bus *bus)
> +{
> +	struct pci_controller *control = (struct pci_controller *)bus->sysdata;

bus->sysdata is void * so this cast is unnecessary.

  Ralf
