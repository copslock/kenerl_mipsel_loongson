Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 08:33:19 +0200 (CEST)
Received: from szxga01-in.huawei.com ([119.145.14.64]:48037 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011437AbaJWGdRmGAJa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 08:33:17 +0200
Received: from 172.24.2.119 (EHLO szxeml449-hub.china.huawei.com) ([172.24.2.119])
        by szxrg01-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CDG41546;
        Thu, 23 Oct 2014 14:32:43 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml449-hub.china.huawei.com
 (10.82.67.192) with Microsoft SMTP Server id 14.3.158.1; Thu, 23 Oct 2014
 14:32:29 +0800
Message-ID: <5448A0F8.1040004@huawei.com>
Date:   Thu, 23 Oct 2014 14:32:24 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        <linux-arch@vger.kernel.org>, <arnab.basu@freescale.com>,
        <Bharat.Bhushan@freescale.com>, <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        <xen-devel@lists.xenproject.org>, Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>, <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        "Tony Luck" <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        <sparclinux@vger.kernel.org>, Chris Metcalf <cmetcalf@tilera.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Vrabel <david.vrabel@citrix.com>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Thomas Petazzoni" <thomas.petazzoni@free-electrons.com>,
        Liviu Dudau <liviu@dudau.co.uk>
Subject: Re: [PATCH v3 04/27] arm/MSI: Save MSI chip in pci_sys_data
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com> <1413342435-7876-5-git-send-email-wangyijing@huawei.com> <20141023053555.GC11770@google.com>
In-Reply-To: <20141023053555.GC11770@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43527
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

>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index 22e413c..f11108c 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -35,6 +35,9 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>>  	struct msi_chip *chip = dev->bus->msi;
>>  	int err;
>>  
>> +	if (!chip)
>> +		chip = pci_msi_chip(dev->bus);
>> +
>>  	if (!chip || !chip->setup_irq)
>>  		return -EINVAL;
>>  
>> @@ -50,6 +53,9 @@ void __weak arch_teardown_msi_irq(unsigned int irq)
>>  	struct msi_desc *entry = irq_get_msi_desc(irq);
>>  	struct msi_chip *chip = entry->dev->bus->msi;
>>  
>> +	if (!chip)
>> +		chip = pci_msi_chip(entry->dev->bus);
>> +
>>  	if (!chip || !chip->teardown_irq)
>>  		return;
>>  
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 9cd2721..7a48b40 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1433,6 +1433,15 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>>  
>>  #include <asm/pci.h>
>>  
>> +/* Just avoid compile error, will be clean up later */
>> +#ifdef CONFIG_PCI_MSI
>> +
>> +#ifndef pci_msi_chip
>> +#define pci_msi_chip(bus)	NULL
>> +#endif
>> +#endif
> 
> I don't like the mixture of ARM changes and PCI core changes in the same
> patch.  Can you split this into a core patch that does something like this:
> 
>   struct msi_chip * __weak pcibios_msi_controller(struct pci_bus *bus)
>   {
>     return NULL;
>   }
> 
>   struct msi_chip *pci_msi_controller(struct pci_bus *bus)
>   {
>     msi_chip *controller = bus->msi;
> 
>     if (controller)
>       return controller;
>     return pcibios_msi_controller(bus);
>   }
> 
> followed by an ARM patch that puts the msi_chip pointer in struct hw_pci
> and implements pcibios_msi_controller()?

OK, I will split it in half.

> 
> I know you're trying to *remove* weak functions, and this adds one, but
> this section of the series is more about getting rid of the ARM
> pcibios_add_bus() because all it was used for was setting the bus->msi
> pointer.

Yes, agree.

> 
> Eventually we might have a way to stash an MSI controller pointer in the
> generic pci_host_bridge struct, and then the pcibios_msi_controller()
> interface could go away.

Yep, I am doing the work to make a generic pci_host_bridge, and try to rip it out from
pci_create_root_bus, that's also a large changes across many archs.

> 
>> +
>>  /* these helpers provide future and backwards compatibility
>>   * for accessing popular PCI BAR info */
>>  #define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)
>> -- 
>> 1.7.1
>>
> 
> .
> 


-- 
Thanks!
Yijing
