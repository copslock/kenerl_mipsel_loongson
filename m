Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2018 12:23:29 +0200 (CEST)
Received: from pegase1.c-s.fr ([93.17.236.30]:50806 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993008AbeGEKXMpScVf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Jul 2018 12:23:12 +0200
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41Lv7r3Lptz9ttS1;
        Thu,  5 Jul 2018 12:23:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id btNar2wGZxeY; Thu,  5 Jul 2018 12:23:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41Lv7r2cDfz9ttBx;
        Thu,  5 Jul 2018 12:23:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AF59E8B897;
        Thu,  5 Jul 2018 12:23:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id R6m_1W6ppBel; Thu,  5 Jul 2018 12:23:05 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0DC1A8B88B;
        Thu,  5 Jul 2018 12:23:05 +0200 (CEST)
Subject: Re: [PATCH v3 02/11] hugetlb: Introduce generic version of
 hugetlb_free_pgd_range
To:     Alexandre Ghiti <alex@ghiti.fr>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20180705051640.790-1-alex@ghiti.fr>
 <20180705051640.790-3-alex@ghiti.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <005bf713-fb51-bf29-5f86-6f244cd49f35@c-s.fr>
Date:   Thu, 5 Jul 2018 10:22:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180705051640.790-3-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <christophe.leroy@c-s.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christophe.leroy@c-s.fr
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



On 07/05/2018 05:16 AM, Alexandre Ghiti wrote:
> arm, arm64, mips, parisc, sh, x86 architectures use the
> same version of hugetlb_free_pgd_range, so move this generic
> implementation into asm-generic/hugetlb.h.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Build failure on mpc885_ads_defconfig

   CC      arch/powerpc/kernel/setup-common.o
In file included from arch/powerpc/kernel/setup-common.c:37:
./include/linux/hugetlb.h:191:65: error: expected identifier or '(' 
before '{' token
  #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) 
({BUG(); 0; })
                                                                  ^
./include/asm-generic/hugetlb.h:44:20: note: in expansion of macro 
'hugetlb_free_pgd_range'
  static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
                     ^~~~~~~~~~~~~~~~~~~~~~

see below

> ---
>   arch/arm/include/asm/hugetlb.h     | 12 ++----------
>   arch/arm64/include/asm/hugetlb.h   | 10 ----------
>   arch/ia64/include/asm/hugetlb.h    |  5 +++--
>   arch/mips/include/asm/hugetlb.h    | 13 ++-----------
>   arch/parisc/include/asm/hugetlb.h  | 12 ++----------
>   arch/powerpc/include/asm/hugetlb.h |  4 +++-
>   arch/sh/include/asm/hugetlb.h      | 12 ++----------
>   arch/sparc/include/asm/hugetlb.h   |  4 +++-
>   arch/x86/include/asm/hugetlb.h     | 11 ++---------
>   include/asm-generic/hugetlb.h      | 11 +++++++++++
>   10 files changed, 30 insertions(+), 64 deletions(-)
> 

[snip]

> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index 3225eb6402cc..de46ee16b615 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -4,7 +4,6 @@
>   
>   #ifdef CONFIG_HUGETLB_PAGE
>   #include <asm/page.h>
> -#include <asm-generic/hugetlb.h>
>   
>   extern struct kmem_cache *hugepte_cache;
>   
> @@ -113,6 +112,7 @@ static inline void flush_hugetlb_page(struct vm_area_struct *vma,
>   void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
>   #endif
>   
> +#define __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
>   void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
>   			    unsigned long end, unsigned long floor,
>   			    unsigned long ceiling);
> @@ -193,4 +193,6 @@ static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
>   }
>   #endif /* CONFIG_HUGETLB_PAGE */
>   
> +#include <asm-generic/hugetlb.h>
> +

That include was previously inside #ifdef CONFIG_HUGETLB_PAGE.
Why put it outside ?

Christophe
