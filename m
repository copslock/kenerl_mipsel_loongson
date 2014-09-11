Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2014 03:31:11 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:11908 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006909AbaIKBbIMfscK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2014 03:31:08 +0200
Received: from 172.24.2.119 (EHLO szxeml459-hub.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id BZH30357;
        Thu, 11 Sep 2014 09:29:13 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml459-hub.china.huawei.com
 (10.82.67.202) with Microsoft SMTP Server id 14.3.158.1; Thu, 11 Sep 2014
 09:29:02 +0800
Message-ID: <5410FAD9.40702@huawei.com>
Date:   Thu, 11 Sep 2014 09:28:57 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Vrabel <david.vrabel@citrix.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-mips@linux-mips.org>,
        <linux-ia64@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Xinwei Hu <huxinwei@huawei.com>, <sparclinux@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Joerg Roedel <joro@8bytes.org>, <x86@kernel.org>,
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
Subject: Re: [Xen-devel] [PATCH v1 08/21] x86/xen/MSI: Use MSI chip framework
 to configure MSI/MSI-X irq
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com> <1409911806-10519-9-git-send-email-wangyijing@huawei.com> <5409C8C0.8020200@citrix.com> <540E6095.8030409@huawei.com> <54104641.7020007@citrix.com> <20140910145957.GD12893@laptop.dumpdata.com>
In-Reply-To: <20140910145957.GD12893@laptop.dumpdata.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42502
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

On 2014/9/10 22:59, Konrad Rzeszutek Wilk wrote:
> On Wed, Sep 10, 2014 at 01:38:25PM +0100, David Vrabel wrote:
>> On 09/09/14 03:06, Yijing Wang wrote:
>>> On 2014/9/5 22:29, David Vrabel wrote:
>>>> On 05/09/14 11:09, Yijing Wang wrote:
>>>>> Use MSI chip framework instead of arch MSI functions to configure
>>>>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
>>>> [...]
>>>>> --- a/arch/x86/pci/xen.c
>>>>> +++ b/arch/x86/pci/xen.c
>>>> [...]
>>>>> @@ -418,9 +430,9 @@ int __init pci_xen_init(void)
>>>>>  #endif
>>>>>  
>>>>>  #ifdef CONFIG_PCI_MSI
>>>>> -	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
>>>>> -	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
>>>>> -	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
>>>>> +	xen_msi_chip.setup_irqs = xen_setup_msi_irqs;
>>>>> +	xen_msi_chip.teardown_irqs = xen_teardown_msi_irqs;
>>>>> +	x86_msi_chip = &xen_msi_chip;
>>>>>  	msi_chip.irq_mask = xen_nop_msi_mask;
>>>>>  	msi_chip.irq_unmask = xen_nop_msi_mask;
>>>>
>>>> Why have these not been changed to set the x86_msi_chip.mask/unmask
>>>> fields instead?
>>>
>>> Hi David, x86_msi_chip here is struct msi_chip data type, used to configure MSI/MSI-X
>>> irq. msi_chip above is struct irq_chip data type, represent the MSI irq controller. They are
>>> not the same object. Their name easily confusing people.
>>
>> Ok, it all makes sense now.
>>
>> Acked-by: David Vrabel <david.vrabel@citrix.com>
> 
> You can also add 'Tested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>'
> 
> on the whole series - I ran it through on Xen and on baremetal with a mix of 32/64 builds.
> 
> Oh, and also Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> the Xen parts.

Thanks very much for your test and review!

Thanks!
Yijing.

> 
>>
>> David
>>
>> _______________________________________________
>> Xen-devel mailing list
>> Xen-devel@lists.xen.org
>> http://lists.xen.org/xen-devel
> 
> .
> 


-- 
Thanks!
Yijing
