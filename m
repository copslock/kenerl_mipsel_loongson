Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2012 21:47:56 +0100 (CET)
Received: from terminus.zytor.com ([198.137.202.10]:44063 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903701Ab2CAUrw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Mar 2012 21:47:52 +0100
Received: from tazenda.hos.anvin.org ([IPv6:2001:470:861f::feed:face:f00d])
        (authenticated bits=0)
        by mail.zytor.com (8.14.5/8.14.5) with ESMTP id q21Kl373015685
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=OK);
        Thu, 1 Mar 2012 12:47:04 -0800
Message-ID: <4F4FE041.1000507@zytor.com>
Date:   Thu, 01 Mar 2012 12:46:57 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120209 Thunderbird/10.0.1
MIME-Version: 1.0
To:     Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>
CC:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Subject: Re: [PATCH] mm: module_alloc: check if size is 0
References: <1330631119-10059-1-git-send-email-veli-pekka.peltola@bluegiga.com>
In-Reply-To: <1330631119-10059-1-git-send-email-veli-pekka.peltola@bluegiga.com>
X-Enigmail-Version: 1.3.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 32592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/01/2012 11:45 AM, Veli-Pekka Peltola wrote:
> diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> index 1e9be5d..d44d212 100644
> --- a/arch/arm/kernel/module.c
> +++ b/arch/arm/kernel/module.c
> @@ -39,8 +39,8 @@
>  #ifdef CONFIG_MMU
>  void *module_alloc(unsigned long size)
>  {
> -	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> -				GFP_KERNEL, PAGE_KERNEL_EXEC, -1,
> +	return size == 0 ? NULL : __vmalloc_node_range(size, 1, MODULES_VADDR,
> +				MODULES_END, GFP_KERNEL, PAGE_KERNEL_EXEC, -1,
>  				__builtin_return_address(0));
>  }
>  #endif
> diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
> index a5066b1..cd768e9 100644
> --- a/arch/mips/kernel/module.c
> +++ b/arch/mips/kernel/module.c
> @@ -47,8 +47,8 @@ static DEFINE_SPINLOCK(dbe_lock);
>  #ifdef MODULE_START
>  void *module_alloc(unsigned long size)
>  {
> -	return __vmalloc_node_range(size, 1, MODULE_START, MODULE_END,
> -				GFP_KERNEL, PAGE_KERNEL, -1,
> +	return size == 0 ? NULL : __vmalloc_node_range(size, 1, MODULE_START,
> +				MODULE_END, GFP_KERNEL, PAGE_KERNEL, -1,
>  				__builtin_return_address(0));
>  }
>  #endif
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index 925179f..bff6118 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -38,7 +38,7 @@
>  
>  void *module_alloc(unsigned long size)
>  {
> -	if (PAGE_ALIGN(size) > MODULES_LEN)
> +	if (size == 0 || PAGE_ALIGN(size) > MODULES_LEN)
>  		return NULL;
>  	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
>  				GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL_EXEC,

Looks good stylistically but really awkward technically.

I would like to suggest using the idiom:

	if (!size)
		return NULL;

... consistently; combined with the PAGE_ALIGN() clause for x86 is fine too.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
