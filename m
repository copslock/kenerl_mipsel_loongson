Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Aug 2004 20:02:01 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:9186 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8224920AbUHGTBz>;
	Sat, 7 Aug 2004 20:01:55 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i77J1me1005484;
	Sat, 7 Aug 2004 15:01:48 -0400
Received: from localhost (mail@vpnuser2.surrey.redhat.com [172.16.9.2])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i77J1ja28505;
	Sat, 7 Aug 2004 15:01:45 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1BtWRr-0000Km-00; Sat, 07 Aug 2004 20:01:43 +0100
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
References: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl>
	<87hds49bmo.fsf@redhat.com>
	<Pine.LNX.4.55.0407191907300.3667@jurand.ds.pg.gda.pl>
	<20040719213801.GD14931@redhat.com>
	<Pine.LNX.4.55.0407201505330.14824@jurand.ds.pg.gda.pl>
	<20040723202703.GB30931@redhat.com>
	<20040723211232.GB5138@linux-mips.org>
	<Pine.LNX.4.58L.0407261325470.3873@blysk.ds.pg.gda.pl>
	<410E9E25.7080104@mips.com> <87acxcbxfl.fsf@redhat.com>
	<410F5964.3010109@mips.com> <876580bm2e.fsf@redhat.com>
	<410F60DF.9020400@mips.com>
	<Pine.LNX.4.58L.0408042123030.31930@blysk.ds.pg.gda.pl>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Sat, 07 Aug 2004 20:01:43 +0100
In-Reply-To: <Pine.LNX.4.58L.0408042123030.31930@blysk.ds.pg.gda.pl> (Maciej
 W. Rozycki's message of "Wed, 4 Aug 2004 21:57:04 +0200 (CEST)")
Message-ID: <87r7qiwz54.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

FWIW, here's a work-in-progress patch.  It takes the current
optabs handling of doubleword shifts by constants and generalises
it to handle variable shifts as well.  I've tried to take advantage
of SHIFT_COUNT_TRUNCATED where possible.

Unfortunately, I'm not sure whether the code is good enough in the
!SHIFT_COUNT_TRUNCATED case.  E.g. ARM has special asm versions of
64-bit shifts, and it takes advantage of the fact that word shifts by
32 bits or more will set the result to 0 (ashl or lshr) or -1 (ashr).
We can't do that in optabs.c since !SHIFT_COUNT_TRUNCATED dosn't mean
that shifts _aren't_ truncated, it simply means that the behaviour of
out-of-range shifts is undefined.

I've checked that the new open-coded variable shifts do work on ARM,
but perhaps they should be disabled on !SHIFT_COUNT_TRUNCATED targets,
at least for now.

Anyway, the SHIFT_COUNT_TRUNCATED version produces MIPS sequences
that are the same length as Maciej's asm versions (assuming conditional
moves are available).  They should take 5 cycles on a typical 2-way
superscalar target.

I've bootstrapped & regression tested the patch on mips-sgi-irix6.5 but
it's not really ready for approval yet.  Just posting for info & comments.

Of course, this doesn't let linux off the hook.  It still needs to define
the libgcc shift functions if it wants to support -Os compilation.

Richard


	* optabs.c (simplify_expand_binop, expand_superword_shift)
	(expand_subword_shift, expand_doubleword_shift): New functions.
	Generalize expand_binop's handling of doubleword shifts so that
	it can cope with non-constant shift amounts.
	(expand_binop): Replace said handling with expand_doubleword_shift.

