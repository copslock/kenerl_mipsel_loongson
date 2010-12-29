Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Dec 2010 06:28:50 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:56433 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490981Ab0L2F2q convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Dec 2010 06:28:46 +0100
Received: by wyf22 with SMTP id 22so9809517wyf.36
        for <multiple recipients>; Tue, 28 Dec 2010 21:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PGNY0Y289HxZ2O9xxaRPHu3BFiBrreDqsTVNJM1t7Xo=;
        b=g6Sns4nUx6hCc76deqndh4EIhLkY7kKjVWbzhDTfZhc3DrzabcjN1zEVdhr+rqfNVb
         keInzuP6dS07RrgGHIDRQjo+Rr6oVl+kkT2gEp6ytfMXQOZ3pf45sKpOqJ0ZRFXTbrDU
         MokX84R0BEhthTiFeQ2tP2TYKaGOOANkOYgOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HL5FgMga/f7y6rg3+9G/N3mWXJ4r9T0bODwKNSzIuPbWsl/9yFXSzA6HbSc2He4q0n
         DpTYsEV2sBIctAg8y9Tcm0eFr9AxfXkojEFbul0wle9+wNQh4gESeJSXQ34UhSZLM7VM
         FgKhU5RvexWa8xdwzCH4cD8iBjlMgAEjc0VpA=
MIME-Version: 1.0
Received: by 10.216.46.193 with SMTP id r43mr17774893web.20.1293600519692;
 Tue, 28 Dec 2010 21:28:39 -0800 (PST)
Received: by 10.216.131.88 with HTTP; Tue, 28 Dec 2010 21:28:39 -0800 (PST)
In-Reply-To: <1293571583-14472-1-git-send-email-ddaney@caviumnetworks.com>
References: <1293571583-14472-1-git-send-email-ddaney@caviumnetworks.com>
Date:   Wed, 29 Dec 2010 13:28:39 +0800
Message-ID: <AANLkTikFrth=zJD6EsMy0qD00XO4AvVw3jyM18yTj5Rj@mail.gmail.com>
Subject: Re: [PATCH v4] jump lable: Add MIPS support.
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, David & Steve

Can we use 'jump lable' in Assembly? If it works, I guess this may
also give some help on improving the Ftrace implementation, e.g.
HAVE_FUNCTION_TRACE_MCOUNT_TEST and the other condition checking in
the mcount.S(or the corresponding part of the other ARCH's entry*.S).

For the C implementation,

kernel/trace/ftrace.c:

#ifndef CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST
/*
 * For those archs that do not test ftrace_trace_stop in their
 * mcount call site, we need to do it from C.
 */
static void ftrace_test_stop_func(unsigned long ip, unsigned long parent_ip)
{
        if (function_trace_stop)
                return;

        __ftrace_trace_function(ip, parent_ip);
}
#endif

We may be easy to apply the jump lable above, but some ARCH selects
HAVE_FUNCTION_TRACE_MCOUNT_TEST and uses the assembly implementation,
let's use MIPS an example:

arch/mips/kernel/mcount.S:

#else   /* ! CONFIG_DYNAMIC_FTRACE */

NESTED(_mcount, PT_SIZE, ra)
        lw      t1, function_trace_stop
        bnez    t1, ftrace_stub

When function_trace_stop is false, we can simply convert the above 2
lines to nops ;-)

Can we use 'jump lable' above for the condition check of
function_trace_stop or if there is such macros or functions to do so?

Best Regards,
Wu Zhangjin

