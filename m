Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2004 16:35:13 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:31457 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225007AbUGSPfH>; Mon, 19 Jul 2004 16:35:07 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id D4F75477EF; Mon, 19 Jul 2004 17:35:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id BC8234762E; Mon, 19 Jul 2004 17:35:00 +0200 (CEST)
Date: Mon, 19 Jul 2004 17:35:00 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Richard Sandiford <rsandifo@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit targets
Message-ID: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello Richard,

 Your change to gcc 3.5:

2004-05-17  Richard Sandiford  <rsandifo@redhat.com>

	* config/mips/mips.h (MASK_DEBUG_G, TARGET_DEBUG_G_MODE): Delete.
	(TARGET_SWITCHES): Remove debugg.
	* config/mips/mips.md (adddi3, ashldi3, ashrdi3, lshrdi3): Only handle
	TARGET_64BIT.
	(subdi3): Replace the define_expand with a define_insn, the latter
	renamed from subdi3_internal_3.
	(negdi2): Likewise negdi2_internal_2.
	(adddi3_internal_[12], subdi3_internal, ashldi3_internal{,2,3})
	(ashrdi3_internal{,2,3}, lshrdi3_internal{,2,3}): Remove patterns
	and associated define_splits.
	(adddi3_internal): Renamed from adddi3_internal_3.
	(ashldi3_internal): Likewise ashldi3_internal4.
	(ashrdi3_internal): Likewise ashrdi3_internal4.
	(lshrdi3_internal): Likewise lshrdi3_internal4.

breaks 32-bit Linux builds.  Linux relies on simple operations
(addition/subtraction and shifts) on "long long" variables being
implemented inline without a call to libgcc, which isn't linked in.  
After your change Linux has unresolved references to external __ashldi3(),
__ashrdi3() and __lshrdi3() functions at the final link.

 Here is a complete revert of the relevant changes that works for me, but
please feel free to provide a replacement.  Either way, please make
ashldi3, ashrdi3 and lshrdi3 available for 32-bit targets again.

2004-07-19  Maciej W. Rozycki  <macro@linux-mips.org>

	* config/mips/mips.md (ashldi3, ashrdi3, lshrdi3): Handle 
	!TARGET_64BIT again, partially reverting the change from 
	2004-05-17.
	(ashldi3_internal{,2,3}, ashrdi3_internal{,2,3}, 
	lshrdi3_internal{,2,3}): Restore patterns and associated 
	define_splits.
	(ashldi3_internal4): Rename from ashldi3_internal.
	(ashrdi3_internal4): Likewise ashrdi3_internal.
	(lshrdi3_internal4): Likewise lshrdi3_internal.

  Maciej

