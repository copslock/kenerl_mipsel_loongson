Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Feb 2005 20:15:15 +0000 (GMT)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:55988 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225251AbVBTUOz>;
	Sun, 20 Feb 2005 20:14:55 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j1KKEsGE026892
	for <linux-mips@linux-mips.org>; Sun, 20 Feb 2005 15:14:54 -0500
Received: from firetop.home (vpn50-19.rdu.redhat.com [172.16.50.19])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j1KKElK14094
	for <linux-mips@linux-mips.org>; Sun, 20 Feb 2005 15:14:48 -0500
Received: from rsandifo by firetop.home with local (Exim 4.34)
	id 1D2x4r-0000oL-SM
	for linux-mips@linux-mips.org; Sun, 20 Feb 2005 21:00:46 +0000
To:	linux-mips@linux-mips.org
Subject: [PATCH] SMP/TLB problems with 64-bit kernels
From:	Richard Sandiford <rsandifo@redhat.com>
Date:	Sun, 20 Feb 2005 19:49:13 +0000
Message-ID: <87r7jbdnba.fsf@firetop.home>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

A 64-bit SB1 SMP kernel built from current 2.6 CVS sources will
hang when trying to run init.  This is probably the same as the
bug reported here:

  http://www.linux-mips.org/archives/linux-mips/2005-01/msg00086.html

The patch below fixes things for me.  There were three separate problems:

  - The CONFIG_BUILD_ELF64 version of get_saved_sp miscalculated
    kernel_sp: it failed to shift the address left 16 bits after
    adding in %hi(kernel_sp).

  - build_get_pmde64 says:

        /*
         * 64 bit SMP has the lower part of &pgd_current[smp_processor_id()]
         * stored in CONTEXT.
         */
        if (in_compat_space_p(pgdc)) {
                i_dmfc0(p, ptr, C0_CONTEXT);
                i_dsra(p, ptr, ptr, 23);
                i_ld(p, ptr, 0, ptr);
        } else {
#ifdef CONFIG_BUILD_ELF64
                ...
#else
                ...
#endif
        }

    but for CONFIG_BUILD_ELF64, the context register contains
    smp_processor_id(), not &pgd_current[smp_processor_id()].
    The patch rearranges the code as follows:

#ifdef CONFIG_BUILD_ELF64
        ...
#else
        /*
         * 64 bit SMP has the lower part of &pgd_current[smp_processor_id()]
         * stored in CONTEXT.
         */
        if (in_compat_space_p(pgdc)) {
                i_dmfc0(p, ptr, C0_CONTEXT);
                i_dsra(p, ptr, ptr, 23);
                i_ld(p, ptr, 0, ptr);
        } else {
                ...
        }
#endif

  - The final "..." above is:

                i_dmfc0(p, ptr, C0_CONTEXT);
                i_lui(p, tmp, rel_highest(pgdc));
                i_dsll(p, ptr, ptr, 9);
                i_daddiu(p, tmp, tmp, rel_higher(pgdc));
    --->        i_dsrl32(p, ptr, ptr, 0);
    --->        i_and(p, ptr, ptr, tmp);
                i_dmfc0(p, tmp, C0_BADVADDR);
                i_ld(p, ptr, 0, ptr);

    There are three problems here:

      * the high 32 bits of the address (tmp) aren't shifted left
        32 places.

      * If you calculate foo as:

            (%highest(foo) << 48) + (%higher(foo) << 32) + x

        then "x" is a signed number, so the shift should be dsra32,
        not dsrl32.  This is the only use of dsrl32 in the file,
        and nothing uses dsra32 at the moment, so the patch replaces
        the dsrl32 definitions with dsra32 definitions.

      * The "and" should be a "daddu".

    (I'm not sure how this case triggers.  Won't pgd_current always
    be in the compat region if !CONFIG_BUILD_ELF64?)

Also, whenever the CONFIG_BUILD_ELF64 code reads smp_processor_id() from
the context register, it uses the result to index arrays of 8-byte values.
We can avoid a shift in both the TLB code and in get_saved_sp if we store
smp_processor_id() * 8 in the context register (i.e. if TLBMISS_HANDLER_SETUP
shifts the value left by 26 rather than 23).

I've tested the patch with both CONFIG_BUILD_ELF64 and !CONFIG_BUILD_ELF64,
and in both cases it fixes the hang and seems to give a stable kernel.
I also tried a !CONFIG_BUILD_ELF64 with the in_compat_space_p() check
above disabled, forcing the longer version to be used.  Please apply if OK.

Richard


