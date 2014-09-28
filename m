Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2014 08:12:51 +0200 (CEST)
Received: from szxga01-in.huawei.com ([119.145.14.64]:8414 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007791AbaI1GMrg8gCy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2014 08:12:47 +0200
Received: from 172.24.2.119 (EHLO szxeml451-hub.china.huawei.com) ([172.24.2.119])
        by szxrg01-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CCG15382;
        Sun, 28 Sep 2014 14:12:03 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml451-hub.china.huawei.com
 (10.82.67.194) with Microsoft SMTP Server id 14.3.158.1; Sun, 28 Sep 2014
 14:11:48 +0800
Message-ID: <5427A6A0.5040703@huawei.com>
Date:   Sun, 28 Sep 2014 14:11:44 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Liviu Dudau <liviu@dudau.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
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
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com> <20140925074235.GN12423@ulmo> <20140925144855.GB31157@bart.dudau.co.uk> <20140925164937.GB30382@ulmo> <20140925171612.GC31157@bart.dudau.co.uk> <542505B3.7040208@huawei.com> <20140926085430.GG31106@ulmo> <20140926090537.GH31106@ulmo> <54277327.6070500@huawei.com>
In-Reply-To: <54277327.6070500@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42849
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

On 2014/9/28 10:32, Yijing Wang wrote:
> On 2014/9/26 17:05, Thierry Reding wrote:
>> On Fri, Sep 26, 2014 at 10:54:32AM +0200, Thierry Reding wrote:
>> [...]
>>> At least for Tegra it's trivial to just hook it up in tegra_pcie_scan_bus()
>>> directly (patch attached).
>>
>> Really attached this time.
>>
>> Thierry
>>
> 
> It looks good to me, so I will update the arm pci hostbridge driver to assign
> pci root bus the msi chip instead of current pcibios_add_bus(). But for other
> platforms which only have a one msi chip, I will kept the arch_find_msi_chip()
> temporarily for more comments, especially from Bjorn.

Oh, sorry, I found designware and rcar use pci_scan_root_bus(), so we can not simply
assign msi chip to root bus in all host drivers's scan functions.

> 
> Thanks!
> Yijing.
> 


-- 
Thanks!
Yijing
