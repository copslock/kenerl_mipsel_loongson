Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2017 21:25:55 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36466 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994066AbdGYTUznqvBn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2017 21:20:55 +0200
Received: from localhost (rrcs-64-183-28-114.west.biz.rr.com [64.183.28.114])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AD471B0A;
        Tue, 25 Jul 2017 19:20:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 66/83] MIPS: Send SIGILL for linked branches in `__compute_return_epc_for_insn
Date:   Tue, 25 Jul 2017 12:19:30 -0700
Message-Id: <20170725191718.880288929@linuxfoundation.org>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170725191708.449126292@linuxfoundation.org>
References: <20170725191708.449126292@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@imgtec.com>

commit fef40be6da856afead4177aaa9d869a66fb3381f upstream.

Fix commit 319824eabc3f ("MIPS: kernel: branch: Do not emulate the
branch likelies on MIPS R6") and also send SIGILL rather than returning
-SIGILL for BLTZAL, BLTZALL, BGEZAL and BGEZALL instruction encodings no
longer supported in R6, except where emulated.  Returning -SIGILL is
never correct as the API defines this function's result upon error to be
-EFAULT and a signal actually issued.

Fixes: 319824eabc3f ("MIPS: kernel: branch: Do not emulate the branch likelies on MIPS R6")
Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16398/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/branch.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -473,10 +473,8 @@ int __compute_return_epc_for_insn(struct
 		case bltzal_op:
 		case bltzall_op:
 			if (NO_R6EMU && (insn.i_format.rs ||
-			    insn.i_format.rt == bltzall_op)) {
-				ret = -SIGILL;
-				break;
-			}
+			    insn.i_format.rt == bltzall_op))
+				goto sigill_r2r6;
 			regs->regs[31] = epc + 8;
 			/*
 			 * OK we are here either because we hit a NAL
@@ -507,10 +505,8 @@ int __compute_return_epc_for_insn(struct
 		case bgezal_op:
 		case bgezall_op:
 			if (NO_R6EMU && (insn.i_format.rs ||
-			    insn.i_format.rt == bgezall_op)) {
-				ret = -SIGILL;
-				break;
-			}
+			    insn.i_format.rt == bgezall_op))
+				goto sigill_r2r6;
 			regs->regs[31] = epc + 8;
 			/*
 			 * OK we are here either because we hit a BAL
