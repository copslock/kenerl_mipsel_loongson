Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2014 08:21:51 +0200 (CEST)
Received: from szxga03-in.huawei.com ([119.145.14.66]:19920 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008039AbaIZGVrz552T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Sep 2014 08:21:47 +0200
Received: from 172.24.2.119 (EHLO szxeml418-hub.china.huawei.com) ([172.24.2.119])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id AUW36952;
        Fri, 26 Sep 2014 14:21:04 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml418-hub.china.huawei.com
 (10.82.67.157) with Microsoft SMTP Server id 14.3.158.1; Fri, 26 Sep 2014
 14:20:52 +0800
Message-ID: <542505B3.7040208@huawei.com>
Date:   Fri, 26 Sep 2014 14:20:35 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     Liviu Dudau <liviu@dudau.co.uk>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Xinwei Hu <huxinwei@huawei.com>,
        Wuyun <wuyun.wu@huawei.com>,
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
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com> <20140925074235.GN12423@ulmo> <20140925144855.GB31157@bart.dudau.co.uk> <20140925164937.GB30382@ulmo> <20140925171612.GC31157@bart.dudau.co.uk>
In-Reply-To: <20140925171612.GC31157@bart.dudau.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A020202.542505D1.007E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
        ip=0.0.0.0,
        so=2013-05-26 15:14:31,
        dmn=2013-03-21 17:37:32
X-Mirapoint-Loop-Id: bc7a0eef4c8aa463ce41e250f24a1d40
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42833
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

>> The PCI core can already deal with that. An MSI chip can be set per bus
>> and the weak pcibios_add_bus() can be used to set that. Often it might
>> not even be necessary to do it via pcibios_add_bus() if you create the
>> root bus directly, since you can attach the MSI chip at that time.
> 
> But I'm thinking that we need to move away from pcibios_add_bus() interface to do
> something that should be generic. You don't need to be called for every bus when all
> you want is just the root bus in order to add the MSI chip. Also, from looking at
> the current patchset, a lot of architectures would set the MSI chip to a global
> variable, which means you don't have an option to choose the MSI chip based on the
> bus.

I also agree to remove the pcibios_add_bus() in arm which call .add_bus() to associate msi_chip
and PCI bus.

In my opinions, all PCI devices under the same PCI hostbridge must share same msi chip, right ?
So if we can associate msi chip and PCI hostbridge, every PCI device can find correct msi chip.
PCI hostbridge private attributes can be saved in PCI sysdata, and this data will be propagate to
PCI root bus and its child buses.

> 
>>
>>> What I would like to see is a way of creating the pci_host_bridge structure outside
>>> the pci_create_root_bus(). That would then allow us to pass this sort of platform
>>> details like associated msi_chip into the host bridge and the child busses will
>>> have an easy way of finding the information needed by finding the root bus and then
>>> the host bridge structure. Then the generic pci_scan_root_bus() can be used by (mostly)
>>> everyone and the drivers can remove their kludges that try to work around the
>>> current limitations.
>>
>> I think both issues are orthogonal. Last time I checked a lot of work
>> was still necessary to unify host bridges enough so that it could be
>> shared across architectures. But perhaps some of that work has
>> happened in the meantime.
> 
> Breaking out the host bridge creation from root bus creation is not difficult, just not
> agree upon. That would be the first step in making the generic host brige structure
> useful for sharing, specially if used as a sort of "parent" structure that you can
> wrap with your actual host bridge structure.

Breaking out the host bridge creation is a good idea, but there need a lot of changes, we can
do it in another series. And if we save msi chip in pci sysdata now, it will be easy to
move it to generic pci host bridge. We can also move the pci domain number and other common info to it.

Thanks!
Yijing.

> 
>>
>> But like I said, when you create the root bus, you can easily attach the
>> MSI chip to it.
> 
> Not if you want to use the generic pci_scan_root_bus() function. One needs to copy the code
> and add their own needed modifications. Which makes it hard to fix bugs and prevents code
> reuse.
> 
> Best regards,
> Liviu
> 
>>
>> Thierry
> 
> 
> 


-- 
Thanks!
Yijing