Index: optabs.c
===================================================================
RCS file: /cvs/gcc/gcc/gcc/optabs.c,v
retrieving revision 1.231
diff -c -p -F^\([(a-zA-Z0-9_]\|#define\) -r1.231 optabs.c
*** optabs.c	22 Jul 2004 08:20:35 -0000	1.231
--- optabs.c	7 Aug 2004 07:14:19 -0000
*************** optab_for_tree_code (enum tree_code code
*** 709,715 ****
--- 709,981 ----
        return NULL;
      }
  }
+ 
+ /* Like expand_binop, but return a constant rtx if the result can be
+    calculated at compile time.  The arguments and return value are
+    otherwise the same as for expand_binop.  */
+ 
+ static rtx
+ simplify_expand_binop (enum machine_mode mode, optab binoptab,
+ 		       rtx op0, rtx op1, rtx target, int unsignedp,
+ 		       enum optab_methods methods)
+ {
+   if (CONSTANT_P (op0) && CONSTANT_P (op1))
+     return simplify_gen_binary (binoptab->code, mode, op0, op1);
+   else
+     return expand_binop (mode, binoptab, op0, op1, target, unsignedp, methods);
+ }
  
+ /* This subroutine of expand_doubleword_shift handles the cases in which
+    the effective shift value is >= BITS_PER_WORD.  The arguments and return
+    value are the same as for the parent routine.  */
+ 
+ static bool
+ expand_superword_shift (enum machine_mode op1_mode, optab binoptab,
+ 			rtx outof_input, rtx op1,
+ 			rtx outof_target, rtx into_target,
+ 			int unsignedp, enum optab_methods methods)
+ {
+   rtx tmp;
+ 
+   /* If shifts aren't truncated, we should shift OUTOF_INPUT by
+      (OP1 - BITS_PER_WORD) bits and store the result in INTO_TARGET.
+      If shifts are truncated, we can just shift by OP1 itself .  */
+   if (SHIFT_COUNT_TRUNCATED && !CONSTANT_P (op1))
+     tmp = op1;
+   else
+     {
+       tmp = immed_double_const (BITS_PER_WORD, 0, op1_mode);
+       tmp = simplify_expand_binop (op1_mode, sub_optab, op1, tmp,
+ 				   0, true, methods);
+       if (tmp == 0)
+ 	return false;
+     }
+   tmp = expand_binop (word_mode, binoptab, outof_input, tmp,
+ 		      into_target, unsignedp, methods);
+   if (tmp == 0)
+     return false;
+   if (tmp != into_target)
+     emit_move_insn (into_target, tmp);
+ 
+   /* For a signed right shift, we must fill OUTOF_TARGET with copies
+      of the sign bit, otherwise we must fill it with zeros.  */
+   if (binoptab != ashr_optab)
+     tmp = CONST0_RTX (word_mode);
+   else
+     {
+       tmp = expand_binop (word_mode, binoptab,
+ 			  outof_input, GEN_INT (BITS_PER_WORD - 1),
+ 			  outof_target, unsignedp, methods);
+       if (tmp == 0)
+ 	return false;
+     }
+   if (tmp != outof_target)
+     emit_move_insn (outof_target, tmp);
+ 
+   return true;
+ }
+ 
+ /* This subroutine of expand_doubleword_shift handles the cases in which
+    the effective shift value is < BITS_PER_WORD.  The arguments and return
+    value are the same as for the parent routine.  */
+ 
+ static bool
+ expand_subword_shift (enum machine_mode op1_mode, optab binoptab,
+ 		      rtx outof_input, rtx into_input, rtx op1,
+ 		      rtx outof_target, rtx into_target,
+ 		      int unsignedp, enum optab_methods methods)
+ {
+   optab reverse_unsigned_shift, unsigned_shift;
+   rtx tmp, carries;
+ 
+   reverse_unsigned_shift = (binoptab == ashl_optab ? lshr_optab : ashl_optab);
+   unsigned_shift = (binoptab == ashl_optab ? ashl_optab : lshr_optab);
+ 
+   /* The low OP1 bits of INTO_TARGET come from the high bits of OUTOF_INPUT.
+      We therefore need to shift OUTOF_INPUT by (BITS_PER_WORD - OP1) bits in
+      the opposite direction to BINOPTAB.  */
+   if (GET_CODE (op1) != CONST_INT || INTVAL (op1) == 0)
+     {
+       /* We must avoid shifting by BITS_PER_WORD bits since that is
+ 	 either the same as a zero shift (if SHIFT_COUNT_TRUNCATED)
+ 	 or has undefined RTL semantics.  Do a single shift first,
+ 	 then shift by the remainder.  It's OK to use ~OP1 as the
+ 	 remainder if shift counts are truncated.  */
+       carries = expand_binop (word_mode, reverse_unsigned_shift,
+ 			      outof_input, const1_rtx, 0, unsignedp, methods);
+       if (SHIFT_COUNT_TRUNCATED && !CONSTANT_P (op1))
+ 	{
+ 	  tmp = immed_double_const (-1, -1, op1_mode);
+ 	  tmp = simplify_expand_binop (op1_mode, xor_optab, op1, tmp,
+ 				       0, true, methods);
+ 	}
+       else
+ 	{
+ 	  tmp = immed_double_const (BITS_PER_WORD - 1, 0, op1_mode);
+ 	  tmp = simplify_expand_binop (op1_mode, sub_optab, tmp, op1,
+ 				       0, true, methods);
+ 	}
+     }
+   else
+     {
+       carries = outof_input;
+       tmp = immed_double_const (BITS_PER_WORD, 0, op1_mode);
+       tmp = simplify_expand_binop (op1_mode, sub_optab, tmp, op1,
+ 				   0, true, methods);
+     }
+   if (tmp == 0 || carries == 0)
+     return false;
+   carries = expand_binop (word_mode, reverse_unsigned_shift,
+ 			  carries, tmp, 0, unsignedp, methods);
+   if (carries == 0)
+     return false;
+ 
+   /* Shift INTO_INPUT logically by OP1 bits...  */
+   tmp = expand_binop (word_mode, unsigned_shift, into_input, op1,
+ 		      0, unsignedp, methods);
+   if (tmp == 0)
+     return false;
+ 
+   /* ...and OR in the bits carried over from OUTOF_INPUT.  */
+   tmp = expand_binop (word_mode, ior_optab, carries, tmp,
+ 		      into_target, unsignedp, methods);
+   if (tmp == 0)
+     return false;
+   if (tmp != into_target)
+     emit_move_insn (into_target, tmp);
+ 
+   /* Use a standard word_mode shift for the out-of half.  */
+   tmp = expand_binop (word_mode, binoptab, outof_input, op1,
+ 		      outof_target, unsignedp, methods);
+   if (tmp == 0)
+     return false;
+   if (tmp != outof_target)
+     emit_move_insn (outof_target, tmp);
+ 
+   return true;
+ }
+ 
+ /* Expand a doubleword shift (ashl, ashr or lshr) using word-mode shifts.
+    OUTOF_INPUT is the input word that we are shifting away from and
+    INTO_INPUT is the word that we are shifting towards.  OUTOF_TARGET
+    and INTO_TARGET specify the equivalent words of the output.  OP1 is
+    the shift amount, which has mode OP1_MODE.  BINOPTAB, UNSIGNEDP and
+    METHODS are as for expand_binop.
+ 
+    This function must not assign to OUTOF_TARGET or INTO_TARGET
+    until it has completely finished with the input operands.
+ 
+    Return true if the shift could be successfully synthesized.  */
+ 
+ static bool
+ expand_doubleword_shift (enum machine_mode op1_mode, optab binoptab,
+ 			 rtx outof_input, rtx into_input, rtx op1,
+ 			 rtx outof_target, rtx into_target,
+ 			 int unsignedp, enum optab_methods methods)
+ {
+   rtx tmp, cmp1, cmp2;
+   rtx subword_label, done_label;
+ #ifdef HAVE_conditional_move
+   rtx start, outof_superword, into_superword;
+ #endif
+   enum rtx_code cmp_code;
+ 
+   /* Set CMP_CODE, CMP1 and CMP2 so that the rtx (CMP_CODE CMP1 CMP2)
+      is true when the effective shift value is less than BITS_PER_WORD.  */
+   tmp = immed_double_const (BITS_PER_WORD, 0, op1_mode);
+   if (SHIFT_COUNT_TRUNCATED)
+     {
+       cmp1 = simplify_expand_binop (op1_mode, and_optab,
+ 				    op1, tmp, 0, true, methods);
+       cmp2 = const0_rtx;
+       cmp_code = EQ;
+       if (cmp1 == 0)
+ 	return false;
+     }
+   else
+     {
+       cmp1 = op1;
+       cmp2 = tmp;
+       cmp_code = LT;
+     }
+ 
+   /* If we can compute the condition at compile time, pick the
+      appropriate subroutine.  */
+   tmp = simplify_relational_operation (cmp_code, SImode, op1_mode, cmp1, cmp2);
+   if (tmp != 0 && GET_CODE (tmp) == CONST_INT)
+     {
+       if (tmp == const0_rtx)
+ 	return expand_superword_shift (op1_mode, binoptab,
+ 				       outof_input, op1,
+ 				       outof_target, into_target,
+ 				       unsignedp, methods);
+       else
+ 	return expand_subword_shift (op1_mode, binoptab,
+ 				     outof_input, into_input, op1,
+ 				     outof_target, into_target,
+ 				     unsignedp, methods);
+     }
+ 
+ #ifdef HAVE_conditional_move
+   /* Try using conditional moves to select between the subword and
+      superword forms.  Do the superword version first, putting the
+      result into a temporary comprised of OUTOF_SUPERWORD and
+      INTO_SUPERWORD.  Then do the subword version and store it
+      directly into the final output.
+ 
+      Note that OUTOF_TARGET and INTO_SUPERWORD are both equal to
+      (shift OUTOF_INPUT OP1) when shift counts are truncated.  */
+   outof_superword = gen_reg_rtx (word_mode);
+   into_superword = gen_reg_rtx (word_mode);
+ 
+   start = get_last_insn ();
+   if (expand_superword_shift (op1_mode, binoptab,
+ 			      outof_input, op1,
+ 			      outof_superword, into_superword,
+ 			      unsignedp, methods)
+       && expand_subword_shift (op1_mode, binoptab,
+ 			       outof_input, into_input, op1,
+ 			       outof_target, into_target,
+ 			       unsignedp, methods)
+       && emit_conditional_move (into_target, cmp_code, cmp1, cmp2, op1_mode,
+ 				into_target, (SHIFT_COUNT_TRUNCATED
+ 					      ? outof_target
+ 					      : into_superword),
+ 				word_mode, unsignedp)
+       && emit_conditional_move (outof_target, cmp_code, cmp1, cmp2, op1_mode,
+ 				outof_target, outof_superword, word_mode,
+ 				unsignedp))
+     return true;
+ 
+   delete_insns_since (start);
+ #endif
+ 
+   /* As a last resort, use branches to select the correct alternative.  */
+   subword_label = gen_label_rtx ();
+   done_label = gen_label_rtx ();
+ 
+   do_compare_rtx_and_jump (cmp1, cmp2, cmp_code, true, op1_mode,
+ 			   0, 0, subword_label);
+ 
+   if (!expand_superword_shift (op1_mode, binoptab,
+ 			       outof_input, op1,
+ 			       outof_target, into_target,
+ 			       unsignedp, methods))
+     return false;
+ 
+   emit_jump_insn (gen_jump (done_label));
+   emit_barrier ();
+   emit_label (subword_label);
+ 
+   if (!expand_subword_shift (op1_mode, binoptab,
+ 			     outof_input, into_input, op1,
+ 			     outof_target, into_target,
+ 			     unsignedp, methods))
+     return false;
+ 
+   emit_label (done_label);
+   return true;
+ }
  
  /* Wrapper around expand_binop which takes an rtx code to specify
     the operation to perform, not an optab pointer.  All other
*************** expand_binop (enum machine_mode mode, op
*** 1035,1050 ****
    if ((binoptab == lshr_optab || binoptab == ashl_optab
         || binoptab == ashr_optab)
        && class == MODE_INT
!       && GET_CODE (op1) == CONST_INT
        && GET_MODE_SIZE (mode) == 2 * UNITS_PER_WORD
        && binoptab->handlers[(int) word_mode].insn_code != CODE_FOR_nothing
        && ashl_optab->handlers[(int) word_mode].insn_code != CODE_FOR_nothing
        && lshr_optab->handlers[(int) word_mode].insn_code != CODE_FOR_nothing)
      {
!       rtx insns, inter, equiv_value;
        rtx into_target, outof_target;
        rtx into_input, outof_input;
!       int shift_count, left_shift, outof_word;
  
        /* If TARGET is the same as one of the operands, the REG_EQUAL note
  	 won't be accurate, so use a new target.  */
--- 1301,1317 ----
    if ((binoptab == lshr_optab || binoptab == ashl_optab
         || binoptab == ashr_optab)
        && class == MODE_INT
!       && (GET_CODE (op1) == CONST_INT || !optimize_size)
        && GET_MODE_SIZE (mode) == 2 * UNITS_PER_WORD
        && binoptab->handlers[(int) word_mode].insn_code != CODE_FOR_nothing
        && ashl_optab->handlers[(int) word_mode].insn_code != CODE_FOR_nothing
        && lshr_optab->handlers[(int) word_mode].insn_code != CODE_FOR_nothing)
      {
!       rtx insns, equiv_value;
        rtx into_target, outof_target;
        rtx into_input, outof_input;
!       enum machine_mode op1_mode;
!       int left_shift, outof_word;
  
        /* If TARGET is the same as one of the operands, the REG_EQUAL note
  	 won't be accurate, so use a new target.  */
*************** expand_binop (enum machine_mode mode, op
*** 1053,1059 ****
  
        start_sequence ();
  
!       shift_count = INTVAL (op1);
  
        /* OUTOF_* is the word we are shifting bits away from, and
  	 INTO_* is the word that we are shifting bits towards, thus
--- 1320,1326 ----
  
        start_sequence ();
  
!       op1_mode = GET_MODE (op1) != VOIDmode ? GET_MODE (op1) : word_mode;
  
        /* OUTOF_* is the word we are shifting bits away from, and
  	 INTO_* is the word that we are shifting bits towards, thus
*************** expand_binop (enum machine_mode mode, op
*** 1069,1145 ****
        outof_input = operand_subword_force (op0, outof_word, mode);
        into_input = operand_subword_force (op0, 1 - outof_word, mode);
  
!       if (shift_count >= BITS_PER_WORD)
! 	{
! 	  inter = expand_binop (word_mode, binoptab,
! 			       outof_input,
! 			       GEN_INT (shift_count - BITS_PER_WORD),
! 			       into_target, unsignedp, next_methods);
! 
! 	  if (inter != 0 && inter != into_target)
! 	    emit_move_insn (into_target, inter);
! 
! 	  /* For a signed right shift, we must fill the word we are shifting
! 	     out of with copies of the sign bit.  Otherwise it is zeroed.  */
! 	  if (inter != 0 && binoptab != ashr_optab)
! 	    inter = CONST0_RTX (word_mode);
! 	  else if (inter != 0)
! 	    inter = expand_binop (word_mode, binoptab,
! 				  outof_input,
! 				  GEN_INT (BITS_PER_WORD - 1),
! 				  outof_target, unsignedp, next_methods);
! 
! 	  if (inter != 0 && inter != outof_target)
! 	    emit_move_insn (outof_target, inter);
! 	}
!       else
  	{
! 	  rtx carries;
! 	  optab reverse_unsigned_shift, unsigned_shift;
! 
! 	  /* For a shift of less then BITS_PER_WORD, to compute the carry,
! 	     we must do a logical shift in the opposite direction of the
! 	     desired shift.  */
! 
! 	  reverse_unsigned_shift = (left_shift ? lshr_optab : ashl_optab);
! 
! 	  /* For a shift of less than BITS_PER_WORD, to compute the word
! 	     shifted towards, we need to unsigned shift the orig value of
! 	     that word.  */
! 
! 	  unsigned_shift = (left_shift ? ashl_optab : lshr_optab);
! 
! 	  carries = expand_binop (word_mode, reverse_unsigned_shift,
! 				  outof_input,
! 				  GEN_INT (BITS_PER_WORD - shift_count),
! 				  0, unsignedp, next_methods);
  
- 	  if (carries == 0)
- 	    inter = 0;
- 	  else
- 	    inter = expand_binop (word_mode, unsigned_shift, into_input,
- 				  op1, 0, unsignedp, next_methods);
- 
- 	  if (inter != 0)
- 	    inter = expand_binop (word_mode, ior_optab, carries, inter,
- 				  into_target, unsignedp, next_methods);
- 
- 	  if (inter != 0 && inter != into_target)
- 	    emit_move_insn (into_target, inter);
- 
- 	  if (inter != 0)
- 	    inter = expand_binop (word_mode, binoptab, outof_input,
- 				  op1, outof_target, unsignedp, next_methods);
- 
- 	  if (inter != 0 && inter != outof_target)
- 	    emit_move_insn (outof_target, inter);
- 	}
- 
-       insns = get_insns ();
-       end_sequence ();
- 
-       if (inter != 0)
- 	{
  	  if (binoptab->code != UNKNOWN)
  	    equiv_value = gen_rtx_fmt_ee (binoptab->code, mode, op0, op1);
  	  else
--- 1336,1349 ----
        outof_input = operand_subword_force (op0, outof_word, mode);
        into_input = operand_subword_force (op0, 1 - outof_word, mode);
  
!       if (expand_doubleword_shift (op1_mode, binoptab,
! 				   outof_input, into_input, op1,
! 				   outof_target, into_target,
! 				   unsignedp, methods))
  	{
! 	  insns = get_insns ();
! 	  end_sequence ();
  
  	  if (binoptab->code != UNKNOWN)
  	    equiv_value = gen_rtx_fmt_ee (binoptab->code, mode, op0, op1);
  	  else
*************** expand_binop (enum machine_mode mode, op
*** 1148,1153 ****
--- 1352,1358 ----
  	  emit_no_conflict_block (insns, target, op0, op1, equiv_value);
  	  return target;
  	}
+       end_sequence ();
      }
  
    /* Synthesize double word rotates from single word shifts.  */
