Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 09:02:56 +0100 (CET)
Received: from bes.se.axis.com ([195.60.68.10]:33714 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010622AbcBXICyamWt9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2016 09:02:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 6D1112E135;
        Wed, 24 Feb 2016 09:02:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 2BENgtamusqE; Wed, 24 Feb 2016 09:02:47 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id 192022E0B5;
        Wed, 24 Feb 2016 09:02:47 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id EE0EA1289;
        Wed, 24 Feb 2016 09:02:46 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id E2982DF6;
        Wed, 24 Feb 2016 09:02:46 +0100 (CET)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
        by seth.se.axis.com (Postfix) with ESMTP id DCAF13E3F9;
        Wed, 24 Feb 2016 09:02:46 +0100 (CET)
Received: from [10.88.41.2] (10.0.5.55) by XBOX02.axis.com (10.0.5.16) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Wed, 24 Feb 2016 09:02:46 +0100
Message-ID: <56CD63A6.5090305@axis.com>
Date:   Wed, 24 Feb 2016 09:02:46 +0100
From:   Lars Persson <lars.persson@axis.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Lars Persson <larper@axis.com>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Marchand <jmarchan@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 2/2] MIPS: Flush highmem pages from dcache in __flush_icache_page
References: <1456164585-26910-1-git-send-email-paul.burton@imgtec.com> <1456164585-26910-2-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1456164585-26910-2-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.0.5.55]
X-ClientProxiedBy: XBOX04.axis.com (10.0.5.18) To XBOX02.axis.com (10.0.5.16)
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars.persson@axis.com
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


On 02/22/2016 07:09 PM, Paul Burton wrote:
> When a page is to be mapped executable for userspace, we can presume
> that the icache doesn't contain anything valid for its address range but
> we cannot be sure that its content has been written back from the dcache
> to L2 or memory further out. If the icache fills from those memories,
> ie. does not fill from the dcache, then we need to ensure that content
> has been flushed from the dcache. This was being done for lowmem pages
> but not for highmem pages. Fix this by mapping the page & flushing its
> content from the dcache in __flush_icache_page, before the page is
> provided to userland.
>

Reviewed-by: Lars Persson <larper@axis.com>

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>
> ---
>
>   arch/mips/mm/cache.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 3f159ca..734cb2f 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -16,6 +16,7 @@
>   #include <linux/mm.h>
>
>   #include <asm/cacheflush.h>
> +#include <asm/highmem.h>
>   #include <asm/processor.h>
>   #include <asm/cpu.h>
>   #include <asm/cpu-features.h>
> @@ -124,10 +125,14 @@ void __flush_icache_page(struct vm_area_struct *vma, struct page *page)
>   	unsigned long addr;
>
>   	if (PageHighMem(page))
> -		return;
> +		addr = (unsigned long)kmap_atomic(page);
> +	else
> +		addr = (unsigned long)page_address(page);
>
> -	addr = (unsigned long) page_address(page);
>   	flush_data_cache_page(addr);
> +
> +	if (PageHighMem(page))
> +		__kunmap_atomic((void *)addr);
>   }
>   EXPORT_SYMBOL_GPL(__flush_icache_page);
>
>