gcc-3.5.0-20040714-mips-xshxdi32.patch
diff -up --recursive --new-file gcc-3.5.0-20040714.macro/gcc/config/mips/mips.md gcc-3.5.0-20040714/gcc/config/mips/mips.md
--- gcc-3.5.0-20040714.macro/gcc/config/mips/mips.md	2004-07-13 04:59:54.000000000 +0000
+++ gcc-3.5.0-20040714/gcc/config/mips/mips.md	2004-07-17 19:00:14.000000000 +0000
@@ -4997,37 +4997,213 @@ dsrl\t%3,%3,1\n\
   { operands[2] = GEN_INT (INTVAL (operands[2]) - 8); })
 
 (define_expand "ashldi3"
-  [(set (match_operand:DI 0 "register_operand")
-	(ashift:DI (match_operand:DI 1 "register_operand")
-		   (match_operand:SI 2 "arith_operand")))]
-  "TARGET_64BIT"
+  [(parallel [(set (match_operand:DI 0 "register_operand")
+		   (ashift:DI (match_operand:DI 1 "register_operand")
+			      (match_operand:SI 2 "arith_operand")))
+	      (clobber (match_dup  3))])]
+  "TARGET_64BIT || !TARGET_MIPS16"
 {
-  /* On the mips16, a shift of more than 8 is a four byte
-     instruction, so, for a shift between 8 and 16, it is just as
-     fast to do two shifts of 8 or less.  If there is a lot of
-     shifting going on, we may win in CSE.  Otherwise combine will
-     put the shifts back together again.  This can be called by
-     function_arg, so we must be careful not to allocate a new
-     register if we've reached the reload pass.  */
-  if (TARGET_MIPS16
-      && optimize
-      && GET_CODE (operands[2]) == CONST_INT
-      && INTVAL (operands[2]) > 8
-      && INTVAL (operands[2]) <= 16
-      && ! reload_in_progress
-      && ! reload_completed)
+  if (TARGET_64BIT)
     {
-      rtx temp = gen_reg_rtx (DImode);
+      /* On the mips16, a shift of more than 8 is a four byte
+	 instruction, so, for a shift between 8 and 16, it is just as
+	 fast to do two shifts of 8 or less.  If there is a lot of
+	 shifting going on, we may win in CSE.  Otherwise combine will
+	 put the shifts back together again.  This can be called by
+	 function_arg, so we must be careful not to allocate a new
+	 register if we've reached the reload pass.  */
+      if (TARGET_MIPS16
+	  && optimize
+	  && GET_CODE (operands[2]) == CONST_INT
+	  && INTVAL (operands[2]) > 8
+	  && INTVAL (operands[2]) <= 16
+	  && ! reload_in_progress
+	  && ! reload_completed)
+	{
+	  rtx temp = gen_reg_rtx (DImode);
 
-      emit_insn (gen_ashldi3_internal (temp, operands[1], GEN_INT (8)));
-      emit_insn (gen_ashldi3_internal (operands[0], temp,
-				       GEN_INT (INTVAL (operands[2]) - 8)));
+	  emit_insn (gen_ashldi3_internal4 (temp, operands[1], GEN_INT (8)));
+	  emit_insn (gen_ashldi3_internal4 (operands[0], temp,
+					    GEN_INT (INTVAL (operands[2]) - 8)));
+	  DONE;
+	}
+
+      emit_insn (gen_ashldi3_internal4 (operands[0], operands[1],
+					operands[2]));
       DONE;
     }
+
+  operands[3] = gen_reg_rtx (SImode);
 })
 
 
 (define_insn "ashldi3_internal"
+  [(set (match_operand:DI 0 "register_operand" "=&d")
+	(ashift:DI (match_operand:DI 1 "register_operand" "d")
+		   (match_operand:SI 2 "register_operand" "d")))
+   (clobber (match_operand:SI 3 "register_operand" "=d"))]
+  "!TARGET_64BIT && !TARGET_MIPS16"
+  "sll\t%3,%2,26\;\
+bgez\t%3,1f%#\;\
+sll\t%M0,%L1,%2\;\
+%(b\t3f\;\
+move\t%L0,%.%)\
+\n\n\
+%~1:\;\
+%(beq\t%3,%.,2f\;\
+sll\t%M0,%M1,%2%)\
+\n\;\
+subu\t%3,%.,%2\;\
+srl\t%3,%L1,%3\;\
+or\t%M0,%M0,%3\n\
+%~2:\;\
+sll\t%L0,%L1,%2\n\
+%~3:"
+  [(set_attr "type"	"multi")
+   (set_attr "mode"	"SI")
+   (set_attr "length"	"48")])
+
+
+(define_insn "ashldi3_internal2"
+  [(set (match_operand:DI 0 "register_operand" "=d")
+	(ashift:DI (match_operand:DI 1 "register_operand" "d")
+		   (match_operand:SI 2 "small_int" "IJK")))
+   (clobber (match_operand:SI 3 "register_operand" "=d"))]
+  "!TARGET_64BIT && !TARGET_MIPS16
+   && (INTVAL (operands[2]) & 32) != 0"
+{
+  operands[2] = GEN_INT (INTVAL (operands[2]) & 0x1f);
+  return "sll\t%M0,%L1,%2\;move\t%L0,%.";
+}
+  [(set_attr "type"	"multi")
+   (set_attr "mode"	"DI")
+   (set_attr "length"	"8")])
+
+
+(define_split
+  [(set (match_operand:DI 0 "register_operand")
+	(ashift:DI (match_operand:DI 1 "register_operand")
+		   (match_operand:SI 2 "small_int")))
+   (clobber (match_operand:SI 3 "register_operand"))]
+  "reload_completed && !WORDS_BIG_ENDIAN && !TARGET_64BIT
+   && !TARGET_DEBUG_D_MODE && !TARGET_MIPS16
+   && GET_CODE (operands[0]) == REG && REGNO (operands[0]) < FIRST_PSEUDO_REGISTER
+   && GET_CODE (operands[1]) == REG && REGNO (operands[1]) < FIRST_PSEUDO_REGISTER
+   && (INTVAL (operands[2]) & 32) != 0"
+
+  [(set (subreg:SI (match_dup 0) 4) (ashift:SI (subreg:SI (match_dup 1) 0) (match_dup 2)))
+   (set (subreg:SI (match_dup 0) 0) (const_int 0))]
+
+  "operands[2] = GEN_INT (INTVAL (operands[2]) & 0x1f);")
+
+
+(define_split
+  [(set (match_operand:DI 0 "register_operand")
+	(ashift:DI (match_operand:DI 1 "register_operand")
+		   (match_operand:SI 2 "small_int")))
+   (clobber (match_operand:SI 3 "register_operand"))]
+  "reload_completed && WORDS_BIG_ENDIAN && !TARGET_64BIT
+   && !TARGET_DEBUG_D_MODE && !TARGET_MIPS16
+   && GET_CODE (operands[0]) == REG && REGNO (operands[0]) < FIRST_PSEUDO_REGISTER
+   && GET_CODE (operands[1]) == REG && REGNO (operands[1]) < FIRST_PSEUDO_REGISTER
+   && (INTVAL (operands[2]) & 32) != 0"
+
+  [(set (subreg:SI (match_dup 0) 0) (ashift:SI (subreg:SI (match_dup 1) 4) (match_dup 2)))
+   (set (subreg:SI (match_dup 0) 4) (const_int 0))]
+
+  "operands[2] = GEN_INT (INTVAL (operands[2]) & 0x1f);")
+
+
+(define_insn "ashldi3_internal3"
+  [(set (match_operand:DI 0 "register_operand" "=d")
+	(ashift:DI (match_operand:DI 1 "register_operand" "d")
+		   (match_operand:SI 2 "small_int" "IJK")))
+   (clobber (match_operand:SI 3 "register_operand" "=d"))]
+  "!TARGET_64BIT && !TARGET_MIPS16
+   && (INTVAL (operands[2]) & 63) < 32
+   && (INTVAL (operands[2]) & 63) != 0"
+{
+  int amount = INTVAL (operands[2]);
+
+  operands[2] = GEN_INT (amount & 31);
+  operands[4] = GEN_INT ((-amount) & 31);
+
+  return "sll\t%M0,%M1,%2\;srl\t%3,%L1,%4\;or\t%M0,%M0,%3\;sll\t%L0,%L1,%2";
+}
+  [(set_attr "type"	"multi")
+   (set_attr "mode"	"DI")
+   (set_attr "length"	"16")])
+
+
+(define_split
+  [(set (match_operand:DI 0 "register_operand")
+	(ashift:DI (match_operand:DI 1 "register_operand")
+		   (match_operand:SI 2 "small_int")))
+   (clobber (match_operand:SI 3 "register_operand"))]
+  "reload_completed && !WORDS_BIG_ENDIAN && !TARGET_64BIT
+   && !TARGET_DEBUG_D_MODE && !TARGET_MIPS16
+   && GET_CODE (operands[0]) == REG && REGNO (operands[0]) < FIRST_PSEUDO_REGISTER
+   && GET_CODE (operands[1]) == REG && REGNO (operands[1]) < FIRST_PSEUDO_REGISTER
+   && (INTVAL (operands[2]) & 63) < 32
+   && (INTVAL (operands[2]) & 63) != 0"
+
+  [(set (subreg:SI (match_dup 0) 4)
+	(ashift:SI (subreg:SI (match_dup 1) 4)
+		   (match_dup 2)))
+
+   (set (match_dup 3)
+	(lshiftrt:SI (subreg:SI (match_dup 1) 0)
+		     (match_dup 4)))
+
+   (set (subreg:SI (match_dup 0) 4)
+	(ior:SI (subreg:SI (match_dup 0) 4)
+		(match_dup 3)))
+
+   (set (subreg:SI (match_dup 0) 0)
+	(ashift:SI (subreg:SI (match_dup 1) 0)
+		   (match_dup 2)))]
+{
+  int amount = INTVAL (operands[2]);
+  operands[2] = GEN_INT (amount & 31);
+  operands[4] = GEN_INT ((-amount) & 31);
+})
+
+
+(define_split
+  [(set (match_operand:DI 0 "register_operand")
+	(ashift:DI (match_operand:DI 1 "register_operand")
+		   (match_operand:SI 2 "small_int")))
+   (clobber (match_operand:SI 3 "register_operand"))]
+  "reload_completed && WORDS_BIG_ENDIAN && !TARGET_64BIT
+   && !TARGET_DEBUG_D_MODE && !TARGET_MIPS16
+   && GET_CODE (operands[0]) == REG && REGNO (operands[0]) < FIRST_PSEUDO_REGISTER
+   && GET_CODE (operands[1]) == REG && REGNO (operands[1]) < FIRST_PSEUDO_REGISTER
+   && (INTVAL (operands[2]) & 63) < 32
+   && (INTVAL (operands[2]) & 63) != 0"
+
+  [(set (subreg:SI (match_dup 0) 0)
+	(ashift:SI (subreg:SI (match_dup 1) 0)
+		   (match_dup 2)))
+
+   (set (match_dup 3)
+	(lshiftrt:SI (subreg:SI (match_dup 1) 4)
+		     (match_dup 4)))
+
+   (set (subreg:SI (match_dup 0) 0)
+	(ior:SI (subreg:SI (match_dup 0) 0)
+		(match_dup 3)))
+
+   (set (subreg:SI (match_dup 0) 4)
+	(ashift:SI (subreg:SI (match_dup 1) 4)
+		   (match_dup 2)))]
+{
+  int amount = INTVAL (operands[2]);
+  operands[2] = GEN_INT (amount & 31);
+  operands[4] = GEN_INT ((-amount) & 31);
+})
+
+
+(define_insn "ashldi3_internal4"
   [(set (match_operand:DI 0 "register_operand" "=d")
 	(ashift:DI (match_operand:DI 1 "register_operand" "d")
 		   (match_operand:SI 2 "arith_operand" "dI")))]
@@ -5157,33 +5333,208 @@ dsrl\t%3,%3,1\n\
   { operands[2] = GEN_INT (INTVAL (operands[2]) - 8); })
 
 (define_expand "ashrdi3"
-  [(set (match_operand:DI 0 "register_operand")
-	(ashiftrt:DI (match_operand:DI 1 "register_operand")
-		     (match_operand:SI 2 "arith_operand")))]
-  "TARGET_64BIT"
+  [(parallel [(set (match_operand:DI 0 "register_operand")
+		   (ashiftrt:DI (match_operand:DI 1 "register_operand")
+				(match_operand:SI 2 "arith_operand")))
+	      (clobber (match_dup  3))])]
+  "TARGET_64BIT || !TARGET_MIPS16"
 {
-  /* On the mips16, a shift of more than 8 is a four byte
-     instruction, so, for a shift between 8 and 16, it is just as
-     fast to do two shifts of 8 or less.  If there is a lot of
-     shifting going on, we may win in CSE.  Otherwise combine will
-     put the shifts back together again.  */
-  if (TARGET_MIPS16
-      && optimize
-      && GET_CODE (operands[2]) == CONST_INT
-      && INTVAL (operands[2]) > 8
-      && INTVAL (operands[2]) <= 16)
+  if (TARGET_64BIT)
     {
-      rtx temp = gen_reg_rtx (DImode);
+      /* On the mips16, a shift of more than 8 is a four byte
+	 instruction, so, for a shift between 8 and 16, it is just as
+	 fast to do two shifts of 8 or less.  If there is a lot of
+	 shifting going on, we may win in CSE.  Otherwise combine will
+	 put the shifts back together again.  */
+      if (TARGET_MIPS16
+	  && optimize
+	  && GET_CODE (operands[2]) == CONST_INT
+	  && INTVAL (operands[2]) > 8
+	  && INTVAL (operands[2]) <= 16)
+	{
+	  rtx temp = gen_reg_rtx (DImode);
+
+	  emit_insn (gen_ashrdi3_internal4 (temp, operands[1], GEN_INT (8)));
+	  emit_insn (gen_ashrdi3_internal4 (operands[0], temp,
+					    GEN_INT (INTVAL (operands[2]) - 8)));
+	  DONE;
+	}
 
-      emit_insn (gen_ashrdi3_internal (temp, operands[1], GEN_INT (8)));
-      emit_insn (gen_ashrdi3_internal (operands[0], temp,
-				       GEN_INT (INTVAL (operands[2]) - 8)));
+      emit_insn (gen_ashrdi3_internal4 (operands[0], operands[1],
+					operands[2]));
       DONE;
     }
+
+  operands[3] = gen_reg_rtx (SImode);
 })
 
 
 (define_insn "ashrdi3_internal"
+  [(set (match_operand:DI 0 "register_operand" "=&d")
+	(ashiftrt:DI (match_operand:DI 1 "register_operand" "d")
+		     (match_operand:SI 2 "register_operand" "d")))
+   (clobber (match_operand:SI 3 "register_operand" "=d"))]
+  "!TARGET_64BIT && !TARGET_MIPS16"
+  "sll\t%3,%2,26\;\
+bgez\t%3,1f%#\;\
+sra\t%L0,%M1,%2\;\
+%(b\t3f\;\
+sra\t%M0,%M1,31%)\
+\n\n\
+%~1:\;\
+%(beq\t%3,%.,2f\;\
+srl\t%L0,%L1,%2%)\
+\n\;\
+subu\t%3,%.,%2\;\
+sll\t%3,%M1,%3\;\
+or\t%L0,%L0,%3\n\
+%~2:\;\
+sra\t%M0,%M1,%2\n\
+%~3:"
+  [(set_attr "type"	"multi")
+   (set_attr "mode"	"DI")
+   (set_attr "length"	"48")])
+
+
+(define_insn "ashrdi3_internal2"
+  [(set (match_operand:DI 0 "register_operand" "=d")
+	(ashiftrt:DI (match_operand:DI 1 "register_operand" "d")
+		     (match_operand:SI 2 "small_int" "IJK")))
+   (clobber (match_operand:SI 3 "register_operand" "=d"))]
+  "!TARGET_64BIT && (INTVAL (operands[2]) & 32) != 0"
+{
+  operands[2] = GEN_INT (INTVAL (operands[2]) & 0x1f);
+  return "sra\t%L0,%M1,%2\;sra\t%M0,%M1,31";
+}
+  [(set_attr "type"	"multi")
+   (set_attr "mode"	"DI")
+   (set_attr "length"	"8")])
+
+
+(define_split
+  [(set (match_operand:DI 0 "register_operand")
+	(ashiftrt:DI (match_operand:DI 1 "register_operand")
+		     (match_operand:SI 2 "small_int")))
+   (clobber (match_operand:SI 3 "register_operand"))]
+  "reload_completed && !WORDS_BIG_ENDIAN && !TARGET_64BIT
+   && !TARGET_DEBUG_D_MODE
+   && GET_CODE (operands[0]) == REG && REGNO (operands[0]) < FIRST_PSEUDO_REGISTER
+   && GET_CODE (operands[1]) == REG && REGNO (operands[1]) < FIRST_PSEUDO_REGISTER
+   && (INTVAL (operands[2]) & 32) != 0"
+
+  [(set (subreg:SI (match_dup 0) 0) (ashiftrt:SI (subreg:SI (match_dup 1) 4) (match_dup 2)))
+   (set (subreg:SI (match_dup 0) 4) (ashiftrt:SI (subreg:SI (match_dup 1) 4) (const_int 31)))]
+
+  "operands[2] = GEN_INT (INTVAL (operands[2]) & 0x1f);")
+
+
+(define_split
+  [(set (match_operand:DI 0 "register_operand")
+	(ashiftrt:DI (match_operand:DI 1 "register_operand")
+		     (match_operand:SI 2 "small_int")))
+   (clobber (match_operand:SI 3 "register_operand"))]
+  "reload_completed && WORDS_BIG_ENDIAN && !TARGET_64BIT
+   && !TARGET_DEBUG_D_MODE
+   && GET_CODE (operands[0]) == REG && REGNO (operands[0]) < FIRST_PSEUDO_REGISTER
+   && GET_CODE (operands[1]) == REG && REGNO (operands[1]) < FIRST_PSEUDO_REGISTER
+   && (INTVAL (operands[2]) & 32) != 0"
+
+  [(set (subreg:SI (match_dup 0) 4) (ashiftrt:SI (subreg:SI (match_dup 1) 0) (match_dup 2)))
+   (set (subreg:SI (match_dup 0) 0) (ashiftrt:SI (subreg:SI (match_dup 1) 0) (const_int 31)))]
+
+  "operands[2] = GEN_INT (INTVAL (operands[2]) & 0x1f);")
+
+
+(define_insn "ashrdi3_internal3"
+  [(set (match_operand:DI 0 "register_operand" "=d")
+	(ashiftrt:DI (match_operand:DI 1 "register_operand" "d")
+		     (match_operand:SI 2 "small_int" "IJK")))
+   (clobber (match_operand:SI 3 "register_operand" "=d"))]
+  "!TARGET_64BIT && !TARGET_MIPS16
+   && (INTVAL (operands[2]) & 63) < 32
+   && (INTVAL (operands[2]) & 63) != 0"
+{
+  int amount = INTVAL (operands[2]);
+
+  operands[2] = GEN_INT (amount & 31);
+  operands[4] = GEN_INT ((-amount) & 31);
+
+  return "srl\t%L0,%L1,%2\;sll\t%3,%M1,%4\;or\t%L0,%L0,%3\;sra\t%M0,%M1,%2";
+}
+  [(set_attr "type"	"multi")
+   (set_attr "mode"	"DI")
+   (set_attr "length"	"16")])
+
+
+(define_split
+  [(set (match_operand:DI 0 "register_operand")
+	(ashiftrt:DI (match_operand:DI 1 "register_operand")
+		     (match_operand:SI 2 "small_int")))
+   (clobber (match_operand:SI 3 "register_operand"))]
+  "reload_completed && !WORDS_BIG_ENDIAN && !TARGET_64BIT
+   && !TARGET_DEBUG_D_MODE && !TARGET_MIPS16
+   && GET_CODE (operands[0]) == REG && REGNO (operands[0]) < FIRST_PSEUDO_REGISTER
+   && GET_CODE (operands[1]) == REG && REGNO (operands[1]) < FIRST_PSEUDO_REGISTER
+   && (INTVAL (operands[2]) & 63) < 32
+   && (INTVAL (operands[2]) & 63) != 0"
+
+  [(set (subreg:SI (match_dup 0) 0)
+	(lshiftrt:SI (subreg:SI (match_dup 1) 0)
+		     (match_dup 2)))
+
+   (set (match_dup 3)
+	(ashift:SI (subreg:SI (match_dup 1) 4)
+		   (match_dup 4)))
+
+   (set (subreg:SI (match_dup 0) 0)
+	(ior:SI (subreg:SI (match_dup 0) 0)
+		(match_dup 3)))
+
+   (set (subreg:SI (match_dup 0) 4)
+	(ashiftrt:SI (subreg:SI (match_dup 1) 4)
+		     (match_dup 2)))]
+{
+  int amount = INTVAL (operands[2]);
+  operands[2] = GEN_INT (amount & 31);
+  operands[4] = GEN_INT ((-amount) & 31);
+})
+
+
+(define_split
+  [(set (match_operand:DI 0 "register_operand")
+	(ashiftrt:DI (match_operand:DI 1 "register_operand")
+		     (match_operand:SI 2 "small_int")))
+   (clobber (match_operand:SI 3 "register_operand"))]
+  "reload_completed && WORDS_BIG_ENDIAN && !TARGET_64BIT
+   && !TARGET_DEBUG_D_MODE && !TARGET_MIPS16
+   && GET_CODE (operands[0]) == REG && REGNO (operands[0]) < FIRST_PSEUDO_REGISTER
+   && GET_CODE (operands[1]) == REG && REGNO (operands[1]) < FIRST_PSEUDO_REGISTER
+   && (INTVAL (operands[2]) & 63) < 32
+   && (INTVAL (operands[2]) & 63) != 0"
+
+  [(set (subreg:SI (match_dup 0) 4)
+	(lshiftrt:SI (subreg:SI (match_dup 1) 4)
+		     (match_dup 2)))
+
+   (set (match_dup 3)
+	(ashift:SI (subreg:SI (match_dup 1) 0)
+		   (match_dup 4)))
+
+   (set (subreg:SI (match_dup 0) 4)
+	(ior:SI (subreg:SI (match_dup 0) 4)
+		(match_dup 3)))
+
+   (set (subreg:SI (match_dup 0) 0)
+	(ashiftrt:SI (subreg:SI (match_dup 1) 0)
+		     (match_dup 2)))]
+{
+  int amount = INTVAL (operands[2]);
+  operands[2] = GEN_INT (amount & 31);
+  operands[4] = GEN_INT ((-amount) & 31);
+})
+
+
+(define_insn "ashrdi3_internal4"
   [(set (match_operand:DI 0 "register_operand" "=d")
 	(ashiftrt:DI (match_operand:DI 1 "register_operand" "d")
 		     (match_operand:SI 2 "arith_operand" "dI")))]
@@ -5332,33 +5683,209 @@ dsrl\t%3,%3,1\n\
    (set_attr "length"	"16")])
 
 (define_expand "lshrdi3"
-  [(set (match_operand:DI 0 "register_operand")
-	(lshiftrt:DI (match_operand:DI 1 "register_operand")
-		     (match_operand:SI 2 "arith_operand")))]
-  "TARGET_64BIT"
+  [(parallel [(set (match_operand:DI 0 "register_operand")
+		   (lshiftrt:DI (match_operand:DI 1 "register_operand")
+				(match_operand:SI 2 "arith_operand")))
+	      (clobber (match_dup  3))])]
+  "TARGET_64BIT || !TARGET_MIPS16"
 {
-  /* On the mips16, a shift of more than 8 is a four byte
-     instruction, so, for a shift between 8 and 16, it is just as
-     fast to do two shifts of 8 or less.  If there is a lot of
-     shifting going on, we may win in CSE.  Otherwise combine will
-     put the shifts back together again.  */
-  if (TARGET_MIPS16
-      && optimize
-      && GET_CODE (operands[2]) == CONST_INT
-      && INTVAL (operands[2]) > 8
-      && INTVAL (operands[2]) <= 16)
+  if (TARGET_64BIT)
     {
-      rtx temp = gen_reg_rtx (DImode);
+      /* On the mips16, a shift of more than 8 is a four byte
+	 instruction, so, for a shift between 8 and 16, it is just as
+	 fast to do two shifts of 8 or less.  If there is a lot of
+	 shifting going on, we may win in CSE.  Otherwise combine will
+	 put the shifts back together again.  */
+      if (TARGET_MIPS16
+	  && optimize
+	  && GET_CODE (operands[2]) == CONST_INT
+	  && INTVAL (operands[2]) > 8
+	  && INTVAL (operands[2]) <= 16)
+	{
+	  rtx temp = gen_reg_rtx (DImode);
 
-      emit_insn (gen_lshrdi3_internal (temp, operands[1], GEN_INT (8)));
-      emit_insn (gen_lshrdi3_internal (operands[0], temp,
-				       GEN_INT (INTVAL (operands[2]) - 8)));
+	  emit_insn (gen_lshrdi3_internal4 (temp, operands[1], GEN_INT (8)));
+	  emit_insn (gen_lshrdi3_internal4 (operands[0], temp,
+					    GEN_INT (INTVAL (operands[2]) - 8)));
+	  DONE;
+	}
+
+      emit_insn (gen_lshrdi3_internal4 (operands[0], operands[1],
+					operands[2]));
       DONE;
     }
+
+  operands[3] = gen_reg_rtx (SImode);
 })
 
 
 (define_insn "lshrdi3_internal"
+  [(set (match_operand:DI 0 "register_operand" "=&d")
+	(lshiftrt:DI (match_operand:DI 1 "register_operand" "d")
+		     (match_operand:SI 2 "register_operand" "d")))
+   (clobber (match_operand:SI 3 "register_operand" "=d"))]
+  "!TARGET_64BIT && !TARGET_MIPS16"
+  "sll\t%3,%2,26\;\
+bgez\t%3,1f%#\;\
+srl\t%L0,%M1,%2\;\
+%(b\t3f\;\
+move\t%M0,%.%)\
+\n\n\
+%~1:\;\
+%(beq\t%3,%.,2f\;\
+srl\t%L0,%L1,%2%)\
+\n\;\
+subu\t%3,%.,%2\;\
+sll\t%3,%M1,%3\;\
+or\t%L0,%L0,%3\n\
+%~2:\;\
+srl\t%M0,%M1,%2\n\
+%~3:"
+  [(set_attr "type"	"multi")
+   (set_attr "mode"	"DI")
+   (set_attr "length"	"48")])
+
+
+(define_insn "lshrdi3_internal2"
+  [(set (match_operand:DI 0 "register_operand" "=d")
+	(lshiftrt:DI (match_operand:DI 1 "register_operand" "d")
+		     (match_operand:SI 2 "small_int" "IJK")))
+   (clobber (match_operand:SI 3 "register_operand" "=d"))]
+  "!TARGET_64BIT && !TARGET_MIPS16
+   && (INTVAL (operands[2]) & 32) != 0"
+{
+  operands[2] = GEN_INT (INTVAL (operands[2]) & 0x1f);
+  return "srl\t%L0,%M1,%2\;move\t%M0,%.";
+}
+  [(set_attr "type"	"multi")
+   (set_attr "mode"	"DI")
+   (set_attr "length"	"8")])
+
+
+(define_split
+  [(set (match_operand:DI 0 "register_operand")
+	(lshiftrt:DI (match_operand:DI 1 "register_operand")
+		     (match_operand:SI 2 "small_int")))
+   (clobber (match_operand:SI 3 "register_operand"))]
+  "reload_completed && !WORDS_BIG_ENDIAN && !TARGET_64BIT
+   && !TARGET_DEBUG_D_MODE && !TARGET_MIPS16
+   && GET_CODE (operands[0]) == REG && REGNO (operands[0]) < FIRST_PSEUDO_REGISTER
+   && GET_CODE (operands[1]) == REG && REGNO (operands[1]) < FIRST_PSEUDO_REGISTER
+   && (INTVAL (operands[2]) & 32) != 0"
+
+  [(set (subreg:SI (match_dup 0) 0) (lshiftrt:SI (subreg:SI (match_dup 1) 4) (match_dup 2)))
+   (set (subreg:SI (match_dup 0) 4) (const_int 0))]
+
+  "operands[2] = GEN_INT (INTVAL (operands[2]) & 0x1f);")
+
+
+(define_split
+  [(set (match_operand:DI 0 "register_operand")
+	(lshiftrt:DI (match_operand:DI 1 "register_operand")
+		     (match_operand:SI 2 "small_int")))
+   (clobber (match_operand:SI 3 "register_operand"))]
+  "reload_completed && WORDS_BIG_ENDIAN && !TARGET_64BIT
+   && !TARGET_DEBUG_D_MODE && !TARGET_MIPS16
+   && GET_CODE (operands[0]) == REG && REGNO (operands[0]) < FIRST_PSEUDO_REGISTER
+   && GET_CODE (operands[1]) == REG && REGNO (operands[1]) < FIRST_PSEUDO_REGISTER
+   && (INTVAL (operands[2]) & 32) != 0"
+
+  [(set (subreg:SI (match_dup 0) 4) (lshiftrt:SI (subreg:SI (match_dup 1) 0) (match_dup 2)))
+   (set (subreg:SI (match_dup 0) 0) (const_int 0))]
+
+  "operands[2] = GEN_INT (INTVAL (operands[2]) & 0x1f);")
+
+
+(define_insn "lshrdi3_internal3"
+  [(set (match_operand:DI 0 "register_operand" "=d")
+	(lshiftrt:DI (match_operand:DI 1 "register_operand" "d")
+		   (match_operand:SI 2 "small_int" "IJK")))
+   (clobber (match_operand:SI 3 "register_operand" "=d"))]
+  "!TARGET_64BIT && !TARGET_MIPS16
+   && (INTVAL (operands[2]) & 63) < 32
+   && (INTVAL (operands[2]) & 63) != 0"
+{
+  int amount = INTVAL (operands[2]);
+
+  operands[2] = GEN_INT (amount & 31);
+  operands[4] = GEN_INT ((-amount) & 31);
+
+  return "srl\t%L0,%L1,%2\;sll\t%3,%M1,%4\;or\t%L0,%L0,%3\;srl\t%M0,%M1,%2";
+}
+  [(set_attr "type"	"multi")
+   (set_attr "mode"	"DI")
+   (set_attr "length"	"16")])
+
+
+(define_split
+  [(set (match_operand:DI 0 "register_operand")
+	(lshiftrt:DI (match_operand:DI 1 "register_operand")
+		     (match_operand:SI 2 "small_int")))
+   (clobber (match_operand:SI 3 "register_operand"))]
+  "reload_completed && !WORDS_BIG_ENDIAN && !TARGET_64BIT
+   && !TARGET_DEBUG_D_MODE && !TARGET_MIPS16
+   && GET_CODE (operands[0]) == REG && REGNO (operands[0]) < FIRST_PSEUDO_REGISTER
+   && GET_CODE (operands[1]) == REG && REGNO (operands[1]) < FIRST_PSEUDO_REGISTER
+   && (INTVAL (operands[2]) & 63) < 32
+   && (INTVAL (operands[2]) & 63) != 0"
+
+  [(set (subreg:SI (match_dup 0) 0)
+	(lshiftrt:SI (subreg:SI (match_dup 1) 0)
+		     (match_dup 2)))
+
+   (set (match_dup 3)
+	(ashift:SI (subreg:SI (match_dup 1) 4)
+		   (match_dup 4)))
+
+   (set (subreg:SI (match_dup 0) 0)
+	(ior:SI (subreg:SI (match_dup 0) 0)
+		(match_dup 3)))
+
+   (set (subreg:SI (match_dup 0) 4)
+	(lshiftrt:SI (subreg:SI (match_dup 1) 4)
+		     (match_dup 2)))]
+{
+  int amount = INTVAL (operands[2]);
+  operands[2] = GEN_INT (amount & 31);
+  operands[4] = GEN_INT ((-amount) & 31);
+})
+
+
+(define_split
+  [(set (match_operand:DI 0 "register_operand")
+	(lshiftrt:DI (match_operand:DI 1 "register_operand")
+		     (match_operand:SI 2 "small_int")))
+   (clobber (match_operand:SI 3 "register_operand"))]
+  "reload_completed && WORDS_BIG_ENDIAN && !TARGET_64BIT
+   && !TARGET_DEBUG_D_MODE && !TARGET_MIPS16
+   && GET_CODE (operands[0]) == REG && REGNO (operands[0]) < FIRST_PSEUDO_REGISTER
+   && GET_CODE (operands[1]) == REG && REGNO (operands[1]) < FIRST_PSEUDO_REGISTER
+   && (INTVAL (operands[2]) & 63) < 32
+   && (INTVAL (operands[2]) & 63) != 0"
+
+  [(set (subreg:SI (match_dup 0) 4)
+	(lshiftrt:SI (subreg:SI (match_dup 1) 4)
+		     (match_dup 2)))
+
+   (set (match_dup 3)
+	(ashift:SI (subreg:SI (match_dup 1) 0)
+		   (match_dup 4)))
+
+   (set (subreg:SI (match_dup 0) 4)
+	(ior:SI (subreg:SI (match_dup 0) 4)
+		(match_dup 3)))
+
+   (set (subreg:SI (match_dup 0) 0)
+	(lshiftrt:SI (subreg:SI (match_dup 1) 0)
+		     (match_dup 2)))]
+{
+  int amount = INTVAL (operands[2]);
+  operands[2] = GEN_INT (amount & 31);
+  operands[4] = GEN_INT ((-amount) & 31);
+})
+
+
+(define_insn "lshrdi3_internal4"
   [(set (match_operand:DI 0 "register_operand" "=d")
 	(lshiftrt:DI (match_operand:DI 1 "register_operand" "d")
 		     (match_operand:SI 2 "arith_operand" "dI")))]
