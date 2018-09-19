Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2018 11:05:26 +0200 (CEST)
Received: from szxga07-in.huawei.com ([45.249.212.35]:34709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994637AbeISJFTBvklQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Sep 2018 11:05:19 +0200
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4DE785ADFD14B;
        Wed, 19 Sep 2018 17:05:09 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 17:05:03 +0800
Date:   Wed, 19 Sep 2018 10:04:49 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linuxppc-dev@lists.ozlabs.org>,
        <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 03/29] mm: remove CONFIG_HAVE_MEMBLOCK
Message-ID: <20180919100449.00006df9@huawei.com>
In-Reply-To: <1536163184-26356-4-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
        <1536163184-26356-4-git-send-email-rppt@linux.vnet.ibm.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Return-Path: <jonathan.cameron@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonathan.cameron@huawei.com
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

On Wed, 5 Sep 2018 18:59:18 +0300
Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> All architecures use memblock for early memory management. There is no need
> for the CONFIG_HAVE_MEMBLOCK configuration option.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Hi Mike,

A minor editing issue in here that is stopping boot on arm64 platforms with latest
version of the mm tree.

> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 76c83c1..bd841bb 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1115,13 +1115,11 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  	return 1;
>  }
>  
> -#ifdef CONFIG_HAVE_MEMBLOCK
>  #ifndef MIN_MEMBLOCK_ADDR
>  #define MIN_MEMBLOCK_ADDR	__pa(PAGE_OFFSET)
>  #endif
>  #ifndef MAX_MEMBLOCK_ADDR
>  #define MAX_MEMBLOCK_ADDR	((phys_addr_t)~0)
> -#endif

This isn't the right #endif. It is matching with the #ifndef MAX_MEMBLOCK_ADDR
not the intented #ifdef CONFIG_HAVE_MEMBLOCK.

Now I haven't chased through the exact reason this is causing my acpi
arm64 system not to boot on the basis it is obviously miss-matched anyway
and I'm inherently lazy.  It's resulting in stubs replacing the following weak
functions.

early_init_dt_add_memory_arch
(this is defined elsewhere for some architectures but not arm)

early_init_dt_mark_hotplug_memory_arch
(there is only one definition of this in the kernel so it doesn't
 need to be weak or in the header etc).

early_init_dt_reserve_memory_arch
(defined on mips but nothing else)

Taking out the right endif also lets you drop an #else removing some stub
functions further down in here.

Nice cleanup in general btw.

Thanks,

Jonathan
>  
>  void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
>  {
