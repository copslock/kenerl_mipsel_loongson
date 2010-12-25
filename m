Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Dec 2010 21:43:41 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:41484 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491147Ab0LYUnh convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 25 Dec 2010 21:43:37 +0100
Received: by wyf22 with SMTP id 22so7635010wyf.36
        for <multiple recipients>; Sat, 25 Dec 2010 12:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+8COppeov40B/4FWeTj4xY1jmEXWgjSOEn9NFUd815Y=;
        b=K1mDukkWCY7MBl9fQozbRyl7FGYk0Z+t6wxIVJZLOjbQxYq8wUJFtEvYY5fLysMPyZ
         sLldKm0j9FOhBWQxV0WsTGWoKQoCaOO7bR3exj6ekOWFx1/GEcc1o3+pZNE+hZKVW/Oi
         j2julFc7vFrF5MWZeXw5V6Rzj9EfGtFdqn77o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=et2WFLZYzuIiHFD8RUh62JCqOwZuZKCG7C8Z/74hOejo7+CJlSv26pOegSwo6gnlGm
         CwC3LTg963f7UHcN2XQX1YthglnRo0S9Ub8KbCMQ+ps0ME7VxPuf1G/bG+WVcvNFIbmy
         NxZxCu9H9nYYel0ug5QeR8IYiESfksK0q+ofk=
MIME-Version: 1.0
Received: by 10.216.82.9 with SMTP id n9mr11798261wee.35.1293309812241; Sat,
 25 Dec 2010 12:43:32 -0800 (PST)
Received: by 10.216.131.88 with HTTP; Sat, 25 Dec 2010 12:43:32 -0800 (PST)
In-Reply-To: <8c3fb090a937ba193dcdf83196a0ada38025b20d.1293309744.git.wuzhangjin@gmail.com>
References: <8c3fb090a937ba193dcdf83196a0ada38025b20d.1293309744.git.wuzhangjin@gmail.com>
Date:   Sun, 26 Dec 2010 04:43:32 +0800
Message-ID: <AANLkTin01=_JfW75B2Q3dHL2qcfCqXyt9yrY2nGo1BeC@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Use current_cpu_type() instead of c->cputype
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This should be applied after "MIPS: Add current_cpu_prid() to optimize
the code generation".

