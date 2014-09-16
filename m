Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 04:10:04 +0200 (CEST)
Received: from szxga03-in.huawei.com ([119.145.14.66]:46705 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007217AbaIPCJ7bTPt9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 04:09:59 +0200
Received: from 172.24.2.119 (EHLO szxeml421-hub.china.huawei.com) ([172.24.2.119])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id AUK46153;
        Tue, 16 Sep 2014 10:09:04 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml421-hub.china.huawei.com
 (10.82.67.160) with Microsoft SMTP Server id 14.3.158.1; Tue, 16 Sep 2014
 10:08:51 +0800
Message-ID: <54179BAB.7030506@huawei.com>
Date:   Tue, 16 Sep 2014 10:08:43 +0800
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
Subject: Re: [PATCH v1 05/21] PCI/MSI: Introduce weak arch_find_msi_chip()
 to find MSI chip
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>    <1409911806-10519-6-git-send-email-wangyijing@huawei.com> <1410792154.3314.7.camel@pengutronix.de>
In-Reply-To: <1410792154.3314.7.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A020204.54179BC1.0141,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
        ip=0.0.0.0,
        so=2013-05-26 15:14:31,
        dmn=2013-03-21 17:37:32
X-Mirapoint-Loop-Id: 5ec266704f642678263183a74004ba63
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42644
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

On 2014/9/15 22:42, Lucas Stach wrote:
> Am Freitag, den 05.09.2014, 18:09 +0800 schrieb Yijing Wang:
>> Introduce weak arch_find_msi_chip() to find the match msi_chip.
>> Currently, MSI chip associates pci bus to msi_chip. Because in
>> ARM platform, there may be more than one MSI controller in system.
>> Associate pci bus to msi_chip help pci device to find the match
>> msi_chip and setup MSI/MSI-X irq correctly. But in other platform,
>> like in x86. we only need one MSI chip, because all device use
>> the same MSI address/data and irq etc. So it's no need to associate
>> pci bus to MSI chip, just use a arch function, arch_find_msi_chip()
>> to return the MSI chip for simplicity. The default weak
>> arch_find_msi_chip() used in ARM platform, find the MSI chip
>> by pci bus.
>>
> Hm, while one weak function sounds much better than the plethora we have
> now, I wonder how much work it would be to associate the msi_chip with
> the pci bus on other arches the same way as done on ARM. This way we
> could kill this calling into arch specific functions which would make
> things a bit clearer to follow I think.

That's a heavy work to associate msi_chip with the pci_bus in all platforms,
And only in ARM platform, there are two or more different msi_chips which maybe
associate pci hostbridge or irq chip. In other platforms, only one MSI chip
exists at the same time. Another reason is I don't think associate the msi_chip
with pci bus is a good idea to make PCI device find its own msi_chip.
All PCI devices under the same PCI hostbridge should have the same msi_chip,
and now a property "msi-parent" is defined to help pci hostbridge to find its matched
msi_chip. I like to associate the msi_chip with a pci hostbridge. So we don't need to
add a lot of pcibios_add_bus() to do that.

I inspected all MSI chip drivers, and found there are two different relations between msi_chip and PCI hostbridge
1. MSI chip is a irq chip, like irq_armada_370_xp, PCI hostbridge platform device use "msi-parent" to find msi_chip by of_node.
2. MSI chip is integrated into PCI hostbridge, so msi_chip->dev is the PCI hostbridge platform device.

So long as we use PCI hostbridge platform device as the parent of PCI hostbridge, every PCI device under the hostbridge
can find the msi_chip by it.

All MSI chip drivers now except pci-mvebu have been passed the hostbridge platform dev as the parent.
pci_common_init_dev(pcie->dev, &hw);
			^
Pseudo code like:

struct msi_chip *pcibios_find_msi_chip(struct pci_dev *dev)
 {
       struct pci_bus *root;
       struct pci_host_bridge *bridge;
       struct msi_chip *chip;
       struct device_node *node, *msi_node;

       /* First we find msi_chip by the phb of_node */    <-------- MSI chip is a irq chip
       root = pci_find_root_bus(dev->bus);
       node = pcibios_get_phb_of_node(root);
       if (node) {
               msi_node = of_parse_phandle(n, "msi-parent", 0);
               of_node_put(node);
               if (msi_node)
                       return of_pci_find_msi_chip_by_node(msi_node);
       }


       /* Some msi_chip are integrated into pci hostbridge,
        * we find it by phb device pointer.
        */
       if (bridge && bridge->dev.parent) {		<-----------MSI chip is integrated into PCI hostbridge
               down_read(&pci_msi_chip_sem);
               list_for_each_entry(chip, &pci_msi_chip_list, list) {
                       if (chip->dev == bridge->dev.parent) {
                               up_read(pci_msi_chip_sem);
                               return chip;
                       }
                }
               up_read(&pci_msi_chip_sem);
        }


        return NULL;
 }

Thanks!
Yijing.


> 
> Regards,
> Lucas
> 
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/msi.c |    7 ++++++-
>>  1 files changed, 6 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index a77e7f7..539c11d 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -29,9 +29,14 @@ static int pci_msi_enable = 1;
>>  
>>  /* Arch hooks */
>>  
>> +struct msi_chip * __weak arch_find_msi_chip(struct pci_dev *dev)
>> +{
>> +	return dev->bus->msi;
>> +}
>> +
>>  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>>  {
>> -	struct msi_chip *chip = dev->bus->msi;
>> +	struct msi_chip *chip = arch_find_msi_chip(dev);
>>  	int err;
>>  
>>  	if (!chip || !chip->setup_irq)
> 


-- 
Thanks!
Yijing
