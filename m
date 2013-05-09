Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 May 2013 22:33:50 +0200 (CEST)
Received: from mail-ob0-f176.google.com ([209.85.214.176]:36863 "EHLO
        mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816288Ab3EIUdtWvEiy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 May 2013 22:33:49 +0200
Received: by mail-ob0-f176.google.com with SMTP id wc20so3346132obb.7
        for <multiple recipients>; Thu, 09 May 2013 13:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nKpdw96ssSHQVFIAF4oAc5DFBqKCMSvpDpxQ8eF8WjY=;
        b=JzTUX9eWvZBwCvnDmIeNVjengU5ZHSTEG/9Y5c407VuWEhCrIK9bMFVcHYRNWzm9N4
         Lj9JhJVMDb/4jTCfsIa8LGkK13a0fitIxho+Df6ufActO8acHIWN6vZ6zeoBUzx7yU+4
         enkW3wB6ohgiAwjgrgmD+fTCv3vgwW/xqNF+5RlTgPLfOqau8yyS4do2lrGElUdDvp99
         z2yVrLC7s+/t5jY2zwGIcSEou5CmRnATNZXhey3avBKpx5G7uqD5h1PepfHIqX/G1ZQu
         Fwcdmm8f0IwKfKIDwQBIf7qHW+KeZ17mORtrIftQgK1eCSgie0bxyLhTp3DhqnSkZ7as
         x5Tg==
X-Received: by 10.182.129.101 with SMTP id nv5mr5126518obb.56.1368131623119;
        Thu, 09 May 2013 13:33:43 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id jz6sm5082648oeb.3.2013.05.09.13.33.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 13:33:42 -0700 (PDT)
Message-ID: <518C0823.6030606@gmail.com>
Date:   Thu, 09 May 2013 13:33:39 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Jiang Liu <liuj97@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Jiang Liu <jiang.liu@huawei.com>,
        EUNBONG SONG <eunb.song@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, MIPS: fix a bug caused by free_initmem_default()
References: <1368115804-22220-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1368115804-22220-1-git-send-email-jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/09/2013 09:10 AM, Jiang Liu wrote:
> EUNBONG SONG <eunb.song@samsung.com> reported a bug on MIPS64 platforms
> caused by free_initmem() as below:
> [  132.134719] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.9.0+ #29
> [  132.141678] Stack : 0000000000000004 000000000000003f ffffffff80fa0000 ffffffff802924a8
>            0000000000000000 ffffffff80fa0000 00000000000000ff ffffffff80293760
>            0000000000000000 0000000000000000 ffffffff81080000 ffffffff81080000
>            ffffffff80e2baf0 ffffffff80f93977 a80000004146cbb8 0000000000000020
>            0000000000000003 0000000000000020 a800000041473da8 ffffffff810f0000
>            a800000041473a10 ffffffff806ef910 a800000041473828 ffffffff80290920
>            0000000000000000 ffffffff80293b90 000000000000000a ffffffff80e2baf0
>            0000000000000000 a800000041473750 000000004146cef8 ffffffff805e7794
>            0000000000000000 0000000000000000 0000000000000000 0000000000000000
>            0000000000000000 ffffffff80272498 0000000000000000 0000000000000000
>            ...
> [  132.207201] Call Trace:
> [  132.209655] [<ffffffff80272498>] show_stack+0x68/0x80
> [  132.225943] [<ffffffff802bd4ac>] notifier_call_chain+0x5c/0xa8
> [  132.231776] [<ffffffff802bdb84>] __atomic_notifier_call_chain+0x3c/0x58
> [  132.238391] [<ffffffff802bdbe8>] notify_die+0x38/0x48
> [  132.243442] [<ffffffff802716cc>] die+0x4c/0x148
> [  132.247974] [<ffffffff8027f998>] do_page_fault+0x4b8/0x500
> [  132.253461] [<ffffffff8026c764>] resume_userspace_check+0x0/0x10
> [  132.259469] [<ffffffff80324a54>] free_reserved_area+0x8c/0x178
> [  132.265304] [<ffffffff806e0dc8>] kernel_init+0x20/0x100
> [  132.270529] [<ffffffff8026c7e0>] ret_from_kernel_thread+0x10/0x18
>
> The root cause is that virt_to_page()/virt_to_phys() can't be used to
> handle virtual address from compatible segments on MIPS64 because
> virt_to_phys() is defined as:
> static inline unsigned long virt_to_phys(volatile const void *address)
> {
>          return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
> }
>
> x86_64 platforms have a similar situation, but __pa() has been enhanced
> to handle virtual address space used for kernel code and data segments.
> static inline unsigned long __phys_addr_nodebug(unsigned long x)
> {
>          unsigned long y = x - __START_KERNEL_map;
>
>          /* use the carry flag to determine if x was < __START_KERNEL_map */
>          x = y + ((x > y) ? phys_base : (__START_KERNEL_map - PAGE_OFFSET));
>
>          return x;
> }
>
> So we have two possible solutions here. The quick solution is to revert
> to the original implementation by using __pa_symbal(). The long term
> solution is to enhance virt_to_phys() to correctly handle virtual
> address from compatible segments.

We have a patch that does exactly this for MIPS:

http://www.linux-mips.org/archives/linux-mips/2013-05/msg00048.html

or if you prefer patchwork:

http://patchwork.linux-mips.org/patch/5220/

>
> This patch adopts the quick solution to fix the bug for v3.10, and we
> need guidance from MIPS64 experts on whether we should go with the long
> term solution.
>

I (as the author of the Long Term Solution) prefer that we apply the fix 
for virt_to_phys(), which is also needed for the reasons stated in the 
patch changelog.

So I would have to say NACK to this patch, use the virt_to_phys() fix 
instead.

David Daney


> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Signed-off-by: EUNBONG SONG <eunb.song@samsung.com>
> Cc: David Daney <ddaney.cavm@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/mips/mm/init.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> index 3d0346d..3648768 100644
> --- a/arch/mips/mm/init.c
> +++ b/arch/mips/mm/init.c
> @@ -446,7 +446,9 @@ void free_initrd_mem(unsigned long start, unsigned long end)
>   void __init_refok free_initmem(void)
>   {
>   	prom_free_prom_memory();
> -	free_initmem_default(POISON_FREE_INITMEM);
> +	free_init_pages("unused kernel memory",
> +			__pa_symbol(&__init_begin),
> +			__pa_symbol(&__init_end));
>   }
>
>   #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
>
