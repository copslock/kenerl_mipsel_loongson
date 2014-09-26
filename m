Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2014 04:35:07 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:49234 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006668AbaIZCfEFZKA0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Sep 2014 04:35:04 +0200
Received: from 172.24.2.119 (EHLO szxeml421-hub.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id BZZ13705;
        Fri, 26 Sep 2014 10:33:40 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml421-hub.china.huawei.com
 (10.82.67.160) with Microsoft SMTP Server id 14.3.158.1; Fri, 26 Sep 2014
 10:33:31 +0800
Message-ID: <5424D074.60102@huawei.com>
Date:   Fri, 26 Sep 2014 10:33:24 +0800
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
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com> <1411614872-4009-7-git-send-email-wangyijing@huawei.com> <alpine.DEB.2.10.1409251220570.4604@nanos>
In-Reply-To: <alpine.DEB.2.10.1409251220570.4604@nanos>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42828
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

On 2014/9/25 18:38, Thomas Gleixner wrote:
> On Thu, 25 Sep 2014, Yijing Wang wrote:
> 
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
> 
> This is really backwards. On one hand you try to get rid of the weak
> arch functions zoo and then you invent new ones for no good
> reason. Why can't x86 store the chip in the pci bus?

Hi Thomas, I introduced this weak function , because I thought all platforms
except arm always have only one msi chip, and I hoped to provide a simplest
solution, less code changes. I consider several solutions to associate msi chip
and PCI device. In my reply to Thierry in first reply,
http://marc.info/?l=linux-pci&m=141169658208255&w=2
Could you give me some advices ?

Thanks!
Yijing.


> 
> Looking deeper, I'm questioning the whole notion of different
> msi_chips. Are this really different MSI controllers with a different
> feature set or are this defacto multiple instances of the same
> controller which just need a different data set?
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
