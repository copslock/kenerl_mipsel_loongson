Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 07:42:21 +0200 (CEST)
Received: from szxga03-in.huawei.com ([119.145.14.66]:34013 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006505AbaIPFmR0ZBtA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 07:42:17 +0200
Received: from 172.24.2.119 (EHLO szxeml422-hub.china.huawei.com) ([172.24.2.119])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id AUK69806;
        Tue, 16 Sep 2014 13:40:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml422-hub.china.huawei.com
 (10.82.67.161) with Microsoft SMTP Server id 14.3.158.1; Tue, 16 Sep 2014
 13:40:39 +0800
Message-ID: <5417CD50.7010803@huawei.com>
Date:   Tue, 16 Sep 2014 13:40:32 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     Michael Ellerman <mpe@ellerman.id.au>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-mips@linux-mips.org>,
        <linux-ia64@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <Bharat.Bhushan@freescale.com>, <sparclinux@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Joerg Roedel <joro@8bytes.org>, <x86@kernel.org>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        <xen-devel@lists.xenproject.org>, <arnab.basu@freescale.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        "Xinwei Hu" <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <iommu@lists.linux-foundation.org>, Wuyun <wuyun.wu@huawei.com>,
        <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v1 15/21] Powerpc/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>    <1409911806-10519-16-git-send-email-wangyijing@huawei.com> <1410845317.12488.2.camel@concordia>
In-Reply-To: <1410845317.12488.2.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A020206.5417CD62.00CA,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
        ip=0.0.0.0,
        so=2013-05-26 15:14:31,
        dmn=2013-03-21 17:37:32
X-Mirapoint-Loop-Id: fc45fef02ef98b8135f246dc7126291b
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42648
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

On 2014/9/16 13:28, Michael Ellerman wrote:
> On Fri, 2014-09-05 at 18:10 +0800, Yijing Wang wrote:
>> Use MSI chip framework instead of arch MSI functions to configure
>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> 
> This looks fine and seems to boot OK.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Thanks very much!

> 
> cheers
> 
> 
> 
> .
> 


-- 
Thanks!
Yijing
