Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Aug 2013 02:54:56 +0200 (CEST)
Received: from szxga01-in.huawei.com ([119.145.14.64]:23052 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827342Ab3HaAyxMNtAJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 Aug 2013 02:54:53 +0200
Received: from 172.24.2.119 (EHLO szxeml206-edg.china.huawei.com) ([172.24.2.119])
        by szxrg01-dlp.huawei.com (MOS 4.3.4-GA FastPath queued)
        with ESMTP id BHN26053;
        Sat, 31 Aug 2013 08:54:32 +0800 (CST)
Received: from SZXEML452-HUB.china.huawei.com (10.82.67.195) by
 szxeml206-edg.china.huawei.com (172.24.2.59) with Microsoft SMTP Server (TLS)
 id 14.1.323.7; Sat, 31 Aug 2013 08:54:27 +0800
Received: from [127.0.0.1] (10.135.74.216) by szxeml452-hub.china.huawei.com
 (10.82.67.195) with Microsoft SMTP Server id 14.1.323.7; Sat, 31 Aug 2013
 08:54:26 +0800
Message-ID: <52213EBD.8060609@huawei.com>
Date:   Sat, 31 Aug 2013 08:54:21 +0800
From:   Jianguo Wu <wujianguo@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-parisc@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <sparclinux@vger.kernel.org>, <x86@kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH 4/4] mm/arch: use NUMA_NODE
References: <521FFE3B.7040801@huawei.com>
In-Reply-To: <521FFE3B.7040801@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.135.74.216]
X-CFilter-Loop: Reflected
Return-Path: <wujianguo@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wujianguo@huawei.com
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

Cc linux-mm@kvack.org

On 2013/8/30 10:06, Jianguo Wu wrote:

> Use more appropriate NUMA_NO_NODE instead of -1 in some archs' module_alloc()
> 
> Signed-off-by: Jianguo Wu <wujianguo@huawei.com>
> ---
>  arch/arm/kernel/module.c    |    2 +-
>  arch/arm64/kernel/module.c  |    2 +-
>  arch/mips/kernel/module.c   |    2 +-
>  arch/parisc/kernel/module.c |    2 +-
>  arch/s390/kernel/module.c   |    2 +-
>  arch/sparc/kernel/module.c  |    2 +-
>  arch/x86/kernel/module.c    |    2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> index 85c3fb6..8f4cff3 100644
> --- a/arch/arm/kernel/module.c
> +++ b/arch/arm/kernel/module.c
> @@ -40,7 +40,7 @@
>  void *module_alloc(unsigned long size)
>  {
>  	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> -				GFP_KERNEL, PAGE_KERNEL_EXEC, -1,
> +				GFP_KERNEL, PAGE_KERNEL_EXEC, NUMA_NO_NODE,
>  				__builtin_return_address(0));
>  }
>  #endif
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index ca0e3d5..8f898bd 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -29,7 +29,7 @@
>  void *module_alloc(unsigned long size)
>  {
>  	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> -				    GFP_KERNEL, PAGE_KERNEL_EXEC, -1,
> +				    GFP_KERNEL, PAGE_KERNEL_EXEC, NUMA_NO_NODE,
>  				    __builtin_return_address(0));
>  }
>  
> diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
> index 977a623..b507e07 100644
> --- a/arch/mips/kernel/module.c
> +++ b/arch/mips/kernel/module.c
> @@ -46,7 +46,7 @@ static DEFINE_SPINLOCK(dbe_lock);
>  void *module_alloc(unsigned long size)
>  {
>  	return __vmalloc_node_range(size, 1, MODULE_START, MODULE_END,
> -				GFP_KERNEL, PAGE_KERNEL, -1,
> +				GFP_KERNEL, PAGE_KERNEL, NUMA_NO_NODE,
>  				__builtin_return_address(0));
>  }
>  #endif
> diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
> index 2a625fb..50dfafc 100644
> --- a/arch/parisc/kernel/module.c
> +++ b/arch/parisc/kernel/module.c
> @@ -219,7 +219,7 @@ void *module_alloc(unsigned long size)
>  	 * init_data correctly */
>  	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
>  				    GFP_KERNEL | __GFP_HIGHMEM,
> -				    PAGE_KERNEL_RWX, -1,
> +				    PAGE_KERNEL_RWX, NUMA_NO_NODE,
>  				    __builtin_return_address(0));
>  }
>  
> diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
> index 7845e15..b89b591 100644
> --- a/arch/s390/kernel/module.c
> +++ b/arch/s390/kernel/module.c
> @@ -50,7 +50,7 @@ void *module_alloc(unsigned long size)
>  	if (PAGE_ALIGN(size) > MODULES_LEN)
>  		return NULL;
>  	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> -				    GFP_KERNEL, PAGE_KERNEL, -1,
> +				    GFP_KERNEL, PAGE_KERNEL, NUMA_NO_NODE,
>  				    __builtin_return_address(0));
>  }
>  #endif
> diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
> index 4435488..97655e0 100644
> --- a/arch/sparc/kernel/module.c
> +++ b/arch/sparc/kernel/module.c
> @@ -29,7 +29,7 @@ static void *module_map(unsigned long size)
>  	if (PAGE_ALIGN(size) > MODULES_LEN)
>  		return NULL;
>  	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> -				GFP_KERNEL, PAGE_KERNEL, -1,
> +				GFP_KERNEL, PAGE_KERNEL, NUMA_NO_NODE,
>  				__builtin_return_address(0));
>  }
>  #else
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index 216a4d7..18be189 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -49,7 +49,7 @@ void *module_alloc(unsigned long size)
>  		return NULL;
>  	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
>  				GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL_EXEC,
> -				-1, __builtin_return_address(0));
> +				NUMA_NO_NODE, __builtin_return_address(0));
>  }
>  
>  #ifdef CONFIG_X86_32
