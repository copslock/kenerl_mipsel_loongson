Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2014 15:10:05 +0200 (CEST)
Received: from smtp02.citrix.com ([66.165.176.63]:55969 "EHLO
        SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008725AbaIKNKCkeEf4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2014 15:10:02 +0200
X-IronPort-AV: E=Sophos;i="5.04,505,1406592000"; 
   d="scan'208";a="171354780"
Message-ID: <54119ED2.3070802@citrix.com>
Date:   Thu, 11 Sep 2014 14:08:34 +0100
From:   David Vrabel <david.vrabel@citrix.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
MIME-Version: 1.0
To:     Yijing Wang <wangyijing@huawei.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-mips@linux-mips.org>, <linux-ia64@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Xinwei Hu <huxinwei@huawei.com>,
        <sparclinux@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-s390@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        "Joerg Roedel" <joro@8bytes.org>, <x86@kernel.org>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <xen-devel@lists.xenproject.org>, <arnab.basu@freescale.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <Bharat.Bhushan@freescale.com>, "Tony Luck" <tony.luck@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <iommu@lists.linux-foundation.org>, Wuyun <wuyun.wu@huawei.com>,
        <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [Xen-devel] [PATCH v1 04/21] x86/xen/MSI: Eliminate arch_msix_mask_irq()
 and arch_msi_mask_irq()
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>   <1409911806-10519-5-git-send-email-wangyijing@huawei.com>       <541045BE.9050804@citrix.com> <5410F955.80609@huawei.com>
In-Reply-To: <5410F955.80609@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-DLP:  MIA1
Return-Path: <david.vrabel@citrix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42521
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

On 11/09/14 02:22, Yijing Wang wrote:
> On 2014/9/10 20:36, David Vrabel wrote:
>> On 05/09/14 11:09, Yijing Wang wrote:
>>> Commit 0e4ccb150 added two __weak arch functions arch_msix_mask_irq()
>>> and arch_msi_mask_irq() to fix a bug found when running xen in x86.
>>> Introduced these two funcntions make MSI code complex. And mask/unmask
>>> is the irq actions related to interrupt controller, should not use
>>> weak arch functions to override mask/unmask interfaces. This patch
>>> reverted commit 0e4ccb150 and export struct irq_chip msi_chip, modify
>>> msi_chip->irq_mask/irq_unmask() in xen init functions to fix this
>>> bug for simplicity. Also this is preparation for using struct
>>> msi_chip instead of weak arch MSI functions in all platforms.
>>
>> Acked-by: David Vrabel <david.vrabel@citrix.com>
>>
>> But I wonder if it would be better the Xen subsystem to provide its own
>> struct irq_chip instead of adjusting the fields in the generic x86 one.
> 
> Thanks! Currently, Xen and the bare x86 system only have the different irq_chip->irq_mask/irq_unmask.
> So I chose to override the two ops of bare x86 irq_chip in xen. Konrad Rzeszutek Wilk has been tested it
> ok in his platform, so I think we could use its own irq_chip for xen later if the difference become large.

This sounds reasonable.

David