On Wed, Dec 29, 2010 at 5:26 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> In order not to be left behind, we add jump label support for MIPS.
>
> Tested on 64-bit big endian (Octeon), and 32-bit little endian
> (malta/qemu).
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Jason Baron <jbaron@redhat.com>
> ---
>
> The only change from v3 is to guard the body of
> arch/mips/kernel/jump_label.c with #ifdef HAVE_JUMP_LABEL.  This
> avoids compiler errors when CONFIG_JUMP_LABEL is selected, but the
> compiler does not support it.
>
>  arch/mips/Kconfig                  |    1 +
>  arch/mips/include/asm/jump_label.h |   48 ++++++++++++++++++++++++++++++++
>  arch/mips/kernel/Makefile          |    2 +
>  arch/mips/kernel/jump_label.c      |   54 ++++++++++++++++++++++++++++++++++++
>  arch/mips/kernel/module.c          |    5 +++
>  5 files changed, 110 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/include/asm/jump_label.h
>  create mode 100644 arch/mips/kernel/jump_label.c
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 913d50d..12d0d0f 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -21,6 +21,7 @@ config MIPS
>        select HAVE_DMA_API_DEBUG
>        select HAVE_GENERIC_HARDIRQS
>        select GENERIC_IRQ_PROBE
> +       select HAVE_ARCH_JUMP_LABEL
>
>  menu "Machine selection"
>
> diff --git a/arch/mips/include/asm/jump_label.h b/arch/mips/include/asm/jump_label.h
> new file mode 100644
> index 0000000..7622ccf
> --- /dev/null
> +++ b/arch/mips/include/asm/jump_label.h
> @@ -0,0 +1,48 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (c) 2010 Cavium Networks, Inc.
> + */
> +#ifndef _ASM_MIPS_JUMP_LABEL_H
> +#define _ASM_MIPS_JUMP_LABEL_H
> +
> +#include <linux/types.h>
> +
> +#ifdef __KERNEL__
> +
> +#define JUMP_LABEL_NOP_SIZE 4
> +
> +#ifdef CONFIG_64BIT
> +#define WORD_INSN ".dword"
> +#else
> +#define WORD_INSN ".word"
> +#endif
> +
> +#define JUMP_LABEL(key, label)                                         \
> +       do {                                                            \
> +               asm goto("1:\tnop\n\t"                                  \
> +                       "nop\n\t"                                       \
> +                       ".pushsection __jump_table,  \"a\"\n\t"         \
> +                       WORD_INSN " 1b, %l[" #label "], %0\n\t"         \
> +                       ".popsection\n\t"                               \
> +                       : :  "i" (key) :  : label);                     \
> +       } while (0)
> +
> +
> +#endif /* __KERNEL__ */
> +
> +#ifdef CONFIG_64BIT
> +typedef u64 jump_label_t;
> +#else
> +typedef u32 jump_label_t;
> +#endif
> +
> +struct jump_entry {
> +       jump_label_t code;
> +       jump_label_t target;
> +       jump_label_t key;
> +};
> +
> +#endif /* _ASM_MIPS_JUMP_LABEL_H */
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index 3977397..cedee2b 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -107,4 +107,6 @@ obj-$(CONFIG_MIPS_CPUFREQ)  += cpufreq/
>
>  obj-$(CONFIG_HW_PERF_EVENTS)   += perf_event.o
>
> +obj-$(CONFIG_JUMP_LABEL)       += jump_label.o
> +
>  CPPFLAGS_vmlinux.lds           := $(KBUILD_CFLAGS)
> diff --git a/arch/mips/kernel/jump_label.c b/arch/mips/kernel/jump_label.c
> new file mode 100644
> index 0000000..6001610
> --- /dev/null
> +++ b/arch/mips/kernel/jump_label.c
> @@ -0,0 +1,54 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (c) 2010 Cavium Networks, Inc.
> + */
> +
> +#include <linux/jump_label.h>
> +#include <linux/kernel.h>
> +#include <linux/memory.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +#include <linux/cpu.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/inst.h>
> +
> +#ifdef HAVE_JUMP_LABEL
> +
> +#define J_RANGE_MASK ((1ul << 28) - 1)
> +
> +void arch_jump_label_transform(struct jump_entry *e,
> +                              enum jump_label_type type)
> +{
> +       union mips_instruction insn;
> +       union mips_instruction *insn_p =
> +               (union mips_instruction *)(unsigned long)e->code;
> +
> +       /* Jump only works within a 256MB aligned region. */
> +       BUG_ON((e->target & ~J_RANGE_MASK) != (e->code & ~J_RANGE_MASK));
> +
> +       /* Target must have 4 byte alignment. */
> +       BUG_ON((e->target & 3) != 0);
> +
> +       if (type == JUMP_LABEL_ENABLE) {
> +               insn.j_format.opcode = j_op;
> +               insn.j_format.target = (e->target & J_RANGE_MASK) >> 2;
> +       } else {
> +               insn.word = 0; /* nop */
> +       }
> +
> +       get_online_cpus();
> +       mutex_lock(&text_mutex);
> +       *insn_p = insn;
> +
> +       flush_icache_range((unsigned long)insn_p,
> +                          (unsigned long)insn_p + sizeof(*insn_p));
> +
> +       mutex_unlock(&text_mutex);
> +       put_online_cpus();
> +}
> +
> +#endif /* HAVE_JUMP_LABEL */
> diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
> index 6f51dda..bb9cde4 100644
> --- a/arch/mips/kernel/module.c
> +++ b/arch/mips/kernel/module.c
> @@ -30,6 +30,8 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/spinlock.h>
> +#include <linux/jump_label.h>
> +
>  #include <asm/pgtable.h>       /* MODULE_START */
>
>  struct mips_hi16 {
> @@ -390,6 +392,9 @@ int module_finalize(const Elf_Ehdr *hdr,
>        const Elf_Shdr *s;
>        char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
>
> +       /* Make jump label nops. */
> +       jump_label_apply_nops(me);
> +
>        INIT_LIST_HEAD(&me->arch.dbe_list);
>        for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
>                if (strcmp("__dbe_table", secstrings + s->sh_name) != 0)
> --
> 1.7.2.3
>
>
>
