Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2008 22:13:48 +0100 (BST)
Received: from ik-out-1112.google.com ([66.249.90.179]:27928 "EHLO
	ik-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20030025AbYFIVNn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jun 2008 22:13:43 +0100
Received: by ik-out-1112.google.com with SMTP id b32so1590615ika.0
        for <linux-mips@linux-mips.org>; Mon, 09 Jun 2008 14:13:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=mGBXkMqeNQ7+20GTfcpxYUaORKq1ZJSI4FhHOH/VbFE=;
        b=kAc/e6URDuhrhp916u5b/O905SuAqHhtVzoRqUY1ZVBuwQsSs3Bt5e2U4EVM0Ppgul
         7VbUqN5A9JvPWgIw69LrFLmylR1ZKBfoJ707Nbh9AYglupRd2wf8evr+tAxxyUEa1Kst
         5h+tzdCkKiMNM0rJfXUu+b94pUqPZMu3JVdqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=Ywr+Qg0v/5STQfHuM4PVXcqI35IhL+TrAmMGjFHx3lypIzL9P7L9zfS+RqYsduQ3cZ
         6/Knb7V2FD4s5ly9xqsX+0N1/M2T5ahY83b6NoORle7PO/7Je51afiiLJ2NoPsXqRav7
         5AkimU6gmjmVbykbKLz3jSZBXkmYdmDjdFFE4=
Received: by 10.210.28.4 with SMTP id b4mr3444889ebb.40.1213046020287;
        Mon, 09 Jun 2008 14:13:40 -0700 (PDT)
Received: from localhost ( [79.75.55.39])
        by mx.google.com with ESMTPS id i6sm16441688gve.4.2008.06.09.14.13.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Jun 2008 14:13:36 -0700 (PDT)
From:	Richard Sandiford <rdsandiford@googlemail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Mail-Followup-To: "Maciej W. Rozycki" <macro@linux-mips.org>,Ralf Baechle <ralf@linux-mips.org>,  gcc-patches@gcc.gnu.org,  linux-mips@linux-mips.org, rdsandiford@googlemail.com
Cc:	Ralf Baechle <ralf@linux-mips.org>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: Changing the treatment of the MIPS HI and LO registers
References: <87tzgj4nh6.fsf@firetop.home>
	<Pine.LNX.4.55.0805272134540.18833@cliff.in.clinika.pl>
	<87abib4d9t.fsf@firetop.home>
	<Pine.LNX.4.55.0805272357020.18833@cliff.in.clinika.pl>
	<87r6bm1ebd.fsf@firetop.home>
	<Pine.LNX.4.55.0805290213140.29522@cliff.in.clinika.pl>
	<878wxtvarg.fsf@firetop.home> <8763stz2p3.fsf@firetop.home>
Date:	Mon, 09 Jun 2008 22:13:28 +0100
In-Reply-To: <8763stz2p3.fsf@firetop.home> (Richard Sandiford's message of
	"Sun\, 01 Jun 2008 14\:48\:08 +0100")
Message-ID: <87zlpuxqfb.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Richard Sandiford <rdsandiford@googlemail.com> writes:
> I'll reinstate the 48 hour warning, mostly as a way of seeing
> whether the thread is still alive.

Here's the final version of the patch.  I fixed the <su>mulsi3_highpart
condition and added a couple of missing attributes.  Applied after retesting.
I also made the following changes to the web page:

Index: htdocs/gcc-4.4/changes.html
===================================================================
RCS file: /cvs/gcc/wwwdocs/htdocs/gcc-4.4/changes.html,v
retrieving revision 1.11
diff -u -p -r1.11 changes.html
--- htdocs/gcc-4.4/changes.html	9 Jun 2008 20:41:49 -0000	1.11
+++ htdocs/gcc-4.4/changes.html	9 Jun 2008 21:10:25 -0000
@@ -28,6 +28,28 @@
     when <code>-Wdeprecated</code> or <code>-pedantic</code> is used.
     This extension has been deprecated for many years, but never
     warned about.</li>
+
+    <li>The MIPS port no longer recognizes the <code>h</code>
+    <code>asm</code> constraint.  It was necessary to remove
+    this constraint in order to avoid generating unpredictable
+    code sequences.
+
+    <p>One of the main uses of the <code>h</code> constraint
+    was to extract the high part of a multiplication on
+    64-bit targets.  For example:</p>
+    <pre>
+    asm ("dmultu\t%1,%2" : "=h" (result) : "r" (x), "r" (y));</pre>
+    <p>You can now achieve the same effect using 128-bit types:</p>
+    <pre>
+    typedef unsigned int uint128_t __attribute__((mode(TI)));
+    result = ((uint128_t) x * y) >> 64;</pre>
+    <p>The second sequence is better in many ways.  For example,
+    if <code>x</code> and <code>y</code> are constants, the
+    compiler can perform the multiplication at compile time.
+    If <code>x</code> and <code>y</code> are not constants,
+    the compiler can schedule the runtime multiplication
+    better than it can schedule an <code>asm</code> statement.</p>
+    </li>
  </ul>
 
 <h2>General Optimizer Improvements</h2>
@@ -75,6 +97,8 @@
   <ul>
     <li>Support for RMI's XLR processor is now available through the
         <code>-march=xlr</code> and <code>-mtune=xlr</code> options.</li>
+    <li>64-bit targets can now perform 128-bit multiplications inline,
+        instead of relying on a <code>libgcc</code> function.</li>
   </ul>
 
 <h2>Documentation improvements</h2>

Please shout if you find anything wrong with either the patch or
the documentation changes.

Richard


gcc/
	* doc/md.texi: Synchronize with later constraints.md change.
	* longlong.h (umul_ppmm): Replace the MIPS asm implementation
	with a C implementation.
	* config/mips/mips.c (mips_legitimize_move): Remove MFHI and
	MFLO handling.
	(mips_subword): Assume TImode for CONST_INTs if TARGET_64BIT.
	(mips_split_doubleword_move): Use special MTHI and MFHI instructions
	when moving to and from MD_REGNUM.
	(mips_output_move): Don't handle moves from GPRs to HI_REGNUM.
	Handle moves from LO_REGNUM to GPRs using MFLO, MACC or DMACC.
	Handle byte and halfword moves.
	(mips_hard_regno_mode_ok_p): Handle MD_REGS and DSP_ACC_REGS
	separately.
	* config/mips/constraints.md (h): Turn into NO_REGS.
	(l, x): Update documentation.
	* config/mips/mips.md (UNSPEC_MFHILO): Delete.
	(UNSPEC_MFHI, UNSPEC_MTHI, UNSPEC_SET_HILO): New.
	(UNSPEC_TLS_LDM, UNSPEC_TLS_GET_TP): Renumber.
	(HILO): New mode iterator.
	(MOVE128): Add TI.
	(any_div): New code iterator.
	(u): Extend code attribute to div and udiv.
	(*add<mode>3_mips16, *movdi_64bit_mips16, *movsi_mips16): Use
	d_operand in the splitters.  Remove redundant CONST_INT checks.
	(mulsi3_mult3, mul<mode>3_internal, mul<mode>3_r4000, *mul_acc_si)
	(*macc, *msac, *msac_using_macc, *macc2, *msac2, *mul_sub_si)
	(*muls): Remove "=h" clobbers.  Adjust peephole2s and define_splits
	accordingly, using normal moves instead of unspecs to move LO into
	a GPR.  Use d_operand and lo_operand instead of *_REG_P checks.
	(<u>mulsidi3): Handle expansion in C code.
	(<u>mulsidi3_32bit_internal): Rename to...
	(<u>mulsidi3_32bit): ...this.
	(<u>mulsidi3_32bit_r4000): Fix insn separator.
	(*<u>mulsidi3_64bit): Rename to...
	(<u>mulsidi3_64bit): ...this.  Combine DImode "=h" and "=l" clobbers
	into a TImode "=x" clobber.  In the split, use an UNSPEC_SET_HILO
	to set LO and HI to the multiplication result.  Use a normal move
	for MFLO and an unspec for MFHI.
	(*<u>mulsidi3_64bit_parts): Replace with...
	(<u>mulsidi3_64bit_hilo): ...this new instruction.
	(<su>mulsi3_highpart): Extend to TARGET_FIX_R4000.
	(<su>mulsi3_highpart_internal): Turn into a define_insn_and_split
	and extend it to TARGET_FIX_R4000.  Store the destination in a GPR
	instead of HI.  Split the instruction into a separate multiplication
	and MFHI if !TARGET_FIX_R4000.
	(<su>muldi3_highpart): Likewise.
	(<su>mulsi3_highpart_mulhi_internal): Remove the first alternative
	and the "=h" clobber.
	(*<su>mulsi3_highpart_neg_mulhi_internal): Likewise.
	(<u>mulditi3): New expander.
	(<u>mulditi3_internal, <u>mulditi3_r4000): New patterns.
	(madsi): Remove "=h" clobber.
	(divmod<mode>4, udivmod<mode>4): Turn into define_insn_and_splits.
	Force the modulus result to be a GPR and split the instruction into
	a division followed by an MFHI after reload.
	(<u>divmod<GPR:mode>4_hilo_<HILO:mode>): New instruction.
	(*lea_high64): Use d_operand in the define_peephole2.  Likewise
	the MIPS16 HIGH define_split.
	(*movdi_32bit, *movdi_gp32_fp64, *movdi_32bit_mips16): Change type
	of acc<->gpr moves to "multi".
	(*movdi_64bit): Replace the single "x" alternative with
	alternatives for moving into and out of "a".
	(*movhi_internal, *movqi_internal): Likewise.  Use mips_output_move.
	(*movsi_internal): Extend the "d<-A" alternative to "d<-a".
	(*movdi_64bit_mips16, *movsi_mips16): Add d<-a alternatives.
	Use d_operand in the splitters.  Remove redundant CONST_INT checks.
	(*movhi_mips16, *movqi_mips16): Likewise.  Use mips_output_move.
	(movti): New expander.
	(*movti, *movti_mips16): New insns.
	(mfhilo_<mode>, *mfhilo_<mode>, *mfhilo_<mode>_macc): Delete.
	(mfhi<GPR:mode>_<HILO:mode>): New pattern.
	(mthi<GPR:mode>_<HILO:mode>): Likewise.
	* config/mips/predicates.md (fpr_operand): Delete.
	(d_operand): New predicate.

gcc/testsuite/
	* gcc.dg/torture/mips-hilo-1.c: Delete.
	* gcc.target/mips/pr35232.c: Likewise.
	* gcc.target/mips/fix-vr4130-1.c: Use modulus to create an mfhi.
	* gcc.target/mips/fix-vr4130-3.c: Likewise.
	* gcc.target/mips/int-moves-1.c: New test.
	* gcc.target/mips/int-moves-2.c: Likewise.
	* gcc.target/mips/fix-r4000-1.c: Likewise.
	* gcc.target/mips/fix-r4000-2.c: Likewise.
	* gcc.target/mips/fix-r4000-3.c: Likewise.
	* gcc.target/mips/fix-r4000-4.c: Likewise.
	* gcc.target/mips/fix-r4000-5.c: Likewise.
	* gcc.target/mips/fix-r4000-6.c: Likewise.
	* gcc.target/mips/fix-r4000-7.c: Likewise.
	* gcc.target/mips/fix-r4000-8.c: Likewise.
	* gcc.target/mips/fix-r4000-9.c: Likewise.
	* gcc.target/mips/fix-r4000-10.c: Likewise.
	* gcc.target/mips/fix-r4000-11.c: Likewise.
	* gcc.target/mips/fix-r4000-12.c: Likewise.
	* gcc.target/mips/timode-1.c: Likewise.
	* gcc.target/mips/timode-2.c: Likewise.

Index: gcc/doc/md.texi
===================================================================
--- gcc/doc/md.texi	2008-06-09 21:42:44.000000000 +0100
+++ gcc/doc/md.texi	2008-06-09 21:45:18.000000000 +0100
@@ -2469,13 +2469,15 @@ generating MIPS16 code.
 A floating-point register (if available).
 
 @item h
-The @code{hi} register.
+Formerly the @code{hi} register.  This constraint is no longer supported.
 
 @item l
-The @code{lo} register.
+The @code{lo} register.  Use this register to store values that are
+no bigger than a word.
 
 @item x
-The @code{hi} and @code{lo} registers.
+The concatenated @code{hi} and @code{lo} registers.  Use this register
+to store doubleword values.
 
 @item c
 A register suitable for use in an indirect jump.  This will always be
Index: gcc/longlong.h
===================================================================
--- gcc/longlong.h	2008-06-09 21:42:44.000000000 +0100
+++ gcc/longlong.h	2008-06-09 21:45:18.000000000 +0100
@@ -623,12 +623,12 @@ #define UDIV_TIME 150
 #endif /* __m88000__ */
 
 #if defined (__mips__) && W_TYPE_SIZE == 32
-#define umul_ppmm(w1, w0, u, v) \
-  __asm__ ("multu %2,%3"						\
-	   : "=l" ((USItype) (w0)),					\
-	     "=h" ((USItype) (w1))					\
-	   : "d" ((USItype) (u)),					\
-	     "d" ((USItype) (v)))
+#define umul_ppmm(w1, w0, u, v)						\
+  do {									\
+    UDItype __x = (UDItype) (USItype) (u) * (USItype) (v);		\
+    (w1) = (USItype) (__x >> 32);					\
+    (w0) = (USItype) (__x);						\
+  } while (0)
 #define UMUL_TIME 10
 #define UDIV_TIME 100
 
Index: gcc/config/mips/mips.c
===================================================================
--- gcc/config/mips/mips.c	2008-06-09 21:42:44.000000000 +0100
+++ gcc/config/mips/mips.c	2008-06-09 21:45:18.000000000 +0100
@@ -2675,23 +2675,6 @@ mips_legitimize_move (enum machine_mode 
       return true;
     }
 
-  /* Check for individual, fully-reloaded mflo and mfhi instructions.  */
-  if (GET_MODE_SIZE (mode) <= UNITS_PER_WORD
-      && REG_P (src) && MD_REG_P (REGNO (src))
-      && REG_P (dest) && GP_REG_P (REGNO (dest)))
-    {
-      int other_regno = REGNO (src) == HI_REGNUM ? LO_REGNUM : HI_REGNUM;
-      if (GET_MODE_SIZE (mode) <= 4)
-	emit_insn (gen_mfhilo_si (gen_lowpart (SImode, dest),
-				  gen_lowpart (SImode, src),
-				  gen_rtx_REG (SImode, other_regno)));
-      else
-	emit_insn (gen_mfhilo_di (gen_lowpart (DImode, dest),
-				  gen_lowpart (DImode, src),
-				  gen_rtx_REG (DImode, other_regno)));
-      return true;
-    }
-
   /* We need to deal with constants that would be legitimate
      immediate_operands but aren't legitimate move_operands.  */
   if (CONSTANT_P (src) && !move_operand (src, mode))
@@ -3488,7 +3471,7 @@ mips_subword (rtx op, bool high_p)
 
   mode = GET_MODE (op);
   if (mode == VOIDmode)
-    mode = DImode;
+    mode = TARGET_64BIT ? TImode : DImode;
 
   if (TARGET_BIG_ENDIAN ? !high_p : high_p)
     byte = UNITS_PER_WORD;
@@ -3539,6 +3522,8 @@ mips_split_64bit_move_p (rtx dest, rtx s
 void
 mips_split_doubleword_move (rtx dest, rtx src)
 {
+  rtx low_dest;
+
   if (FP_REG_RTX_P (dest) || FP_REG_RTX_P (src))
     {
       if (!TARGET_64BIT && GET_MODE (dest) == DImode)
@@ -3552,12 +3537,27 @@ mips_split_doubleword_move (rtx dest, rt
       else
 	gcc_unreachable ();
     }
+  else if (REG_P (dest) && REGNO (dest) == MD_REG_FIRST)
+    {
+      low_dest = mips_subword (dest, false);
+      mips_emit_move (low_dest, mips_subword (src, false));
+      if (TARGET_64BIT)
+	emit_insn (gen_mthidi_ti (dest, mips_subword (src, true), low_dest));
+      else
+	emit_insn (gen_mthisi_di (dest, mips_subword (src, true), low_dest));
+    }
+  else if (REG_P (src) && REGNO (src) == MD_REG_FIRST)
+    {
+      mips_emit_move (mips_subword (dest, false), mips_subword (src, false));
+      if (TARGET_64BIT)
+	emit_insn (gen_mfhidi_ti (mips_subword (dest, true), src));
+      else
+	emit_insn (gen_mfhisi_di (mips_subword (dest, true), src));
+    }
   else
     {
       /* The operation can be split into two normal moves.  Decide in
 	 which order to do them.  */
-      rtx low_dest;
-
       low_dest = mips_subword (dest, false);
       if (REG_P (low_dest)
 	  && reg_overlap_mentioned_p (low_dest, src))
@@ -3600,8 +3600,9 @@ mips_output_move (rtx dest, rtx src)
 	  if (GP_REG_P (REGNO (dest)))
 	    return "move\t%0,%z1";
 
-	  if (MD_REG_P (REGNO (dest)))
-	    return "mt%0\t%z1";
+	  /* Moves to HI are handled by special .md insns.  */
+	  if (REGNO (dest) == LO_REGNUM)
+	    return "mtlo\t%z1";
 
 	  if (DSP_ACC_REG_P (REGNO (dest)))
 	    {
@@ -3624,14 +3625,29 @@ mips_output_move (rtx dest, rtx src)
 	    }
 	}
       if (dest_code == MEM)
-	return dbl_p ? "sd\t%z1,%0" : "sw\t%z1,%0";
+	switch (GET_MODE_SIZE (mode))
+	  {
+	  case 1: return "sb\t%z1,%0";
+	  case 2: return "sh\t%z1,%0";
+	  case 4: return "sw\t%z1,%0";
+	  case 8: return "sd\t%z1,%0";
+	  }
     }
   if (dest_code == REG && GP_REG_P (REGNO (dest)))
     {
       if (src_code == REG)
 	{
-	  /* Handled by separate patterns.  */
-	  gcc_assert (!MD_REG_P (REGNO (src)));
+	  /* Moves from HI are handled by special .md insns.  */
+	  if (REGNO (src) == LO_REGNUM)
+	    {
+	      /* When generating VR4120 or VR4130 code, we use MACC and
+		 DMACC instead of MFLO.  This avoids both the normal
+		 MIPS III HI/LO hazards and the errata related to
+		 -mfix-vr4130.  */
+	      if (ISA_HAS_MACCHI)
+		return dbl_p ? "dmacc\t%0,%.,%." : "macc\t%0,%.,%.";
+	      return "mflo\t%0";
+	    }
 
 	  if (DSP_ACC_REG_P (REGNO (src)))
 	    {
@@ -3658,7 +3674,13 @@ mips_output_move (rtx dest, rtx src)
 	}
 
       if (src_code == MEM)
-	return dbl_p ? "ld\t%0,%1" : "lw\t%0,%1";
+	switch (GET_MODE_SIZE (mode))
+	  {
+	  case 1: return "lbu\t%0,%1";
+	  case 2: return "lhu\t%0,%1";
+	  case 4: return "lw\t%0,%1";
+	  case 8: return "ld\t%0,%1";
+	  }
 
       if (src_code == CONST_INT)
 	{
@@ -8954,13 +8976,30 @@ mips_hard_regno_mode_ok_p (unsigned int 
   if (ACC_REG_P (regno)
       && (INTEGRAL_MODE_P (mode) || ALL_FIXED_POINT_MODE_P (mode)))
     {
-      if (size <= UNITS_PER_WORD)
-	return true;
+      if (MD_REG_P (regno))
+	{
+	  /* After a multiplication or division, clobbering HI makes
+	     the value of LO unpredictable, and vice versa.  This means
+	     that, for all interesting cases, HI and LO are effectively
+	     a single register.
 
-      if (size <= UNITS_PER_WORD * 2)
-	return (DSP_ACC_REG_P (regno)
-		? ((regno - DSP_ACC_REG_FIRST) & 1) == 0
-		: regno == MD_REG_FIRST);
+	     We model this by requiring that any value that uses HI
+	     also uses LO.  */
+	  if (size <= UNITS_PER_WORD * 2)
+	    return regno == (size <= UNITS_PER_WORD ? LO_REGNUM : MD_REG_FIRST);
+	}
+      else
+	{
+	  /* DSP accumulators do not have the same restrictions as
+	     HI and LO, so we can treat them as normal doubleword
+	     registers.  */
+	  if (size <= UNITS_PER_WORD)
+	    return true;
+
+	  if (size <= UNITS_PER_WORD * 2
+	      && ((regno - DSP_ACC_REG_FIRST) & 1) == 0)
+	    return true;
+	}
     }
 
   if (ALL_COP_REG_P (regno))
Index: gcc/config/mips/constraints.md
===================================================================
--- gcc/config/mips/constraints.md	2008-06-09 21:42:44.000000000 +0100
+++ gcc/config/mips/constraints.md	2008-06-09 21:45:18.000000000 +0100
@@ -29,14 +29,16 @@ (define_register_constraint "t" "T_REG"
 (define_register_constraint "f" "TARGET_HARD_FLOAT ? FP_REGS : NO_REGS"
   "A floating-point register (if available).")
 
-(define_register_constraint "h" "TARGET_BIG_ENDIAN ? MD0_REG : MD1_REG"
-  "The @code{hi} register.")
+(define_register_constraint "h" "NO_REGS"
+  "Formerly the @code{hi} register.  This constraint is no longer supported.")
 
 (define_register_constraint "l" "TARGET_BIG_ENDIAN ? MD1_REG : MD0_REG"
-  "The @code{lo} register.")
+  "The @code{lo} register.  Use this register to store values that are
+   no bigger than a word.")
 
 (define_register_constraint "x" "MD_REGS"
-  "The @code{hi} and @code{lo} registers.")
+  "The concatenated @code{hi} and @code{lo} registers.  Use this register
+   to store doubleword values.")
 
 (define_register_constraint "b" "ALL_REGS"
   "@internal")
Index: gcc/config/mips/mips.md
===================================================================
--- gcc/config/mips/mips.md	2008-06-09 21:42:44.000000000 +0100
+++ gcc/config/mips/mips.md	2008-06-09 21:45:18.000000000 +0100
@@ -44,9 +44,11 @@ (define_constants
    (UNSPEC_LOAD_CALL		23)
    (UNSPEC_LOAD_GOT		24)
    (UNSPEC_GP			25)
-   (UNSPEC_MFHILO		26)
-   (UNSPEC_TLS_LDM		27)
-   (UNSPEC_TLS_GET_TP		28)
+   (UNSPEC_MFHI			26)
+   (UNSPEC_MTHI			27)
+   (UNSPEC_SET_HILO		28)
+   (UNSPEC_TLS_LDM		29)
+   (UNSPEC_TLS_GET_TP		30)
    (UNSPEC_MFHC1		31)
    (UNSPEC_MTHC1		32)
    (UNSPEC_CLEAR_HAZARD		33)
@@ -484,6 +486,10 @@ (define_mode_iterator GPR [SI (DI "TARGE
 ;; modes.
 (define_mode_iterator GPR2 [SI (DI "TARGET_64BIT")])
 
+;; This mode iterator allows :HILO to be used as the mode of the
+;; concatenated HI and LO registers.
+(define_mode_iterator HILO [(DI "!TARGET_64BIT") (TI "TARGET_64BIT")])
+
 ;; This mode iterator allows :P to be used for patterns that operate on
 ;; pointer-sized quantities.  Exactly one of the two alternatives will match.
 (define_mode_iterator P [(SI "Pmode == SImode") (DI "Pmode == DImode")])
@@ -497,7 +503,7 @@ (define_mode_iterator MOVE64
   [DI DF (V2SF "TARGET_HARD_FLOAT && TARGET_PAIRED_SINGLE_FLOAT")])
 
 ;; 128-bit modes for which we provide move patterns on 64-bit targets.
-(define_mode_iterator MOVE128 [TF])
+(define_mode_iterator MOVE128 [TI TF])
 
 ;; This mode iterator allows the QI and HI extension patterns to be
 ;; defined from the same template.
@@ -613,6 +619,10 @@ (define_code_iterator any_extend [sign_e
 ;; from the same template.
 (define_code_iterator any_shift [ashift ashiftrt lshiftrt])
 
+;; This code iterator allows unsigned and signed division to be generated
+;; from the same template.
+(define_code_iterator any_div [div udiv])
+
 ;; This code iterator allows all native floating-point comparisons to be
 ;; generated from the same template.
 (define_code_iterator fcond [unordered uneq unlt unle eq lt le])
@@ -631,6 +641,7 @@ (define_code_iterator any_le [le leu])
 ;; <u> expands to an empty string when doing a signed operation and
 ;; "u" when doing an unsigned operation.
 (define_code_attr u [(sign_extend "") (zero_extend "u")
+		     (div "") (udiv "u")
 		     (gt "") (gtu "u")
 		     (ge "") (geu "u")
 		     (lt "") (ltu "u")
@@ -865,13 +876,10 @@ (define_insn "*add<mode>3_mips16"
 ;; simply adding a constant to a register.
 
 (define_split
-  [(set (match_operand:SI 0 "register_operand")
+  [(set (match_operand:SI 0 "d_operand")
 	(plus:SI (match_dup 0)
 		 (match_operand:SI 1 "const_int_operand")))]
   "TARGET_MIPS16 && reload_completed && !TARGET_DEBUG_D_MODE
-   && REG_P (operands[0])
-   && M16_REG_P (REGNO (operands[0]))
-   && GET_CODE (operands[1]) == CONST_INT
    && ((INTVAL (operands[1]) > 0x7f
 	&& INTVAL (operands[1]) <= 0x7f + 0x7f)
        || (INTVAL (operands[1]) < - 0x80
@@ -894,16 +902,11 @@ (define_split
 })
 
 (define_split
-  [(set (match_operand:SI 0 "register_operand")
-	(plus:SI (match_operand:SI 1 "register_operand")
+  [(set (match_operand:SI 0 "d_operand")
+	(plus:SI (match_operand:SI 1 "d_operand")
 		 (match_operand:SI 2 "const_int_operand")))]
   "TARGET_MIPS16 && reload_completed && !TARGET_DEBUG_D_MODE
-   && REG_P (operands[0])
-   && M16_REG_P (REGNO (operands[0]))
-   && REG_P (operands[1])
-   && M16_REG_P (REGNO (operands[1]))
    && REGNO (operands[0]) != REGNO (operands[1])
-   && GET_CODE (operands[2]) == CONST_INT
    && ((INTVAL (operands[2]) > 0x7
 	&& INTVAL (operands[2]) <= 0x7 + 0x7f)
        || (INTVAL (operands[2]) < - 0x8
@@ -926,13 +929,10 @@ (define_split
 })
 
 (define_split
-  [(set (match_operand:DI 0 "register_operand")
+  [(set (match_operand:DI 0 "d_operand")
 	(plus:DI (match_dup 0)
 		 (match_operand:DI 1 "const_int_operand")))]
   "TARGET_MIPS16 && TARGET_64BIT && reload_completed && !TARGET_DEBUG_D_MODE
-   && REG_P (operands[0])
-   && M16_REG_P (REGNO (operands[0]))
-   && GET_CODE (operands[1]) == CONST_INT
    && ((INTVAL (operands[1]) > 0xf
 	&& INTVAL (operands[1]) <= 0xf + 0xf)
        || (INTVAL (operands[1]) < - 0x10
@@ -955,16 +955,11 @@ (define_split
 })
 
 (define_split
-  [(set (match_operand:DI 0 "register_operand")
-	(plus:DI (match_operand:DI 1 "register_operand")
+  [(set (match_operand:DI 0 "d_operand")
+	(plus:DI (match_operand:DI 1 "d_operand")
 		 (match_operand:DI 2 "const_int_operand")))]
   "TARGET_MIPS16 && TARGET_64BIT && reload_completed && !TARGET_DEBUG_D_MODE
-   && REG_P (operands[0])
-   && M16_REG_P (REGNO (operands[0]))
-   && REG_P (operands[1])
-   && M16_REG_P (REGNO (operands[1]))
    && REGNO (operands[0]) != REGNO (operands[1])
-   && GET_CODE (operands[2]) == CONST_INT
    && ((INTVAL (operands[2]) > 0x7
 	&& INTVAL (operands[2]) <= 0x7 + 0xf)
        || (INTVAL (operands[2]) < - 0x8
@@ -1175,8 +1170,7 @@ (define_insn "mulsi3_mult3"
   [(set (match_operand:SI 0 "register_operand" "=d,l")
 	(mult:SI (match_operand:SI 1 "register_operand" "d,d")
 		 (match_operand:SI 2 "register_operand" "d,d")))
-   (clobber (match_scratch:SI 3 "=h,h"))
-   (clobber (match_scratch:SI 4 "=l,X"))]
+   (clobber (match_scratch:SI 3 "=l,X"))]
   "ISA_HAS_MUL3"
 {
   if (which_alternative == 1)
@@ -1195,30 +1189,26 @@ (define_insn "mulsi3_mult3"
 ;; Operand 0: LO
 ;; Operand 1: GPR (1st multiplication operand)
 ;; Operand 2: GPR (2nd multiplication operand)
-;; Operand 3: HI
-;; Operand 4: GPR (destination)
+;; Operand 3: GPR (destination)
 (define_peephole2
   [(parallel
-       [(set (match_operand:SI 0 "register_operand")
-	     (mult:SI (match_operand:SI 1 "register_operand")
-		      (match_operand:SI 2 "register_operand")))
-        (clobber (match_operand:SI 3 "register_operand"))
+       [(set (match_operand:SI 0 "lo_operand")
+	     (mult:SI (match_operand:SI 1 "d_operand")
+		      (match_operand:SI 2 "d_operand")))
         (clobber (scratch:SI))])
-   (set (match_operand:SI 4 "register_operand")
-	(unspec [(match_dup 0) (match_dup 3)] UNSPEC_MFHILO))]
+   (set (match_operand:SI 3 "d_operand")
+	(match_dup 0))]
   "ISA_HAS_MUL3 && peep2_reg_dead_p (2, operands[0])"
   [(parallel
-       [(set (match_dup 4)
+       [(set (match_dup 3)
 	     (mult:SI (match_dup 1)
 		      (match_dup 2)))
-        (clobber (match_dup 3))
         (clobber (match_dup 0))])])
 
 (define_insn "mul<mode>3_internal"
   [(set (match_operand:GPR 0 "register_operand" "=l")
 	(mult:GPR (match_operand:GPR 1 "register_operand" "d")
-		  (match_operand:GPR 2 "register_operand" "d")))
-   (clobber (match_scratch:GPR 3 "=h"))]
+		  (match_operand:GPR 2 "register_operand" "d")))]
   "!TARGET_FIX_R4000"
   "<d>mult\t%1,%2"
   [(set_attr "type" "imul")
@@ -1228,8 +1218,7 @@ (define_insn "mul<mode>3_r4000"
   [(set (match_operand:GPR 0 "register_operand" "=d")
 	(mult:GPR (match_operand:GPR 1 "register_operand" "d")
 		  (match_operand:GPR 2 "register_operand" "d")))
-   (clobber (match_scratch:GPR 3 "=h"))
-   (clobber (match_scratch:GPR 4 "=l"))]
+   (clobber (match_scratch:GPR 3 "=l"))]
   "TARGET_FIX_R4000"
   "<d>mult\t%1,%2\;mflo\t%0"
   [(set_attr "type" "imul")
@@ -1243,16 +1232,13 @@ (define_insn "mul<mode>3_r4000"
 ;; Operand 0: LO
 ;; Operand 1: GPR (1st multiplication operand)
 ;; Operand 2: GPR (2nd multiplication operand)
-;; Operand 3: HI
-;; Operand 4: GPR (destination)
+;; Operand 3: GPR (destination)
 (define_peephole2
-  [(parallel
-       [(set (match_operand:SI 0 "register_operand")
-	     (mult:SI (match_operand:SI 1 "register_operand")
-		      (match_operand:SI 2 "register_operand")))
-        (clobber (match_operand:SI 3 "register_operand"))])
-   (set (match_operand:SI 4 "register_operand")
-	(unspec:SI [(match_dup 0) (match_dup 3)] UNSPEC_MFHILO))]
+  [(set (match_operand:SI 0 "lo_operand")
+	(mult:SI (match_operand:SI 1 "d_operand")
+		 (match_operand:SI 2 "d_operand")))
+   (set (match_operand:SI 3 "d_operand")
+	(match_dup 0))]
   "ISA_HAS_MACC && !ISA_HAS_MUL3"
   [(set (match_dup 0)
 	(const_int 0))
@@ -1261,11 +1247,10 @@ (define_peephole2
 	     (plus:SI (mult:SI (match_dup 1)
 			       (match_dup 2))
 		      (match_dup 0)))
-	(set (match_dup 4)
+	(set (match_dup 3)
 	     (plus:SI (mult:SI (match_dup 1)
 			       (match_dup 2))
-		      (match_dup 0)))
-        (clobber (match_dup 3))])])
+		      (match_dup 0)))])])
 
 ;; Multiply-accumulate patterns
 
@@ -1284,9 +1269,8 @@ (define_insn "*mul_acc_si"
 	(plus:SI (mult:SI (match_operand:SI 1 "register_operand" "d,d,d")
 			  (match_operand:SI 2 "register_operand" "d,d,d"))
 		 (match_operand:SI 3 "register_operand" "0,l,*d")))
-   (clobber (match_scratch:SI 4 "=h,h,h"))
-   (clobber (match_scratch:SI 5 "=X,3,l"))
-   (clobber (match_scratch:SI 6 "=X,X,&d"))]
+   (clobber (match_scratch:SI 4 "=X,3,l"))
+   (clobber (match_scratch:SI 5 "=X,X,&d"))]
   "(TARGET_MIPS3900
    || GENERATE_MADD_MSUB)
    && !TARGET_MIPS16"
@@ -1302,53 +1286,45 @@ (define_insn "*mul_acc_si"
    (set_attr "mode"	"SI")
    (set_attr "length"	"4,4,8")])
 
-;; Split the above insn if we failed to get LO allocated.
+;; Split *mul_acc_si if both the source and destination accumulator
+;; values are GPRs.
 (define_split
-  [(set (match_operand:SI 0 "register_operand")
-	(plus:SI (mult:SI (match_operand:SI 1 "register_operand")
-			  (match_operand:SI 2 "register_operand"))
-		 (match_operand:SI 3 "register_operand")))
-   (clobber (match_scratch:SI 4))
-   (clobber (match_scratch:SI 5))
-   (clobber (match_scratch:SI 6))]
-  "reload_completed && !TARGET_DEBUG_D_MODE
-   && GP_REG_P (true_regnum (operands[0]))
-   && GP_REG_P (true_regnum (operands[3]))"
-  [(parallel [(set (match_dup 6)
+  [(set (match_operand:SI 0 "d_operand")
+	(plus:SI (mult:SI (match_operand:SI 1 "d_operand")
+			  (match_operand:SI 2 "d_operand"))
+		 (match_operand:SI 3 "d_operand")))
+   (clobber (match_operand:SI 4 "lo_operand"))
+   (clobber (match_operand:SI 5 "d_operand"))]
+  "reload_completed && !TARGET_DEBUG_D_MODE"
+  [(parallel [(set (match_dup 5)
 		   (mult:SI (match_dup 1) (match_dup 2)))
-	      (clobber (match_dup 4))
-	      (clobber (match_dup 5))])
-   (set (match_dup 0) (plus:SI (match_dup 6) (match_dup 3)))]
+	      (clobber (match_dup 4))])
+   (set (match_dup 0) (plus:SI (match_dup 5) (match_dup 3)))]
   "")
 
-;; Splitter to copy result of MADD to a general register
+;; Split *mul_acc_si if the destination accumulator value is in a GPR
+;; and the source accumulator value is in LO.
 (define_split
-  [(set (match_operand:SI                   0 "register_operand")
-        (plus:SI (mult:SI (match_operand:SI 1 "register_operand")
-                          (match_operand:SI 2 "register_operand"))
-                 (match_operand:SI          3 "register_operand")))
-   (clobber (match_scratch:SI               4))
-   (clobber (match_scratch:SI               5))
-   (clobber (match_scratch:SI               6))]
-  "reload_completed && !TARGET_DEBUG_D_MODE
-   && GP_REG_P (true_regnum (operands[0]))
-   && true_regnum (operands[3]) == LO_REGNUM"
+  [(set (match_operand:SI 0 "d_operand")
+        (plus:SI (mult:SI (match_operand:SI 1 "d_operand")
+                          (match_operand:SI 2 "d_operand"))
+                 (match_operand:SI 3 "lo_operand")))
+   (clobber (match_dup 3))
+   (clobber (scratch:SI))]
+  "reload_completed && !TARGET_DEBUG_D_MODE"
   [(parallel [(set (match_dup 3)
                    (plus:SI (mult:SI (match_dup 1) (match_dup 2))
                             (match_dup 3)))
-              (clobber (match_dup 4))
-              (clobber (match_dup 5))
-              (clobber (match_dup 6))])
-   (set (match_dup 0) (unspec:SI [(match_dup 5) (match_dup 4)] UNSPEC_MFHILO))]
-  "")
+              (clobber (scratch:SI))
+              (clobber (scratch:SI))])
+   (set (match_dup 0) (match_dup 3))])
 
 (define_insn "*macc"
   [(set (match_operand:SI 0 "register_operand" "=l,d")
 	(plus:SI (mult:SI (match_operand:SI 1 "register_operand" "d,d")
 			  (match_operand:SI 2 "register_operand" "d,d"))
 		 (match_operand:SI 3 "register_operand" "0,l")))
-   (clobber (match_scratch:SI 4 "=h,h"))
-   (clobber (match_scratch:SI 5 "=X,3"))]
+   (clobber (match_scratch:SI 4 "=X,3"))]
   "ISA_HAS_MACC"
 {
   if (which_alternative == 1)
@@ -1369,8 +1345,7 @@ (define_insn "*msac"
         (minus:SI (match_operand:SI 1 "register_operand" "0,l")
                   (mult:SI (match_operand:SI 2 "register_operand" "d,d")
                            (match_operand:SI 3 "register_operand" "d,d"))))
-   (clobber (match_scratch:SI 4 "=h,h"))
-   (clobber (match_scratch:SI 5 "=X,1"))]
+   (clobber (match_scratch:SI 4 "=X,1"))]
   "ISA_HAS_MSAC"
 {
   if (which_alternative == 1)
@@ -1389,21 +1364,19 @@ (define_insn_and_split "*msac_using_macc
         (minus:SI (match_operand:SI 1 "register_operand" "0,l")
                   (mult:SI (match_operand:SI 2 "register_operand" "d,d")
                            (match_operand:SI 3 "register_operand" "d,d"))))
-   (clobber (match_scratch:SI 4 "=h,h"))
-   (clobber (match_scratch:SI 5 "=X,1"))
-   (clobber (match_scratch:SI 6 "=d,d"))]
+   (clobber (match_scratch:SI 4 "=X,1"))
+   (clobber (match_scratch:SI 5 "=d,d"))]
   "ISA_HAS_MACC && !ISA_HAS_MSAC"
   "#"
   "&& reload_completed"
-  [(set (match_dup 6)
+  [(set (match_dup 5)
 	(neg:SI (match_dup 3)))
    (parallel
        [(set (match_dup 0)
 	     (plus:SI (mult:SI (match_dup 2)
-			       (match_dup 6))
+			       (match_dup 5))
 		      (match_dup 1)))
-	(clobber (match_dup 4))
-	(clobber (match_dup 5))])]
+	(clobber (match_dup 4))])]
   ""
   [(set_attr "type"     "imadd")
    (set_attr "length"	"8")])
@@ -1418,8 +1391,7 @@ (define_insn "*macc2"
    (set (match_operand:SI 3 "register_operand" "=d")
 	(plus:SI (mult:SI (match_dup 1)
 			  (match_dup 2))
-		 (match_dup 0)))
-   (clobber (match_scratch:SI 4 "=h"))]
+		 (match_dup 0)))]
   "ISA_HAS_MACC && reload_completed"
   "macc\t%3,%1,%2"
   [(set_attr "type"	"imadd")
@@ -1433,8 +1405,7 @@ (define_insn "*msac2"
    (set (match_operand:SI 3 "register_operand" "=d")
 	(minus:SI (match_dup 0)
 		  (mult:SI (match_dup 1)
-			   (match_dup 2))))
-   (clobber (match_scratch:SI 4 "=h"))]
+			   (match_dup 2))))]
   "ISA_HAS_MSAC && reload_completed"
   "msac\t%3,%1,%2"
   [(set_attr "type"	"imadd")
@@ -1445,23 +1416,19 @@ (define_insn "*msac2"
 ;;
 ;; Operand 0: LO
 ;; Operand 1: macc/msac
-;; Operand 2: HI
-;; Operand 3: GPR (destination)
+;; Operand 2: GPR (destination)
 (define_peephole2
   [(parallel
-       [(set (match_operand:SI 0 "register_operand")
+       [(set (match_operand:SI 0 "lo_operand")
 	     (match_operand:SI 1 "macc_msac_operand"))
-	(clobber (match_operand:SI 2 "register_operand"))
 	(clobber (scratch:SI))])
-   (set (match_operand:SI 3 "register_operand")
-	(unspec:SI [(match_dup 0) (match_dup 2)] UNSPEC_MFHILO))]
+   (set (match_operand:SI 2 "d_operand")
+	(match_dup 0))]
   ""
   [(parallel [(set (match_dup 0)
 		   (match_dup 1))
-	      (set (match_dup 3)
-		   (match_dup 1))
-	      (clobber (match_dup 2))])]
-  "")
+	      (set (match_dup 2)
+		   (match_dup 1))])])
 
 ;; When we have a three-address multiplication instruction, it should
 ;; be faster to do a separate multiply and add, rather than moving
@@ -1475,32 +1442,26 @@ (define_peephole2
 ;; Operand 2: GPR (addend)
 ;; Operand 3: GPR (destination)
 ;; Operand 4: macc/msac
-;; Operand 5: HI
-;; Operand 6: new multiplication
-;; Operand 7: new addition/subtraction
+;; Operand 5: new multiplication
+;; Operand 6: new addition/subtraction
 (define_peephole2
   [(match_scratch:SI 0 "d")
-   (set (match_operand:SI 1 "register_operand")
-	(match_operand:SI 2 "register_operand"))
+   (set (match_operand:SI 1 "lo_operand")
+	(match_operand:SI 2 "d_operand"))
    (match_dup 0)
    (parallel
-       [(set (match_operand:SI 3 "register_operand")
+       [(set (match_operand:SI 3 "d_operand")
 	     (match_operand:SI 4 "macc_msac_operand"))
-	(clobber (match_operand:SI 5 "register_operand"))
 	(clobber (match_dup 1))])]
-  "ISA_HAS_MUL3
-   && true_regnum (operands[1]) == LO_REGNUM
-   && peep2_reg_dead_p (2, operands[1])
-   && GP_REG_P (true_regnum (operands[3]))"
+  "ISA_HAS_MUL3 && peep2_reg_dead_p (2, operands[1])"
   [(parallel [(set (match_dup 0)
-		   (match_dup 6))
-	      (clobber (match_dup 5))
+		   (match_dup 5))
 	      (clobber (match_dup 1))])
    (set (match_dup 3)
-	(match_dup 7))]
+	(match_dup 6))]
 {
-  operands[6] = XEXP (operands[4], GET_CODE (operands[4]) == PLUS ? 0 : 1);
-  operands[7] = gen_rtx_fmt_ee (GET_CODE (operands[4]), SImode,
+  operands[5] = XEXP (operands[4], GET_CODE (operands[4]) == PLUS ? 0 : 1);
+  operands[6] = gen_rtx_fmt_ee (GET_CODE (operands[4]), SImode,
 				operands[2], operands[0]);
 })
 
@@ -1510,33 +1471,30 @@ (define_peephole2
 ;; Operand 1: LO
 ;; Operand 2: GPR (addend)
 ;; Operand 3: macc/msac
-;; Operand 4: HI
-;; Operand 5: GPR (destination)
-;; Operand 6: new multiplication
-;; Operand 7: new addition/subtraction
+;; Operand 4: GPR (destination)
+;; Operand 5: new multiplication
+;; Operand 6: new addition/subtraction
 (define_peephole2
   [(match_scratch:SI 0 "d")
-   (set (match_operand:SI 1 "register_operand")
-	(match_operand:SI 2 "register_operand"))
+   (set (match_operand:SI 1 "lo_operand")
+	(match_operand:SI 2 "d_operand"))
    (match_dup 0)
    (parallel
        [(set (match_dup 1)
 	     (match_operand:SI 3 "macc_msac_operand"))
-	(clobber (match_operand:SI 4 "register_operand"))
 	(clobber (scratch:SI))])
    (match_dup 0)
-   (set (match_operand:SI 5 "register_operand")
-	(unspec:SI [(match_dup 1) (match_dup 4)] UNSPEC_MFHILO))]
+   (set (match_operand:SI 4 "d_operand")
+	(match_dup 1))]
   "ISA_HAS_MUL3 && peep2_reg_dead_p (3, operands[1])"
   [(parallel [(set (match_dup 0)
-		   (match_dup 6))
-	      (clobber (match_dup 4))
+		   (match_dup 5))
 	      (clobber (match_dup 1))])
-   (set (match_dup 5)
-	(match_dup 7))]
+   (set (match_dup 4)
+	(match_dup 6))]
 {
-  operands[6] = XEXP (operands[4], GET_CODE (operands[4]) == PLUS ? 0 : 1);
-  operands[7] = gen_rtx_fmt_ee (GET_CODE (operands[4]), SImode,
+  operands[5] = XEXP (operands[3], GET_CODE (operands[3]) == PLUS ? 0 : 1);
+  operands[6] = gen_rtx_fmt_ee (GET_CODE (operands[3]), SImode,
 				operands[2], operands[0]);
 })
 
@@ -1545,9 +1503,8 @@ (define_insn "*mul_sub_si"
         (minus:SI (match_operand:SI 1 "register_operand" "0,l,*d")
                   (mult:SI (match_operand:SI 2 "register_operand" "d,d,d")
                            (match_operand:SI 3 "register_operand" "d,d,d"))))
-   (clobber (match_scratch:SI 4 "=h,h,h"))
-   (clobber (match_scratch:SI 5 "=X,1,l"))
-   (clobber (match_scratch:SI 6 "=X,X,&d"))]
+   (clobber (match_scratch:SI 4 "=X,1,l"))
+   (clobber (match_scratch:SI 5 "=X,X,&d"))]
   "GENERATE_MADD_MSUB"
   "@
    msub\t%2,%3
@@ -1557,52 +1514,45 @@ (define_insn "*mul_sub_si"
    (set_attr "mode"     "SI")
    (set_attr "length"   "4,8,8")])
 
-;; Split the above insn if we failed to get LO allocated.
+;; Split *mul_sub_si if both the source and destination accumulator
+;; values are GPRs.
 (define_split
-  [(set (match_operand:SI 0 "register_operand")
-        (minus:SI (match_operand:SI 1 "register_operand")
-                  (mult:SI (match_operand:SI 2 "register_operand")
-                           (match_operand:SI 3 "register_operand"))))
-   (clobber (match_scratch:SI 4))
-   (clobber (match_scratch:SI 5))
-   (clobber (match_scratch:SI 6))]
-  "reload_completed && !TARGET_DEBUG_D_MODE
-   && GP_REG_P (true_regnum (operands[0]))
-   && GP_REG_P (true_regnum (operands[1]))"
-  [(parallel [(set (match_dup 6)
+  [(set (match_operand:SI 0 "d_operand")
+        (minus:SI (match_operand:SI 1 "d_operand")
+                  (mult:SI (match_operand:SI 2 "d_operand")
+                           (match_operand:SI 3 "d_operand"))))
+   (clobber (match_operand:SI 4 "lo_operand"))
+   (clobber (match_operand:SI 5 "d_operand"))]
+  "reload_completed && !TARGET_DEBUG_D_MODE"
+  [(parallel [(set (match_dup 5)
                    (mult:SI (match_dup 2) (match_dup 3)))
-              (clobber (match_dup 4))
-              (clobber (match_dup 5))])
-   (set (match_dup 0) (minus:SI (match_dup 1) (match_dup 6)))]
+              (clobber (match_dup 4))])
+   (set (match_dup 0) (minus:SI (match_dup 1) (match_dup 5)))]
   "")
 
-;; Splitter to copy result of MSUB to a general register
+;; Split *mul_acc_si if the destination accumulator value is in a GPR
+;; and the source accumulator value is in LO.
 (define_split
-  [(set (match_operand:SI 0 "register_operand")
-        (minus:SI (match_operand:SI 1 "register_operand")
-                  (mult:SI (match_operand:SI 2 "register_operand")
-                           (match_operand:SI 3 "register_operand"))))
-   (clobber (match_scratch:SI 4))
-   (clobber (match_scratch:SI 5))
-   (clobber (match_scratch:SI 6))]
-  "reload_completed && !TARGET_DEBUG_D_MODE
-   && GP_REG_P (true_regnum (operands[0]))
-   && true_regnum (operands[1]) == LO_REGNUM"
+  [(set (match_operand:SI 0 "d_operand")
+        (minus:SI (match_operand:SI 1 "lo_operand")
+                  (mult:SI (match_operand:SI 2 "d_operand")
+                           (match_operand:SI 3 "d_operand"))))
+   (clobber (match_dup 1))
+   (clobber (scratch:SI))]
+  "reload_completed && !TARGET_DEBUG_D_MODE"
   [(parallel [(set (match_dup 1)
                    (minus:SI (match_dup 1)
                              (mult:SI (match_dup 2) (match_dup 3))))
-              (clobber (match_dup 4))
-              (clobber (match_dup 5))
-              (clobber (match_dup 6))])
-   (set (match_dup 0) (unspec:SI [(match_dup 5) (match_dup 4)] UNSPEC_MFHILO))]
+              (clobber (scratch:SI))
+              (clobber (scratch:SI))])
+   (set (match_dup 0) (match_dup 1))]
   "")
 
 (define_insn "*muls"
-  [(set (match_operand:SI                  0 "register_operand" "=l,d")
+  [(set (match_operand:SI 0 "register_operand" "=l,d")
         (neg:SI (mult:SI (match_operand:SI 1 "register_operand" "d,d")
                          (match_operand:SI 2 "register_operand" "d,d"))))
-   (clobber (match_scratch:SI              3                    "=h,h"))
-   (clobber (match_scratch:SI              4                    "=X,l"))]
+   (clobber (match_scratch:SI 3 "=X,l"))]
   "ISA_HAS_MULS"
   "@
    muls\t$0,%1,%2
@@ -1610,31 +1560,23 @@ (define_insn "*muls"
   [(set_attr "type"     "imul,imul3")
    (set_attr "mode"     "SI")])
 
-;; ??? We could define a mulditi3 pattern when TARGET_64BIT.
-
 (define_expand "<u>mulsidi3"
-  [(parallel
-      [(set (match_operand:DI 0 "register_operand")
-	    (mult:DI (any_extend:DI (match_operand:SI 1 "register_operand"))
-		     (any_extend:DI (match_operand:SI 2 "register_operand"))))
-       (clobber (scratch:DI))
-       (clobber (scratch:DI))
-       (clobber (scratch:DI))])]
+  [(set (match_operand:DI 0 "register_operand")
+	(mult:DI (any_extend:DI (match_operand:SI 1 "register_operand"))
+		 (any_extend:DI (match_operand:SI 2 "register_operand"))))]
   "!TARGET_64BIT || !TARGET_FIX_R4000"
 {
-  if (!TARGET_64BIT)
-    {
-      if (!TARGET_FIX_R4000)
-	emit_insn (gen_<u>mulsidi3_32bit_internal (operands[0], operands[1],
-						   operands[2]));
-      else
-	emit_insn (gen_<u>mulsidi3_32bit_r4000 (operands[0], operands[1],
-					        operands[2]));
-      DONE;
-    }
+  if (TARGET_64BIT)
+    emit_insn (gen_<u>mulsidi3_64bit (operands[0], operands[1], operands[2]));
+  else if (TARGET_FIX_R4000)
+    emit_insn (gen_<u>mulsidi3_32bit_r4000 (operands[0], operands[1],
+					    operands[2]));
+  else
+    emit_insn (gen_<u>mulsidi3_32bit (operands[0], operands[1], operands[2]));
+  DONE;
 })
 
-(define_insn "<u>mulsidi3_32bit_internal"
+(define_insn "<u>mulsidi3_32bit"
   [(set (match_operand:DI 0 "register_operand" "=x")
 	(mult:DI (any_extend:DI (match_operand:SI 1 "register_operand" "d"))
 		 (any_extend:DI (match_operand:SI 2 "register_operand" "d"))))]
@@ -1649,42 +1591,35 @@ (define_insn "<u>mulsidi3_32bit_r4000"
 		 (any_extend:DI (match_operand:SI 2 "register_operand" "d"))))
    (clobber (match_scratch:DI 3 "=x"))]
   "!TARGET_64BIT && TARGET_FIX_R4000"
-  "mult<u>\t%1,%2\;mflo\t%L0;mfhi\t%M0"
+  "mult<u>\t%1,%2\;mflo\t%L0\;mfhi\t%M0"
   [(set_attr "type" "imul")
    (set_attr "mode" "SI")
    (set_attr "length" "12")])
 
-(define_insn_and_split "*<u>mulsidi3_64bit"
+(define_insn_and_split "<u>mulsidi3_64bit"
   [(set (match_operand:DI 0 "register_operand" "=d")
 	(mult:DI (any_extend:DI (match_operand:SI 1 "register_operand" "d"))
 		 (any_extend:DI (match_operand:SI 2 "register_operand" "d"))))
-   (clobber (match_scratch:DI 3 "=l"))
-   (clobber (match_scratch:DI 4 "=h"))
-   (clobber (match_scratch:DI 5 "=d"))]
+   (clobber (match_scratch:TI 3 "=x"))
+   (clobber (match_scratch:DI 4 "=d"))]
   "TARGET_64BIT && !TARGET_FIX_R4000"
   "#"
   "&& reload_completed"
-  [(parallel
-       [(set (match_dup 3)
-	     (sign_extend:DI
-		(mult:SI (match_dup 1)
-			 (match_dup 2))))
-	(set (match_dup 4)
-	     (ashiftrt:DI
-		(mult:DI (any_extend:DI (match_dup 1))
-			 (any_extend:DI (match_dup 2)))
-		(const_int 32)))])
-
-   ;; OP5 <- LO, OP0 <- HI
-   (set (match_dup 5) (unspec:DI [(match_dup 3) (match_dup 4)] UNSPEC_MFHILO))
-   (set (match_dup 0) (unspec:DI [(match_dup 4) (match_dup 3)] UNSPEC_MFHILO))
-
-   ;; Zero-extend OP5.
-   (set (match_dup 5)
-	(ashift:DI (match_dup 5)
+  [(set (match_dup 3)
+	(unspec:TI [(mult:DI (any_extend:DI (match_dup 1))
+			     (any_extend:DI (match_dup 2)))]
+		   UNSPEC_SET_HILO))
+
+   ;; OP4 <- LO, OP0 <- HI
+   (set (match_dup 4) (match_dup 5))
+   (set (match_dup 0) (unspec:DI [(match_dup 3)] UNSPEC_MFHI))
+
+   ;; Zero-extend OP4.
+   (set (match_dup 4)
+	(ashift:DI (match_dup 4)
 		   (const_int 32)))
-   (set (match_dup 5)
-	(lshiftrt:DI (match_dup 5)
+   (set (match_dup 4)
+	(lshiftrt:DI (match_dup 4)
 		     (const_int 32)))
 
    ;; Shift OP0 into place.
@@ -1695,24 +1630,21 @@ (define_insn_and_split "*<u>mulsidi3_64b
    ;; OR the two halves together
    (set (match_dup 0)
 	(ior:DI (match_dup 0)
-		(match_dup 5)))]
-  ""
+		(match_dup 4)))]
+  { operands[5] = gen_rtx_REG (DImode, LO_REGNUM); }
   [(set_attr "type" "imul")
    (set_attr "mode" "SI")
    (set_attr "length" "24")])
 
-(define_insn "*<u>mulsidi3_64bit_parts"
-  [(set (match_operand:DI 0 "register_operand" "=l")
-	(sign_extend:DI
-	   (mult:SI (match_operand:SI 2 "register_operand" "d")
-		    (match_operand:SI 3 "register_operand" "d"))))
-   (set (match_operand:DI 1 "register_operand" "=h")
-	(ashiftrt:DI
-	   (mult:DI (any_extend:DI (match_dup 2))
-		    (any_extend:DI (match_dup 3)))
-	   (const_int 32)))]
+(define_insn "<u>mulsidi3_64bit_hilo"
+  [(set (match_operand:TI 0 "register_operand" "=x")
+	(unspec:TI
+	  [(mult:DI
+	     (any_extend:DI (match_operand:SI 1 "register_operand" "d"))
+	     (any_extend:DI (match_operand:SI 2 "register_operand" "d")))]
+	  UNSPEC_SET_HILO))]
   "TARGET_64BIT && !TARGET_FIX_R4000"
-  "mult<u>\t%2,%3"
+  "mult<u>\t%1,%2"
   [(set_attr "type" "imul")
    (set_attr "mode" "SI")])
 
@@ -1756,7 +1688,7 @@ (define_expand "<su>mulsi3_highpart"
 	  (mult:DI (any_extend:DI (match_operand:SI 1 "register_operand"))
 		   (any_extend:DI (match_operand:SI 2 "register_operand")))
 	  (const_int 32))))]
-  "ISA_HAS_MULHI || !TARGET_FIX_R4000"
+  ""
 {
   if (ISA_HAS_MULHI)
     emit_insn (gen_<su>mulsi3_highpart_mulhi_internal (operands[0],
@@ -1768,72 +1700,133 @@ (define_expand "<su>mulsi3_highpart"
   DONE;
 })
 
-(define_insn "<su>mulsi3_highpart_internal"
-  [(set (match_operand:SI 0 "register_operand" "=h")
+(define_insn_and_split "<su>mulsi3_highpart_internal"
+  [(set (match_operand:SI 0 "register_operand" "=d")
 	(truncate:SI
 	 (lshiftrt:DI
 	  (mult:DI (any_extend:DI (match_operand:SI 1 "register_operand" "d"))
 		   (any_extend:DI (match_operand:SI 2 "register_operand" "d")))
 	  (const_int 32))))
    (clobber (match_scratch:SI 3 "=l"))]
-  "!ISA_HAS_MULHI && !TARGET_FIX_R4000"
-  "mult<u>\t%1,%2"
+  "!ISA_HAS_MULHI"
+  { return TARGET_FIX_R4000 ? "mult<u>\t%1,%2\n\tmfhi\t%0" : "#"; }
+  "&& reload_completed && !TARGET_FIX_R4000"
+  [(const_int 0)]
+{
+  rtx hilo;
+
+  if (TARGET_64BIT)
+    {
+      hilo = gen_rtx_REG (TImode, MD_REG_FIRST);
+      emit_insn (gen_<u>mulsidi3_64bit_hilo (hilo, operands[1], operands[2]));
+      emit_insn (gen_mfhisi_ti (operands[0], hilo));
+    }
+  else
+    {
+      hilo = gen_rtx_REG (DImode, MD_REG_FIRST);
+      emit_insn (gen_<u>mulsidi3_32bit (hilo, operands[1], operands[2]));
+      emit_insn (gen_mfhisi_di (operands[0], hilo));
+    }
+  DONE;
+}
   [(set_attr "type" "imul")
-   (set_attr "mode" "SI")])
+   (set_attr "mode" "SI")
+   (set_attr "length" "8")])
 
 (define_insn "<su>mulsi3_highpart_mulhi_internal"
-  [(set (match_operand:SI 0 "register_operand" "=h,d")
+  [(set (match_operand:SI 0 "register_operand" "=d")
         (truncate:SI
 	 (lshiftrt:DI
 	  (mult:DI
-	   (any_extend:DI (match_operand:SI 1 "register_operand" "d,d"))
-	   (any_extend:DI (match_operand:SI 2 "register_operand" "d,d")))
+	   (any_extend:DI (match_operand:SI 1 "register_operand" "d"))
+	   (any_extend:DI (match_operand:SI 2 "register_operand" "d")))
 	  (const_int 32))))
-   (clobber (match_scratch:SI 3 "=l,l"))
-   (clobber (match_scratch:SI 4 "=X,h"))]
+   (clobber (match_scratch:SI 3 "=l"))]
   "ISA_HAS_MULHI"
-  "@
-   mult<u>\t%1,%2
-   mulhi<u>\t%0,%1,%2"
-  [(set_attr "type" "imul,imul3")
+  "mulhi<u>\t%0,%1,%2"
+  [(set_attr "type" "imul3")
    (set_attr "mode" "SI")])
 
 (define_insn "*<su>mulsi3_highpart_neg_mulhi_internal"
-  [(set (match_operand:SI 0 "register_operand" "=h,d")
+  [(set (match_operand:SI 0 "register_operand" "=d")
         (truncate:SI
 	 (lshiftrt:DI
 	  (neg:DI
 	   (mult:DI
-	    (any_extend:DI (match_operand:SI 1 "register_operand" "d,d"))
-	    (any_extend:DI (match_operand:SI 2 "register_operand" "d,d"))))
+	    (any_extend:DI (match_operand:SI 1 "register_operand" "d"))
+	    (any_extend:DI (match_operand:SI 2 "register_operand" "d"))))
 	  (const_int 32))))
-   (clobber (match_scratch:SI 3 "=l,l"))
-   (clobber (match_scratch:SI 4 "=X,h"))]
+   (clobber (match_scratch:SI 3 "=l"))]
   "ISA_HAS_MULHI"
-  "@
-   mulshi<u>\t%.,%1,%2
-   mulshi<u>\t%0,%1,%2"
-  [(set_attr "type" "imul,imul3")
+  "mulshi<u>\t%0,%1,%2"
+  [(set_attr "type" "imul3")
    (set_attr "mode" "SI")])
 
 ;; Disable unsigned multiplication for -mfix-vr4120.  This is for VR4120
 ;; errata MD(0), which says that dmultu does not always produce the
 ;; correct result.
-(define_insn "<su>muldi3_highpart"
-  [(set (match_operand:DI 0 "register_operand" "=h")
+(define_insn_and_split "<su>muldi3_highpart"
+  [(set (match_operand:DI 0 "register_operand" "=d")
 	(truncate:DI
 	 (lshiftrt:TI
-	  (mult:TI
-	   (any_extend:TI (match_operand:DI 1 "register_operand" "d"))
-	   (any_extend:TI (match_operand:DI 2 "register_operand" "d")))
+	  (mult:TI (any_extend:TI (match_operand:DI 1 "register_operand" "d"))
+		   (any_extend:TI (match_operand:DI 2 "register_operand" "d")))
 	  (const_int 64))))
    (clobber (match_scratch:DI 3 "=l"))]
-  "TARGET_64BIT && !TARGET_FIX_R4000
+  "TARGET_64BIT && !(<CODE> == ZERO_EXTEND && TARGET_FIX_VR4120)"
+  { return TARGET_FIX_R4000 ? "dmult<u>\t%1,%2\n\tmfhi\t%0" : "#"; }
+  "&& reload_completed && !TARGET_FIX_R4000"
+  [(const_int 0)]
+{
+  rtx hilo;
+
+  hilo = gen_rtx_REG (TImode, MD_REG_FIRST);
+  emit_insn (gen_<u>mulditi3_internal (hilo, operands[1], operands[2]));
+  emit_insn (gen_mfhidi_ti (operands[0], hilo));
+  DONE;
+}
+  [(set_attr "type" "imul")
+   (set_attr "mode" "DI")
+   (set_attr "length" "8")])
+
+(define_expand "<u>mulditi3"
+  [(set (match_operand:TI 0 "register_operand")
+	(mult:TI (any_extend:TI (match_operand:DI 1 "register_operand"))
+		 (any_extend:TI (match_operand:DI 2 "register_operand"))))]
+  "TARGET_64BIT && !(<CODE> == ZERO_EXTEND && TARGET_FIX_VR4120)"
+{
+  if (TARGET_FIX_R4000)
+    emit_insn (gen_<u>mulditi3_r4000 (operands[0], operands[1], operands[2]));
+  else
+    emit_insn (gen_<u>mulditi3_internal (operands[0], operands[1],
+					 operands[2]));
+  DONE;
+})
+
+(define_insn "<u>mulditi3_internal"
+  [(set (match_operand:TI 0 "register_operand" "=x")
+	(mult:TI (any_extend:TI (match_operand:DI 1 "register_operand" "d"))
+		 (any_extend:TI (match_operand:DI 2 "register_operand" "d"))))]
+  "TARGET_64BIT
+   && !TARGET_FIX_R4000
    && !(<CODE> == ZERO_EXTEND && TARGET_FIX_VR4120)"
   "dmult<u>\t%1,%2"
   [(set_attr "type" "imul")
    (set_attr "mode" "DI")])
 
+(define_insn "<u>mulditi3_r4000"
+  [(set (match_operand:TI 0 "register_operand" "=d")
+	(mult:TI (any_extend:TI (match_operand:DI 1 "register_operand" "d"))
+		 (any_extend:TI (match_operand:DI 2 "register_operand" "d"))))
+   (clobber (match_scratch:TI 3 "=x"))]
+  "TARGET_64BIT
+   && TARGET_FIX_R4000
+   && !(<CODE> == ZERO_EXTEND && TARGET_FIX_VR4120)"
+  "dmult<u>\t%1,%2\;mflo\t%L0\;mfhi\t%M0"
+  [(set_attr "type" "imul")
+   (set_attr "mode" "DI")
+   (set_attr "length" "12")])
+
 ;; The R4650 supports a 32-bit multiply/ 64-bit accumulate
 ;; instruction.  The HI/LO registers are used as a 64-bit accumulator.
 
@@ -1841,8 +1834,7 @@ (define_insn "madsi"
   [(set (match_operand:SI 0 "register_operand" "+l")
 	(plus:SI (mult:SI (match_operand:SI 1 "register_operand" "d")
 			  (match_operand:SI 2 "register_operand" "d"))
-		 (match_dup 0)))
-   (clobber (match_scratch:SI 3 "=h"))]
+		 (match_dup 0)))]
   "TARGET_MAD"
   "mad\t%1,%2"
   [(set_attr "type"	"imadd")
@@ -2017,29 +2009,80 @@ (define_insn "*recip<mode>3"
 
 ;; VR4120 errata MD(A1): signed division instructions do not work correctly
 ;; with negative operands.  We use special libgcc functions instead.
-(define_insn "divmod<mode>4"
+(define_insn_and_split "divmod<mode>4"
   [(set (match_operand:GPR 0 "register_operand" "=l")
 	(div:GPR (match_operand:GPR 1 "register_operand" "d")
 		 (match_operand:GPR 2 "register_operand" "d")))
-   (set (match_operand:GPR 3 "register_operand" "=h")
+   (set (match_operand:GPR 3 "register_operand" "=d")
 	(mod:GPR (match_dup 1)
 		 (match_dup 2)))]
   "!TARGET_FIX_VR4120"
-  { return mips_output_division ("<d>div\t$0,%1,%2", operands); }
-  [(set_attr "type" "idiv")
-   (set_attr "mode" "<MODE>")])
+  "#"
+  "&& reload_completed"
+  [(const_int 0)]
+{
+  rtx hilo;
+
+  if (TARGET_64BIT)
+    {
+      hilo = gen_rtx_REG (TImode, MD_REG_FIRST);
+      emit_insn (gen_divmod<mode>4_hilo_ti (hilo, operands[1], operands[2]));
+      emit_insn (gen_mfhi<mode>_ti (operands[3], hilo));
+    }
+  else
+    {
+      hilo = gen_rtx_REG (DImode, MD_REG_FIRST);
+      emit_insn (gen_divmod<mode>4_hilo_di (hilo, operands[1], operands[2]));
+      emit_insn (gen_mfhi<mode>_di (operands[3], hilo));
+    }
+  DONE;
+}
+ [(set_attr "type" "idiv")
+  (set_attr "mode" "<MODE>")
+  (set_attr "length" "8")])
 
-(define_insn "udivmod<mode>4"
+(define_insn_and_split "udivmod<mode>4"
   [(set (match_operand:GPR 0 "register_operand" "=l")
 	(udiv:GPR (match_operand:GPR 1 "register_operand" "d")
 		  (match_operand:GPR 2 "register_operand" "d")))
-   (set (match_operand:GPR 3 "register_operand" "=h")
+   (set (match_operand:GPR 3 "register_operand" "=d")
 	(umod:GPR (match_dup 1)
 		  (match_dup 2)))]
   ""
-  { return mips_output_division ("<d>divu\t$0,%1,%2", operands); }
+  "#"
+  "reload_completed"
+  [(const_int 0)]
+{
+  rtx hilo;
+
+  if (TARGET_64BIT)
+    {
+      hilo = gen_rtx_REG (TImode, MD_REG_FIRST);
+      emit_insn (gen_udivmod<mode>4_hilo_ti (hilo, operands[1], operands[2]));
+      emit_insn (gen_mfhi<mode>_ti (operands[3], hilo));
+    }
+  else
+    {
+      hilo = gen_rtx_REG (DImode, MD_REG_FIRST);
+      emit_insn (gen_udivmod<mode>4_hilo_di (hilo, operands[1], operands[2]));
+      emit_insn (gen_mfhi<mode>_di (operands[3], hilo));
+    }
+  DONE;
+}
+ [(set_attr "type" "idiv")
+  (set_attr "mode" "<MODE>")
+  (set_attr "length" "8")])
+
+(define_insn "<u>divmod<GPR:mode>4_hilo_<HILO:mode>"
+  [(set (match_operand:HILO 0 "register_operand" "=x")
+	(unspec:HILO
+	  [(any_div:GPR (match_operand:GPR 1 "register_operand" "d")
+			(match_operand:GPR 2 "register_operand" "d"))]
+	  UNSPEC_SET_HILO))]
+  ""
+  { return mips_output_division ("<GPR:d>div<u>\t%.,%1,%2", operands); }
   [(set_attr "type" "idiv")
-   (set_attr "mode" "<MODE>")])
+   (set_attr "mode" "<GPR:MODE>")])
 
 ;;
 ;;  ....................
@@ -3241,7 +3284,7 @@ (define_insn_and_split "*lea_high64"
 ;;	dsll32	op1,op1,0
 ;;	daddu	op1,op1,op0
 (define_peephole2
-  [(set (match_operand:DI 1 "register_operand")
+  [(set (match_operand:DI 1 "d_operand")
 	(high:DI (match_operand:DI 2 "absolute_symbolic_operand")))
    (match_scratch:DI 0 "d")]
   "TARGET_EXPLICIT_RELOCS && ABI_HAS_64BIT_SYMBOLS"
@@ -3294,8 +3337,8 @@ (define_insn_and_split "*lea64"
 ;;
 ;; on MIPS16 targets.
 (define_split
-  [(set (match_operand:SI 0 "register_operand" "=d")
-	(high:SI (match_operand:SI 1 "absolute_symbolic_operand" "")))]
+  [(set (match_operand:SI 0 "d_operand")
+	(high:SI (match_operand:SI 1 "absolute_symbolic_operand")))]
   "TARGET_MIPS16 && reload_completed"
   [(set (match_dup 0) (match_dup 2))
    (set (match_dup 0) (ashift:SI (match_dup 0) (const_int 16)))]
@@ -3464,7 +3507,7 @@ (define_insn "*movdi_32bit"
    && (register_operand (operands[0], DImode)
        || reg_or_0_operand (operands[1], DImode))"
   { return mips_output_move (operands[0], operands[1]); }
-  [(set_attr "type"	"multi,multi,load,store,mthilo,mfhilo,mtc,load,mfc,store")
+  [(set_attr "type"	"multi,multi,load,store,multi,multi,mtc,load,mfc,store")
    (set_attr "mode"	"DI")
    (set_attr "length"   "8,16,*,*,8,8,8,*,8,*")])
 
@@ -3475,7 +3518,7 @@ (define_insn "*movdi_gp32_fp64"
    && (register_operand (operands[0], DImode)
        || reg_or_0_operand (operands[1], DImode))"
   { return mips_output_move (operands[0], operands[1]); }
-  [(set_attr "type"	"multi,multi,load,store,mthilo,mfhilo,mtc,fpload,mfc,fpstore")
+  [(set_attr "type"	"multi,multi,load,store,multi,multi,mtc,fpload,mfc,fpstore")
    (set_attr "mode"	"DI")
    (set_attr "length"   "8,16,*,*,8,8,8,*,8,*")])
 
@@ -3486,29 +3529,29 @@ (define_insn "*movdi_32bit_mips16"
    && (register_operand (operands[0], DImode)
        || register_operand (operands[1], DImode))"
   { return mips_output_move (operands[0], operands[1]); }
-  [(set_attr "type"	"multi,multi,multi,multi,multi,load,store,mfhilo")
+  [(set_attr "type"	"multi,multi,multi,multi,multi,load,store,multi")
    (set_attr "mode"	"DI")
    (set_attr "length"	"8,8,8,8,12,*,*,8")])
 
 (define_insn "*movdi_64bit"
-  [(set (match_operand:DI 0 "nonimmediate_operand" "=d,d,e,d,m,*f,*f,*d,*m,*x,*B*C*D,*B*C*D,*d,*m")
-	(match_operand:DI 1 "move_operand" "d,U,T,m,dJ,*d*J,*m,*f,*f,*J*d,*d,*m,*B*C*D,*B*C*D"))]
+  [(set (match_operand:DI 0 "nonimmediate_operand" "=d,d,e,d,m,*f,*f,*d,*m,*a,*d,*B*C*D,*B*C*D,*d,*m")
+	(match_operand:DI 1 "move_operand" "d,U,T,m,dJ,*d*J,*m,*f,*f,*J*d,*a,*d,*m,*B*C*D,*B*C*D"))]
   "TARGET_64BIT && !TARGET_MIPS16
    && (register_operand (operands[0], DImode)
        || reg_or_0_operand (operands[1], DImode))"
   { return mips_output_move (operands[0], operands[1]); }
-  [(set_attr "type"	"move,const,const,load,store,mtc,fpload,mfc,fpstore,mthilo,mtc,load,mfc,store")
+  [(set_attr "type"	"move,const,const,load,store,mtc,fpload,mfc,fpstore,mthilo,mfhilo,mtc,load,mfc,store")
    (set_attr "mode"	"DI")
-   (set_attr "length"	"4,*,*,*,*,4,*,4,*,4,8,*,8,*")])
+   (set_attr "length"	"4,*,*,*,*,4,*,4,*,4,4,8,*,8,*")])
 
 (define_insn "*movdi_64bit_mips16"
-  [(set (match_operand:DI 0 "nonimmediate_operand" "=d,y,d,d,d,d,d,d,m")
-	(match_operand:DI 1 "move_operand" "d,d,y,K,N,kf,U,m,d"))]
+  [(set (match_operand:DI 0 "nonimmediate_operand" "=d,y,d,d,d,d,d,d,m,*d")
+	(match_operand:DI 1 "move_operand" "d,d,y,K,N,kf,U,m,d,*a"))]
   "TARGET_64BIT && TARGET_MIPS16
    && (register_operand (operands[0], DImode)
        || register_operand (operands[1], DImode))"
   { return mips_output_move (operands[0], operands[1]); }
-  [(set_attr "type"	"move,move,move,arith,arith,load,const,load,store")
+  [(set_attr "type"	"move,move,move,arith,arith,load,const,load,store,mfhilo")
    (set_attr "mode"	"DI")
    (set_attr_alternative "length"
 		[(const_int 4)
@@ -3523,7 +3566,8 @@ (define_insn "*movdi_64bit_mips16"
 		 (const_int 8)
 		 (const_string "*")
 		 (const_string "*")
-		 (const_string "*")])])
+		 (const_string "*")
+		 (const_int 4)])])
 
 
 ;; On the mips16, we can split ld $r,N($r) into an add and a load,
@@ -3531,14 +3575,11 @@ (define_insn "*movdi_64bit_mips16"
 ;; load are 2 2 byte instructions.
 
 (define_split
-  [(set (match_operand:DI 0 "register_operand")
+  [(set (match_operand:DI 0 "d_operand")
 	(mem:DI (plus:DI (match_dup 0)
 			 (match_operand:DI 1 "const_int_operand"))))]
   "TARGET_64BIT && TARGET_MIPS16 && reload_completed
    && !TARGET_DEBUG_D_MODE
-   && REG_P (operands[0])
-   && M16_REG_P (REGNO (operands[0]))
-   && GET_CODE (operands[1]) == CONST_INT
    && ((INTVAL (operands[1]) < 0
 	&& INTVAL (operands[1]) >= -0x10)
        || (INTVAL (operands[1]) >= 32 * 8
@@ -3589,7 +3630,7 @@ (define_expand "movsi"
 
 (define_insn "*movsi_internal"
   [(set (match_operand:SI 0 "nonimmediate_operand" "=d,d,e,d,m,*f,*f,*d,*m,*d,*z,*a,*d,*B*C*D,*B*C*D,*d,*m")
-	(match_operand:SI 1 "move_operand" "d,U,T,m,dJ,*d*J,*m,*f,*f,*z,*d,*J*d,*A,*d,*m,*B*C*D,*B*C*D"))]
+	(match_operand:SI 1 "move_operand" "d,U,T,m,dJ,*d*J,*m,*f,*f,*z,*d,*J*d,*a,*d,*m,*B*C*D,*B*C*D"))]
   "!TARGET_MIPS16
    && (register_operand (operands[0], SImode)
        || reg_or_0_operand (operands[1], SImode))"
@@ -3599,13 +3640,13 @@ (define_insn "*movsi_internal"
    (set_attr "length"	"4,*,*,*,*,4,*,4,*,4,4,4,4,4,*,4,*")])
 
 (define_insn "*movsi_mips16"
-  [(set (match_operand:SI 0 "nonimmediate_operand" "=d,y,d,d,d,d,d,d,m")
-	(match_operand:SI 1 "move_operand" "d,d,y,K,N,kf,U,m,d"))]
+  [(set (match_operand:SI 0 "nonimmediate_operand" "=d,y,d,d,d,d,d,d,m,*d")
+	(match_operand:SI 1 "move_operand" "d,d,y,K,N,kf,U,m,d,*a"))]
   "TARGET_MIPS16
    && (register_operand (operands[0], SImode)
        || register_operand (operands[1], SImode))"
   { return mips_output_move (operands[0], operands[1]); }
-  [(set_attr "type"	"move,move,move,arith,arith,load,const,load,store")
+  [(set_attr "type"	"move,move,move,arith,arith,load,const,load,store,mfhilo")
    (set_attr "mode"	"SI")
    (set_attr_alternative "length"
 		[(const_int 4)
@@ -3620,20 +3661,18 @@ (define_insn "*movsi_mips16"
 		 (const_int 8)
 		 (const_string "*")
 		 (const_string "*")
-		 (const_string "*")])])
+		 (const_string "*")
+		 (const_int 4)])])
 
 ;; On the mips16, we can split lw $r,N($r) into an add and a load,
 ;; when the original load is a 4 byte instruction but the add and the
 ;; load are 2 2 byte instructions.
 
 (define_split
-  [(set (match_operand:SI 0 "register_operand")
+  [(set (match_operand:SI 0 "d_operand")
 	(mem:SI (plus:SI (match_dup 0)
 			 (match_operand:SI 1 "const_int_operand"))))]
   "TARGET_MIPS16 && reload_completed && !TARGET_DEBUG_D_MODE
-   && REG_P (operands[0])
-   && M16_REG_P (REGNO (operands[0]))
-   && GET_CODE (operands[1]) == CONST_INT
    && ((INTVAL (operands[1]) < 0
 	&& INTVAL (operands[1]) >= -0x80)
        || (INTVAL (operands[1]) >= 32 * 4
@@ -3669,12 +3708,9 @@ (define_split
 ;; instructions.
 
 (define_split
-  [(set (match_operand:SI 0 "register_operand")
+  [(set (match_operand:SI 0 "d_operand")
 	(match_operand:SI 1 "const_int_operand"))]
   "TARGET_MIPS16 && reload_completed && !TARGET_DEBUG_D_MODE
-   && REG_P (operands[0])
-   && M16_REG_P (REGNO (operands[0]))
-   && GET_CODE (operands[1]) == CONST_INT
    && INTVAL (operands[1]) >= 0x100
    && INTVAL (operands[1]) <= 0xff + 0x7f"
   [(set (match_dup 0) (match_dup 1))
@@ -3797,36 +3833,24 @@ (define_expand "movhi"
 })
 
 (define_insn "*movhi_internal"
-  [(set (match_operand:HI 0 "nonimmediate_operand" "=d,d,d,m,*x")
-	(match_operand:HI 1 "move_operand"         "d,I,m,dJ,*d"))]
+  [(set (match_operand:HI 0 "nonimmediate_operand" "=d,d,d,m,*a,*d")
+	(match_operand:HI 1 "move_operand"         "d,I,m,dJ,*d*J,*a"))]
   "!TARGET_MIPS16
    && (register_operand (operands[0], HImode)
        || reg_or_0_operand (operands[1], HImode))"
-  "@
-    move\t%0,%1
-    li\t%0,%1
-    lhu\t%0,%1
-    sh\t%z1,%0
-    mt%0\t%1"
-  [(set_attr "type"	"move,arith,load,store,mthilo")
+  { return mips_output_move (operands[0], operands[1]); }
+  [(set_attr "type"	"move,arith,load,store,mthilo,mfhilo")
    (set_attr "mode"	"HI")
-   (set_attr "length"	"4,4,*,*,4")])
+   (set_attr "length"	"4,4,*,*,4,4")])
 
 (define_insn "*movhi_mips16"
-  [(set (match_operand:HI 0 "nonimmediate_operand" "=d,y,d,d,d,d,m")
-	(match_operand:HI 1 "move_operand"         "d,d,y,K,N,m,d"))]
+  [(set (match_operand:HI 0 "nonimmediate_operand" "=d,y,d,d,d,d,m,*d")
+	(match_operand:HI 1 "move_operand"         "d,d,y,K,N,m,d,*a"))]
   "TARGET_MIPS16
    && (register_operand (operands[0], HImode)
        || register_operand (operands[1], HImode))"
-  "@
-    move\t%0,%1
-    move\t%0,%1
-    move\t%0,%1
-    li\t%0,%1
-    #
-    lhu\t%0,%1
-    sh\t%1,%0"
-  [(set_attr "type"	"move,move,move,arith,arith,load,store")
+  { return mips_output_move (operands[0], operands[1]); }
+  [(set_attr "type"	"move,move,move,arith,arith,load,store,mfhilo")
    (set_attr "mode"	"HI")
    (set_attr_alternative "length"
 		[(const_int 4)
@@ -3839,6 +3863,7 @@ (define_insn "*movhi_mips16"
 			       (const_int 8)
 			       (const_int 12))
 		 (const_string "*")
+		 (const_string "*")
 		 (const_string "*")])])
 
 
@@ -3847,13 +3872,10 @@ (define_insn "*movhi_mips16"
 ;; load are 2 2 byte instructions.
 
 (define_split
-  [(set (match_operand:HI 0 "register_operand")
+  [(set (match_operand:HI 0 "d_operand")
 	(mem:HI (plus:SI (match_dup 0)
 			 (match_operand:SI 1 "const_int_operand"))))]
   "TARGET_MIPS16 && reload_completed && !TARGET_DEBUG_D_MODE
-   && REG_P (operands[0])
-   && M16_REG_P (REGNO (operands[0]))
-   && GET_CODE (operands[1]) == CONST_INT
    && ((INTVAL (operands[1]) < 0
 	&& INTVAL (operands[1]) >= -0x80)
        || (INTVAL (operands[1]) >= 32 * 2
@@ -3901,51 +3923,36 @@ (define_expand "movqi"
 })
 
 (define_insn "*movqi_internal"
-  [(set (match_operand:QI 0 "nonimmediate_operand" "=d,d,d,m,*x")
-	(match_operand:QI 1 "move_operand"         "d,I,m,dJ,*d"))]
+  [(set (match_operand:QI 0 "nonimmediate_operand" "=d,d,d,m,*a,*d")
+	(match_operand:QI 1 "move_operand"         "d,I,m,dJ,*d*J,*a"))]
   "!TARGET_MIPS16
    && (register_operand (operands[0], QImode)
        || reg_or_0_operand (operands[1], QImode))"
-  "@
-    move\t%0,%1
-    li\t%0,%1
-    lbu\t%0,%1
-    sb\t%z1,%0
-    mt%0\t%1"
-  [(set_attr "type"	"move,arith,load,store,mthilo")
+  { return mips_output_move (operands[0], operands[1]); }
+  [(set_attr "type"	"move,arith,load,store,mthilo,mfhilo")
    (set_attr "mode"	"QI")
-   (set_attr "length"	"4,4,*,*,4")])
+   (set_attr "length"	"4,4,*,*,4,4")])
 
 (define_insn "*movqi_mips16"
-  [(set (match_operand:QI 0 "nonimmediate_operand" "=d,y,d,d,d,d,m")
-	(match_operand:QI 1 "move_operand"         "d,d,y,K,N,m,d"))]
+  [(set (match_operand:QI 0 "nonimmediate_operand" "=d,y,d,d,d,d,m,*d")
+	(match_operand:QI 1 "move_operand"         "d,d,y,K,N,m,d,*a"))]
   "TARGET_MIPS16
    && (register_operand (operands[0], QImode)
        || register_operand (operands[1], QImode))"
-  "@
-    move\t%0,%1
-    move\t%0,%1
-    move\t%0,%1
-    li\t%0,%1
-    #
-    lbu\t%0,%1
-    sb\t%1,%0"
-  [(set_attr "type"	"move,move,move,arith,arith,load,store")
+  { return mips_output_move (operands[0], operands[1]); }
+  [(set_attr "type"	"move,move,move,arith,arith,load,store,mfhilo")
    (set_attr "mode"	"QI")
-   (set_attr "length"	"4,4,4,4,8,*,*")])
+   (set_attr "length"	"4,4,4,4,8,*,*,4")])
 
 ;; On the mips16, we can split lb $r,N($r) into an add and a load,
 ;; when the original load is a 4 byte instruction but the add and the
 ;; load are 2 2 byte instructions.
 
 (define_split
-  [(set (match_operand:QI 0 "register_operand")
+  [(set (match_operand:QI 0 "d_operand")
 	(mem:QI (plus:SI (match_dup 0)
 			 (match_operand:SI 1 "const_int_operand"))))]
   "TARGET_MIPS16 && reload_completed && !TARGET_DEBUG_D_MODE
-   && REG_P (operands[0])
-   && M16_REG_P (REGNO (operands[0]))
-   && GET_CODE (operands[1]) == CONST_INT
    && ((INTVAL (operands[1]) < 0
 	&& INTVAL (operands[1]) >= -0x80)
        || (INTVAL (operands[1]) >= 32
@@ -4065,6 +4072,39 @@ (define_insn "*movdf_mips16"
    (set_attr "mode"	"DF")
    (set_attr "length"	"8,8,8,*,*")])
 
+;; 128-bit integer moves
+
+(define_expand "movti"
+  [(set (match_operand:TI 0)
+	(match_operand:TI 1))]
+  "TARGET_64BIT"
+{
+  if (mips_legitimize_move (TImode, operands[0], operands[1]))
+    DONE;
+})
+
+(define_insn "*movti"
+  [(set (match_operand:TI 0 "nonimmediate_operand" "=d,d,m,*a,*d")
+	(match_operand:TI 1 "move_operand" "di,m,dJ,*d*J,*a"))]
+  "TARGET_64BIT
+   && !TARGET_MIPS16
+   && (register_operand (operands[0], TImode)
+       || reg_or_0_operand (operands[1], TImode))"
+  "#"
+  [(set_attr "type" "multi,load,store,multi,multi")
+   (set_attr "length" "8,*,*,8,8")])
+
+(define_insn "*movti_mips16"
+  [(set (match_operand:TI 0 "nonimmediate_operand" "=d,y,d,d,d,d,m,*d")
+	(match_operand:TI 1 "move_operand" "d,d,y,K,N,m,d,*a"))]
+  "TARGET_64BIT
+   && TARGET_MIPS16
+   && (register_operand (operands[0], TImode)
+       || register_operand (operands[1], TImode))"
+  "#"
+  [(set_attr "type" "multi,multi,multi,multi,multi,load,store,multi")
+   (set_attr "length" "8,8,8,12,16,*,*,8")])
+
 ;; 128-bit floating point moves
 
 (define_expand "movtf"
@@ -4123,7 +4163,7 @@ (define_split
 ;; When generating mips16 code, split moves of negative constants into
 ;; a positive "li" followed by a negation.
 (define_split
-  [(set (match_operand 0 "register_operand")
+  [(set (match_operand 0 "d_operand")
 	(match_operand 1 "const_int_operand"))]
   "TARGET_MIPS16 && reload_completed && INTVAL (operands[1]) < 0"
   [(set (match_dup 2)
@@ -4172,44 +4212,33 @@ (define_insn "movv2sf_hardfloat_32bit"
    (set_attr "mode" "SF")
    (set_attr "length" "4,8,*,*,*,8,8,8,*,*")])
 
-;; The HI and LO registers are not truly independent.  If we move an mthi
-;; instruction before an mflo instruction, it will make the result of the
-;; mflo unpredictable.  The same goes for mtlo and mfhi.
-;;
-;; We cope with this by making the mflo and mfhi patterns use both HI and LO.
-;; Operand 1 is the register we want, operand 2 is the other one.
-;;
-;; When generating VR4120 or VR4130 code, we use macc{,hi} and
-;; dmacc{,hi} instead of mfhi and mflo.  This avoids both the normal
-;; MIPS III hi/lo hazards and the errata related to -mfix-vr4130.
-
-(define_expand "mfhilo_<mode>"
-  [(set (match_operand:GPR 0 "register_operand")
-	(unspec:GPR [(match_operand:GPR 1 "register_operand")
-		     (match_operand:GPR 2 "register_operand")]
-		    UNSPEC_MFHILO))])
-
-(define_insn "*mfhilo_<mode>"
-  [(set (match_operand:GPR 0 "register_operand" "=d,d")
-	(unspec:GPR [(match_operand:GPR 1 "register_operand" "h,l")
-		     (match_operand:GPR 2 "register_operand" "l,h")]
-		    UNSPEC_MFHILO))]
-  "!ISA_HAS_MACCHI"
-  "mf%1\t%0"
+;; Extract the high part of a HI/LO value.  See mips_hard_regno_mode_ok_p
+;; for the reason why we can't just use (reg:GPR HI_REGNUM).
+;;
+;; When generating VR4120 or VR4130 code, we use MACCHI and DMACCHI
+;; instead of MFHI.  This avoids both the normal MIPS III hi/lo hazards
+;; and the errata related to -mfix-vr4130.
+(define_insn "mfhi<GPR:mode>_<HILO:mode>"
+  [(set (match_operand:GPR 0 "register_operand" "=d")
+	(unspec:GPR [(match_operand:HILO 1 "register_operand" "x")]
+		    UNSPEC_MFHI))]
+  ""
+  { return ISA_HAS_MACCHI ? "<GPR:d>macchi\t%0,%.,%." : "mfhi\t%0"; }
   [(set_attr "type" "mfhilo")
-   (set_attr "mode" "<MODE>")])
+   (set_attr "mode" "<GPR:MODE>")])
 
-(define_insn "*mfhilo_<mode>_macc"
-  [(set (match_operand:GPR 0 "register_operand" "=d,d")
-	(unspec:GPR [(match_operand:GPR 1 "register_operand" "h,l")
-		     (match_operand:GPR 2 "register_operand" "l,h")]
-		    UNSPEC_MFHILO))]
-  "ISA_HAS_MACCHI"
-  "@
-   <d>macchi\t%0,%.,%.
-   <d>macc\t%0,%.,%."
-  [(set_attr "type" "mfhilo")
-   (set_attr "mode" "<MODE>")])
+;; Set the high part of a HI/LO value, given that the low part has
+;; already been set.  See mips_hard_regno_mode_ok_p for the reason
+;; why we can't just use (reg:GPR HI_REGNUM).
+(define_insn "mthi<GPR:mode>_<HILO:mode>"
+  [(set (match_operand:HILO 0 "register_operand" "=x")
+	(unspec:HILO [(match_operand:GPR 1 "reg_or_0_operand" "dJ")
+		      (match_operand:GPR 2 "register_operand" "l")]
+		     UNSPEC_MTHI))]
+  ""
+  "mthi\t%z1"
+  [(set_attr "type" "mthilo")
+   (set_attr "mode" "SI")])
 
 ;; Emit a doubleword move in which exactly one of the operands is
 ;; a floating-point register.  We can't just emit two normal moves
@@ -5120,11 +5149,10 @@ (define_insn "*lshrdi3_mips16"
 ;; On the mips16, we can split a 4 byte shift into 2 2 byte shifts.
 
 (define_split
-  [(set (match_operand:GPR 0 "register_operand")
-	(any_shift:GPR (match_operand:GPR 1 "register_operand")
+  [(set (match_operand:GPR 0 "d_operand")
+	(any_shift:GPR (match_operand:GPR 1 "d_operand")
 		       (match_operand:GPR 2 "const_int_operand")))]
   "TARGET_MIPS16 && reload_completed && !TARGET_DEBUG_D_MODE
-   && GET_CODE (operands[2]) == CONST_INT
    && INTVAL (operands[2]) > 8
    && INTVAL (operands[2]) <= 16"
   [(set (match_dup 0) (any_shift:GPR (match_dup 1) (const_int 8)))
Index: gcc/config/mips/predicates.md
===================================================================
--- gcc/config/mips/predicates.md	2008-06-09 21:42:44.000000000 +0100
+++ gcc/config/mips/predicates.md	2008-06-09 21:45:18.000000000 +0100
@@ -76,9 +76,11 @@ (define_predicate "const_0_or_1_operand"
        (ior (match_test "op == CONST0_RTX (GET_MODE (op))")
 	    (match_test "op == CONST1_RTX (GET_MODE (op))"))))
 
-(define_predicate "fpr_operand"
+(define_predicate "d_operand"
   (and (match_code "reg")
-       (match_test "FP_REG_P (REGNO (op))")))
+       (match_test "TARGET_MIPS16
+		    ? M16_REG_P (REGNO (op))
+		    : GP_REG_P (REGNO (op))")))
 
 (define_predicate "lo_operand"
   (and (match_code "reg")
Index: gcc/testsuite/gcc.dg/torture/mips-hilo-1.c
===================================================================
--- gcc/testsuite/gcc.dg/torture/mips-hilo-1.c	2008-06-09 21:42:44.000000000 +0100
+++ /dev/null	2008-06-08 10:32:14.544096500 +0100
@@ -1,73 +0,0 @@
-/* f1 checks that an mtlo is not moved before an mfhi.  f2 does the same
-   for an mthi and an mflo.  */
-/* { dg-do run { target mips*-*-* } } */
-/* { dg-options "-mtune=rm7000" } */
-
-extern void abort (void);
-extern void exit (int);
-
-#define DECLARE(TYPE)							\
-  TYPE __attribute__ ((noinline)) __attribute__ ((nomips16))		\
-  f1##TYPE (TYPE x1, TYPE x2, TYPE x3)					\
-  {									\
-    TYPE t1, t2;							\
-									\
-    asm ("mult\t%1,%2" : "=h" (t1) : "d" (x1), "d" (x2) : "lo");	\
-    asm ("mflo\t%0" : "=r" (t2) : "l" (x3) : "hi");			\
-    return t1 + t2;							\
-  }									\
-									\
-  TYPE __attribute__ ((noinline)) __attribute__ ((nomips16))		\
-  f2##TYPE (TYPE x1, TYPE x2, TYPE x3)					\
-  {									\
-    TYPE t1, t2;							\
-									\
-    asm ("mult\t%1,%2" : "=l" (t1) : "d" (x1), "d" (x2) : "hi");	\
-    asm ("mfhi\t%0" : "=r" (t2) : "h" (x3) : "lo");			\
-    return t1 + t2;							\
-  }
-
-#define TEST(TYPE)							\
-  if (f1##TYPE (1, 2, 10) != 10)					\
-    abort ();								\
-  if (f2##TYPE (1, 2, 40) != 42)					\
-    abort ()
-
-typedef char c;
-typedef signed char sc;
-typedef unsigned char uc;
-typedef short s;
-typedef unsigned short us;
-typedef int i;
-typedef unsigned int ui;
-typedef long long ll;
-typedef unsigned long long ull;
-
-DECLARE (c)
-DECLARE (sc)
-DECLARE (uc)
-DECLARE (s)
-DECLARE (us)
-DECLARE (i)
-DECLARE (ui)
-#if defined (__mips64)
-DECLARE (ll)
-DECLARE (ull)
-#endif
-
-int
-main ()
-{
-  TEST (c);
-  TEST (sc);
-  TEST (uc);
-  TEST (s);
-  TEST (us);
-  TEST (i);
-  TEST (ui);
-#if defined (__mips64)
-  TEST (ll);
-  TEST (ull);
-#endif
-  exit (0);
-}
Index: gcc/testsuite/gcc.target/mips/pr35232.c
===================================================================
--- gcc/testsuite/gcc.target/mips/pr35232.c	2008-06-09 21:42:44.000000000 +0100
+++ /dev/null	2008-06-08 10:32:14.544096500 +0100
@@ -1,17 +0,0 @@
-/* { dg-do run } */
-/* { dg-mips-options "-O" } */
-
-NOMIPS16 unsigned int
-f1 (unsigned long long x)
-{
-  unsigned int r;
-  asm ("# %0" : "=a" (r) : "0" (x));
-  asm ("# %0" : "=h" (r) : "0" (r));
-  return r;
-}
-
-int
-main (void)
-{
-  return f1 (4) != 4;
-}
Index: gcc/testsuite/gcc.target/mips/fix-vr4130-1.c
===================================================================
--- gcc/testsuite/gcc.target/mips/fix-vr4130-1.c	2008-06-09 21:42:44.000000000 +0100
+++ gcc/testsuite/gcc.target/mips/fix-vr4130-1.c	2008-06-09 21:45:18.000000000 +0100
@@ -1,4 +1,8 @@
 /* { dg-do compile } */
 /* { dg-mips-options "-march=vr4130 -mfix-vr4130" } */
-NOMIPS16 int foo (void) { int r; asm ("# foo" : "=h" (r)); return r; }
+NOMIPS16 unsigned int
+foo (unsigned int x, unsigned int y)
+{
+  return x % y;
+}
 /* { dg-final { scan-assembler "\tmacchi\t" } } */
Index: gcc/testsuite/gcc.target/mips/fix-vr4130-3.c
===================================================================
--- gcc/testsuite/gcc.target/mips/fix-vr4130-3.c	2008-06-09 21:42:44.000000000 +0100
+++ gcc/testsuite/gcc.target/mips/fix-vr4130-3.c	2008-06-09 21:45:18.000000000 +0100
@@ -1,10 +1,8 @@
 /* { dg-do compile } */
 /* { dg-mips-options "-march=vr4130 -mgp64 -mfix-vr4130" } */
-NOMIPS16 long long
-foo (void)
+NOMIPS16 unsigned long long
+foo (unsigned long long x, unsigned long long y)
 {
-  long long r;
-  asm ("# foo" : "=h" (r));
-  return r;
+  return x % y;
 }
 /* { dg-final { scan-assembler "\tdmacchi\t" } } */
Index: gcc/testsuite/gcc.target/mips/int-moves-1.c
===================================================================
--- /dev/null	2008-06-08 10:32:14.544096500 +0100
+++ gcc/testsuite/gcc.target/mips/int-moves-1.c	2008-06-09 21:45:18.000000000 +0100
@@ -0,0 +1,40 @@
+/* { dg-do compile { target mips16_attribute } } */
+/* { dg-mips-options "-mgp64 -msoft-float -O2 -EL" } */
+/* { dg-add-options mips16_attribute } */
+
+typedef unsigned uint128_t __attribute__((mode(TI)));
+
+extern uint128_t g[16];
+extern unsigned char gstuff[0x10000];
+
+NOMIPS16 uint128_t
+foo (uint128_t i1, uint128_t i2, uint128_t i3, uint128_t i4,
+     uint128_t *x, unsigned char *lstuff)
+{
+  g[0] = i1;
+  g[1] = i2;
+  g[2] = i3;
+  g[3] = i4;
+  x[0] = x[4];
+  x[1] = 0;
+  x[2] = ((uint128_t) 0x123456789abcdefULL << 64) | 0xaabbccddeeff1122ULL;
+  x[3] = g[4];
+  x[4] = *(uint128_t *) (lstuff + 0x7fff);
+  return *(uint128_t *) (gstuff + 0x7fff);
+}
+
+MIPS16 uint128_t
+bar (uint128_t i1, uint128_t i2, uint128_t i3, uint128_t i4,
+     uint128_t *x, unsigned char *lstuff)
+{
+  g[0] = i1;
+  g[1] = i2;
+  g[2] = i3;
+  g[3] = i4;
+  x[0] = x[4];
+  x[1] = 0;
+  x[2] = ((uint128_t) 0x123456789abcdefULL << 64) | 0xaabbccddeeff1122ULL;
+  x[3] = g[4];
+  x[4] = *(uint128_t *) (lstuff + 0x7fff);
+  return *(uint128_t *) (gstuff + 0x7fff);
+}
Index: gcc/testsuite/gcc.target/mips/int-moves-2.c
===================================================================
--- /dev/null	2008-06-08 10:32:14.544096500 +0100
+++ gcc/testsuite/gcc.target/mips/int-moves-2.c	2008-06-09 21:45:18.000000000 +0100
@@ -0,0 +1,40 @@
+/* { dg-do compile { target mips16_attribute } } */
+/* { dg-mips-options "-mgp64 -msoft-float -O2 -EB" } */
+/* { dg-add-options mips16_attribute } */
+
+typedef unsigned uint128_t __attribute__((mode(TI)));
+
+extern uint128_t g[16];
+extern unsigned char gstuff[0x10000];
+
+NOMIPS16 uint128_t
+foo (uint128_t i1, uint128_t i2, uint128_t i3, uint128_t i4,
+     uint128_t *x, unsigned char *lstuff)
+{
+  g[0] = i1;
+  g[1] = i2;
+  g[2] = i3;
+  g[3] = i4;
+  x[0] = x[4];
+  x[1] = 0;
+  x[2] = ((uint128_t) 0x123456789abcdefULL << 64) | 0xaabbccddeeff1122ULL;
+  x[3] = g[4];
+  x[4] = *(uint128_t *) (lstuff + 0x7fff);
+  return *(uint128_t *) (gstuff + 0x7fff);
+}
+
+MIPS16 uint128_t
+bar (uint128_t i1, uint128_t i2, uint128_t i3, uint128_t i4,
+     uint128_t *x, unsigned char *lstuff)
+{
+  g[0] = i1;
+  g[1] = i2;
+  g[2] = i3;
+  g[3] = i4;
+  x[0] = x[4];
+  x[1] = 0;
+  x[2] = ((uint128_t) 0x123456789abcdefULL << 64) | 0xaabbccddeeff1122ULL;
+  x[3] = g[4];
+  x[4] = *(uint128_t *) (lstuff + 0x7fff);
+  return *(uint128_t *) (gstuff + 0x7fff);
+}
Index: gcc/testsuite/gcc.target/mips/fix-r4000-1.c
===================================================================
--- /dev/null	2008-06-08 10:32:14.544096500 +0100
+++ gcc/testsuite/gcc.target/mips/fix-r4000-1.c	2008-06-09 21:45:18.000000000 +0100
@@ -0,0 +1,6 @@
+/* { dg-mips-options "-march=r4000 -mfix-r4000 -O2 -dp" } */
+typedef int int32_t;
+typedef int uint32_t;
+int32_t foo (int32_t x, int32_t y) { return x * y; }
+uint32_t bar (uint32_t x, uint32_t y) { return x * y; }
+/* { dg-final { scan-assembler-times "[concat {\tmult\t\$[45],\$[45][^\n]+mulsi3_r4000[^\n]+\n\tmflo\t\$2\n}]" 2 } } */
Index: gcc/testsuite/gcc.target/mips/fix-r4000-2.c
===================================================================
--- /dev/null	2008-06-08 10:32:14.544096500 +0100
+++ gcc/testsuite/gcc.target/mips/fix-r4000-2.c	2008-06-09 21:45:18.000000000 +0100
@@ -0,0 +1,7 @@
+/* { dg-mips-options "-mips1 -mfix-r4000 -O2 -dp -EB" } */
+typedef int int32_t;
+typedef long long int64_t;
+int32_t foo (int32_t x, int32_t y) { return ((int64_t) x * y) >> 32; }
+/* ??? A highpart pattern would be a better choice, but we currently
+   don't use them.  */
+/* { dg-final { scan-assembler "[concat {\tmult\t\$[45],\$[45][^\n]+mulsidi3_32bit_r4000[^\n]+\n\tmflo\t\$3\n\tmfhi\t\$2\n}]" } } */
Index: gcc/testsuite/gcc.target/mips/fix-r4000-3.c
===================================================================
--- /dev/null	2008-06-08 10:32:14.544096500 +0100
+++ gcc/testsuite/gcc.target/mips/fix-r4000-3.c	2008-06-09 21:45:18.000000000 +0100
@@ -0,0 +1,7 @@
+/* { dg-mips-options "-mips1 -mfix-r4000 -O2 -dp -EB" } */
+typedef unsigned int uint32_t;
+typedef unsigned long long uint64_t;
+uint32_t foo (uint32_t x, uint32_t y) { return ((uint64_t) x * y) >> 32; }
+/* ??? A highpart pattern would be a better choice, but we currently
+   don't use them.  */
+/* { dg-final { scan-assembler "[concat {\tmultu\t\$[45],\$[45][^\n]+umulsidi3_32bit_r4000[^\n]+\n\tmflo\t\$3\n\tmfhi\t\$2\n}]" } } */
Index: gcc/testsuite/gcc.target/mips/fix-r4000-4.c
===================================================================
--- /dev/null	2008-06-08 10:32:14.544096500 +0100
+++ gcc/testsuite/gcc.target/mips/fix-r4000-4.c	2008-06-09 21:45:18.000000000 +0100
@@ -0,0 +1,8 @@
+/* ??? At the moment, lower-subreg.c decomposes the copy of the multiplication
+   result to $2, which prevents the register allocators from storing the
+   multiplication result in $2.  */
+/* { dg-mips-options "-mips1 -mfix-r4000 -O2 -fno-split-wide-types -dp -EL" } */
+typedef int int32_t;
+typedef long long int64_t;
+int64_t foo (int32_t x, int32_t y) { return (int64_t) x * y; }
+/* { dg-final { scan-assembler "[concat {\tmult\t\$[45],\$[45][^\n]+mulsidi3_32bit_r4000[^\n]+\n\tmflo\t\$2\n\tmfhi\t\$3\n}]" } } */
Index: gcc/testsuite/gcc.target/mips/fix-r4000-5.c
===================================================================
--- /dev/null	2008-06-08 10:32:14.544096500 +0100
+++ gcc/testsuite/gcc.target/mips/fix-r4000-5.c	2008-06-09 21:45:18.000000000 +0100
@@ -0,0 +1,8 @@
+/* ??? At the moment, lower-subreg.c decomposes the copy of the multiplication
+   result to $2, which prevents the register allocators from storing the
+   multiplication result in $2.  */
+/* { dg-mips-options "-mips1 -mfix-r4000 -O2 -fno-split-wide-types -dp -EL" } */
+typedef unsigned int uint32_t;
+typedef unsigned long long uint64_t;
+uint64_t foo (uint32_t x, uint32_t y) { return (uint64_t) x * y; }
+/* { dg-final { scan-assembler "[concat {\tmultu\t\$[45],\$[45][^\n]+umulsidi3_32bit_r4000[^\n]+\n\tmflo\t\$2\n\tmfhi\t\$3\n}]" } } */
Index: gcc/testsuite/gcc.target/mips/fix-r4000-6.c
===================================================================
--- /dev/null	2008-06-08 10:32:14.544096500 +0100
+++ gcc/testsuite/gcc.target/mips/fix-r4000-6.c	2008-06-09 21:45:18.000000000 +0100
@@ -0,0 +1,6 @@
+/* { dg-mips-options "-march=r4000 -mfix-r4000 -mgp64 -O2 -dp" } */
+typedef long long int64_t;
+typedef unsigned long long uint64_t;
+int64_t foo (int64_t x, int64_t y) { return x * y; }
+uint64_t bar (uint64_t x, uint64_t y) { return x * y; }
+/* { dg-final { scan-assembler-times "[concat {\tdmult\t\$[45],\$[45][^\n]+muldi3_r4000[^\n]+\n\tmflo\t\$2\n}]" 2 } } */
Index: gcc/testsuite/gcc.target/mips/fix-r4000-7.c
===================================================================
--- /dev/null	2008-06-08 10:32:14.544096500 +0100
+++ gcc/testsuite/gcc.target/mips/fix-r4000-7.c	2008-06-09 21:45:18.000000000 +0100
@@ -0,0 +1,7 @@
+/* { dg-mips-options "-march=r4000 -mfix-r4000 -O2 -mgp64 -dp -EB" } */
+typedef long long int64_t;
+typedef int int128_t __attribute__((mode(TI)));
+int64_t foo (int64_t x, int64_t y) { return ((int128_t) x * y) >> 64; }
+/* ??? A highpart pattern would be a better choice, but we currently
+   don't use them.  */
+/* { dg-final { scan-assembler "[concat {\tdmult\t\$[45],\$[45][^\n]+mulditi3[^\n]+\n\tmflo\t\$3\n\tmfhi\t\$2\n}]" } } */
Index: gcc/testsuite/gcc.target/mips/fix-r4000-8.c
===================================================================
--- /dev/null	2008-06-08 10:32:14.544096500 +0100
+++ gcc/testsuite/gcc.target/mips/fix-r4000-8.c	2008-06-09 21:45:18.000000000 +0100
@@ -0,0 +1,7 @@
+/* { dg-mips-options "-march=r4000 -mfix-r4000 -O2 -mgp64 -dp -EB" } */
+typedef unsigned long long uint64_t;
+typedef unsigned int uint128_t __attribute__((mode(TI)));
+uint64_t foo (uint64_t x, uint64_t y) { return ((uint128_t) x * y) >> 64; }
+/* ??? A highpart pattern would be a better choice, but we currently
+   don't use them.  */
+/* { dg-final { scan-assembler "[concat {\tdmultu\t\$[45],\$[45][^\n]+umulditi3[^\n]+\n\tmflo\t\$3\n\tmfhi\t\$2\n}]" } } */
Index: gcc/testsuite/gcc.target/mips/fix-r4000-9.c
===================================================================
--- /dev/null	2008-06-08 10:32:14.544096500 +0100
+++ gcc/testsuite/gcc.target/mips/fix-r4000-9.c	2008-06-09 21:45:18.000000000 +0100
@@ -0,0 +1,8 @@
+/* ??? At the moment, lower-subreg.c decomposes the copy of the multiplication
+   result to $2, which prevents the register allocators from storing the
+   multiplication result in $2.  */
+/* { dg-mips-options "-mips3 -mfix-r4000 -mgp64 -O2 -fno-split-wide-types -dp -EL" } */
+typedef long long int64_t;
+typedef int int128_t __attribute__((mode(TI)));
+int128_t foo (int64_t x, int64_t y) { return (int128_t) x * y; }
+/* { dg-final { scan-assembler "[concat {\tdmult\t\$[45],\$[45][^\n]+mulditi3_r4000[^\n]+\n\tmflo\t\$2\n\tmfhi\t\$3\n}]" } } */
Index: gcc/testsuite/gcc.target/mips/fix-r4000-10.c
===================================================================
--- /dev/null	2008-06-08 10:32:14.544096500 +0100
+++ gcc/testsuite/gcc.target/mips/fix-r4000-10.c	2008-06-09 21:45:18.000000000 +0100
@@ -0,0 +1,8 @@
+/* ??? At the moment, lower-subreg.c decomposes the copy of the multiplication
+   result to $2, which prevents the register allocators from storing the
+   multiplication result in $2.  */
+/* { dg-mips-options "-mips3 -mfix-r4000 -mgp64 -O2 -fno-split-wide-types -dp -EL" } */
+typedef unsigned long long uint64_t;
+typedef unsigned int uint128_t __attribute__((mode(TI)));
+uint128_t foo (uint64_t x, uint64_t y) { return (uint128_t) x * y; }
+/* { dg-final { scan-assembler "[concat {\tdmultu\t\$[45],\$[45][^\n]+umulditi3_r4000[^\n]+\n\tmflo\t\$2\n\tmfhi\t\$3\n}]" } } */
Index: gcc/testsuite/gcc.target/mips/fix-r4000-11.c
===================================================================
--- /dev/null	2008-06-08 10:32:14.544096500 +0100
+++ gcc/testsuite/gcc.target/mips/fix-r4000-11.c	2008-06-09 21:45:18.000000000 +0100
@@ -0,0 +1,4 @@
+/* { dg-mips-options "-march=r4000 -mfix-r4000 -mgp64 -O2 -dp" } */
+typedef long long int64_t;
+int64_t foo (int64_t x) { return x / 11993; }
+/* { dg-final { scan-assembler "[concat {\tdmult\t\$4,\$[0-9]+[^\n]+smuldi3_highpart[^\n]+\n\tmfhi\t\$[0-9]+\n}]" } } */
Index: gcc/testsuite/gcc.target/mips/fix-r4000-12.c
===================================================================
--- /dev/null	2008-06-08 10:32:14.544096500 +0100
+++ gcc/testsuite/gcc.target/mips/fix-r4000-12.c	2008-06-09 21:45:18.000000000 +0100
@@ -0,0 +1,4 @@
+/* { dg-mips-options "-march=r4000 -mfix-r4000 -mgp64 -O2 -dp" } */
+typedef unsigned long long uint64_t;
+uint64_t foo (uint64_t x) { return x / 11993; }
+/* { dg-final { scan-assembler "[concat {\tdmultu\t\$4,\$[0-9]+[^\n]+umuldi3_highpart[^\n]+\n\tmfhi\t\$[0-9]+\n}]" } } */
Index: gcc/testsuite/gcc.target/mips/timode-1.c
===================================================================
--- /dev/null	2008-06-08 10:32:14.544096500 +0100
+++ gcc/testsuite/gcc.target/mips/timode-1.c	2008-06-09 21:45:18.000000000 +0100
@@ -0,0 +1,65 @@
+/* { dg-mips-options "-mgp64" } */
+typedef int int128_t __attribute__((mode(TI)));
+typedef unsigned int uint128_t __attribute__((mode(TI)));
+
+#define UINT128_CONST(A, B) \
+  (((uint128_t) (0x ## A ## ULL) << 64) | (0x ## B ## ULL))
+
+volatile uint128_t a = UINT128_CONST (1111111111111111, a222222222222222);
+volatile uint128_t b = UINT128_CONST (0000000000000005, 0000000000000003);
+volatile uint128_t c = UINT128_CONST (5dddddddddddddde, e666666666666666);
+volatile uint128_t d = UINT128_CONST (e612340000000000, 5000000000234500);
+volatile uint128_t e = UINT128_CONST (43f011dddddddddf, 366666666689ab66);
+volatile uint128_t f = UINT128_CONST (4210100000000000, 1000000000010100);
+volatile uint128_t g = UINT128_CONST (a5e225dddddddddf, 6666666666aaee66);
+volatile uint128_t h = UINT128_CONST (e7f235dddddddddf, 7666666666abef66);
+volatile uint128_t i = UINT128_CONST (5e225dddddddddf6, 666666666aaee660);
+volatile uint128_t j = UINT128_CONST (0a5e225ddddddddd, f6666666666aaee6);
+volatile uint128_t k = UINT128_CONST (fa5e225ddddddddd, f6666666666aaee6);
+
+volatile int amount = 4;
+
+volatile uint128_t result;
+
+int
+main (void)
+{
+  result = a * b;
+  if (result != c)
+    return 1;
+
+  result = c + d;
+  if (result != e)
+    return 1;
+
+  result = e - d;
+  if (result != c)
+    return 1;
+
+  result = d & e;
+  if (result != f)
+    return 1;
+
+  result = d ^ e;
+  if (result != g)
+    return 1;
+
+  result = d | e;
+  if (result != h)
+    return 1;
+
+  result = g << amount;
+  if (result != i)
+    return 1;
+
+  result = g >> amount;
+  if (result != j)
+    return 1;
+
+  result = (int128_t) g >> amount;
+  if (result != k)
+    return 1;
+
+  return 0;
+}
+/* { dg-final { scan-assembler-not "\tjal" } } */
Index: gcc/testsuite/gcc.target/mips/timode-2.c
===================================================================
--- /dev/null	2008-06-08 10:32:14.544096500 +0100
+++ gcc/testsuite/gcc.target/mips/timode-2.c	2008-06-09 21:45:18.000000000 +0100
@@ -0,0 +1,64 @@
+/* { dg-do run { target mips64 } } */
+typedef int int128_t __attribute__((mode(TI)));
+typedef unsigned int uint128_t __attribute__((mode(TI)));
+
+#define UINT128_CONST(A, B) \
+  (((uint128_t) (0x ## A ## ULL) << 64) | (0x ## B ## ULL))
+
+volatile uint128_t a = UINT128_CONST (1111111111111111, a222222222222222);
+volatile uint128_t b = UINT128_CONST (0000000000000005, 0000000000000003);
+volatile uint128_t c = UINT128_CONST (5dddddddddddddde, e666666666666666);
+volatile uint128_t d = UINT128_CONST (e612340000000000, 5000000000234500);
+volatile uint128_t e = UINT128_CONST (43f011dddddddddf, 366666666689ab66);
+volatile uint128_t f = UINT128_CONST (4210100000000000, 1000000000010100);
+volatile uint128_t g = UINT128_CONST (a5e225dddddddddf, 6666666666aaee66);
+volatile uint128_t h = UINT128_CONST (e7f235dddddddddf, 7666666666abef66);
+volatile uint128_t i = UINT128_CONST (5e225dddddddddf6, 666666666aaee660);
+volatile uint128_t j = UINT128_CONST (0a5e225ddddddddd, f6666666666aaee6);
+volatile uint128_t k = UINT128_CONST (fa5e225ddddddddd, f6666666666aaee6);
+
+volatile int amount = 4;
+
+volatile uint128_t result;
+
+int
+main (void)
+{
+  result = a * b;
+  if (result != c)
+    return 1;
+
+  result = c + d;
+  if (result != e)
+    return 1;
+
+  result = e - d;
+  if (result != c)
+    return 1;
+
+  result = d & e;
+  if (result != f)
+    return 1;
+
+  result = d ^ e;
+  if (result != g)
+    return 1;
+
+  result = d | e;
+  if (result != h)
+    return 1;
+
+  result = g << amount;
+  if (result != i)
+    return 1;
+
+  result = g >> amount;
+  if (result != j)
+    return 1;
+
+  result = (int128_t) g >> amount;
+  if (result != k)
+    return 1;
+
+  return 0;
+}
