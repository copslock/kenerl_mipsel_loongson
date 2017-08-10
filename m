Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2017 09:57:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19047 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992262AbdHJH5uCfEhl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Aug 2017 09:57:50 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 686E02E34A657;
        Thu, 10 Aug 2017 08:57:39 +0100 (IST)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 10 Aug
 2017 08:57:41 +0100
Subject: Re: [PATCH] mips: Fix using smp_processor_id() when preemptible
To:     <minyard@acm.org>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, <linux-kernel@vger.kernel.org>
CC:     Corey Minyard <cminyard@mvista.com>
References: <1502313950-725-1-git-send-email-minyard@acm.org>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <d5605c8a-6c98-af7c-1878-3a8d85b25f71@imgtec.com>
Date:   Thu, 10 Aug 2017 09:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1502313950-725-1-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Hi Corey,

This has already been fixed here:
https://git.linux-mips.org/cgit/ralf/upstream-sfr.git/commit/?id=21da5332327b6d183bd93336ecf29c70bc609b7b

https://git.linux-mips.org/cgit/ralf/upstream-sfr.git/commit/?id=735302665c353d6756e7fa2a2cf41b039299f732

Marcin

On 09.08.2017 23:25, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> I was getting the following:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> caller is pcibios_set_cache_line_size+0x10/0x58
> 
> pcibios_set_cache_line_size() used current_cpu_data outside of
> an unpreemptible context.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>   arch/mips/pci/pci.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
> index bd67ac7..afd2f8a 100644
> --- a/arch/mips/pci/pci.c
> +++ b/arch/mips/pci/pci.c
> @@ -28,9 +28,11 @@ EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
>   
>   static int __init pcibios_set_cache_line_size(void)
>   {
> -	struct cpuinfo_mips *c = &current_cpu_data;
> +	struct cpuinfo_mips *c;
>   	unsigned int lsize;
>   
> +	preempt_disable();
> +	c = &current_cpu_data;
>   	/*
>   	 * Set PCI cacheline size to that of the highest level in the
>   	 * cache hierarchy.
> @@ -38,6 +40,7 @@ static int __init pcibios_set_cache_line_size(void)
>   	lsize = c->dcache.linesz;
>   	lsize = c->scache.linesz ? : lsize;
>   	lsize = c->tcache.linesz ? : lsize;
> +	preempt_enable();
>   
>   	BUG_ON(!lsize);
>   
> 
