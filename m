Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2016 18:21:53 +0200 (CEST)
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36814 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027713AbcD1QVuWocg6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Apr 2016 18:21:50 +0200
Received: by mail-yw0-f170.google.com with SMTP id o66so127587883ywc.3
        for <linux-mips@linux-mips.org>; Thu, 28 Apr 2016 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lyfgsq5qTuKwyMLBzvuknQqzhjSVNqUBbwb0lZ1TInE=;
        b=ONOHHp36ynYGV8qjSy3S9684oElNLqg7F2E+4iAkaEj3g8PTEHbLM3sGFg3og5Ia5f
         UkuIKKDVfAvgXZcu/nSkXEolZH5YtXlhx+WBJEgW4CUtIed7ej4LbnR6H8QrWPGxdQaB
         OhRrBI6g9Hazb+lOURWqfYmHQivjRPDKxnWNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lyfgsq5qTuKwyMLBzvuknQqzhjSVNqUBbwb0lZ1TInE=;
        b=jD+TRJNnVo0kgYaZVEbYacZn6XMQMds0ECHrptjFIrMtJXLfcbBfSRXQYGcnkHNH7I
         G1hc2O2DOJ6hr2yYKx+ycO2+KAf3hhzdmqg67zwlstBpW8FRoIAW8xN2LDacUimwqecG
         QpuQoFSIz9gXrZ8DZI7ZX9A3VKTrrvZnR2wmf26F37TI+yFDytTuuz7p+h8mLgxbFZwt
         Vk5Ay9EEg+bqi5wytvExTcsFnhOADT3SscCFuD+zO0cywOLxW3JRjJONWdDQkbCdCEWG
         95gpI7/vLZ2H/4fd4Sh6a/M0G9HpveBlSxePny8z21vz79b+QpUWFGBbHDOadqyVbH1x
         z7LA==
X-Gm-Message-State: AOPr4FU8raaNWeGA8tzZ6zhJVz3ZYxQob2a2boOLPQRlD0mcTDX7+7EeDIiE+lN6Voa0mfF+o+2s6Fmf/BQEc7oK
X-Received: by 10.129.155.198 with SMTP id s189mr9780166ywg.31.1461860504353;
 Thu, 28 Apr 2016 09:21:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.229.1 with HTTP; Thu, 28 Apr 2016 09:21:05 -0700 (PDT)
In-Reply-To: <1461859576-7036-1-git-send-email-james.hogan@imgtec.com>
References: <1461859576-7036-1-git-send-email-james.hogan@imgtec.com>
From:   Jayachandran C <jchandra@broadcom.com>
Date:   Thu, 28 Apr 2016 21:51:05 +0530
Message-ID: <CAKc_7PW4Tv3tmjVqLD5fq3tZyYnBSkJp-f3U+rLtmw6kXRUy4A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: netlogic: Fix CP0_EBASE redefinition warnings
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jayachandran.c@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

