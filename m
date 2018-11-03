Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Nov 2018 10:26:04 +0100 (CET)
Received: from ivanoab6.miniserver.com ([5.153.251.140]:52876 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990395AbeKCJY5IHotV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Nov 2018 10:24:57 +0100
Received: from [192.168.17.6] (helo=smaug.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1gIsA2-0004dx-Ls; Sat, 03 Nov 2018 09:24:06 +0000
Received: from wyvern.kot-begemot.co.uk ([192.168.3.72])
        by smaug.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1gIsA2-00028s-8O; Sat, 03 Nov 2018 09:24:06 +0000
Subject: Re: [PATCH -next 0/3] Add support for fast mremap
To:     Richard Weinberger <richard@nod.at>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Joel Fernandes <joelaf@google.com>, akpm@linux-foundation.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, dancol@google.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        elfring@users.sourceforge.net, Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>,
        hughd@google.com, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        kasan-dev@googlegroups.com, kirill@shutemov.name,
        kvmarm@lists.cs.columbia.edu, Ley Foon Tan <lftan@altera.com>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vge, r.kernel.org@lithops.sigma-star.at,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, lokeshgidra@google.com,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, minchan@kernel.org,
        nios2-dev@lists.rocketboards.org, pantin@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        Rich Felker <dalias@libc.org>, Sam Creasey <sammy@sammy.net>,
        sparclinux@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20181103040041.7085-1-joelaf@google.com>
 <6886607.O3ZT5bM3Cy@blindfold>
From:   Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <e1d039a5-9c83-b9b9-98b5-d39bc48f04e0@kot-begemot.co.uk>
Date:   Sat, 3 Nov 2018 09:24:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6886607.O3ZT5bM3Cy@blindfold>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Clacks-Overhead: GNU Terry Pratchett
Return-Path: <anton.ivanov@kot-begemot.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67061
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

On 03/11/2018 09:15, Richard Weinberger wrote:
> Joel,
>
> Am Samstag, 3. November 2018, 05:00:38 CET schrieb Joel Fernandes:
>> Hi,
>> Here is the latest "fast mremap" series. This just a repost with Kirill's
>> Acked-bys added. I would like this to be considered for linux -next.  I also
>> dropped the CONFIG enablement patch for arm64 since I am yet to test it with
>> the new TLB flushing code that is in very recent kernel releases. (None of my
>> arm64 devices run mainline right now.) so I will post the arm64 enablement once
>> I get to that. The performance numbers in the series are for x86.
>>
>> List of patches in series:
>>
>> (1) mm: select HAVE_MOVE_PMD in x86 for faster mremap
>>
>> (2) mm: speed up mremap by 20x on large regions (v4)
>> v1->v2: Added support for per-arch enablement (Kirill Shutemov)
>> v2->v3: Updated commit message to state the optimization may also
>> 	run for non-thp type of systems (Daniel Col).
>> v3->v4: Remove useless pmd_lock check (Kirill Shutemov)
>> 	Rebased ontop of Linus's master, updated perf results based
>>          on x86 testing. Added Kirill's Acks.
>>
>> (3) mm: treewide: remove unused address argument from pte_alloc functions (v2)
>> v1->v2: fix arch/um/ prototype which was missed in v1 (Anton Ivanov)
>>          update changelog with manual fixups for m68k and microblaze.
>>
>> not included - (4) mm: select HAVE_MOVE_PMD in arm64 for faster mremap
>>      This patch is dropped since last posting pending further performance
>>      testing on arm64 with new TLB gather updates. See notes in patch
>>      titled "mm: speed up mremap by 500x on large regions" for more
>>      details.
>>
> This breaks UML build:
>    CC      mm/mremap.o
> mm/mremap.c: In function ‘move_normal_pmd’:
> mm/mremap.c:229:2: error: implicit declaration of function ‘set_pmd_at’; did you mean ‘set_pte_at’? [-Werror=implicit-function-declaration]
>    set_pmd_at(mm, new_addr, new_pmd, pmd);
>    ^~~~~~~~~~
>    set_pte_at
>    CC      crypto/rng.o
>    CC      fs/direct-io.o
> cc1: some warnings being treated as errors
>
> To test yourself, just run on a x86 box:
> $ make defconfig ARCH=um
> $ make linux ARCH=um
>
> Thanks,
> //richard
>
>
>

UM somehow managed to miss one of the 3-level functions, I sent a patch 
at some point to add to the mmremap series, but it looks like it did not 
get included in the final version.

You need these two incremental on top of Joel's patch. Richard - feel 
free to relocate the actual implementation of the set_pgd_at elsewhere - 
I put it at the end of tlb.c

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 7485398d0737..1692da55e63a 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -359,4 +359,7 @@ do {                                                \
         __flush_tlb_one((vaddr));               \
  } while (0)

+extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+               pmd_t *pmdp, pmd_t pmd);
+
  #endif
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 763d35bdda01..d17b74184ba0 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -647,3 +647,9 @@ void force_flush_all(void)
                 vma = vma->vm_next;
         }
  }
+void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+               pmd_t *pmdp, pmd_t pmd)
+{
+       *pmdp = pmd;
+}
+
