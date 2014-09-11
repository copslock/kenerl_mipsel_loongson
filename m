Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2014 03:24:47 +0200 (CEST)
Received: from szxga03-in.huawei.com ([119.145.14.66]:41542 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006909AbaIKBYnRXHpn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2014 03:24:43 +0200
Received: from 172.24.2.119 (EHLO szxeml448-hub.china.huawei.com) ([172.24.2.119])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id AUE31679;
        Thu, 11 Sep 2014 09:22:48 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml448-hub.china.huawei.com
 (10.82.67.191) with Microsoft SMTP Server id 14.3.158.1; Thu, 11 Sep 2014
 09:22:37 +0800
Message-ID: <5410F955.80609@huawei.com>
Date:   Thu, 11 Sep 2014 09:22:29 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     David Vrabel <david.vrabel@citrix.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-mips@linux-mips.org>, <linux-ia64@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <Bharat.Bhushan@freescale.com>,
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
        Xinwei Hu <huxinwei@huawei.com>,
        "Tony Luck" <tony.luck@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <iommu@lists.linux-foundation.org>, Wuyun <wuyun.wu@huawei.com>,
        <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [Xen-devel] [PATCH v1 04/21] x86/xen/MSI: Eliminate arch_msix_mask_irq()
 and arch_msi_mask_irq()
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com> <1409911806-10519-5-git-send-email-wangyijing@huawei.com> <541045BE.9050804@citrix.com>
In-Reply-To: <541045BE.9050804@citrix.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A020208.5410F96D.006D,ss=1,re=0.000,fgs=0,
        ip=0.0.0.0,
        so=2013-05-26 15:14:31,
        dmn=2011-05-27 18:58:46
X-Mirapoint-Loop-Id: 5b23eb4297e59afdb70bc19d5e198dc7
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wangyijing@huawei.com
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

On 2014/9/10 20:36, David Vrabel wrote:
> On 05/09/14 11:09, Yijing Wang wrote:
>> Commit 0e4ccb150 added two __weak arch functions arch_msix_mask_irq()
>> and arch_msi_mask_irq() to fix a bug found when running xen in x86.
>> Introduced these two funcntions make MSI code complex. And mask/unmask
>> is the irq actions related to interrupt controller, should not use
>> weak arch functions to override mask/unmask interfaces. This patch
>> reverted commit 0e4ccb150 and export struct irq_chip msi_chip, modify
>> msi_chip->irq_mask/irq_unmask() in xen init functions to fix this
>> bug for simplicity. Also this is preparation for using struct
>> msi_chip instead of weak arch MSI functions in all platforms.
> 
> Acked-by: David Vrabel <david.vrabel@citrix.com>
> 
> But I wonder if it would be better the Xen subsystem to provide its own
> struct irq_chip instead of adjusting the fields in the generic x86 one.

Thanks! Currently, Xen and the bare x86 system only have the different irq_chip->irq_mask/irq_unmask.
So I chose to override the two ops of bare x86 irq_chip in xen. Konrad Rzeszutek Wilk has been tested it
ok in his platform, so I think we could use its own irq_chip for xen later if the difference become large.

Thanks!
Yijing.

> 
> David
> 
> .
> 


-- 
Thanks!
Yijing