On Thu, Apr 28, 2016 at 9:36 PM, James Hogan <james.hogan@imgtec.com> wrote:
> A couple of netlogic assembly files define CP0_EBASE to $15, the same as
> CP0_PRID in mipsregs.h, and use it for accessing both CP0_PRId and
> CP0_EBase registers. However commit 609cf6f2291a ("MIPS: CPS: Early
> debug using an ns16550-compatible UART") added a different definition of
> CP0_EBASE to mipsregs.h, which included a register select of 1. This
> causes harmless build warnings like the following:
>
>   arch/mips/netlogic/common/reset.S:53:0: warning: "CP0_EBASE" redefined
>   #define CP0_EBASE $15
>   ^
>   In file included from arch/mips/netlogic/common/reset.S:41:0:
>   ./arch/mips/include/asm/mipsregs.h:63:0: note: this is the location of the previous definition
>   #define CP0_EBASE $15, 1
>   ^
>
> Update the code to use the definitions from mipsregs.h for accessing
> both registers.
>
> Fixes: 609cf6f2291a ("MIPS: CPS: Early debug using an ns16550-compatible UART")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Jayachandran C <jchandra@broadcom.com>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/netlogic/common/reset.S   | 11 +++++------
>  arch/mips/netlogic/common/smpboot.S |  4 +---
>  2 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/arch/mips/netlogic/common/reset.S b/arch/mips/netlogic/common/reset.S
> index edbab9b8691f..c474981a6c0d 100644
> --- a/arch/mips/netlogic/common/reset.S
> +++ b/arch/mips/netlogic/common/reset.S
> @@ -50,7 +50,6 @@
>  #include <asm/netlogic/xlp-hal/sys.h>
>  #include <asm/netlogic/xlp-hal/cpucontrol.h>
>
> -#define CP0_EBASE      $15
>  #define SYS_CPU_COHERENT_BASE  CKSEG1ADDR(XLP_DEFAULT_IO_BASE) + \
>                         XLP_IO_SYS_OFFSET(0) + XLP_IO_PCI_HDRSZ + \
>                         SYS_CPU_NONCOHERENT_MODE * 4
> @@ -92,7 +91,7 @@
>   * registers. On XLPII CPUs, usual cache instructions work.
>   */
>  .macro xlp_flush_l1_dcache
> -       mfc0    t0, CP0_EBASE, 0
> +       mfc0    t0, CP0_PRID
>         andi    t0, t0, PRID_IMP_MASK
>         slt     t1, t0, 0x1200
>         beqz    t1, 15f
> @@ -171,7 +170,7 @@ FEXPORT(nlm_reset_entry)
>         nop
>
>  1:     /* Entry point on core wakeup */
> -       mfc0    t0, CP0_EBASE, 0        /* processor ID */
> +       mfc0    t0, CP0_PRID            /* processor ID */
>         andi    t0, PRID_IMP_MASK
>         li      t1, 0x1500              /* XLP 9xx */
>         beq     t0, t1, 2f              /* does not need to set coherent */
> @@ -182,8 +181,8 @@ FEXPORT(nlm_reset_entry)
>         nop
>
>         /* set bit in SYS coherent register for the core */
> -       mfc0    t0, CP0_EBASE, 1
> -       mfc0    t1, CP0_EBASE, 1
> +       mfc0    t0, CP0_EBASE
> +       mfc0    t1, CP0_EBASE
>         srl     t1, 5
>         andi    t1, 0x3                 /* t1 <- node */
>         li      t2, 0x40000
> @@ -232,7 +231,7 @@ EXPORT(nlm_boot_siblings)
>
>          * NOTE: All GPR contents are lost after the mtcr above!
>          */
> -       mfc0    v0, CP0_EBASE, 1
> +       mfc0    v0, CP0_EBASE
>         andi    v0, 0x3ff               /* v0 <- node/core */
>
>         /*
> diff --git a/arch/mips/netlogic/common/smpboot.S b/arch/mips/netlogic/common/smpboot.S
> index 805355b0bd05..f0cc4c9de2bb 100644
> --- a/arch/mips/netlogic/common/smpboot.S
> +++ b/arch/mips/netlogic/common/smpboot.S
> @@ -48,8 +48,6 @@
>  #include <asm/netlogic/xlp-hal/sys.h>
>  #include <asm/netlogic/xlp-hal/cpucontrol.h>
>
> -#define CP0_EBASE      $15
> -
>         .set    noreorder
>         .set    noat
>         .set    arch=xlr                /* for mfcr/mtcr, XLR is sufficient */
> @@ -86,7 +84,7 @@ NESTED(nlm_boot_secondary_cpus, 16, sp)
>         PTR_L   gp, 0(t1)
>
>         /* a0 has the processor id */
> -       mfc0    a0, CP0_EBASE, 1
> +       mfc0    a0, CP0_EBASE
>         andi    a0, 0x3ff               /* a0 <- node/core */
>         PTR_LA  t0, nlm_early_init_secondary
>         jalr    t0

Thanks for fixing this up.

Acked-by: Jayachandran C <jchandra@broadcom.com>

JC.
