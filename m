Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 13:30:13 +0200 (CEST)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:59608 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007043AbaIELaMLfOsJ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Sep 2014 13:30:12 +0200
Received: by mail-pa0-f48.google.com with SMTP id hz1so969877pad.7
        for <multiple recipients>; Fri, 05 Sep 2014 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=TufQeAlfqp5e3AwvJ4CWSF5ND+pG8+q9vbcvEXWTRYc=;
        b=laHpRN+yUsVBxHypfwh5Iah8z5IuFNe7r+fInsIdsdqjNPOCXBMzi9x6FSvRlBhw0b
         errs+wT3yZlCzx+OWEDHfSeodooSpq/dU8sMjPhSvGHGvqZN1nnbCBapcXv7aToseKn2
         aafGgg74NxYwzOJGk0mOD89eYIGkRyA534fz57kKYlQ7c00TdF9P9b84vJt+oebK+nU6
         xFOcBbrhK+Afb1cqEz9/e+PCphXzuC9FidYvCrj1/tao4cMETsTfLFs2gfnHW7vr4LvQ
         tfY+RZQRmQD8OBJsUrdKmkiexaw8HG/BY6VPShXYpQETD8+zE/U29j/piTnoKcyp18ro
         P5kg==
X-Received: by 10.66.141.142 with SMTP id ro14mr20474420pab.104.1409916602625;
        Fri, 05 Sep 2014 04:30:02 -0700 (PDT)
Received: from [192.168.1.102] ([111.140.71.79])
        by mx.google.com with ESMTPSA id yx1sm1651315pab.5.2014.09.05.04.30.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 05 Sep 2014 04:30:01 -0700 (PDT)
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com> <1409911806-10519-10-git-send-email-wangyijing@huawei.com> <540993B3.1000701@cogentembedded.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <540993B3.1000701@cogentembedded.com>
Content-Type: text/plain;
        charset=gb2312
Content-Transfer-Encoding: 8BIT
Message-Id: <58C2E84C-7080-4FDA-8684-5D0B2DAD7C20@gmail.com>
Cc:     Yijing Wang <wangyijing@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnab.basu@freescale.com" <arnab.basu@freescale.com>,
        "Bharat.Bhushan@freescale.com" <Bharat.Bhushan@freescale.com>,
        "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Ralf Baechle <ralf@linux-mips.org>
X-Mailer: iPad Mail (11D201)
From:   wangyijing <wangyijing0307@gmail.com>
Subject: Re: [PATCH v1 09/21] Irq_remapping/MSI: Use MSI chip framework to configure MSI/MSI-X irq
Date:   Fri, 5 Sep 2014 19:30:01 +0800
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Return-Path: <wangyijing0307@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wangyijing0307@gmail.com
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


> 在 2014年9月5日，18:42，Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> 写道：
> 
> Hello.
> 
>> On 9/5/2014 2:09 PM, Yijing Wang wrote:
>> 
>> Use MSI chip framework instead of arch MSI functions to configure
>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/iommu/irq_remapping.c |    8 +++++++-
>>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
>> diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
>> index 33c4395..e75026e 100644
>> --- a/drivers/iommu/irq_remapping.c
>> +++ b/drivers/iommu/irq_remapping.c
> [...]
>> @@ -165,9 +170,10 @@ static void __init irq_remapping_modify_x86_ops(void)
>>      x86_io_apic_ops.set_affinity    = set_remapped_irq_affinity;
>>      x86_io_apic_ops.setup_entry    = setup_ioapic_remapped_entry;
>>      x86_io_apic_ops.eoi_ioapic_pin    = eoi_ioapic_pin_remapped;
>> -    x86_msi.setup_msi_irqs        = irq_remapping_setup_msi_irqs;
>> +    x86_msi.setup_msi_irqs          = irq_remapping_setup_msi_irqs;
> 
>   AFAICS, this change only converts tabs to spaces, so not needed at all.

Will update,  thanks.

> 
>>      x86_msi.setup_hpet_msi        = setup_hpet_msi_remapped;
>>      x86_msi.compose_msi_msg        = compose_remapped_msi_msg;
>> +    x86_msi_chip = &remap_msi_chip;
> 
>   Please align = with the rest of assignments.

Ok.

Thanks!
Yijing.

> 
> WBR, Sergei
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
