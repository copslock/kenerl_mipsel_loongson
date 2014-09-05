Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 12:48:00 +0200 (CEST)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:48721 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007085AbaIEKr6gZCPv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 12:47:58 +0200
Received: by mail-lb0-f170.google.com with SMTP id w7so13297412lbi.15
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 03:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=uJLBa6cPxUOQX+ycR56L9xpjg9GWzBHL8AbsN3/9qBU=;
        b=SUx3qIMQq81YdyMHCq0xXUfpxhCVwJKp6Kfp+ITSYtM3HoHZiNYhOH/UCN5vqiV8BN
         FL29opz3oBBy0Ev5r1mHqyI1kCnk5QwKurHrQP6Mn4p8zc6NcWezEpCWI9RNfYXM0orQ
         bl7H3slyDxt4MlHRurRxRiciMfxb2H30MqMUKztdopsPINItZlklLyibP64AZXHNhe0P
         oTqmOW+UQH16BSdpiw7wDUWiuIUghIYN2xJrLmg+kqxBnXRMp8c7tGjR4ZPpU5brCWnq
         CaIvEi1wEXqjEebdBjEF3PZP9bLvNmujmZz3dKHX2hUVqlYLNMOK5VVmZqC78j7jgGi+
         EecA==
X-Gm-Message-State: ALoCoQlYFrm1Y/Fbye7R6Kv9BVpVN9oX1m6rbOYAqFddD6qBcQmqpHnxMjlGoJFY7rYPZdVNevqH
X-Received: by 10.112.56.206 with SMTP id c14mr10280054lbq.27.1409914070937;
        Fri, 05 Sep 2014 03:47:50 -0700 (PDT)
Received: from [192.168.2.5] (ppp17-243.pppoe.mtu-net.ru. [81.195.17.243])
        by mx.google.com with ESMTPSA id ue1sm558658lac.48.2014.09.05.03.47.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2014 03:47:50 -0700 (PDT)
Message-ID: <540994D4.6040500@cogentembedded.com>
Date:   Fri, 05 Sep 2014 14:47:48 +0400
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
Subject: Re: [PATCH v1 15/21] Powerpc/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com> <1409911806-10519-16-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1409911806-10519-16-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42424
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

On 9/5/2014 2:10 PM, Yijing Wang wrote:

> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>   arch/powerpc/kernel/msi.c |   14 ++++++++++++--
>   1 files changed, 12 insertions(+), 2 deletions(-)

> diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
> index 71bd161..01781a4 100644
> --- a/arch/powerpc/kernel/msi.c
> +++ b/arch/powerpc/kernel/msi.c
[...]
> @@ -27,7 +27,17 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>   	return ppc_md.setup_msi_irqs(dev, nvec, type);
>   }
>
> -void arch_teardown_msi_irqs(struct pci_dev *dev)
> +static void ppc_teardown_msi_irqs(struct pci_dev *dev)

    Shouldn't this function take IRQ # instead?

>   {
>   	ppc_md.teardown_msi_irqs(dev);
>   }
> +
> +static struct msi_chip ppc_msi_chip = {
> +	.setup_irqs = ppc_setup_msi_irqs,
> +	.teardown_irqs = ppc_teardown_msi_irqs,
> +};
> +
> +struct msi_chip *arch_find_msi_chip(struct pci_dev *dev)
> +{
> +	return &ppc_msi_chip;
> +}

WBR, Sergei
