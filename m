Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:26:24 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27009720AbbDCWYYMlq3Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:24:24 +0200
Date:   Fri, 3 Apr 2015 23:24:24 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 10/48] MIPS: math-emu: Reindent `bc_op' emulation
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030225320.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Correct the double-tab indentation of the branch-likely not-taken case.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-bc1x-indent.patch
Index: linux/arch/mips/math-emu/cp1emu.c
===================================================================
--- linux.orig/arch/mips/math-emu/cp1emu.c	2015-04-02 20:18:52.010538000 +0100
+++ linux/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:53.154170000 +0100
@@ -1192,17 +1192,17 @@ static int cop1Emulate(struct pt_regs *x
 				 */
 				return mips_dsemul(xcp, ir, contpc);
 			} else if (likely) {	/* branch not taken */
-					/*
-					 * branch likely nullifies
-					 * dslot if not taken
-					 */
-					xcp->cp0_epc += dec_insn.pc_inc;
-					contpc += dec_insn.pc_inc;
-					/*
-					 * else continue & execute
-					 * dslot as normal insn
-					 */
-				}
+				/*
+				 * branch likely nullifies
+				 * dslot if not taken
+				 */
+				xcp->cp0_epc += dec_insn.pc_inc;
+				contpc += dec_insn.pc_inc;
+				/*
+				 * else continue & execute
+				 * dslot as normal insn
+				 */
+			}
 			break;
 
 		default:
