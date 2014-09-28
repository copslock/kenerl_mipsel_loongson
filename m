Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2014 04:36:57 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:46295 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006211AbaI1CgwF0O2p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2014 04:36:52 +0200
Received: from 172.24.2.119 (EHLO szxeml405-hub.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CAA97294;
        Sun, 28 Sep 2014 10:35:22 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml405-hub.china.huawei.com
 (10.82.67.60) with Microsoft SMTP Server id 14.3.158.1; Sun, 28 Sep 2014
 10:35:11 +0800
Message-ID: <542773DD.8020105@huawei.com>
Date:   Sun, 28 Sep 2014 10:35:09 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Xinwei Hu <huxinwei@huawei.com>,
        Wuyun <wuyun.wu@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        <linux-arch@vger.kernel.org>, <arnab.basu@freescale.com>,
        <Bharat.Bhushan@freescale.com>, <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
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
        "Thomas Petazzoni" <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 06/22] PCI/MSI: Introduce weak arch_find_msi_chip()
 to find MSI chip
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com> <1411614872-4009-7-git-send-email-wangyijing@huawei.com> <alpine.DEB.2.10.1409251220570.4604@nanos> <5424D30A.6040900@huawei.com> <alpine.DEB.2.11.1409261236160.4567@nanos>
In-Reply-To: <alpine.DEB.2.11.1409261236160.4567@nanos>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42848
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

>> MSI chip in this series is to setup MSI irq, including IRQ allocation, Map,
>> compose MSI msg ..., in different platform, many arch specific MSI irq details in it.
>> It's difficult to extract the common data and code.
>>
>> I have a plan to rework MSI related irq_chips in kernel, PCI and Non-PCI, currently,
>> HPET, DMAR and PCI have their own irq_chip and MSI related functions, write_msi_msg(),
>> mask_msi_irq(), etc... I want to extract the common data set for that, so we can
>> remove lots of unnecessary MSI code.
> 
> That makes sense. Can you please make sure that this does not conflict
> with the ongoing work Jiang is doing in the x86 irq area with
> hierarchical irqdomains to distangle layered levels like MSI from the
> underlying vector/irqremap mechanics.

Yes, I'm reviewing Jiang hierarchical irqdomains series, I'm interested in that changes.

Thanks!
Yijing.

> 
> Thanks,
> 
> 	tglx
> 
> .
> 


-- 
Thanks!
Yijing