On Sun, Dec 26, 2010 at 4:42 AM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> If current_cpu_type() is pre-defined in cpu-feature-overrides.h, This
> may save about 10k for the compressed kernel image(vmlinuz).
>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/bcm63xx/cpu.c                            |    3 +--
>  .../asm/mach-loongson/cpu-feature-overrides.h      |    3 +++
>  arch/mips/kernel/cpu-probe.c                       |    8 ++------
>  arch/mips/kernel/spram.c                           |    2 +-
>  arch/mips/kernel/traps.c                           |    2 +-
>  arch/mips/mm/c-octeon.c                            |    2 +-
>  arch/mips/mm/c-r4k.c                               |   10 +++++-----
>  arch/mips/mm/sc-mips.c                             |    2 +-
>  arch/mips/mm/tlbex.c                               |    2 +-
>  9 files changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
> index 7bd5176..760831f 100644
> --- a/arch/mips/bcm63xx/cpu.c
> +++ b/arch/mips/bcm63xx/cpu.c
> @@ -291,13 +291,12 @@ static unsigned int detect_memory_size(void)
>  void __init bcm63xx_cpu_init(void)
>  {
>        unsigned int tmp, expected_cpu_id;
> -       struct cpuinfo_mips *c = &current_cpu_data;
>        unsigned int cpu = smp_processor_id();
>
>        /* soc registers location depends on cpu type */
>        expected_cpu_id = 0;
>
> -       switch (c->cputype) {
> +       switch (current_cpu_type()) {
>        case CPU_BMIPS3300:
>                if (cpu_prid_imp() == PRID_IMP_BMIPS3300_ALT) {
>                        expected_cpu_id = BCM6348_CPU_ID;
> diff --git a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
> index a941bcc..17c9867 100644
> --- a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
> +++ b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
> @@ -17,6 +17,9 @@
>  #define __ASM_MACH_LOONGSON_CPU_FEATURE_OVERRIDES_H
>
>  #ifdef CONFIG_CPU_LOONGSON2
> +
> +#define current_cpu_type()     CPU_LOONGSON2
> +
>  #define cpu_prid_loongson2() \
>        cpu_prid_encode(PRID_COMP_LEGACY, PRID_IMP_LOONGSON2, 0)
>
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 34cb533..cb14f1e 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -153,14 +153,12 @@ __setup("nodsp", dsp_disable);
>
>  void __init check_wait(void)
>  {
> -       struct cpuinfo_mips *c = &current_cpu_data;
> -
>        if (nowait) {
>                printk("Wait instruction disabled.\n");
>                return;
>        }
>
> -       switch (c->cputype) {
> +       switch (current_cpu_type()) {
>        case CPU_R3081:
>        case CPU_R3081E:
>                cpu_wait = r3081_wait;
> @@ -247,9 +245,7 @@ void __init check_wait(void)
>
>  static inline void check_errata(void)
>  {
> -       struct cpuinfo_mips *c = &current_cpu_data;
> -
> -       switch (c->cputype) {
> +       switch (current_cpu_type()) {
>        case CPU_34K:
>                /*
>                 * Erratum "RPS May Cause Incorrect Instruction Execution"
> diff --git a/arch/mips/kernel/spram.c b/arch/mips/kernel/spram.c
> index 1821d12..76649b5 100644
> --- a/arch/mips/kernel/spram.c
> +++ b/arch/mips/kernel/spram.c
> @@ -202,7 +202,7 @@ void __cpuinit spram_config(void)
>        struct cpuinfo_mips *c = &current_cpu_data;
>        unsigned int config0;
>
> -       switch (c->cputype) {
> +       switch (current_cpu_type()) {
>        case CPU_24K:
>        case CPU_34K:
>        case CPU_74K:
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 38a7ccd..a03fae2 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -617,7 +617,7 @@ static int simulate_rdhwr(struct pt_regs *regs, unsigned int opcode)
>                        regs->regs[rt] = read_c0_count();
>                        return 0;
>                case 3:         /* Count register resolution */
> -                       switch (current_cpu_data.cputype) {
> +                       switch (current_cpu_type()) {
>                        case CPU_20KC:
>                        case CPU_25KF:
>                                regs->regs[rt] = 1;
> diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
> index 16c4d25..8182758 100644
> --- a/arch/mips/mm/c-octeon.c
> +++ b/arch/mips/mm/c-octeon.c
> @@ -182,7 +182,7 @@ static void __cpuinit probe_octeon(void)
>        struct cpuinfo_mips *c = &current_cpu_data;
>
>        config1 = read_c0_config1();
> -       switch (c->cputype) {
> +       switch (current_cpu_type()) {
>        case CPU_CAVIUM_OCTEON:
>        case CPU_CAVIUM_OCTEON_PLUS:
>                c->icache.linesz = 2 << ((config1 >> 19) & 7);
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 4407dd0..a7a6545 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -758,7 +758,7 @@ static void __cpuinit probe_pcache(void)
>        unsigned long config1;
>        unsigned int lsize;
>
> -       switch (c->cputype) {
> +       switch (current_cpu_type()) {
>        case CPU_R4600:                 /* QED style two way caches? */
>        case CPU_R4700:
>        case CPU_R5000:
> @@ -998,7 +998,7 @@ static void __cpuinit probe_pcache(void)
>         * normally they'd suffer from aliases but magic in the hardware deals
>         * with that for us so we don't need to take care ourselves.
>         */
> -       switch (c->cputype) {
> +       switch (current_cpu_type()) {
>        case CPU_20KC:
>        case CPU_25KF:
>        case CPU_SB1:
> @@ -1026,7 +1026,7 @@ static void __cpuinit probe_pcache(void)
>                        c->dcache.flags |= MIPS_CACHE_ALIASES;
>        }
>
> -       switch (c->cputype) {
> +       switch (current_cpu_type()) {
>        case CPU_20KC:
>                /*
>                 * Some older 20Kc chips doesn't have the 'VI' bit in
> @@ -1157,7 +1157,7 @@ static void __cpuinit setup_scache(void)
>         * processors don't have a S-cache that would be relevant to the
>         * Linux memory management.
>         */
> -       switch (c->cputype) {
> +       switch (current_cpu_type()) {
>        case CPU_R4000SC:
>        case CPU_R4000MC:
>        case CPU_R4400SC:
> @@ -1352,7 +1352,7 @@ void __cpuinit r4k_cache_init(void)
>        extern char __weak except_vec2_sb1;
>        struct cpuinfo_mips *c = &current_cpu_data;
>
> -       switch (c->cputype) {
> +       switch (current_cpu_type()) {
>        case CPU_SB1:
>        case CPU_SB1A:
>                set_uncached_handler(0x100, &except_vec2_sb1, 0x80);
> diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
> index 9cca8de..0e633db 100644
> --- a/arch/mips/mm/sc-mips.c
> +++ b/arch/mips/mm/sc-mips.c
> @@ -72,7 +72,7 @@ static inline int mips_sc_is_activated(struct cpuinfo_mips *c)
>        unsigned int tmp;
>
>        /* Check the bypass bit (L2B) */
> -       switch (c->cputype) {
> +       switch (current_cpu_type()) {
>        case CPU_34K:
>        case CPU_74K:
>        case CPU_1004K:
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index af08461..c9a9b6b 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -415,7 +415,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
>
>        default:
>                panic("No TLB refill handler yet (CPU type: %d)",
> -                     current_cpu_data.cputype);
> +                     current_cpu_type());
>                break;
>        }
>  }
> --
> 1.7.1
>
>
