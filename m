Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 15:57:54 +0200 (CEST)
Received: from ivanoab6.miniserver.com ([5.153.251.140]:33638 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992289AbeJLN5pdvNG0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 15:57:45 +0200
Received: from [192.168.17.6] (helo=smaug.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1gAxvQ-0002jB-QH; Fri, 12 Oct 2018 13:56:20 +0000
Received: from amistad.kot-begemot.co.uk ([192.168.3.89])
        by smaug.kot-begemot.co.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1gAxvQ-0001cM-Bu; Fri, 12 Oct 2018 14:56:20 +0100
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        lokeshgidra@google.com, linux-riscv@lists.infradead.org,
        elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>,
        linux-s390@vger.kernel.org, dancol@google.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-snps-arc@lists.infradead.org, kernel-team@android.com,
        Sam Creasey <sammy@sammy.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        nios2-dev@lists.rocketboards.org, kirill@shutemov.name,
        Stafford Horne <shorne@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org,
        Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>,
        Richard Weinberger <richard@nod.at>,
        linux-parisc@vger.kernel.org, pantin@google.com,
        Max Filippov <jcmvbkbc@gmail.com>, minchan@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
References: <20181012013756.11285-1-joel@joelfernandes.org>
From:   Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <594fc952-5e87-3162-b2f9-963479d16eb3@kot-begemot.co.uk>
Date:   Fri, 12 Oct 2018 14:56:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181012013756.11285-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Clacks-Overhead: GNU Terry Pratchett
Return-Path: <anton.ivanov@kot-begemot.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anton.ivanov@kot-begemot.co.uk
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


On 10/12/18 2:37 AM, Joel Fernandes (Google) wrote:
> This series speeds up mremap(2) syscall by copying page tables at the
> PMD level even for non-THP systems. There is concern that the extra
> 'address' argument that mremap passes to pte_alloc may do something
> subtle architecture related in the future, that makes the scheme not
> work.  Also we find that there is no point in passing the 'address' to
> pte_alloc since its unused.
>
> This patch therefore removes this argument tree-wide resulting in a nice
> negative diff as well. Also ensuring along the way that the architecture
> does not do anything funky with 'address' argument that goes unnoticed.
>
> Build and boot tested on x86-64. Build tested on arm64.
>
> The changes were obtained by applying the following Coccinelle script.
> The pte_fragment_alloc was manually fixed up since it was only 2
> occurences and could not be easily generalized (and thanks Julia for
> answering all my silly and not-silly Coccinelle questions!).
>
> // Options: --include-headers --no-includes
> // Note: I split the 'identifier fn' line, so if you are manually
> // running it, please unsplit it so it runs for you.
>
> virtual patch
>
> @pte_alloc_func_def depends on patch exists@
> identifier E2;
> identifier fn =~
> "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> type T2;
> @@
>
>   fn(...
> - , T2 E2
>   )
>   { ... }
>
> @pte_alloc_func_proto depends on patch exists@
> identifier E1, E2, E4;
> type T1, T2, T3, T4;
> identifier fn =~
> "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> @@
>
> (
> - T3 fn(T1 E1, T2 E2);
> + T3 fn(T1 E1);
> |
> - T3 fn(T1 E1, T2 E2, T4 E4);
> + T3 fn(T1 E1, T2 E2);
> )
>
> @pte_alloc_func_call depends on patch exists@
> expression E2;
> identifier fn =~
> "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> @@
>
>   fn(...
> -,  E2
>   )
>
> @pte_alloc_macro depends on patch exists@
> identifier fn =~
> "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> identifier a, b, c;
> expression e;
> position p;
> @@
>
> (
> - #define fn(a, b, c)@p e
> + #define fn(a, b) e
> |
> - #define fn(a, b)@p e
> + #define fn(a) e
> )
>
> Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: elfring@users.sourceforge.net
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>   arch/alpha/include/asm/pgalloc.h             |  6 +++---
>   arch/arc/include/asm/pgalloc.h               |  5 ++---
>   arch/arm/include/asm/pgalloc.h               |  4 ++--
>   arch/arm64/include/asm/pgalloc.h             |  4 ++--
>   arch/hexagon/include/asm/pgalloc.h           |  6 ++----
>   arch/ia64/include/asm/pgalloc.h              |  5 ++---
>   arch/m68k/include/asm/mcf_pgalloc.h          |  8 ++------
>   arch/m68k/include/asm/motorola_pgalloc.h     |  4 ++--
>   arch/m68k/include/asm/sun3_pgalloc.h         |  6 ++----
>   arch/microblaze/include/asm/pgalloc.h        | 19 ++-----------------
>   arch/microblaze/mm/pgtable.c                 |  3 +--
>   arch/mips/include/asm/pgalloc.h              |  6 ++----
>   arch/nds32/include/asm/pgalloc.h             |  5 ++---
>   arch/nios2/include/asm/pgalloc.h             |  6 ++----
>   arch/openrisc/include/asm/pgalloc.h          |  5 ++---
>   arch/openrisc/mm/ioremap.c                   |  3 +--
>   arch/parisc/include/asm/pgalloc.h            |  4 ++--
>   arch/powerpc/include/asm/book3s/32/pgalloc.h |  4 ++--
>   arch/powerpc/include/asm/book3s/64/pgalloc.h | 12 +++++-------
>   arch/powerpc/include/asm/nohash/32/pgalloc.h |  4 ++--
>   arch/powerpc/include/asm/nohash/64/pgalloc.h |  6 ++----
>   arch/powerpc/mm/pgtable-book3s64.c           |  2 +-
>   arch/powerpc/mm/pgtable_32.c                 |  4 ++--
>   arch/riscv/include/asm/pgalloc.h             |  6 ++----
>   arch/s390/include/asm/pgalloc.h              |  4 ++--
>   arch/sh/include/asm/pgalloc.h                |  6 ++----
>   arch/sparc/include/asm/pgalloc_32.h          |  5 ++---
>   arch/sparc/include/asm/pgalloc_64.h          |  6 ++----
>   arch/sparc/mm/init_64.c                      |  6 ++----
>   arch/sparc/mm/srmmu.c                        |  4 ++--
>   arch/um/kernel/mem.c                         |  4 ++--

There is a declaration of pte_alloc_one in arch/um/include/asm/pgalloc.h

This patch missed it.

>   arch/unicore32/include/asm/pgalloc.h         |  4 ++--
>   arch/x86/include/asm/pgalloc.h               |  4 ++--
>   arch/x86/mm/pgtable.c                        |  4 ++--
>   arch/xtensa/include/asm/pgalloc.h            |  8 +++-----
>   include/linux/mm.h                           | 13 ++++++-------
>   mm/huge_memory.c                             |  8 ++++----
>   mm/kasan/kasan_init.c                        |  2 +-
>   mm/memory.c                                  | 17 ++++++++---------
>   mm/migrate.c                                 |  2 +-
>   mm/mremap.c                                  |  2 +-
>   mm/userfaultfd.c                             |  2 +-
>   virt/kvm/arm/mmu.c                           |  2 +-
>   43 files changed, 95 insertions(+), 145 deletions(-)
>
> diff --git a/arch/alpha/include/asm/pgalloc.h b/arch/alpha/include/asm/pgalloc.h
> index ab3e3a8638fb..02f9f91bb4f0 100644
> --- a/arch/alpha/include/asm/pgalloc.h
> +++ b/arch/alpha/include/asm/pgalloc.h
> @@ -52,7 +52,7 @@ pmd_free(struct mm_struct *mm, pmd_t *pmd)
>   }
>   
>   static inline pte_t *
> -pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
> +pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
>   	return pte;
> @@ -65,9 +65,9 @@ pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>   }
>   
>   static inline pgtable_t
> -pte_alloc_one(struct mm_struct *mm, unsigned long address)
> +pte_alloc_one(struct mm_struct *mm)
>   {
> -	pte_t *pte = pte_alloc_one_kernel(mm, address);
> +	pte_t *pte = pte_alloc_one_kernel(mm);
>   	struct page *page;
>   
>   	if (!pte)
> diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
> index 3749234b7419..9c9b5a5ebf2e 100644
> --- a/arch/arc/include/asm/pgalloc.h
> +++ b/arch/arc/include/asm/pgalloc.h
> @@ -90,8 +90,7 @@ static inline int __get_order_pte(void)
>   	return get_order(PTRS_PER_PTE * sizeof(pte_t));
>   }
>   
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -					unsigned long address)
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	pte_t *pte;
>   
> @@ -102,7 +101,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
>   }
>   
>   static inline pgtable_t
> -pte_alloc_one(struct mm_struct *mm, unsigned long address)
> +pte_alloc_one(struct mm_struct *mm)
>   {
>   	pgtable_t pte_pg;
>   	struct page *page;
> diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
> index 2d7344f0e208..17ab72f0cc4e 100644
> --- a/arch/arm/include/asm/pgalloc.h
> +++ b/arch/arm/include/asm/pgalloc.h
> @@ -81,7 +81,7 @@ static inline void clean_pte_table(pte_t *pte)
>    *  +------------+
>    */
>   static inline pte_t *
> -pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
> +pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	pte_t *pte;
>   
> @@ -93,7 +93,7 @@ pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
>   }
>   
>   static inline pgtable_t
> -pte_alloc_one(struct mm_struct *mm, unsigned long addr)
> +pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *pte;
>   
> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
> index 2e05bcd944c8..52fa47c73bf0 100644
> --- a/arch/arm64/include/asm/pgalloc.h
> +++ b/arch/arm64/include/asm/pgalloc.h
> @@ -91,13 +91,13 @@ extern pgd_t *pgd_alloc(struct mm_struct *mm);
>   extern void pgd_free(struct mm_struct *mm, pgd_t *pgdp);
>   
>   static inline pte_t *
> -pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
> +pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	return (pte_t *)__get_free_page(PGALLOC_GFP);
>   }
>   
>   static inline pgtable_t
> -pte_alloc_one(struct mm_struct *mm, unsigned long addr)
> +pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *pte;
>   
> diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
> index eeebf862c46c..d36183887b60 100644
> --- a/arch/hexagon/include/asm/pgalloc.h
> +++ b/arch/hexagon/include/asm/pgalloc.h
> @@ -59,8 +59,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>   	free_page((unsigned long) pgd);
>   }
>   
> -static inline struct page *pte_alloc_one(struct mm_struct *mm,
> -					 unsigned long address)
> +static inline struct page *pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *pte;
>   
> @@ -75,8 +74,7 @@ static inline struct page *pte_alloc_one(struct mm_struct *mm,
>   }
>   
>   /* _kernel variant gets to use a different allocator */
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -					  unsigned long address)
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	gfp_t flags =  GFP_KERNEL | __GFP_ZERO;
>   	return (pte_t *) __get_free_page(flags);
> diff --git a/arch/ia64/include/asm/pgalloc.h b/arch/ia64/include/asm/pgalloc.h
> index 3ee5362f2661..c9e481023c25 100644
> --- a/arch/ia64/include/asm/pgalloc.h
> +++ b/arch/ia64/include/asm/pgalloc.h
> @@ -83,7 +83,7 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t * pmd_entry, pte_t * pte)
>   	pmd_val(*pmd_entry) = __pa(pte);
>   }
>   
> -static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr)
> +static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *page;
>   	void *pg;
> @@ -99,8 +99,7 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr)
>   	return page;
>   }
>   
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -					  unsigned long addr)
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	return quicklist_alloc(0, GFP_KERNEL, NULL);
>   }
> diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
> index 12fe700632f4..4399d712f6db 100644
> --- a/arch/m68k/include/asm/mcf_pgalloc.h
> +++ b/arch/m68k/include/asm/mcf_pgalloc.h
> @@ -12,8 +12,7 @@ extern inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>   
>   extern const char bad_pmd_string[];
>   
> -extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -	unsigned long address)
> +extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	unsigned long page = __get_free_page(GFP_DMA);
>   
> @@ -32,8 +31,6 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
>   #define pmd_alloc_one_fast(mm, address) ({ BUG(); ((pmd_t *)1); })
>   #define pmd_alloc_one(mm, address)      ({ BUG(); ((pmd_t *)2); })
>   
> -#define pte_alloc_one_fast(mm, addr) pte_alloc_one(mm, addr)
> -
>   #define pmd_populate(mm, pmd, page) (pmd_val(*pmd) = \
>   	(unsigned long)(page_address(page)))
>   
> @@ -50,8 +47,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t page,
>   
>   #define __pmd_free_tlb(tlb, pmd, address) do { } while (0)
>   
> -static inline struct page *pte_alloc_one(struct mm_struct *mm,
> -	unsigned long address)
> +static inline struct page *pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *page = alloc_pages(GFP_DMA, 0);
>   	pte_t *pte;
> diff --git a/arch/m68k/include/asm/motorola_pgalloc.h b/arch/m68k/include/asm/motorola_pgalloc.h
> index 7859a86319cf..d04d9ba9b976 100644
> --- a/arch/m68k/include/asm/motorola_pgalloc.h
> +++ b/arch/m68k/include/asm/motorola_pgalloc.h
> @@ -8,7 +8,7 @@
>   extern pmd_t *get_pointer_table(void);
>   extern int free_pointer_table(pmd_t *);
>   
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	pte_t *pte;
>   
> @@ -28,7 +28,7 @@ static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>   	free_page((unsigned long) pte);
>   }
>   
> -static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
> +static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *page;
>   	pte_t *pte;
> diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
> index 11485d38de4e..1456c5eecbd9 100644
> --- a/arch/m68k/include/asm/sun3_pgalloc.h
> +++ b/arch/m68k/include/asm/sun3_pgalloc.h
> @@ -35,8 +35,7 @@ do {							\
>   	tlb_remove_page((tlb), pte);			\
>   } while (0)
>   
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -					  unsigned long address)
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	unsigned long page = __get_free_page(GFP_KERNEL);
>   
> @@ -47,8 +46,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
>   	return (pte_t *) (page);
>   }
>   
> -static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
> -					unsigned long address)
> +static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
>   {
>           struct page *page = alloc_pages(GFP_KERNEL, 0);
>   
> diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
> index 7c89390c0c13..f4cc9ffc449e 100644
> --- a/arch/microblaze/include/asm/pgalloc.h
> +++ b/arch/microblaze/include/asm/pgalloc.h
> @@ -108,10 +108,9 @@ static inline void free_pgd_slow(pgd_t *pgd)
>   #define pmd_alloc_one_fast(mm, address)	({ BUG(); ((pmd_t *)1); })
>   #define pmd_alloc_one(mm, address)	({ BUG(); ((pmd_t *)2); })
>   
> -extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
> +extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
>   
> -static inline struct page *pte_alloc_one(struct mm_struct *mm,
> -		unsigned long address)
> +static inline struct page *pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *ptepage;
>   
> @@ -132,20 +131,6 @@ static inline struct page *pte_alloc_one(struct mm_struct *mm,
>   	return ptepage;
>   }
>   
> -static inline pte_t *pte_alloc_one_fast(struct mm_struct *mm,
> -		unsigned long address)
> -{
> -	unsigned long *ret;
> -
> -	ret = pte_quicklist;
> -	if (ret != NULL) {
> -		pte_quicklist = (unsigned long *)(*ret);
> -		ret[0] = 0;
> -		pgtable_cache_size--;
> -	}
> -	return (pte_t *)ret;
> -}
> -
>   static inline void pte_free_fast(pte_t *pte)
>   {
>   	*(unsigned long **)pte = pte_quicklist;
> diff --git a/arch/microblaze/mm/pgtable.c b/arch/microblaze/mm/pgtable.c
> index 7f525962cdfa..c2ce1e42b888 100644
> --- a/arch/microblaze/mm/pgtable.c
> +++ b/arch/microblaze/mm/pgtable.c
> @@ -235,8 +235,7 @@ unsigned long iopa(unsigned long addr)
>   	return pa;
>   }
>   
> -__ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -		unsigned long address)
> +__ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	pte_t *pte;
>   	if (mem_init_done) {
> diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
> index 39b9f311c4ef..27808d9461f4 100644
> --- a/arch/mips/include/asm/pgalloc.h
> +++ b/arch/mips/include/asm/pgalloc.h
> @@ -50,14 +50,12 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>   	free_pages((unsigned long)pgd, PGD_ORDER);
>   }
>   
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -	unsigned long address)
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	return (pte_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, PTE_ORDER);
>   }
>   
> -static inline struct page *pte_alloc_one(struct mm_struct *mm,
> -	unsigned long address)
> +static inline struct page *pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *pte;
>   
> diff --git a/arch/nds32/include/asm/pgalloc.h b/arch/nds32/include/asm/pgalloc.h
> index 27448869131a..3c5fee5b5759 100644
> --- a/arch/nds32/include/asm/pgalloc.h
> +++ b/arch/nds32/include/asm/pgalloc.h
> @@ -22,8 +22,7 @@ extern void pgd_free(struct mm_struct *mm, pgd_t * pgd);
>   
>   #define check_pgt_cache()		do { } while (0)
>   
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -					  unsigned long addr)
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	pte_t *pte;
>   
> @@ -34,7 +33,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
>   	return pte;
>   }
>   
> -static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr)
> +static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
>   {
>   	pgtable_t pte;
>   
> diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
> index bb47d08c8ef7..3a149ead1207 100644
> --- a/arch/nios2/include/asm/pgalloc.h
> +++ b/arch/nios2/include/asm/pgalloc.h
> @@ -37,8 +37,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>   	free_pages((unsigned long)pgd, PGD_ORDER);
>   }
>   
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -	unsigned long address)
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	pte_t *pte;
>   
> @@ -47,8 +46,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
>   	return pte;
>   }
>   
> -static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
> -	unsigned long address)
> +static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *pte;
>   
> diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
> index 8999b9226512..149c82ee4b8b 100644
> --- a/arch/openrisc/include/asm/pgalloc.h
> +++ b/arch/openrisc/include/asm/pgalloc.h
> @@ -70,10 +70,9 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>   	free_page((unsigned long)pgd);
>   }
>   
> -extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address);
> +extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
>   
> -static inline struct page *pte_alloc_one(struct mm_struct *mm,
> -					 unsigned long address)
> +static inline struct page *pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *pte;
>   	pte = alloc_pages(GFP_KERNEL, 0);
> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> index 2175e4bfd9fc..24fb1021c75a 100644
> --- a/arch/openrisc/mm/ioremap.c
> +++ b/arch/openrisc/mm/ioremap.c
> @@ -118,8 +118,7 @@ EXPORT_SYMBOL(iounmap);
>    * the memblock infrastructure.
>    */
>   
> -pte_t __ref *pte_alloc_one_kernel(struct mm_struct *mm,
> -					 unsigned long address)
> +pte_t __ref *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	pte_t *pte;
>   
> diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
> index cf13275f7c6d..d05c678c77c4 100644
> --- a/arch/parisc/include/asm/pgalloc.h
> +++ b/arch/parisc/include/asm/pgalloc.h
> @@ -122,7 +122,7 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
>   #define pmd_pgtable(pmd) pmd_page(pmd)
>   
>   static inline pgtable_t
> -pte_alloc_one(struct mm_struct *mm, unsigned long address)
> +pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *page = alloc_page(GFP_KERNEL|__GFP_ZERO);
>   	if (!page)
> @@ -135,7 +135,7 @@ pte_alloc_one(struct mm_struct *mm, unsigned long address)
>   }
>   
>   static inline pte_t *
> -pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
> +pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
>   	return pte;
> diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
> index 82e44b1a00ae..af9e13555d95 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
> @@ -82,8 +82,8 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
>   #define pmd_pgtable(pmd) pmd_page(pmd)
>   #endif
>   
> -extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
> -extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
> +extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
> +extern pgtable_t pte_alloc_one(struct mm_struct *mm);
>   
>   static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>   {
> diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> index 391ed2c3b697..8f1d92e99fe5 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> @@ -42,7 +42,7 @@ extern struct kmem_cache *pgtable_cache[];
>   			pgtable_cache[(shift) - 1];	\
>   		})
>   
> -extern pte_t *pte_fragment_alloc(struct mm_struct *, unsigned long, int);
> +extern pte_t *pte_fragment_alloc(struct mm_struct *, int);
>   extern pmd_t *pmd_fragment_alloc(struct mm_struct *, unsigned long);
>   extern void pte_fragment_free(unsigned long *, int);
>   extern void pmd_fragment_free(unsigned long *);
> @@ -192,16 +192,14 @@ static inline pgtable_t pmd_pgtable(pmd_t pmd)
>   	return (pgtable_t)pmd_page_vaddr(pmd);
>   }
>   
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -					  unsigned long address)
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
> -	return (pte_t *)pte_fragment_alloc(mm, address, 1);
> +	return (pte_t *)pte_fragment_alloc(mm, 1);
>   }
>   
> -static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
> -				      unsigned long address)
> +static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
>   {
> -	return (pgtable_t)pte_fragment_alloc(mm, address, 0);
> +	return (pgtable_t)pte_fragment_alloc(mm, 0);
>   }
>   
>   static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
> index 8825953c225b..16623f53f0d4 100644
> --- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
> +++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
> @@ -83,8 +83,8 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
>   #define pmd_pgtable(pmd) pmd_page(pmd)
>   #endif
>   
> -extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
> -extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
> +extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
> +extern pgtable_t pte_alloc_one(struct mm_struct *mm);
>   
>   static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>   {
> diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
> index e2d62d033708..2e7e0230edf4 100644
> --- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
> +++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
> @@ -96,14 +96,12 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
>   }
>   
>   
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -					  unsigned long address)
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
>   }
>   
> -static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
> -				      unsigned long address)
> +static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *page;
>   	pte_t *pte;
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index 01d7c0f7c4f0..cff1d426ca6a 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -379,7 +379,7 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
>   	return (pte_t *)ret;
>   }
>   
> -pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
> +pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel)
>   {
>   	pte_t *pte;
>   
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 120a49bfb9c6..b99a89cdcc5e 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -43,7 +43,7 @@ EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
>   
>   extern char etext[], _stext[], _sinittext[], _einittext[];
>   
> -__ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
> +__ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	pte_t *pte;
>   
> @@ -57,7 +57,7 @@ __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
>   	return pte;
>   }
>   
> -pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
> +pgtable_t pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *ptepage;
>   
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index a79ed5faff3a..94043cf83c90 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -82,15 +82,13 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
>   
>   #endif /* __PAGETABLE_PMD_FOLDED */
>   
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -	unsigned long address)
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	return (pte_t *)__get_free_page(
>   		GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO);
>   }
>   
> -static inline struct page *pte_alloc_one(struct mm_struct *mm,
> -	unsigned long address)
> +static inline struct page *pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *pte;
>   
> diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
> index f0f9bcf94c03..ce2ca8cbd2ec 100644
> --- a/arch/s390/include/asm/pgalloc.h
> +++ b/arch/s390/include/asm/pgalloc.h
> @@ -139,8 +139,8 @@ static inline void pmd_populate(struct mm_struct *mm,
>   /*
>    * page table entry allocation/free routines.
>    */
> -#define pte_alloc_one_kernel(mm, vmaddr) ((pte_t *) page_table_alloc(mm))
> -#define pte_alloc_one(mm, vmaddr) ((pte_t *) page_table_alloc(mm))
> +#define pte_alloc_one_kernel(mm) ((pte_t *)page_table_alloc(mm))
> +#define pte_alloc_one(mm) ((pte_t *)page_table_alloc(mm))
>   
>   #define pte_free_kernel(mm, pte) page_table_free(mm, (unsigned long *) pte)
>   #define pte_free(mm, pte) page_table_free(mm, (unsigned long *) pte)
> diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
> index ed053a359ab7..8ad73cb31121 100644
> --- a/arch/sh/include/asm/pgalloc.h
> +++ b/arch/sh/include/asm/pgalloc.h
> @@ -32,14 +32,12 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
>   /*
>    * Allocate and free page tables.
>    */
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -					  unsigned long address)
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	return quicklist_alloc(QUICK_PT, GFP_KERNEL, NULL);
>   }
>   
> -static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
> -					unsigned long address)
> +static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *page;
>   	void *pg;
> diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
> index 90459481c6c7..282be50a4adf 100644
> --- a/arch/sparc/include/asm/pgalloc_32.h
> +++ b/arch/sparc/include/asm/pgalloc_32.h
> @@ -58,10 +58,9 @@ void pmd_populate(struct mm_struct *mm, pmd_t *pmdp, struct page *ptep);
>   void pmd_set(pmd_t *pmdp, pte_t *ptep);
>   #define pmd_populate_kernel(MM, PMD, PTE) pmd_set(PMD, PTE)
>   
> -pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address);
> +pgtable_t pte_alloc_one(struct mm_struct *mm);
>   
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -					  unsigned long address)
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	return srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
>   }
> diff --git a/arch/sparc/include/asm/pgalloc_64.h b/arch/sparc/include/asm/pgalloc_64.h
> index 874632f34f62..48abccba4991 100644
> --- a/arch/sparc/include/asm/pgalloc_64.h
> +++ b/arch/sparc/include/asm/pgalloc_64.h
> @@ -60,10 +60,8 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
>   	kmem_cache_free(pgtable_cache, pmd);
>   }
>   
> -pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -			    unsigned long address);
> -pgtable_t pte_alloc_one(struct mm_struct *mm,
> -			unsigned long address);
> +pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
> +pgtable_t pte_alloc_one(struct mm_struct *mm);
>   void pte_free_kernel(struct mm_struct *mm, pte_t *pte);
>   void pte_free(struct mm_struct *mm, pgtable_t ptepage);
>   
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index f396048a0d68..6133f21811e9 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2921,8 +2921,7 @@ void __flush_tlb_all(void)
>   			     : : "r" (pstate));
>   }
>   
> -pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -			    unsigned long address)
> +pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	struct page *page = alloc_page(GFP_KERNEL | __GFP_ZERO);
>   	pte_t *pte = NULL;
> @@ -2933,8 +2932,7 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
>   	return pte;
>   }
>   
> -pgtable_t pte_alloc_one(struct mm_struct *mm,
> -			unsigned long address)
> +pgtable_t pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *page = alloc_page(GFP_KERNEL | __GFP_ZERO);
>   	if (!page)
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index be9cb0065179..ce67a96e70c3 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -364,12 +364,12 @@ pgd_t *get_pgd_fast(void)
>    * Alignments up to the page size are the same for physical and virtual
>    * addresses of the nocache area.
>    */
> -pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
> +pgtable_t pte_alloc_one(struct mm_struct *mm)
>   {
>   	unsigned long pte;
>   	struct page *page;
>   
> -	if ((pte = (unsigned long)pte_alloc_one_kernel(mm, address)) == 0)
> +	if ((pte = (unsigned long)pte_alloc_one_kernel(mm)) == 0)
>   		return NULL;
>   	page = pfn_to_page(__nocache_pa(pte) >> PAGE_SHIFT);
>   	if (!pgtable_page_ctor(page)) {
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index 3c0e470ea646..1f277191fbf3 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -197,7 +197,7 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>   	free_page((unsigned long) pgd);
>   }
>   
> -pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
> +pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	pte_t *pte;
>   
> @@ -205,7 +205,7 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
>   	return pte;
>   }
>   
> -pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
> +pgtable_t pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *pte;
>   
> diff --git a/arch/unicore32/include/asm/pgalloc.h b/arch/unicore32/include/asm/pgalloc.h
> index f0fdb268f8f2..7cceabecf4e3 100644
> --- a/arch/unicore32/include/asm/pgalloc.h
> +++ b/arch/unicore32/include/asm/pgalloc.h
> @@ -34,7 +34,7 @@ extern void free_pgd_slow(struct mm_struct *mm, pgd_t *pgd);
>    * Allocate one PTE table.
>    */
>   static inline pte_t *
> -pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
> +pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	pte_t *pte;
>   
> @@ -46,7 +46,7 @@ pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
>   }
>   
>   static inline pgtable_t
> -pte_alloc_one(struct mm_struct *mm, unsigned long addr)
> +pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *pte;
>   
> diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
> index fbd578daa66e..5068e85165b2 100644
> --- a/arch/x86/include/asm/pgalloc.h
> +++ b/arch/x86/include/asm/pgalloc.h
> @@ -47,8 +47,8 @@ extern gfp_t __userpte_alloc_gfp;
>   extern pgd_t *pgd_alloc(struct mm_struct *);
>   extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
>   
> -extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
> -extern pgtable_t pte_alloc_one(struct mm_struct *, unsigned long);
> +extern pte_t *pte_alloc_one_kernel(struct mm_struct *);
> +extern pgtable_t pte_alloc_one(struct mm_struct *);
>   
>   /* Should really implement gc for free page table pages. This could be
>      done with a reference count in struct page. */
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 089e78c4effd..a2eff247377b 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -23,12 +23,12 @@ EXPORT_SYMBOL(physical_mask);
>   
>   gfp_t __userpte_alloc_gfp = PGALLOC_GFP | PGALLOC_USER_GFP;
>   
> -pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
> +pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	return (pte_t *)__get_free_page(PGALLOC_GFP & ~__GFP_ACCOUNT);
>   }
>   
> -pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
> +pgtable_t pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *pte;
>   
> diff --git a/arch/xtensa/include/asm/pgalloc.h b/arch/xtensa/include/asm/pgalloc.h
> index 1065bc8bcae5..b3b388ff2f01 100644
> --- a/arch/xtensa/include/asm/pgalloc.h
> +++ b/arch/xtensa/include/asm/pgalloc.h
> @@ -38,8 +38,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>   	free_page((unsigned long)pgd);
>   }
>   
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -					 unsigned long address)
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
>   	pte_t *ptep;
>   	int i;
> @@ -52,13 +51,12 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
>   	return ptep;
>   }
>   
> -static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
> -					unsigned long addr)
> +static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
>   {
>   	pte_t *pte;
>   	struct page *page;
>   
> -	pte = pte_alloc_one_kernel(mm, addr);
> +	pte = pte_alloc_one_kernel(mm);
>   	if (!pte)
>   		return NULL;
>   	page = virt_to_page(pte);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0416a7204be3..89c2b1739a69 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1789,8 +1789,8 @@ static inline void mm_inc_nr_ptes(struct mm_struct *mm) {}
>   static inline void mm_dec_nr_ptes(struct mm_struct *mm) {}
>   #endif
>   
> -int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address);
> -int __pte_alloc_kernel(pmd_t *pmd, unsigned long address);
> +int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
> +int __pte_alloc_kernel(pmd_t *pmd);
>   
>   /*
>    * The following ifdef needed to get the 4level-fixup.h header to work.
> @@ -1928,18 +1928,17 @@ static inline void pgtable_page_dtor(struct page *page)
>   	pte_unmap(pte);					\
>   } while (0)
>   
> -#define pte_alloc(mm, pmd, address)			\
> -	(unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd, address))
> +#define pte_alloc(mm, pmd) (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd))
>   
>   #define pte_alloc_map(mm, pmd, address)			\
> -	(pte_alloc(mm, pmd, address) ? NULL : pte_offset_map(pmd, address))
> +	(pte_alloc(mm, pmd) ? NULL : pte_offset_map(pmd, address))
>   
>   #define pte_alloc_map_lock(mm, pmd, address, ptlp)	\
> -	(pte_alloc(mm, pmd, address) ?			\
> +	(pte_alloc(mm, pmd) ?			\
>   		 NULL : pte_offset_map_lock(mm, pmd, address, ptlp))
>   
>   #define pte_alloc_kernel(pmd, address)			\
> -	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd, address))? \
> +	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd))? \
>   		NULL: pte_offset_kernel(pmd, address))
>   
>   #if USE_SPLIT_PMD_PTLOCKS
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 00704060b7f7..fd7e8714e5a1 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -558,7 +558,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>   		return VM_FAULT_FALLBACK;
>   	}
>   
> -	pgtable = pte_alloc_one(vma->vm_mm, haddr);
> +	pgtable = pte_alloc_one(vma->vm_mm);
>   	if (unlikely(!pgtable)) {
>   		ret = VM_FAULT_OOM;
>   		goto release;
> @@ -683,7 +683,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>   		struct page *zero_page;
>   		bool set;
>   		vm_fault_t ret;
> -		pgtable = pte_alloc_one(vma->vm_mm, haddr);
> +		pgtable = pte_alloc_one(vma->vm_mm);
>   		if (unlikely(!pgtable))
>   			return VM_FAULT_OOM;
>   		zero_page = mm_get_huge_zero_page(vma->vm_mm);
> @@ -772,7 +772,7 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>   		return VM_FAULT_SIGBUS;
>   
>   	if (arch_needs_pgtable_deposit()) {
> -		pgtable = pte_alloc_one(vma->vm_mm, addr);
> +		pgtable = pte_alloc_one(vma->vm_mm);
>   		if (!pgtable)
>   			return VM_FAULT_OOM;
>   	}
> @@ -910,7 +910,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>   	if (!vma_is_anonymous(vma))
>   		return 0;
>   
> -	pgtable = pte_alloc_one(dst_mm, addr);
> +	pgtable = pte_alloc_one(dst_mm);
>   	if (unlikely(!pgtable))
>   		goto out;
>   
> diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
> index 7a2a2f13f86f..272849cd2007 100644
> --- a/mm/kasan/kasan_init.c
> +++ b/mm/kasan/kasan_init.c
> @@ -121,7 +121,7 @@ static int __ref zero_pmd_populate(pud_t *pud, unsigned long addr,
>   			pte_t *p;
>   
>   			if (slab_is_available())
> -				p = pte_alloc_one_kernel(&init_mm, addr);
> +				p = pte_alloc_one_kernel(&init_mm);
>   			else
>   				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
>   			if (!p)
> diff --git a/mm/memory.c b/mm/memory.c
> index c467102a5cbc..3afdcf38993d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -647,10 +647,10 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   	}
>   }
>   
> -int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
> +int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
>   {
>   	spinlock_t *ptl;
> -	pgtable_t new = pte_alloc_one(mm, address);
> +	pgtable_t new = pte_alloc_one(mm);
>   	if (!new)
>   		return -ENOMEM;
>   
> @@ -681,9 +681,9 @@ int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
>   	return 0;
>   }
>   
> -int __pte_alloc_kernel(pmd_t *pmd, unsigned long address)
> +int __pte_alloc_kernel(pmd_t *pmd)
>   {
> -	pte_t *new = pte_alloc_one_kernel(&init_mm, address);
> +	pte_t *new = pte_alloc_one_kernel(&init_mm);
>   	if (!new)
>   		return -ENOMEM;
>   
> @@ -3139,7 +3139,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>   	 *
>   	 * Here we only have down_read(mmap_sem).
>   	 */
> -	if (pte_alloc(vma->vm_mm, vmf->pmd, vmf->address))
> +	if (pte_alloc(vma->vm_mm, vmf->pmd))
>   		return VM_FAULT_OOM;
>   
>   	/* See the comment in pte_alloc_one_map() */
> @@ -3286,7 +3286,7 @@ static vm_fault_t pte_alloc_one_map(struct vm_fault *vmf)
>   		pmd_populate(vma->vm_mm, vmf->pmd, vmf->prealloc_pte);
>   		spin_unlock(vmf->ptl);
>   		vmf->prealloc_pte = NULL;
> -	} else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd, vmf->address))) {
> +	} else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd))) {
>   		return VM_FAULT_OOM;
>   	}
>   map_pte:
> @@ -3365,7 +3365,7 @@ static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>   	 * related to pte entry. Use the preallocated table for that.
>   	 */
>   	if (arch_needs_pgtable_deposit() && !vmf->prealloc_pte) {
> -		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm, vmf->address);
> +		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
>   		if (!vmf->prealloc_pte)
>   			return VM_FAULT_OOM;
>   		smp_wmb(); /* See comment in __pte_alloc() */
> @@ -3603,8 +3603,7 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
>   			start_pgoff + nr_pages - 1);
>   
>   	if (pmd_none(*vmf->pmd)) {
> -		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm,
> -						  vmf->address);
> +		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm);
>   		if (!vmf->prealloc_pte)
>   			goto out;
>   		smp_wmb(); /* See comment in __pte_alloc() */
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 84381b55b2bd..3080b0626026 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2605,7 +2605,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
>   	 *
>   	 * Here we only have down_read(mmap_sem).
>   	 */
> -	if (pte_alloc(mm, pmdp, addr))
> +	if (pte_alloc(mm, pmdp))
>   		goto abort;
>   
>   	/* See the comment in pte_alloc_one_map() */
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 5c2e18505f75..9e68a02a52b1 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -240,7 +240,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>   			if (pmd_trans_unstable(old_pmd))
>   				continue;
>   		}
> -		if (pte_alloc(new_vma->vm_mm, new_pmd, new_addr))
> +		if (pte_alloc(new_vma->vm_mm, new_pmd))
>   			break;
>   		next = (new_addr + PMD_SIZE) & PMD_MASK;
>   		if (extent > next - new_addr)
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 5029f241908f..f05c8bc38ca5 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -513,7 +513,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>   			break;
>   		}
>   		if (unlikely(pmd_none(dst_pmdval)) &&
> -		    unlikely(__pte_alloc(dst_mm, dst_pmd, dst_addr))) {
> +		    unlikely(__pte_alloc(dst_mm, dst_pmd))) {
>   			err = -ENOMEM;
>   			break;
>   		}
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index ed162a6c57c5..3f8180414301 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -628,7 +628,7 @@ static int create_hyp_pmd_mappings(pud_t *pud, unsigned long start,
>   		BUG_ON(pmd_sect(*pmd));
>   
>   		if (pmd_none(*pmd)) {
> -			pte = pte_alloc_one_kernel(NULL, addr);
> +			pte = pte_alloc_one_kernel(NULL);
>   			if (!pte) {
>   				kvm_err("Cannot allocate Hyp pte\n");
>   				return -ENOMEM;
