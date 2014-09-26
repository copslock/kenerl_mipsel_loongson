Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2014 04:16:49 +0200 (CEST)
Received: from szxga03-in.huawei.com ([119.145.14.66]:32564 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008039AbaIZCQobTPjD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Sep 2014 04:16:44 +0200
Received: from 172.24.2.119 (EHLO szxeml424-hub.china.huawei.com) ([172.24.2.119])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id AUW11772;
        Fri, 26 Sep 2014 10:16:05 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml424-hub.china.huawei.com
 (10.82.67.163) with Microsoft SMTP Server id 14.3.158.1; Fri, 26 Sep 2014
 10:15:56 +0800
Message-ID: <5424CC54.1040507@huawei.com>
Date:   Fri, 26 Sep 2014 10:15:48 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
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
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 01/22] PCI/MSI: Clean up struct msi_chip argument
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com> <1411614872-4009-2-git-send-email-wangyijing@huawei.com> <20140925071536.GG12423@ulmo> <alpine.DEB.2.10.1409251208420.4604@nanos>
In-Reply-To: <alpine.DEB.2.10.1409251208420.4604@nanos>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A020202.5424CC65.00D5,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
        ip=0.0.0.0,
        so=2013-05-26 15:14:31,
        dmn=2013-03-21 17:37:32
X-Mirapoint-Loop-Id: 5cd6542b35db9be32f3a78ca7be566a9
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42826
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

On 2014/9/25 18:20, Thomas Gleixner wrote:
> On Thu, 25 Sep 2014, Thierry Reding wrote:
> 
>> On Thu, Sep 25, 2014 at 11:14:11AM +0800, Yijing Wang wrote:
>>> Msi_chip functions setup_irq/teardown_irq rarely use msi_chip
>>> argument.
>>
>> That's not true. Out of the four drivers that you modify two use the
>> parameter. And the two that don't probably should be using it too.
>>
>> 50% is not "rarely". =)
>>
>>>           We can look up msi_chip pointer by the device pointer
>>> or irq number, so clean up msi_chip argument.
>>
>> I don't like this particular change. The idea was to keep the API object
>> oriented so that drivers wouldn't have to know where to get the MSI chip
>> from. It also makes it more resilient against code reorganizations since
>> the core code is the only place that needs to know where to get the chip
>> from.
> 
> Right. We have the same thing in the irq_chip callbacks. All of them
> take "struct irq_data", because it's already available in the core
> code and it gives easy access to all information (chip, chipdata ...)
> which is necessary for the callback implementations.

OK, I will drop this change, tglx, thanks for your review and comments!

Thanks!
Yijing.


> 
> Thanks,
> 
> 	tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


-- 
Thanks!
Yijing
