Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 13:33:26 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:50215 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007097AbaIELdYFx5kF convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Sep 2014 13:33:24 +0200
Received: by mail-pd0-f180.google.com with SMTP id ft15so30344pdb.25
        for <multiple recipients>; Fri, 05 Sep 2014 04:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=2Gt8WW5VLPdRC7lJXHTATT+5TFDvAOeV25yy7RL1/yY=;
        b=uiSOpMe5umXUwL3XM54ABhiYdKolfxW+9r1TzEvVqrhNtq4wlTPqXge6rjJcry+1iC
         Bny+MFOO2j8ivUYSkcsyv6h62vLTETJxYF0lV4f5zxKJEPXUfWoTOlTtrebuAZq7+FfW
         uMFtJjaU7HtkqbgzqIDs5dfqU6qVtjbFKQ/ydrYqYkAQ/cHv7BtepRV3nWFuvnG9axpI
         Z8UKv6SQFSSJj/Wt47h2Savf791LKuX/sP5iyNNDJPgC20/3EDLLOdp2Y9KLQjtj/OVG
         gwwZ1HOdq9n/5hepHiuqqQKnhXGoFEklvZoRf301VYcG8XFfiDsyRaL+BrKiwDs+G2g2
         p8wQ==
X-Received: by 10.70.102.200 with SMTP id fq8mr20628552pdb.152.1409916789818;
        Fri, 05 Sep 2014 04:33:09 -0700 (PDT)
Received: from [192.168.1.102] ([111.140.71.79])
        by mx.google.com with ESMTPSA id ca2sm1551082pbc.26.2014.09.05.04.33.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 05 Sep 2014 04:33:09 -0700 (PDT)
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com> <1409911806-10519-16-git-send-email-wangyijing@huawei.com> <540994D4.6040500@cogentembedded.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <540994D4.6040500@cogentembedded.com>
Content-Type: text/plain;
        charset=gb2312
Content-Transfer-Encoding: 8BIT
Message-Id: <43412AE0-85BB-4B4B-A4EA-2C6D3B8B85D7@gmail.com>
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
Subject: Re: [PATCH v1 15/21] Powerpc/MSI: Use MSI chip framework to configure MSI/MSI-X irq
Date:   Fri, 5 Sep 2014 19:33:08 +0800
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Return-Path: <wangyijing0307@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42426
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



> 在 2014年9月5日，18:47，Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> 写道：
> 
> Hello.
> 
>> On 9/5/2014 2:10 PM, Yijing Wang wrote:
>> 
>> Use MSI chip framework instead of arch MSI functions to configure
>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  arch/powerpc/kernel/msi.c |   14 ++++++++++++--
>>  1 files changed, 12 insertions(+), 2 deletions(-)
> 
>> diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
>> index 71bd161..01781a4 100644
>> --- a/arch/powerpc/kernel/msi.c
>> +++ b/arch/powerpc/kernel/msi.c
> [...]
>> @@ -27,7 +27,17 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>>      return ppc_md.setup_msi_irqs(dev, nvec, type);
>>  }
>> 
>> -void arch_teardown_msi_irqs(struct pci_dev *dev)
>> +static void ppc_teardown_msi_irqs(struct pci_dev *dev)
> 
>   Shouldn't this function take IRQ # instead?

This function need to teardown all msi irqs of the pci dev, we should pass the pci dev as argument .

Thanks!
Yijing.

> 
>>  {
>>      ppc_md.teardown_msi_irqs(dev);
>>  }
>> +
>> +static struct msi_chip ppc_msi_chip = {
>> +    .setup_irqs = ppc_setup_msi_irqs,
>> +    .teardown_irqs = ppc_teardown_msi_irqs,
>> +};
>> +
>> +struct msi_chip *arch_find_msi_chip(struct pci_dev *dev)
>> +{
>> +    return &ppc_msi_chip;
>> +}
> 
> WBR, Sergei
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
