Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2017 14:51:41 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52161 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992511AbdJIMvdX-yTY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Oct 2017 14:51:33 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1XQk-0004v7-Ku; Mon, 09 Oct 2017 13:45:11 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1XQP-00020n-Vh; Mon, 09 Oct 2017 13:44:49 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Maciej W. Rozycki" <macro@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "James Hogan" <james.hogan@imgtec.com>
Date:   Mon, 09 Oct 2017 13:44:24 +0100
Message-ID: <lsq.1507553064.726250358@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 071/192] MIPS: Fix unaligned PC interpretation in
 `compute_return_epc'
In-Reply-To: <lsq.1507553063.449494954@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.49-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@imgtec.com>

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/branch.h | 5 +----
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
