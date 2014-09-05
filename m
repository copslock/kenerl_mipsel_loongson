Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 12:43:08 +0200 (CEST)
Received: from mail-la0-f47.google.com ([209.85.215.47]:39044 "EHLO
        mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007048AbaIEKnHAukqf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 12:43:07 +0200
Received: by mail-la0-f47.google.com with SMTP id el20so5060468lab.34
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 03:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=i54csfMQj2M4W4CMeqHyIEuJPUSiDw5XDbGmvPCTuuE=;
        b=DIw5MxhUxbkX32ciQ3eRj92liFXqHTUdHKtkr5bB/Utzuhto/gyWrX/1QRsGR1RfBm
         IbtSXNHZMPSAtkbapQnToKaG412cmPx9xO9UntSN4yQLpzY9L+t+jRU6HWogR36bw+49
         /M9i4y/hIkTkLyOAwebawddJiEQea2q07mwOvThpU65kSqfW6Ez50SnRWlY2urWNKleW
         9zT0Y46zavJpTmRf/dVFjb/Qjd2bK+hLxFx3V8BSm0AxCPIBkf8Qp8/H/i7Ib21Q0sqV
         jGKaK5yyUIDby4kQ7+UJOmVlYcgjFxw3/2tKkDCZ9QBfqG5Kp+VPdcaiLGW4j+2v2kIm
         7ZGg==
X-Gm-Message-State: ALoCoQlfTx1AB5NMehI3OrZ8OOK1Z63pAc8CScDeK7yo4ZAyJt6aBakpq2QW9ZISo0zl/I/cLnc1
X-Received: by 10.152.1.6 with SMTP id 6mr10822872lai.22.1409913781133;
        Fri, 05 Sep 2014 03:43:01 -0700 (PDT)
Received: from [192.168.2.5] (ppp17-243.pppoe.mtu-net.ru. [81.195.17.243])
        by mx.google.com with ESMTPSA id yr17sm591952lbb.46.2014.09.05.03.42.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2014 03:43:00 -0700 (PDT)
Message-ID: <540993B3.1000701@cogentembedded.com>
Date:   Fri, 05 Sep 2014 14:42:59 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
MIME-Version: 1.0
To:     Yijing Wang <wangyijing@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arch@vger.kernel.org, arnab.basu@freescale.com,
        Bharat.Bhushan@freescale.com, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v1 09/21] Irq_remapping/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com> <1409911806-10519-10-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1409911806-10519-10-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42423
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

Hello.

On 9/5/2014 2:09 PM, Yijing Wang wrote:

> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>   drivers/iommu/irq_remapping.c |    8 +++++++-
>   1 files changed, 7 insertions(+), 1 deletions(-)

> diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
> index 33c4395..e75026e 100644
> --- a/drivers/iommu/irq_remapping.c
> +++ b/drivers/iommu/irq_remapping.c
[...]
> @@ -165,9 +170,10 @@ static void __init irq_remapping_modify_x86_ops(void)
>   	x86_io_apic_ops.set_affinity	= set_remapped_irq_affinity;
>   	x86_io_apic_ops.setup_entry	= setup_ioapic_remapped_entry;
>   	x86_io_apic_ops.eoi_ioapic_pin	= eoi_ioapic_pin_remapped;
> -	x86_msi.setup_msi_irqs		= irq_remapping_setup_msi_irqs;
> +	x86_msi.setup_msi_irqs          = irq_remapping_setup_msi_irqs;

    AFAICS, this change only converts tabs to spaces, so not needed at all.

>   	x86_msi.setup_hpet_msi		= setup_hpet_msi_remapped;
>   	x86_msi.compose_msi_msg		= compose_remapped_msi_msg;
> +	x86_msi_chip = &remap_msi_chip;

    Please align = with the rest of assignments.

WBR, Sergei
