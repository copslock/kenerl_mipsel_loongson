Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2018 13:12:37 +0100 (CET)
Received: from mail-ua0-x241.google.com ([IPv6:2607:f8b0:400c:c08::241]:45891
        "EHLO mail-ua0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994835AbeBAMM3fs99N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Feb 2018 13:12:29 +0100
Received: by mail-ua0-x241.google.com with SMTP id z3so11659456uae.12;
        Thu, 01 Feb 2018 04:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=V/YDM04PeU6d602HblIMEuVGXexjPs6mJ6u0zgFF4tc=;
        b=cJktxwRtKVoLEWk4AvNM8pQC4cPoBhYE9/E0B2Lvs81uXyjErqhc2BkDjMVWGp6mz8
         0VVg5Kd3urSWu7st1KWu9qsNzHhtTuo6jKtjh1HdE2mu7cYwbTIV7+ZxxYXl3cJ23Uml
         qw91AXdH7qaatb+791+vy7grtPTYC9r0X4MaN/hYS2OPaYFhOyCs/HDNXplbU40p5qUU
         r3+oVN0BEMhQNjw7TbFkz+mzX4WBTDsSG4qZJylHUbcW5Rd70q+mZ2QVJOKvFD98sJik
         O/nZGJWv1SBfxI/v7JTsGJg/BP16qeroEjmvRLBZs3oD+icHrb0oSm5EfjIRm3JHNnxq
         wVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=V/YDM04PeU6d602HblIMEuVGXexjPs6mJ6u0zgFF4tc=;
        b=Od+SJT9E3EvIRtYBd/UzgQqfANbaFMHI68evIemq+1jbmfXWJuKSmD79hITcqTVu1s
         cO8PP6SRhrWFonk9KevIKJhgQ/LR2J2dk9gZatuPMZArZm+/0cZSt20CDKT7M+6j3XAV
         ZK07wtjzxukg0tKhdLjqXoI7GU9t9tV+7IpEg0lmZpftCDQJ7KcHAQMPwC6ZcZFRCnKg
         wUzBObUDoxblaetncxCKHQg3M7IeB4FAN4Cb72nrP87k3qAI+/vkFnlAjuH8xcYNEtwZ
         3Q+gCirVTwbflcVhalRpxEYsDvpmDGwVedfB/Em0tk8haTPZ3DRw6D5gBfhG1PbXg/DI
         c+Xg==
X-Gm-Message-State: AKwxyte+xySiRzRakIv7MABSjJhdYZQe5sBuSl8mKPNrEKHd19IqZ+9F
        CWfIrWyvfk/QdL+/U7aWYbAIJUqWCAU/cPTsVL4=
X-Google-Smtp-Source: AH8x226GTqy7lO7QzmlOI27tJLbMQfK71IS87Q1Pj42ZpvT3sKASx53RVregi8cwrerjeFvhynG0m/CAr2n4tBaTJ5o=
X-Received: by 10.176.94.78 with SMTP id a14mr28159870uah.17.1517487143084;
 Thu, 01 Feb 2018 04:12:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.78.22 with HTTP; Thu, 1 Feb 2018 04:12:02 -0800 (PST)
In-Reply-To: <20180201113721.24776-1-marcin.nowakowski@mips.com>
References: <20180201113721.24776-1-marcin.nowakowski@mips.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Thu, 1 Feb 2018 13:12:02 +0100
X-Google-Sender-Auth: WoMJmxS0p5ylF8lVSsXbLCkQavY
Message-ID: <CA+7wUswiOdqunZfnL-6YFJ6gPfj7bXAdHYbetbW_PdQaN28GzQ@mail.gmail.com>
Subject: Re: [PATCH v3] MIPS: fix incorrect mem=X@Y handling
To:     Marcin Nowakowski <marcin.nowakowski@mips.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "# v4 . 11" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

On Thu, Feb 1, 2018 at 12:37 PM, Marcin Nowakowski
<marcin.nowakowski@mips.com> wrote:
> Commit 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing") added a
> fix to ensure that the memory range between PHYS_OFFSET and low memory
> address specified by mem= cmdline argument is not later processed by
> free_all_bootmem.  This change was incorrect for systems where the
> commandline specifies more than 1 mem argument, as it will cause all
> memory between PHYS_OFFSET and each of the memory offsets to be marked
> as reserved, which results in parts of the RAM marked as reserved
> (Creator CI20's u-boot has a default commandline argument 'mem=256M@0x0
> mem=768M@0x30000000').
>
> Change the behaviour to ensure that only the range between PHYS_OFFSET
> and the lowest start address of the memories is marked as protected.
>
> This change also ensures that the range is marked protected even if it's
> only defined through the devicetree and not only via commandline
> arguments.
>
> Reported-by: Mathieu Malaterre <mathieu.malaterre@gmail.com>
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@mips.com>
> Fixes: 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing")
> Cc: <stable@vger.kernel.org> # v4.11+
> ---
> v3: Update stable version, code cleanup as suggested by James Hogan
> v2: Use updated email adress, add tag for stable.
> ---
>  arch/mips/kernel/setup.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 702c678de116..e4a1581ce822 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -375,6 +375,7 @@ static void __init bootmem_init(void)
>         unsigned long reserved_end;
>         unsigned long mapstart = ~0UL;
>         unsigned long bootmap_size;
> +       phys_addr_t ramstart = (phys_addr_t)ULLONG_MAX;
>         bool bootmap_valid = false;
>         int i;
>
> @@ -395,7 +396,8 @@ static void __init bootmem_init(void)
>         max_low_pfn = 0;
>
>         /*
> -        * Find the highest page frame number we have available.
> +        * Find the highest page frame number we have available
> +        * and the lowest used RAM address
>          */
>         for (i = 0; i < boot_mem_map.nr_map; i++) {
>                 unsigned long start, end;
> @@ -407,6 +409,8 @@ static void __init bootmem_init(void)
>                 end = PFN_DOWN(boot_mem_map.map[i].addr
>                                 + boot_mem_map.map[i].size);
>
> +               ramstart = min(ramstart, boot_mem_map.map[i].addr);
> +
>  #ifndef CONFIG_HIGHMEM
>                 /*
>                  * Skip highmem here so we get an accurate max_low_pfn if low
> @@ -436,6 +440,13 @@ static void __init bootmem_init(void)
>                 mapstart = max(reserved_end, start);
>         }
>
> +       /*
> +        * Reserve any memory between the start of RAM and PHYS_OFFSET
> +        */
> +       if (ramstart > PHYS_OFFSET)
> +               add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
> +                                 BOOT_MEM_RESERVED);
> +
>         if (min_low_pfn >= max_low_pfn)
>                 panic("Incorrect memory mapping !!!");
>         if (min_low_pfn > ARCH_PFN_OFFSET) {
> @@ -664,9 +675,6 @@ static int __init early_parse_mem(char *p)
>
>         add_memory_region(start, size, BOOT_MEM_RAM);
>
> -       if (start && start > PHYS_OFFSET)
> -               add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
> -                               BOOT_MEM_RESERVED);
>         return 0;
>  }
>  early_param("mem", early_parse_mem);
> --
> 2.14.1
>

Looks good to me:

$ cat /proc/cpuinfo
system type : JZ4780
machine : Creator CI20
processor : 0
cpu model : Ingenic JZRISC V4.15  FPU V0.0
BogoMIPS : 956.00
wait instruction : yes
microsecond timers : no
tlb_entries : 32
extra interrupt vector : yes
hardware watchpoint : yes, count: 1, address/irw mask: [0x0fff]
isa : mips1 mips2 mips32r1 mips32r2
ASEs implemented :
shadow register sets : 1
kscratch registers : 0
package : 0
core : 0
VCED exceptions : not available
VCEI exceptions : not available
$ uname -a
Linux ci20 4.15.0+ #323 PREEMPT Thu Feb 1 13:08:11 CET 2018 mips GNU/Linux

Tested-by: Mathieu Malaterre <malat@debian.org>

Thanks
