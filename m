Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Sep 2009 17:36:47 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16297 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493128AbZIIPgl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 Sep 2009 17:36:41 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4aa7cb3a0001>; Wed, 09 Sep 2009 11:35:25 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 9 Sep 2009 08:35:26 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 9 Sep 2009 08:35:26 -0700
Message-ID: <4AA7CB3E.1080807@caviumnetworks.com>
Date:	Wed, 09 Sep 2009 08:35:26 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Wu Fei <at.wufei@gmail.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] cleanup vmalloc_fault for 64bit kernel
References: <20090831132811.GA6924@desktop>
In-Reply-To: <20090831132811.GA6924@desktop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2009 15:35:26.0743 (UTC) FILETIME=[277BD270:01CA3163]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Wu Fei wrote:
> 64bit kernel won't arrive vmalloc_fault, it's not necessary or possible
> to copy the page table from init_mm.pgd. swapper_pg_dir, module_pg_dir
> and the process's pgd represent the different virtual address area, and
> the tlb exception handler accesses the suitable one directly.
> 
> Signed-off-by: Wu Fei <at.wufei@gmail.com>
> ---
>  arch/mips/mm/fault.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
> index f956ecb..e769789 100644
> --- a/arch/mips/mm/fault.c
> +++ b/arch/mips/mm/fault.c
> @@ -58,11 +58,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
>  	 * only copy the information from the master page table,
>  	 * nothing more.
>  	 */
> +#ifdef CONFIG_32BIT
>  	if (unlikely(address >= VMALLOC_START && address <= VMALLOC_END))
>  		goto vmalloc_fault;
> -#ifdef MODULE_START
> -	if (unlikely(address >= MODULE_START && address < MODULE_END))
> -		goto vmalloc_fault;
>  #endif
>  

That is not correct.  You can still arrive at do_page_fault() from 
faults in the vmalloc range.  We need to go directly to the panic code 
as I did in my patch: Message-Id: 
<1251931654-21268-1-git-send-email-ddaney@caviumnetworks.com>

AKA: [PATCH] MIPS: Don't corrupt page tables on vmalloc fault.



>  	/*
> @@ -203,6 +201,7 @@ do_sigbus:
>  	force_sig_info(SIGBUS, &info, tsk);
>  
>  	return;
> +#ifdef CONFIG_32BIT
>  vmalloc_fault:
>  	{
>  		/*
> @@ -241,4 +240,5 @@ vmalloc_fault:
>  			goto no_context;
>  		return;
>  	}
> +#endif
>  }
