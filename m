Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 13:41:49 +0200 (CEST)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33753 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007043AbaIELlsLcnNf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 13:41:48 +0200
Received: by mail-lb0-f170.google.com with SMTP id w7so13352372lbi.1
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 04:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=AvvsciWmWVLT5LL8S+y+bEiiPf/FO0FbMELvEbWbRa4=;
        b=eP02k3PkG2o28S/S83sZpJ+exV8FTwa9MW6eTkcV8mo8QXVM6Oy2rqHZwmOgKcleog
         0Cv75PLKFP083oTgUq3/Ho4nRe110onR3AhXNbmPeqbrSpud+9hgByFlMAI+inYyYppr
         uPoQ89De1gd+bgikE3E8ZOMdNdNu81ZUC8LSYUlCsKnQkkbaaNl3dMusDKpAx9YHooyt
         JPCohIYi7FEUg45E3bogNSc22OMOlF1xg8ZbDKL+nwETC2mh1EPx+FfvTH+NlC7I/JEp
         UE++bLhXaetw2YXx+p5aTLedUp5P/CgYd1bK/KUFrX8A4QXbirIdl+s9SVDDU+J/TtR1
         gSjA==
X-Gm-Message-State: ALoCoQkg0EFRXhiY6Te4fFc5VyHFu6jzt3aaRxEgNoT5Fd4D9+l/6oeXAn9RKQv4DsKIDKJGWrDD
X-Received: by 10.152.23.131 with SMTP id m3mr11300641laf.8.1409917302132;
        Fri, 05 Sep 2014 04:41:42 -0700 (PDT)
Received: from [192.168.2.5] (ppp17-243.pppoe.mtu-net.ru. [81.195.17.243])
        by mx.google.com with ESMTPSA id k7sm618155lak.22.2014.09.05.04.41.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2014 04:41:41 -0700 (PDT)
Message-ID: <5409A174.3050205@cogentembedded.com>
Date:   Fri, 05 Sep 2014 15:41:40 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
MIME-Version: 1.0
To:     wangyijing <wangyijing0307@gmail.com>
CC:     Yijing Wang <wangyijing@huawei.com>,
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
Subject: Re: [PATCH v1 15/21] Powerpc/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com> <1409911806-10519-16-git-send-email-wangyijing@huawei.com> <540994D4.6040500@cogentembedded.com> <43412AE0-85BB-4B4B-A4EA-2C6D3B8B85D7@gmail.com>
In-Reply-To: <43412AE0-85BB-4B4B-A4EA-2C6D3B8B85D7@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 9/5/2014 3:33 PM, wangyijing wrote:

>>> Use MSI chip framework instead of arch MSI functions to configure
>>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

>>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>>> ---
>>>   arch/powerpc/kernel/msi.c |   14 ++++++++++++--
>>>   1 files changed, 12 insertions(+), 2 deletions(-)

>>> diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
>>> index 71bd161..01781a4 100644
>>> --- a/arch/powerpc/kernel/msi.c
>>> +++ b/arch/powerpc/kernel/msi.c
>> [...]
>>> @@ -27,7 +27,17 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>>>       return ppc_md.setup_msi_irqs(dev, nvec, type);
>>>   }
>>>
>>> -void arch_teardown_msi_irqs(struct pci_dev *dev)
>>> +static void ppc_teardown_msi_irqs(struct pci_dev *dev)

>>    Shouldn't this function take IRQ # instead?

> This function need to teardown all msi irqs of the pci dev, we should pass the pci dev as argument .

    Ah, I've mixed up the teardown_irqs() method with teardown_irq()! Too 
similar. :-)

> Thanks!
> Yijing.

WBR, Sergei
