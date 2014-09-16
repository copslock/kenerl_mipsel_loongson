Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 12:38:45 +0200 (CEST)
Received: from szxga01-in.huawei.com ([119.145.14.64]:18689 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007194AbaIPKimfQCSc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 12:38:42 +0200
Received: from 172.24.2.119 (EHLO szxeml462-hub.china.huawei.com) ([172.24.2.119])
        by szxrg01-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CBT19998;
        Tue, 16 Sep 2014 18:37:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml462-hub.china.huawei.com
 (10.82.67.205) with Microsoft SMTP Server id 14.3.158.1; Tue, 16 Sep 2014
 18:37:35 +0800
Message-ID: <541812EC.3000501@huawei.com>
Date:   Tue, 16 Sep 2014 18:37:32 +0800
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
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>            <1409911806-10519-4-git-send-email-wangyijing@huawei.com>       <1410789648.3314.5.camel@pengutronix.de> <541792C0.9090303@huawei.com> <1410863349.2746.5.camel@pengutronix.de>
In-Reply-To: <1410863349.2746.5.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42650
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

>>> arch_teardown_msi_irq() expects to find the msi_chip in the irq
>>> chip_data field. As this means drivers don't have any reasonable other
>>> possibility to stuff things into this field, I think it would make sense
>>> to do the cleanup the other way around: keep the irq_set_chip_data
>>> arch_setup_msi_irq() and rip it out of the individual drivers.
>>
>> Hi Lucas, thanks for your review and comments!
>> irq_set_chip_data() should not be placed in MSI core functions, because other arch like x86,
>> use irq_data->chip_data to stores irq_cfg. So how to set the chip_data is arch dependent.
>> And this series is mainly to use MSI chip framework in all platforms.
>> Currently, only ARM platform MSI drivers use the chip_data to store msi_chip, and the drivers call
>> irq_set_chip_data() in their driver already. So I thought we should clean up it in MSI core code.
>>
> Okay I see your point, so the cleanup done this way is okay.
> 
> But then this still introduces a problem: arch_teardown_msi_irq()
> expects to find the msi_chip in the chip_data field, which is okay for
> all ARM PCI host drivers, but not for other arch MSI chips.
> 
> You fix this by completely removing arch_teardown_msi_irq() at the end
> of the series, but this still has the potential to introduce issues for
> other arches than ARM within the series. So this patch should include a
> change to replace the line
> 
> struct msi_chip *chip = irq_get_chip_data(irq);
> 
> with something that doesn't rely on the msi_chip being in the irq
> chip_data field.

OK, I will update arch_teardown_msi_irq() in this patch, thanks!

Thanks!
Yijing.

> 
> Regards,
> Lucas
> 


-- 
Thanks!
Yijing
