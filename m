Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2017 21:31:12 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994855AbdGYTWDFOcLn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2017 21:22:03 +0200
Received: from localhost (rrcs-64-183-28-114.west.biz.rr.com [64.183.28.114])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1897CA55;
        Tue, 25 Jul 2017 19:21:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.9 090/125] MIPS: Fix unaligned PC interpretation in `compute_return_epc
Date:   Tue, 25 Jul 2017 12:20:05 -0700
Message-Id: <20170725192019.274700971@linuxfoundation.org>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170725192014.314851996@linuxfoundation.org>
References: <20170725192014.314851996@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59258
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@imgtec.com>

commit 11a3799dbeb620bf0400b1fda5cc2c6bea55f20a upstream.

Fix a regression introduced with commit fb6883e5809c ("MIPS: microMIPS:
Support handling of delay slots.") and defer to `__compute_return_epc'
if the ISA bit is set in EPC with non-MIPS16, non-microMIPS hardware,
which will then arrange for a SIGBUS due to an unaligned instruction
reference.  Returning EPC here is never correct as the API defines this
function's result to be either a negative error code on failure or one
of 0 and BRANCH_LIKELY_TAKEN on success.

Fixes: fb6883e5809c ("MIPS: microMIPS: Support handling of delay slots.")
Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16395/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/branch.h |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/arch/mips/include/asm/branch.h
+++ b/arch/mips/include/asm/branch.h
@@ -74,10 +74,7 @@ static inline int compute_return_epc(str
 			return __microMIPS_compute_return_epc(regs);
 		if (cpu_has_mips16)
 			return __MIPS16e_compute_return_epc(regs);
-		return regs->cp0_epc;
-	}
-
-	if (!delay_slot(regs)) {
+	} else if (!delay_slot(regs)) {
 		regs->cp0_epc += 4;
 		return 0;
 	}
