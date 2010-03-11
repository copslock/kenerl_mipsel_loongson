Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 01:18:08 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19430 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492412Ab0CKASE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Mar 2010 01:18:04 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b9836c20000>; Wed, 10 Mar 2010 16:18:10 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 10 Mar 2010 16:17:40 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 10 Mar 2010 16:17:40 -0800
Message-ID: <4B98369F.2060907@caviumnetworks.com>
Date:   Wed, 10 Mar 2010 16:17:35 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Thunderbird/3.0.3
MIME-Version: 1.0
To:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Loongson: Lemote-2F: Fixup of _rdmsr and _wrmsr
References: <7c2dec50764082fafa83895b740f644fc592afa4.1268235182.git.wuzhangjin@gmail.com>
In-Reply-To: <7c2dec50764082fafa83895b740f644fc592afa4.1268235182.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Mar 2010 00:17:40.0679 (UTC) FILETIME=[43258570:01CAC0B0]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/10/2010 07:41 AM, Wu Zhangjin wrote:
> From: Wu Zhangjin<wuzhangjin@gmail.com>
>
> The _rdmsr, _wrmsr operation must be atomic to ensure the accessing to msr
> address is what we want.
>
> Without this patch, in some cases, the reboot operation(fs2f_reboot) defined in
> arch/mips/loongson/lemote-2f/reset.c may fail for it called _rdmsr, _wrmsr but
> may be interrupted/preempted by the other related operations and make the
> _rdmsr get the wrong value or make the _wrmsr write a wrong value to an
> unexpected target.
>
> Signed-off-by: Wu Zhangjin<wuzhangjin@gmail.com>
> ---
>   arch/mips/pci/ops-loongson2.c |    9 +++++++++
>   1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/pci/ops-loongson2.c b/arch/mips/pci/ops-loongson2.c
> index 2bb4057..1f93dfb 100644
> --- a/arch/mips/pci/ops-loongson2.c
> +++ b/arch/mips/pci/ops-loongson2.c
> @@ -180,15 +180,20 @@ struct pci_ops loongson_pci_ops = {
>   };
>
>   #ifdef CONFIG_CS5536
> +DEFINE_SPINLOCK(msr_lock);


Should this be DEFINE_RAW_SPINLOCK instead?

David Daney


>   void _rdmsr(u32 msr, u32 *hi, u32 *lo)
>   {
>   	struct pci_bus bus = {
>   		.number = PCI_BUS_CS5536
>   	};
>   	u32 devfn = PCI_DEVFN(PCI_IDSEL_CS5536, 0);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&msr_lock, flags);
>   	loongson_pcibios_write(&bus, devfn, PCI_MSR_ADDR, 4, msr);
>   	loongson_pcibios_read(&bus, devfn, PCI_MSR_DATA_LO, 4, lo);
>   	loongson_pcibios_read(&bus, devfn, PCI_MSR_DATA_HI, 4, hi);
> +	spin_unlock_irqrestore(&msr_lock, flags);
>   }
>   EXPORT_SYMBOL(_rdmsr);
>
> @@ -198,9 +203,13 @@ void _wrmsr(u32 msr, u32 hi, u32 lo)
>   		.number = PCI_BUS_CS5536
>   	};
>   	u32 devfn = PCI_DEVFN(PCI_IDSEL_CS5536, 0);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&msr_lock, flags);
>   	loongson_pcibios_write(&bus, devfn, PCI_MSR_ADDR, 4, msr);
>   	loongson_pcibios_write(&bus, devfn, PCI_MSR_DATA_LO, 4, lo);
>   	loongson_pcibios_write(&bus, devfn, PCI_MSR_DATA_HI, 4, hi);
> +	spin_unlock_irqrestore(&msr_lock, flags);
>   }
>   EXPORT_SYMBOL(_wrmsr);
>   #endif
