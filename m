Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2014 03:28:47 +0200 (CEST)
Received: from szxga01-in.huawei.com ([119.145.14.64]:47522 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6898576AbaHMB2Tf2QLh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Aug 2014 03:28:19 +0200
Received: from 172.24.2.119 (EHLO szxeml452-hub.china.huawei.com) ([172.24.2.119])
        by szxrg01-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CAF47567;
        Wed, 13 Aug 2014 09:17:05 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml452-hub.china.huawei.com
 (10.82.67.195) with Microsoft SMTP Server id 14.3.158.1; Wed, 13 Aug 2014
 09:16:51 +0800
Message-ID: <53EABC7E.6080103@huawei.com>
Date:   Wed, 13 Aug 2014 09:16:46 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, Xinwei Hu <huxinwei@huawei.com>,
        Wuyun <wuyun.wu@huawei.com>, <linux-pci@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        <arnab.basu@freescale.com>, <x86@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <xen-devel@lists.xenproject.org>,
        Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>, <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        "Tony Luck" <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        <sparclinux@vger.kernel.org>, Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [RFC PATCH 07/20] x86/MSI: Use msi_chip instead of arch func
 to configure MSI/MSI-X
References: <1407828373-24322-1-git-send-email-wangyijing@huawei.com> <1407828373-24322-8-git-send-email-wangyijing@huawei.com> <20140812190947.GD13996@laptop.dumpdata.com>
In-Reply-To: <20140812190947.GD13996@laptop.dumpdata.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42071
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

On 2014/8/13 3:09, Konrad Rzeszutek Wilk wrote:
> On Tue, Aug 12, 2014 at 03:26:00PM +0800, Yijing Wang wrote:
>> Introduce a new struct msi_chip apic_msi_chip instead of weak arch
>> functions to configure MSI/MSI-X in x86.
> 
> Why not 'x86_msi_ops' (see  arch/x86/kernel/x86_init.c)

Hi Konrad, I think currently lots of weak arch functions make MSI code
complex, we have following weak arch functions

arch_setup_msi_irqs
arch_setup_msi_irq
arch_msi_check_device
arch_teardown_msi_irqs
arch_teardown_msi_irq
arch_restore_msi_irqs
arch_msi_mask_irq
arch_msix_mask_irq

And Thierry Reding and Thomas Petazzoni introduce a new MSI chip infrastructure which
is used in arm platform now. Use msi_chip let us focus on implementing msi_chip ops functions(no need to implement all),
but now, we should know much of MSI enable flow, then override the weak functions.
I think use the unified MSI framework in all platforms is better.
Also this series is preparation to support Non-PCI MSI device use common MSI framework in linux. Non-PCI MSI devices
include hpet, dmar and the coming consolidator(introduced in ARM GICv3 spec, which is similar to MSI relay device).


Thanks!
Yijing.

>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  arch/x86/include/asm/pci.h     |    1 +
>>  arch/x86/kernel/apic/io_apic.c |   20 ++++++++++++++++----
>>  2 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
>> index 0892ea0..878a06d 100644
>> --- a/arch/x86/include/asm/pci.h
>> +++ b/arch/x86/include/asm/pci.h
>> @@ -101,6 +101,7 @@ void native_teardown_msi_irq(unsigned int irq);
>>  void native_restore_msi_irqs(struct pci_dev *dev);
>>  int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
>>  		  unsigned int irq_base, unsigned int irq_offset);
>> +extern struct msi_chip *x86_msi_chip;
>>  #else
>>  #define native_setup_msi_irqs		NULL
>>  #define native_teardown_msi_irq		NULL
>> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
>> index 2609dcd..eb8ab7c 100644
>> --- a/arch/x86/kernel/apic/io_apic.c
>> +++ b/arch/x86/kernel/apic/io_apic.c
>> @@ -3077,24 +3077,25 @@ int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
>>  	return 0;
>>  }
>>  
>> -int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>> +int native_setup_msi_irqs(struct device *dev, int nvec, int type)
>>  {
>>  	struct msi_desc *msidesc;
>>  	unsigned int irq;
>>  	int node, ret;
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>  
>>  	/* Multiple MSI vectors only supported with interrupt remapping */
>>  	if (type == PCI_CAP_ID_MSI && nvec > 1)
>>  		return 1;
>>  
>> -	node = dev_to_node(&dev->dev);
>> +	node = dev_to_node(dev);
>>  
>> -	list_for_each_entry(msidesc, &dev->msi_list, list) {
>> +	list_for_each_entry(msidesc, &pdev->msi_list, list) {
>>  		irq = irq_alloc_hwirq(node);
>>  		if (!irq)
>>  			return -ENOSPC;
>>  
>> -		ret = setup_msi_irq(dev, msidesc, irq, 0);
>> +		ret = setup_msi_irq(pdev, msidesc, irq, 0);
>>  		if (ret < 0) {
>>  			irq_free_hwirq(irq);
>>  			return ret;
>> @@ -3214,6 +3215,17 @@ int default_setup_hpet_msi(unsigned int irq, unsigned int id)
>>  }
>>  #endif
>>  
>> +struct msi_chip apic_msi_chip = {
>> +	.setup_irqs = native_setup_msi_irqs,
>> +	.teardown_irq = native_teardown_msi_irq,
>> +};
>> +
>> +struct msi_chip *arch_get_match_msi_chip(struct device *dev)
>> +{
>> +	return x86_msi_chip;
>> +}
>> +
>> +struct msi_chip *x86_msi_chip = &apic_msi_chip;
>>  #endif /* CONFIG_PCI_MSI */
>>  /*
>>   * Hypertransport interrupt support
>> -- 
>> 1.7.1
>>
> 
> .
> 


-- 
Thanks!
Yijing
