Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Sep 2017 00:12:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9919 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993960AbdIHWMsSveJA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Sep 2017 00:12:48 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 96607D95F1B83;
        Fri,  8 Sep 2017 23:12:36 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 8 Sep 2017 23:12:40
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] MIPS: math-emu: Remove pr_err() calls from fpu_emu()
Date:   Fri, 8 Sep 2017 15:12:21 -0700
Message-ID: <20170908221221.3001-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59968
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

The FPU emulator includes 2 calls to pr_err() which are triggered by
invalid instruction encodings for MIPSr6 cmp.cond.fmt instructions.
These cases are not kernel errors, merely invalid instructions which are
already handled by delivering a SIGILL which will provide notification
that something failed in cases where that makes sense.

In cases where that SIGILL is somewhat expected & being handled, for
example when crashme happens to generate one of the affected bad
encodings, the message is printed with no useful context about what
triggered it & spams the kernel log for no good reason.

Remove the pr_err() calls to make crashme run silently & treat the bad
encodings the same way we do others, with a SIGILL & no further kernel
log output.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: f8c3c6717a71 ("MIPS: math-emu: Add support for the CMP.condn.fmt R6 instruction")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable <stable@vger.kernel.org> # v4.3+
---

 arch/mips/math-emu/cp1emu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index f08a7b4facb9..4f0a1a6f7589 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -2387,7 +2387,6 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 					break;
 				default:
 					/* Reserved R6 ops */
-					pr_err("Reserved MIPS R6 CMP.condn.S operation\n");
 					return SIGILL;
 				}
 			}
@@ -2461,7 +2460,6 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 					break;
 				default:
 					/* Reserved R6 ops */
-					pr_err("Reserved MIPS R6 CMP.condn.D operation\n");
 					return SIGILL;
 				}
 			}
-- 
2.14.1