Index: arch/mips/mm/tlbex.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/tlbex.c,v
retrieving revision 1.16
diff -u -p -F^\([(a-zA-Z0-9_]\|#define\) -r1.16 tlbex.c
--- arch/mips/mm/tlbex.c	12 Jan 2005 16:38:50 -0000	1.16
+++ arch/mips/mm/tlbex.c	20 Feb 2005 18:58:35 -0000
@@ -91,7 +91,7 @@ enum opcode {
 	insn_addu, insn_addiu, insn_and, insn_andi, insn_beq,
 	insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
 	insn_bne, insn_daddu, insn_daddiu, insn_dmfc0, insn_dmtc0,
-	insn_dsll, insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32,
+	insn_dsll, insn_dsll32, insn_dsra, insn_dsrl, insn_dsra32,
 	insn_dsubu, insn_eret, insn_j, insn_jal, insn_jr, insn_ld,
 	insn_ll, insn_lld, insn_lui, insn_lw, insn_mfc0, insn_mtc0,
 	insn_ori, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
@@ -134,7 +134,7 @@ static __initdata struct insn insn_table
 	{ insn_dsll32, M(spec_op,0,0,0,0,dsll32_op), RT | RD | RE },
 	{ insn_dsra, M(spec_op,0,0,0,0,dsra_op), RT | RD | RE },
 	{ insn_dsrl, M(spec_op,0,0,0,0,dsrl_op), RT | RD | RE },
-	{ insn_dsrl32, M(spec_op,0,0,0,0,dsrl32_op), RT | RD | RE },
+	{ insn_dsra32, M(spec_op,0,0,0,0,dsra32_op), RT | RD | RE },
 	{ insn_dsubu, M(spec_op,0,0,0,0,dsubu_op), RS | RT | RD },
 	{ insn_eret, M(cop0_op,cop_op,0,0,0,eret_op), 0 },
 	{ insn_j, M(j_op,0,0,0,0,0), JIMM },
@@ -366,7 +366,7 @@ I_u2u1u3(_dsll);
 I_u2u1u3(_dsll32);
 I_u2u1u3(_dsra);
 I_u2u1u3(_dsrl);
-I_u2u1u3(_dsrl32);
+I_u2u1u3(_dsra32);
 I_u3u1u2(_dsubu);
 I_0(_eret);
 I_u1(_j);
@@ -942,6 +942,14 @@ build_get_pmde64(u32 **p, struct label *
 	/* No i_nop needed here, since the next insn doesn't touch TMP. */
 
 #ifdef CONFIG_SMP
+#ifdef CONFIG_BUILD_ELF64
+	i_dmfc0(p, ptr, C0_CONTEXT);
+	i_dsrl(p, ptr, ptr, 23);
+	i_LA_mostly(p, tmp, pgdc);
+	i_daddu(p, ptr, ptr, tmp);
+	i_dmfc0(p, tmp, C0_BADVADDR);
+	i_ld(p, ptr, rel_lo(pgdc), ptr);
+#else
 	/*
 	 * 64 bit SMP has the lower part of &pgd_current[smp_processor_id()]
 	 * stored in CONTEXT.
@@ -951,25 +959,17 @@ build_get_pmde64(u32 **p, struct label *
 		i_dsra(p, ptr, ptr, 23);
 		i_ld(p, ptr, 0, ptr);
 	} else {
-#ifdef CONFIG_BUILD_ELF64
-		i_dmfc0(p, ptr, C0_CONTEXT);
-		i_dsrl(p, ptr, ptr, 23);
-		i_dsll(p, ptr, ptr, 3);
-		i_LA_mostly(p, tmp, pgdc);
-		i_daddu(p, ptr, ptr, tmp);
-		i_dmfc0(p, tmp, C0_BADVADDR);
-		i_ld(p, ptr, rel_lo(pgdc), ptr);
-#else
 		i_dmfc0(p, ptr, C0_CONTEXT);
 		i_lui(p, tmp, rel_highest(pgdc));
 		i_dsll(p, ptr, ptr, 9);
 		i_daddiu(p, tmp, tmp, rel_higher(pgdc));
-		i_dsrl32(p, ptr, ptr, 0);
-		i_and(p, ptr, ptr, tmp);
+		i_dsra32(p, ptr, ptr, 0);
+		i_dsll32(p, tmp, tmp, 0);
+		i_daddu(p, ptr, ptr, tmp);
 		i_dmfc0(p, tmp, C0_BADVADDR);
 		i_ld(p, ptr, 0, ptr);
-#endif
 	}
+#endif
 #else
 	i_LA_mostly(p, ptr, pgdc);
 	i_ld(p, ptr, rel_lo(pgdc), ptr);
Index: include/asm-mips/mmu_context.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/mmu_context.h,v
retrieving revision 1.48
diff -u -p -F^\([(a-zA-Z0-9_]\|#define\) -r1.48 mmu_context.h
--- include/asm-mips/mmu_context.h	8 Jan 2005 15:03:53 -0000	1.48
+++ include/asm-mips/mmu_context.h	20 Feb 2005 18:59:53 -0000
@@ -40,7 +40,7 @@ #define TLBMISS_HANDLER_SETUP()						\
 #endif
 #if defined(CONFIG_MIPS64) && defined(CONFIG_BUILD_ELF64)
 #define TLBMISS_HANDLER_SETUP()						\
-	write_c0_context((unsigned long) smp_processor_id() << 23);	\
+	write_c0_context((unsigned long) smp_processor_id() << 26);	\
 	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir)
 #endif
 
Index: include/asm-mips/stackframe.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/stackframe.h,v
retrieving revision 1.36
diff -u -p -F^\([(a-zA-Z0-9_]\|#define\) -r1.36 stackframe.h
--- include/asm-mips/stackframe.h	13 Feb 2005 00:32:43 -0000	1.36
+++ include/asm-mips/stackframe.h	20 Feb 2005 18:59:54 -0000
@@ -76,12 +76,12 @@ #define _ASM_STACKFRAME_H
 #endif
 #if defined(CONFIG_MIPS64) && defined(CONFIG_BUILD_ELF64)
 		MFC0	k1, CP0_CONTEXT
-		dsrl	k1, 23
-		dsll	k1, k1, 3
 		lui	k0, %highest(kernelsp)
 		daddiu	k0, %higher(kernelsp)
 		dsll	k0, k0, 16
 		daddiu	k0, %hi(kernelsp)
+		dsrl	k1, 23
+		dsll	k0, k0, 16
 		daddu	k1, k1, k0
 		LONG_L	k1, %lo(kernelsp)(k1)
 #endif
