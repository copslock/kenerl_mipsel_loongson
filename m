Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2014 05:53:05 +0200 (CEST)
Received: from szxga01-in.huawei.com ([119.145.14.64]:28258 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006944AbaIXDxCKKywO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2014 05:53:02 +0200
Received: from 172.24.2.119 (EHLO szxeml410-hub.china.huawei.com) ([172.24.2.119])
        by szxrg01-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id CCB54479;
        Wed, 24 Sep 2014 11:52:23 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml410-hub.china.huawei.com
 (10.82.67.137) with Microsoft SMTP Server id 14.3.158.1; Wed, 24 Sep 2014
 11:52:11 +0800
Message-ID: <54223FE8.4070101@huawei.com>
Date:   Wed, 24 Sep 2014 11:52:08 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Russell King" <linux@arm.linux.org.uk>,
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
Subject: Re: [PATCH v1 00/21] Use MSI chip to configure MSI/MSI-X in all platforms
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com> <20140923210936.GC27117@google.com>
In-Reply-To: <20140923210936.GC27117@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42754
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

On 2014/9/24 5:09, Bjorn Helgaas wrote:
> On Fri, Sep 05, 2014 at 06:09:45PM +0800, Yijing Wang wrote:
>> This series is based Bjorn's pci-next branch + Alexander Gordeev's two patches
>> "Remove arch_msi_check_device()" link: https://lkml.org/lkml/2014/7/12/41
>>
>> Currently, there are a lot of weak arch functions in MSI code.
>> Thierry Reding Introduced MSI chip framework to configure MSI/MSI-X in arm.
>> This series use MSI chip framework to refactor MSI code across all platforms
>> to eliminate weak arch functions. It has been tested fine in x86(with or without
>> irq remap).
> 
> I see you plan some updates, so I'll look for a v2 posting after v3.17 releases.
> It will be great to get rid of some of those weak functions!

Thanks, I will send out the new version soon.

Thanks!
Yijing.

> 
> Bjorn
> 
> .
> 


-- 
Thanks!
Yijing
