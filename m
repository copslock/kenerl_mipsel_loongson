Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Aug 2013 21:11:16 +0200 (CEST)
Received: from mail-ob0-f170.google.com ([209.85.214.170]:49545 "EHLO
        mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825891Ab3HSTKsRGtf5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Aug 2013 21:10:48 +0200
Received: by mail-ob0-f170.google.com with SMTP id eh20so6084905obb.1
        for <multiple recipients>; Mon, 19 Aug 2013 12:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C2GVw3lbpYxKDsMBbb8PeuKhiMWVYAu+90I85A7W2iQ=;
        b=PyHlLqJpTSj2RctATEP8QqT4dKtzCwykITzFyXgjex9AhzYIZe9Op8xGj21absVHxZ
         jNMjeFwhLW71TeUz6BjOfY3U5FDDuaSei4yvPMawy1UnuKfAk8YD/bJ2OrQoII9zvMS2
         UDzly1K/VU+UDsq5PeoeGqTBaOorwFOMjga9a4Oh1DQ8UgTn5eFyzhJaSepRqw1cMCaD
         FG+/E8LAf574t+bkz63EFrXcLb16OQe5o/dB1Coha9UOI1jkIKnTMCovCZtYJR3o003d
         LyCh/rl0g0MS+o0qH41exvmHS4gUCgmgdDAcIHvXCPEOfYWX7LBaRC8ea11u94ZwWocf
         wL4g==
X-Received: by 10.60.141.131 with SMTP id ro3mr7889904oeb.54.1376939442053;
        Mon, 19 Aug 2013 12:10:42 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id z5sm18668531obg.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 19 Aug 2013 12:10:41 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r7JJAdFi019805;
        Mon, 19 Aug 2013 12:10:39 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r7JJAdKW019804;
        Mon, 19 Aug 2013 12:10:39 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 2/2] MIPS: Remove unreachable break statements from cp1emu.c
Date:   Mon, 19 Aug 2013 12:10:35 -0700
Message-Id: <1376939435-19761-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1376939435-19761-1-git-send-email-ddaney.cavm@gmail.com>
References: <1376939435-19761-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

There were many cases of:

   return something;
   break;

All those break statements are unreachable and thus redundant.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/math-emu/cp1emu.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 46048d2..efe0088 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -436,7 +436,6 @@ static int microMIPS32_to_MIPS32(union mips_instruction *insn_ptr)
 				break;
 			default:
 				return SIGILL;
-				break;
 			}
 			break;
 		case mm_32f_74_op:	/* c.cond.fmt */
@@ -451,12 +450,10 @@ static int microMIPS32_to_MIPS32(union mips_instruction *insn_ptr)
 			break;
 		default:
 			return SIGILL;
-			break;
 		}
 		break;
 	default:
 		return SIGILL;
-		break;
 	}
 
 	*insn_ptr = mips32_insn;
@@ -491,7 +488,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 						dec_insn.next_pc_inc;
 				*contpc = regs->regs[insn.mm_i_format.rs];
 				return 1;
-				break;
 			}
 		}
 		break;
@@ -513,7 +509,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 					dec_insn.pc_inc +
 					dec_insn.next_pc_inc;
 			return 1;
-			break;
 		case mm_bgezals_op:
 		case mm_bgezal_op:
 			regs->regs[31] = regs->cp0_epc +
@@ -530,7 +525,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 					dec_insn.pc_inc +
 					dec_insn.next_pc_inc;
 			return 1;
-			break;
 		case mm_blez_op:
 			if ((long)regs->regs[insn.mm_i_format.rs] <= 0)
 				*contpc = regs->cp0_epc +
@@ -541,7 +535,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 					dec_insn.pc_inc +
 					dec_insn.next_pc_inc;
 			return 1;
-			break;
 		case mm_bgtz_op:
 			if ((long)regs->regs[insn.mm_i_format.rs] <= 0)
 				*contpc = regs->cp0_epc +
@@ -552,7 +545,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 					dec_insn.pc_inc +
 					dec_insn.next_pc_inc;
 			return 1;
-			break;
 		case mm_bc2f_op:
 		case mm_bc1f_op:
 			bc_false = 1;
@@ -580,7 +572,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 				*contpc = regs->cp0_epc +
 					dec_insn.pc_inc + dec_insn.next_pc_inc;
 			return 1;
-			break;
 		}
 		break;
 	case mm_pool16c_op:
@@ -593,7 +584,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		case mm_jr16_op:
 			*contpc = regs->regs[insn.mm_i_format.rs];
 			return 1;
