Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2014 03:25:27 +0200 (CEST)
Received: from szxga03-in.huawei.com ([119.145.14.66]:14358 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009064AbaIQBZXCFvBa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2014 03:25:23 +0200
Received: from 172.24.2.119 (EHLO szxeml403-hub.china.huawei.com) ([172.24.2.119])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id AUL68514;
        Wed, 17 Sep 2014 09:24:28 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml403-hub.china.huawei.com
 (10.82.67.35) with Microsoft SMTP Server id 14.3.158.1; Wed, 17 Sep 2014
 09:24:19 +0800
Message-ID: <5418E2BA.4030304@huawei.com>
Date:   Wed, 17 Sep 2014 09:24:10 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     Sebastian Ott <sebott@linux.vnet.ibm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
        <linux-pci@vger.kernel.org>,
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
        Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        <sparclinux@vger.kernel.org>, Chris Metcalf <cmetcalf@tilera.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH v1 16/21] s390/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com> <1409911806-10519-17-git-send-email-wangyijing@huawei.com> <alpine.LFD.2.11.1409161325280.1618@denkbrett>
In-Reply-To: <alpine.LFD.2.11.1409161325280.1618@denkbrett>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A020209.5418E2D1.004D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
        ip=0.0.0.0,
        so=2013-05-26 15:14:31,
        dmn=2013-03-21 17:37:32
X-Mirapoint-Loop-Id: f39294459a33fecd36d045692f4d361d
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42656
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

On 2014/9/16 19:35, Sebastian Ott wrote:
> Hello,
> 
> On Fri, 5 Sep 2014, Yijing Wang wrote:
>> Use MSI chip framework instead of arch MSI functions to configure
>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  arch/s390/pci/pci.c |   18 ++++++++++++++----
>>  1 files changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>> index 2fa7b14..da5316e 100644
>> --- a/arch/s390/pci/pci.c
>> +++ b/arch/s390/pci/pci.c
>> @@ -358,7 +358,7 @@ static void zpci_irq_handler(struct airq_struct *airq)
>>  	}
>>  }
>>
>> -int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>> +int zpci_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>>  {
>>  	struct zpci_dev *zdev = get_zdev(pdev);
>>  	unsigned int hwirq, msi_vecs;
>> @@ -434,7 +434,7 @@ out:
>>  	return rc;
>>  }
>>
>> -void arch_teardown_msi_irqs(struct pci_dev *pdev)
>> +static void zpci_teardown_msi_irqs(struct pci_dev *pdev)
>>  {
>>  	struct zpci_dev *zdev = get_zdev(pdev);
>>  	struct msi_desc *msi;
>> @@ -448,9 +448,9 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
>>  	/* Release MSI interrupts */
>>  	list_for_each_entry(msi, &pdev->msi_list, list) {
>>  		if (msi->msi_attrib.is_msix)
>> -			default_msix_mask_irq(msi, 1);
>> +			__msix_mask_irq(msi, 1);
>>  		else
>> -			default_msi_mask_irq(msi, 1, 1);
>> +			__msi_mask_irq(msi, 1, 1);
> 
> The default_msi_mask_irq to __msi_mask_irq renaming is hidden in your
> patch "x86/xen/MSI: Eliminate arch_msix_mask_irq() and arch_msi_mask_irq()"
> 
> This means that between that patch and this one s390 will not compile.
> Could you please move this hunk to the other patch or even make an extra
> patch with the renaming. Other than that:

Good catch. I will move this hunk into the patch "x86/xen/MSI: Eliminate arch_msix_mask_irq() and arch_msi_mask_irq()".

> 
> Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>


Thanks!
Yijing.


> 
> Regards,
> Sebastian
> 
>>  		irq_set_msi_desc(msi->irq, NULL);
>>  		irq_free_desc(msi->irq);
>>  		msi->msg.address_lo = 0;
>> @@ -464,6 +464,16 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
>>  	airq_iv_free_bit(zpci_aisb_iv, zdev->aisb);
>>  }
>>
>> +static struct msi_chip zpci_msi_chip = {
>> +	.setup_irqs = zpci_setup_msi_irqs,
>> +	.teardown_irqs = zpci_teardown_msi_irqs,
>> +};
>> +
>> +struct msi_chip *arch_find_msi_chip(struct pci_dev *dev)
>> +{
>> +	return &zpci_msi_chip;
>> +}
>> +
>>  static void zpci_map_resources(struct zpci_dev *zdev)
>>  {
>>  	struct pci_dev *pdev = zdev->pdev;
>> -- 
>> 1.7.1
>>
>>
> 
> 
> .
> 


-- 
Thanks!
Yijing
