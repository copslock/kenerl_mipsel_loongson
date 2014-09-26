Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2014 04:14:14 +0200 (CEST)
Received: from szxga03-in.huawei.com ([119.145.14.66]:30874 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008039AbaIZCOJFq0bP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Sep 2014 04:14:09 +0200
Received: from 172.24.2.119 (EHLO szxeml460-hub.china.huawei.com) ([172.24.2.119])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id AUW11416;
        Fri, 26 Sep 2014 10:13:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml460-hub.china.huawei.com
 (10.82.67.203) with Microsoft SMTP Server id 14.3.158.1; Fri, 26 Sep 2014
 10:13:29 +0800
Message-ID: <5424CBC1.8080702@huawei.com>
Date:   Fri, 26 Sep 2014 10:13:21 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     Thierry Reding <thierry.reding@gmail.com>
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
Subject: Re: [PATCH v2 14/22] MIPS/Xlp/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com> <1411614872-4009-15-git-send-email-wangyijing@huawei.com> <20140925073608.GK12423@ulmo>
In-Reply-To: <20140925073608.GK12423@ulmo>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A020203.5424CBD2.00BE,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
        ip=0.0.0.0,
        so=2013-05-26 15:14:31,
        dmn=2013-03-21 17:37:32
X-Mirapoint-Loop-Id: a1308cbcf4bde9ccfe842d6583a5c96c
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42824
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

On 2014/9/25 15:36, Thierry Reding wrote:
> On Thu, Sep 25, 2014 at 11:14:24AM +0800, Yijing Wang wrote:
>> Use MSI chip framework instead of arch MSI functions to configure
>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
> Nit: s/irq/IRQ/ in the above.
> 
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  arch/mips/pci/msi-xlp.c |   14 ++++++++++++--
>>  1 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/pci/msi-xlp.c b/arch/mips/pci/msi-xlp.c
>> index e469dc7..6b791ef 100644
>> --- a/arch/mips/pci/msi-xlp.c
>> +++ b/arch/mips/pci/msi-xlp.c
>> @@ -245,7 +245,7 @@ static struct irq_chip xlp_msix_chip = {
>>  	.irq_unmask	= unmask_msi_irq,
>>  };
>>  
>> -void arch_teardown_msi_irq(unsigned int irq)
>> +void xlp_teardown_msi_irq(unsigned int irq)
> 
> Should this not be static now as well?

Yes, Will update.

> 
> Thierry
> 


-- 
Thanks!
Yijing
