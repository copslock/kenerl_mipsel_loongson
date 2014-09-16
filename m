Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 03:32:35 +0200 (CEST)
Received: from szxga01-in.huawei.com ([119.145.14.64]:15349 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007098AbaIPBcci4kdH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 03:32:32 +0200
Received: from 172.24.2.119 (EHLO szxeml423-hub.china.huawei.com) ([172.24.2.119])
        by szxrg01-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CBS53358;
        Tue, 16 Sep 2014 09:31:17 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml423-hub.china.huawei.com
 (10.82.67.162) with Microsoft SMTP Server id 14.3.158.1; Tue, 16 Sep 2014
 09:31:01 +0800
Message-ID: <541792C0.9090303@huawei.com>
Date:   Tue, 16 Sep 2014 09:30:40 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     Lucas Stach <l.stach@pengutronix.de>
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
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        "Tony Luck" <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        <sparclinux@vger.kernel.org>, Chris Metcalf <cmetcalf@tilera.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v1 03/21] MSI: Remove the redundant irq_set_chip_data()
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>    <1409911806-10519-4-git-send-email-wangyijing@huawei.com> <1410789648.3314.5.camel@pengutronix.de>
In-Reply-To: <1410789648.3314.5.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42643
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

On 2014/9/15 22:00, Lucas Stach wrote:
> Am Freitag, den 05.09.2014, 18:09 +0800 schrieb Yijing Wang:
>> Currently, pcie-designware, pcie-rcar, pci-tegra drivers
>> use irq chip_data to save the msi_chip pointer. They
>> already call irq_set_chip_data() in their own MSI irq map
>> functions. So irq_set_chip_data() in arch_setup_msi_irq()
>> is useless.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/msi.c |    2 --
>>  1 files changed, 0 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index f6cb317..d547f7f 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -41,8 +41,6 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>>  	if (err < 0)
>>  		return err;
>>  
>> -	irq_set_chip_data(desc->irq, chip);
>> -
>>  	return 0;
>>  }
>>  
> 
> arch_teardown_msi_irq() expects to find the msi_chip in the irq
> chip_data field. As this means drivers don't have any reasonable other
> possibility to stuff things into this field, I think it would make sense
> to do the cleanup the other way around: keep the irq_set_chip_data
> arch_setup_msi_irq() and rip it out of the individual drivers.

Hi Lucas, thanks for your review and comments!
irq_set_chip_data() should not be placed in MSI core functions, because other arch like x86,
use irq_data->chip_data to stores irq_cfg. So how to set the chip_data is arch dependent.
And this series is mainly to use MSI chip framework in all platforms.
Currently, only ARM platform MSI drivers use the chip_data to store msi_chip, and the drivers call
irq_set_chip_data() in their driver already. So I thought we should clean up it in MSI core code.

Thanks!
Yijing.


> 
> Regards,
> Lucas
> 


-- 
Thanks!
Yijing
