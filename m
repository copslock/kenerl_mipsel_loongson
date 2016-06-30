Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2016 11:25:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2225 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992648AbcF3JZmE8600 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2016 11:25:42 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 0CD83721CBB35;
        Thu, 30 Jun 2016 10:25:33 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3]) by
 hhmail02.hh.imgtec.org ([fe80::5400:d33e:81a4:f775%25]) with mapi id
 14.03.0294.000; Thu, 30 Jun 2016 10:25:35 +0100
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Paul Burton <Paul.Burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Faraz Shahbazker <Faraz.Shahbazker@imgtec.com>,
        Maciej Rozycki <Maciej.Rozycki@imgtec.com>
Subject: RE: [RFC PATCH v3 2/2] MIPS: non-exec stack & heap when non-exec
 PT_GNU_STACK is present
Thread-Topic: [RFC PATCH v3 2/2] MIPS: non-exec stack & heap when non-exec
 PT_GNU_STACK is present
Thread-Index: AQHR0hQTTmJmtt1Vk0q5X1N8w1HBqqABvOyw
Date:   Thu, 30 Jun 2016 09:25:34 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B023537E465A74@HHMAIL01.hh.imgtec.org>
References: <20160629143830.526-1-paul.burton@imgtec.com>
 <20160629143830.526-3-paul.burton@imgtec.com>
In-Reply-To: <20160629143830.526-3-paul.burton@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.159.176]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

Paul Burton <Paul.Burton@imgtec.com> writes:
> The stack and heap have both been executable by default on MIPS until
> now. This patch changes the default to be non-executable, but only for
> ELF binaries with a non-executable PT_GNU_STACK header present. This
> does apply to both the heap & the stack, despite the name PT_GNU_STACK,
> and this matches the behaviour of other architectures like ARM & x86.
> 
> Current MIPS toolchains do not produce the PT_GNU_STACK header, which
> means that we can rely upon this patch not changing the behaviour of
> existing binaries. The new default will only take effect for newly
> compiled binaries once toolchains are updated to support PT_GNU_STACK,
> and since those binaries are newly compiled they can be compiled
> expecting the change in default behaviour. Again this matches the way in
> which the ARM & x86 architectures handled their implementations of
> non-executable memory.

There will be some extra work on top of this to inform user-mode that
no-exec-stack support is actually safe. I'm a bit fuzzy on the exact
details though as I have not been directly involved for a while.

https://www.sourceware.org/ml/libc-alpha/2016-01/msg00719.html

Adding Faraz who worked on the user-mode side and Maciej who has been
reviewing.

Thanks,
Matthew

> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> 
> ---
> 
> Changes in v3:
> - Rebase atop v4.7-rc5.
> 
> Changes in v2: None
> 
>  arch/mips/include/asm/elf.h  |  5 +++++
>  arch/mips/include/asm/page.h |  6 ++++--
>  arch/mips/kernel/elf.c       | 19 +++++++++++++++++++
>  3 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
> index f5f4571..914981d 100644
> --- a/arch/mips/include/asm/elf.h
> +++ b/arch/mips/include/asm/elf.h
> @@ -498,4 +498,9 @@ extern int arch_check_elf(void *ehdr, bool has_interpreter, void
> *interp_ehdr,
>  extern void mips_set_personality_nan(struct arch_elf_state *state);
>  extern void mips_set_personality_fp(struct arch_elf_state *state);
> 
> +#define elf_read_implies_exec(ex, stk) mips_elf_read_implies_exec(&(ex), stk)
> +struct elf32_hdr;
> +extern int mips_elf_read_implies_exec(const struct elf32_hdr *elf_ex,
> +				      int exstack);
> +
>  #endif /* _ASM_ELF_H */
> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> index 21ed715..74cb004 100644
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -229,8 +229,10 @@ extern int __virt_addr_valid(const volatile void *kaddr);
>  #define virt_addr_valid(kaddr)						\
>  	__virt_addr_valid((const volatile void *) (kaddr))
> 
> -#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
> -				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
> +#define VM_DATA_DEFAULT_FLAGS \
> +	(VM_READ | VM_WRITE | \
> +	 ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0) | \
> +	 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
> 
>  #define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
>  #define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET)
> diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
> index 891f5ee..9aa55b8 100644
> --- a/arch/mips/kernel/elf.c
> +++ b/arch/mips/kernel/elf.c
> @@ -8,9 +8,12 @@
>   * option) any later version.
>   */
> 
> +#include <linux/binfmts.h>
>  #include <linux/elf.h>
> +#include <linux/export.h>
>  #include <linux/sched.h>
> 
> +#include <asm/cpu-features.h>
>  #include <asm/cpu-info.h>
> 
>  /* Whether to accept legacy-NaN and 2008-NaN user binaries.  */
> @@ -326,3 +329,19 @@ void mips_set_personality_nan(struct arch_elf_state *state)
>  		BUG();
>  	}
>  }
> +
> +int mips_elf_read_implies_exec(const struct elf32_hdr *elf_ex, int exstack)
> +{
> +	if (exstack != EXSTACK_DISABLE_X) {
> +		/* The binary doesn't request a non-executable stack */
> +		return 1;
> +	}
> +
> +	if (!cpu_has_rixi) {
> +		/* The CPU doesn't support non-executable memory */
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mips_elf_read_implies_exec);
> --
> 2.9.0
