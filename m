Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 13:49:00 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:52389 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818702Ab3KGMszBVuVW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Nov 2013 13:48:55 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/6] mips: microMIPS: mfhc1 & mthc1 support for the FPU emulator
Date:   Thu, 7 Nov 2013 12:48:29 +0000
Message-ID: <1383828513-28462-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1383828513-28462-1-git-send-email-paul.burton@imgtec.com>
References: <1383828513-28462-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2013_11_07_12_48_49
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

This patch adds support for microMIPS encodings of the mfhc1 & mthc1
instructions introduced in release 2 of the mips32 & mips64
architectures, converting them to their mips32 equivalents for the FPU
emulator.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h | 2 ++
 arch/mips/math-emu/cp1emu.c       | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 0ee9656..b39ba25 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -398,8 +398,10 @@ enum mm_32f_73_minor_op {
 	mm_movt1_op = 0xa5,
 	mm_ftruncw_op = 0xac,
 	mm_fneg1_op = 0xad,
+	mm_mfhc1_op = 0xc0,
 	mm_froundl_op = 0xcc,
 	mm_fcvtd1_op = 0xcd,
+	mm_mthc1_op = 0xe0,
 	mm_froundw_op = 0xec,
 	mm_fcvts1_op = 0xed,
 };
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 20a51d0..4b37961 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -417,14 +417,20 @@ static int microMIPS32_to_MIPS32(union mips_instruction *insn_ptr)
 			case mm_mtc1_op:
 			case mm_cfc1_op:
 			case mm_ctc1_op:
+			case mm_mfhc1_op:
+			case mm_mthc1_op:
 				if (insn.mm_fp1_format.op == mm_mfc1_op)
 					op = mfc_op;
 				else if (insn.mm_fp1_format.op == mm_mtc1_op)
 					op = mtc_op;
 				else if (insn.mm_fp1_format.op == mm_cfc1_op)
 					op = cfc_op;
-				else
+				else if (insn.mm_fp1_format.op == mm_ctc1_op)
 					op = ctc_op;
+				else if (insn.mm_fp1_format.op == mm_mfhc1_op)
+					op = mfhc_op;
+				else
+					op = mthc_op;
 				mips32_insn.fp1_format.opcode = cop1_op;
 				mips32_insn.fp1_format.op = op;
 				mips32_insn.fp1_format.rt =
-- 
1.8.4.1
