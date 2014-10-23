Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 08:41:37 +0200 (CEST)
Received: from szxga03-in.huawei.com ([119.145.14.66]:51968 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011437AbaJWGlfNJVra (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 08:41:35 +0200
Received: from 172.24.2.119 (EHLO szxeml416-hub.china.huawei.com) ([172.24.2.119])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id AVY43481;
        Thu, 23 Oct 2014 14:41:07 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml416-hub.china.huawei.com
 (10.82.67.155) with Microsoft SMTP Server id 14.3.158.1; Thu, 23 Oct 2014
 14:40:54 +0800
Message-ID: <5448A2F2.7060001@huawei.com>
Date:   Thu, 23 Oct 2014 14:40:50 +0800
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
Subject: Re: [PATCH v3 10/27] PCI/MSI: Remove useless bus->msi assignment
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com> <1413342435-7876-11-git-send-email-wangyijing@huawei.com> <20141023054121.GE11770@google.com>
In-Reply-To: <20141023054121.GE11770@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A020202.5448A307.0162,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
        ip=0.0.0.0,
        so=2013-05-26 15:14:31,
        dmn=2013-03-21 17:37:32
X-Mirapoint-Loop-Id: 2d23c51c586ec84e4869088c814f38cf
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43529
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

On 2014/10/23 13:41, Bjorn Helgaas wrote:
> On Wed, Oct 15, 2014 at 11:06:58AM +0800, Yijing Wang wrote:
>> Now msi chip is saved in pci_sys_data in arm,
>> we could clean the bus->msi assignment in
>> pci core.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> CC: Thierry Reding <thierry.reding@gmail.com>
>> CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> ---
>>  drivers/pci/probe.c |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index efa48dc..98bf4c3 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -682,7 +682,6 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>>  
>>  	child->parent = parent;
>>  	child->ops = parent->ops;
>> -	child->msi = parent->msi;
> 
> This needs an explanation of why ARM was the only arch to depend on this.

OK, will add explanation in next version.

> 
>>  	child->sysdata = parent->sysdata;
>>  	child->bus_flags = parent->bus_flags;
>>  
>> -- 
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


-- 
Thanks!
Yijing
