Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6TK5KRw027415
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 29 Jul 2002 13:05:20 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6TK5K2b027414
	for linux-mips-outgoing; Mon, 29 Jul 2002 13:05:20 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6TK51Rw027373
	for <linux-mips@oss.sgi.com>; Mon, 29 Jul 2002 13:05:01 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6TK5VXb014202;
	Mon, 29 Jul 2002 13:05:31 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id NAA07086;
	Mon, 29 Jul 2002 13:05:31 -0700 (PDT)
Received: from mips.com ([172.18.27.100])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6TK5Ub09889;
	Mon, 29 Jul 2002 22:05:31 +0200 (MEST)
Message-ID: <3D45A13E.79C882B5@mips.com>
Date: Mon, 29 Jul 2002 22:10:38 +0200
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] MIPS64 R4k TLB refill CP0 hazards
References: <Pine.GSO.3.96.1020729163359.22288I-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:

> Hello,
>
>  The except_vec1_r4k() function in arch/mips64/mm/tlbex-r4k.S is quite new
> and seems specifically written to handle the EntryLo vs "tlbwr" R4k CP0
> hazard by adding an extra "nop" before the "tlbwr" beyond what
> except_vec1_r10k() puts.  Unfortunately, it does not work on my R4400SC
> anyway.  OTOH, the 32-bit MIPS version does, so I tried bits from that for
> MIPS64 and now the function works.
>
>  Here is the resulting patch.  Since barring the hazard fragment the
> functions are identical, I removed the redundant part and made
> except_vec1_r4k() make use of the LOAD_PTE2 and PTE_RELOAD macros.
>
>  OK to apply?

I'm the one who added the except_vec1_r4k function, it works fine on my 5Kc, 20Kc and RM5261.
I can't tell if your patch works for me, before trying it on one of the above CPUs, will do that tomorrow.


>
>   Maciej
>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
>
> patch-mips-2.4.19-rc1-20020726-mips64-tlbex-r4k-1
> diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/arch/mips64/mm/tlbex-r4k.S linux-mips-2.4.19-rc1-20020726/arch/mips64/mm/tlbex-r4k.S
> --- linux-mips-2.4.19-rc1-20020726.macro/arch/mips64/mm/tlbex-r4k.S     2002-07-25 02:57:02.000000000 +0000
> +++ linux-mips-2.4.19-rc1-20020726/arch/mips64/mm/tlbex-r4k.S   2002-07-28 22:27:08.000000000 +0000
> @@ -5,6 +5,7 @@
>   *
>   * Copyright (C) 2000 Silicon Graphics, Inc.
>   * Written by Ulf Carlsson (ulfc@engr.sgi.com)
> + * Copyright (C) 2002  Maciej W. Rozycki
>   */
>  #include <linux/config.h>
>  #include <linux/init.h>
> @@ -23,7 +24,7 @@
>          * that caused the fault in in PTR.
>          */
>
> -       .macro  LOAD_PTE2, ptr, tmp
> +       .macro  LOAD_PTE2, ptr, tmp, kaddr
>  #ifdef CONFIG_SMP
>         dmfc0   \ptr, CP0_CONTEXT
>         dmfc0   \tmp, CP0_BADVADDR
> @@ -32,8 +33,8 @@
>         dmfc0   \tmp, CP0_BADVADDR
>         dla     \ptr, pgd_current
>  #endif
> -       bltz    \tmp, kaddr
> -       ld      \ptr, (\ptr)
> +       bltz    \tmp, \kaddr
> +        ld     \ptr, (\ptr)
>         dsrl    \tmp, (PGDIR_SHIFT-3)           # get pgd offset in bytes
>         andi    \tmp, ((PTRS_PER_PGD - 1)<<3)
>         daddu   \ptr, \tmp                      # add in pgd offset
> @@ -75,34 +76,16 @@ FEXPORT(except_vec0)
>         .align  5
>  LEAF(except_vec1_r4k)
>         .set    noat
> -       dla     k1, pgd_current
> -       dmfc0   k0, CP0_BADVADDR
> -       ld      k1, (k1)
> -       bltz    k0, vmaddr
> -        dsrl   k0, (PGDIR_SHIFT-3)             # get pgd offset in bytes
> -       andi    k0, ((PTRS_PER_PGD - 1)<<3)
> -       daddu   k1, k0                          # add in pgd offset
> -       dmfc0   k0, CP0_BADVADDR
> -       ld      k1, (k1)                        # get pmd pointer
> -       dsrl    k0, (PMD_SHIFT-3)               # get pmd offset in bytes
> -       andi    k0, ((PTRS_PER_PMD - 1)<<3)
> -       daddu   k1, k0                          # add in pmd offset
> -       dmfc0   k0, CP0_XCONTEXT
> -       andi    k0, 0xff0                       # get pte offset
> -       ld      k1, (k1)                        # get pte pointer
> -       daddu   k1, k0
> -       ld      k0, 0(k1)                       # get even pte
> -       ld      k1, 8(k1)                       # get odd pte
> -       dsrl    k0, 6                           # convert to entrylo0
> -       dmtc0   k0, CP0_ENTRYLO0                # load it
> -       dsrl    k1, 6                           # convert to entrylo1
> -       dmtc0   k1, CP0_ENTRYLO1                # load it
> -       nop                                     # Need 2 cycles between mtc0
> -       nop                                     #  and tlbwr (CP0 hazard).
> +       LOAD_PTE2 k1 k0 9f
> +       ld      k0, 0(k1)                       # get even pte
> +       ld      k1, 8(k1)                       # get odd pte
> +       PTE_RELOAD k0 k1
> +       b       1f
>         tlbwr
> +1:
>         nop
>         eret
> -vmaddr:
> +9:
>         dla     k0, handle_vmalloc_address
>         jr      k0
>          nop
> @@ -116,14 +99,14 @@ END(except_vec1_r4k)
>         .align  5
>  LEAF(except_vec1_r10k)
>         .set    noat
> -       LOAD_PTE2 k1 k0
> +       LOAD_PTE2 k1 k0 9f
>         ld      k0, 0(k1)                       # get even pte
>         ld      k1, 8(k1)                       # get odd pte
>         PTE_RELOAD k0 k1
>         nop
>         tlbwr
>         eret
> -kaddr:
> +9:
>         dla     k0, handle_vmalloc_address      # MAPPED kernel needs this
>         jr      k0
>          nop
