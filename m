Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2014 05:43:15 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:29194 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008039AbaIZDnMHl3GR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Sep 2014 05:43:12 +0200
Received: from 172.24.2.119 (EHLO szxeml407-hub.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id BZZ22449;
        Fri, 26 Sep 2014 11:42:39 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml407-hub.china.huawei.com
 (10.82.67.94) with Microsoft SMTP Server id 14.3.158.1; Fri, 26 Sep 2014
 11:42:28 +0800
Message-ID: <5424E09F.50701@huawei.com>
Date:   Fri, 26 Sep 2014 11:42:23 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     Thierry Reding <thierry.reding@gmail.com>,
        Liviu Dudau <liviu@dudau.co.uk>
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
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com> <20140925074235.GN12423@ulmo> <20140925144855.GB31157@bart.dudau.co.uk> <20140925164937.GB30382@ulmo>
In-Reply-To: <20140925164937.GB30382@ulmo>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42832
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

>> I am actually in disagreement with you, Thierry. I don't like the general direction
>> of the patches, or at least I don't like the fact that we don't have a portable
>> way of setting up the msi_chip without having to rely on weak architectural hooks.
> 
> Oh, good. That's actually one of the things I said I wasn't happy with
> either. =)

Hm, I decide to drop weak arch_find_msi_chip(), no one likes it.
Let's find a better solution :)

> 
>> I'm surprised no one considers the case of a platform having more than one host
>> bridge and possibly more than one MSI unit. With the current proposed patchset I
>> can't see how that would work.
> 
> The PCI core can already deal with that. An MSI chip can be set per bus
> and the weak pcibios_add_bus() can be used to set that. Often it might
> not even be necessary to do it via pcibios_add_bus() if you create the
> root bus directly, since you can attach the MSI chip at that time.

Yes, PCI hostbridge driver find the matched msi chip during its initialization,
and assign the msi chip to PCI bus in pcibios_add_bus().

> 
>> What I would like to see is a way of creating the pci_host_bridge structure outside
>> the pci_create_root_bus(). That would then allow us to pass this sort of platform
>> details like associated msi_chip into the host bridge and the child busses will
>> have an easy way of finding the information needed by finding the root bus and then
>> the host bridge structure. Then the generic pci_scan_root_bus() can be used by (mostly)
>> everyone and the drivers can remove their kludges that try to work around the
>> current limitations.

So I think maybe save msi chip in PCI arch sysdata is a good candidate.

> 
> I think both issues are orthogonal. Last time I checked a lot of work
> was still necessary to unify host bridges enough so that it could be
> shared across architectures. But perhaps some of that work has
> happened in the meantime.
> 
> But like I said, when you create the root bus, you can easily attach the
> MSI chip to it.
> 
> Thierry
> 


-- 
Thanks!
Yijing
