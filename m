Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 08:24:22 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:64490 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011437AbaJWGYTJV7gA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 08:24:19 +0200
Received: from 172.24.2.119 (EHLO szxeml418-hub.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CBD39855;
        Thu, 23 Oct 2014 14:23:47 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml418-hub.china.huawei.com
 (10.82.67.157) with Microsoft SMTP Server id 14.3.158.1; Thu, 23 Oct 2014
 14:23:29 +0800
Message-ID: <54489EDE.5070109@huawei.com>
Date:   Thu, 23 Oct 2014 14:23:26 +0800
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
Subject: Re: [PATCH v3 05/27] PCI: tegra: Save msi chip in pci_sys_data
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com> <1413342435-7876-6-git-send-email-wangyijing@huawei.com> <20141023051831.GB11770@google.com>
In-Reply-To: <20141023051831.GB11770@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43526
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

On 2014/10/23 13:18, Bjorn Helgaas wrote:
> On Wed, Oct 15, 2014 at 11:06:53AM +0800, Yijing Wang wrote:
>> Save msi chip in pci_sys_data instead of assign
>> msi chip to every pci bus in .add_bus().
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/host/pci-tegra.c |   13 +++----------
>>  1 files changed, 3 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>> index 3d43874..5af0525 100644
>> --- a/drivers/pci/host/pci-tegra.c
>> +++ b/drivers/pci/host/pci-tegra.c
>> @@ -694,15 +694,6 @@ static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>>  	return irq;
>>  }
>>  
>> -static void tegra_pcie_add_bus(struct pci_bus *bus)
>> -{
>> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>> -		struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
>> -
>> -		bus->msi = &pcie->msi.chip;
>> -	}
>> -}
>> -
>>  static struct pci_bus *tegra_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>>  {
>>  	struct tegra_pcie *pcie = sys_to_pcie(sys);
>> @@ -1881,11 +1872,13 @@ static int tegra_pcie_enable(struct tegra_pcie *pcie)
>>  
>>  	memset(&hw, 0, sizeof(hw));
>>  
>> +#ifdef CONFIG_PCI_MSI
>> +	hw.msi_chip = &pcie->msi.chip;
>> +#endif
> 
> Why did you use "#ifdef CONFIG_PCI_MSI" instead of the
> "IS_ENABLED(CONFIG_PCI_MSI)" used previously?

Just personal habit. :)

> 
> It's true that CONFIG_PCI_MSI will never be a tristate symbol, so we don't
> really *need* the extra smarts of IS_ENABLED(), but I'm fairly sympathetic
> to James' argument [1] that we should just use IS_ENABLED() all the time
> because it's simpler overall.
> 
> If you want to change the #ifdef to IS_ENABLED(), that should be a separate
> patch from your msi_chip change, and we can debate the merits of that by
> itself.
> 
> [1] http://lkml.iu.edu//hypermail/linux/kernel/1204.3/00081.html

Hi Bjorn, thanks for your guidance. I will use IS_ENABLED() instead of #ifdef for simplification
in a separate patch.

> 
>>  	hw.nr_controllers = 1;
>>  	hw.private_data = (void **)&pcie;
>>  	hw.setup = tegra_pcie_setup;
>>  	hw.map_irq = tegra_pcie_map_irq;
>> -	hw.add_bus = tegra_pcie_add_bus;
>>  	hw.scan = tegra_pcie_scan_bus;
>>  	hw.ops = &tegra_pcie_ops;
>>  
>> -- 
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> 
> .
> 


-- 
Thanks!
Yijing
