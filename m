Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2014 04:13:40 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:36484 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006668AbaIZCNfqifAY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Sep 2014 04:13:35 +0200
Received: from 172.24.2.119 (EHLO szxeml405-hub.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id BZZ11143;
        Fri, 26 Sep 2014 10:12:21 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml405-hub.china.huawei.com
 (10.82.67.60) with Microsoft SMTP Server id 14.3.158.1; Fri, 26 Sep 2014
 10:12:09 +0800
Message-ID: <5424CB70.9020800@huawei.com>
Date:   Fri, 26 Sep 2014 10:12:00 +0800
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
Subject: Re: [PATCH v2 12/22] MIPS/Octeon/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com> <1411614872-4009-13-git-send-email-wangyijing@huawei.com> <20140925073435.GJ12423@ulmo>
In-Reply-To: <20140925073435.GJ12423@ulmo>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42823
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

On 2014/9/25 15:34, Thierry Reding wrote:
> On Thu, Sep 25, 2014 at 11:14:22AM +0800, Yijing Wang wrote:
> [...]
>> diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
> [...]
>> @@ -132,12 +132,12 @@ msi_irq_allocated:
>>  	/* Make sure the search for available interrupts didn't fail */
>>  	if (irq >= 64) {
>>  		if (request_private_bits) {
>> -			pr_err("arch_setup_msi_irq: Unable to find %d free interrupts, trying just one",
>> +			pr_err("octeon_setup_msi_irq: Unable to find %d free interrupts, trying just one",
>>  			       1 << request_private_bits);
> 
> Perhaps while at it make this (and other similar changes in this patch):
> 
> 	pr_err("%s(): Unable to ...", __func__, ...);

Will update it, thanks!

> 
> So that it becomes more resilient against this kind of rename?
> 
>>  			request_private_bits = 0;
>>  			goto try_only_one;
>>  		} else
>> -			panic("arch_setup_msi_irq: Unable to find a free MSI interrupt");
>> +			panic("octeon_setup_msi_irq: Unable to find a free MSI interrupt");
> 
>> @@ -210,14 +210,13 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>>  
>>  	return 0;
>>  }
>> -
> 
> This...

OK

> 
>> @@ -240,7 +239,7 @@ void arch_teardown_msi_irq(unsigned int irq)
>>  	 */
>>  	number_irqs = 0;
>>  	while ((irq0 + number_irqs < 64) &&
>> -	       (msi_multiple_irq_bitmask[index]
>> +		(msi_multiple_irq_bitmask[index]
> 
> ... and this seem like unrelated whitespace changes.

OK

> 
>>  		& (1ull << (irq0 + number_irqs))))
>>  		number_irqs++;
>>  	number_irqs++;
>> @@ -249,8 +248,8 @@ void arch_teardown_msi_irq(unsigned int irq)
>>  	/* Shift the mask to the correct bit location */
>>  	bitmask <<= irq0;
>>  	if ((msi_free_irq_bitmask[index] & bitmask) != bitmask)
>> -		panic("arch_teardown_msi_irq: Attempted to teardown MSI "
>> -		      "interrupt (%d) not in use", irq);
>> +		panic("octeon_teardown_msi_irq: Attempted to teardown MSI "
>> +			"interrupt (%d) not in use", irq);
> 
> And the second line here also needlessly changes the indentation.

OK
> 
> Thierry
> 


-- 
Thanks!
Yijing