-			break;
 		}
 		break;
 	case mm_beqz16_op:
@@ -605,7 +595,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 			*contpc = regs->cp0_epc +
 				dec_insn.pc_inc + dec_insn.next_pc_inc;
 		return 1;
-		break;
 	case mm_bnez16_op:
 		if ((long)regs->regs[reg16to32map[insn.mm_b1_format.rs]] != 0)
 			*contpc = regs->cp0_epc +
@@ -615,12 +604,10 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 			*contpc = regs->cp0_epc +
 				dec_insn.pc_inc + dec_insn.next_pc_inc;
 		return 1;
-		break;
 	case mm_b16_op:
 		*contpc = regs->cp0_epc + dec_insn.pc_inc +
 			 (insn.mm_b0_format.simmediate << 1);
 		return 1;
-		break;
 	case mm_beq32_op:
 		if (regs->regs[insn.mm_i_format.rs] ==
 		    regs->regs[insn.mm_i_format.rt])
@@ -632,7 +619,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 				dec_insn.pc_inc +
 				dec_insn.next_pc_inc;
 		return 1;
-		break;
 	case mm_bne32_op:
 		if (regs->regs[insn.mm_i_format.rs] !=
 		    regs->regs[insn.mm_i_format.rt])
@@ -643,7 +629,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 			*contpc = regs->cp0_epc +
 				dec_insn.pc_inc + dec_insn.next_pc_inc;
 		return 1;
-		break;
 	case mm_jalx32_op:
 		regs->regs[31] = regs->cp0_epc +
 			dec_insn.pc_inc + dec_insn.next_pc_inc;
@@ -652,7 +637,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		*contpc <<= 28;
 		*contpc |= (insn.j_format.target << 2);
 		return 1;
-		break;
 	case mm_jals32_op:
 	case mm_jal32_op:
 		regs->regs[31] = regs->cp0_epc +
@@ -665,7 +649,6 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		*contpc |= (insn.j_format.target << 1);
 		set_isa16_mode(*contpc);
 		return 1;
-		break;
 	}
 	return 0;
 }
@@ -694,7 +677,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		case jr_op:
 			*contpc = regs->regs[insn.r_format.rs];
 			return 1;
-			break;
 		}
 		break;
 	case bcond_op:
@@ -716,7 +698,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 					dec_insn.pc_inc +
 					dec_insn.next_pc_inc;
 			return 1;
-			break;
 		case bgezal_op:
 		case bgezall_op:
 			regs->regs[31] = regs->cp0_epc +
@@ -734,7 +715,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 					dec_insn.pc_inc +
 					dec_insn.next_pc_inc;
 			return 1;
-			break;
 		}
 		break;
 	case jalx_op:
@@ -752,7 +732,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		/* Set microMIPS mode bit: XOR for jalx. */
 		*contpc ^= bit;
 		return 1;
-		break;
 	case beq_op:
 	case beql_op:
 		if (regs->regs[insn.i_format.rs] ==
@@ -765,7 +744,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 				dec_insn.pc_inc +
 				dec_insn.next_pc_inc;
 		return 1;
-		break;
 	case bne_op:
 	case bnel_op:
 		if (regs->regs[insn.i_format.rs] !=
@@ -778,7 +756,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 				dec_insn.pc_inc +
 				dec_insn.next_pc_inc;
 		return 1;
-		break;
 	case blez_op:
 	case blezl_op:
 		if ((long)regs->regs[insn.i_format.rs] <= 0)
@@ -790,7 +767,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 				dec_insn.pc_inc +
 				dec_insn.next_pc_inc;
 		return 1;
-		break;
 	case bgtz_op:
 	case bgtzl_op:
 		if ((long)regs->regs[insn.i_format.rs] > 0)
@@ -802,7 +778,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 				dec_insn.pc_inc +
 				dec_insn.next_pc_inc;
 		return 1;
-		break;
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 	case lwc2_op: /* This is bbit0 on Octeon */
 		if ((regs->regs[insn.i_format.rs] & (1ull<<insn.i_format.rt)) == 0)
@@ -856,7 +831,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 						dec_insn.pc_inc +
 						dec_insn.next_pc_inc;
 				return 1;
-				break;
 			case 1:	/* bc1t */
 			case 3:	/* bc1tl */
 				if (fcr31 & (1 << bit))
@@ -868,7 +842,6 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 						dec_insn.pc_inc +
 						dec_insn.next_pc_inc;
 				return 1;
-				break;
 			}
 		}
 		break;
-- 
1.7.11.7
