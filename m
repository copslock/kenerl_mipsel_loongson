Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 14:24:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34453 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993122AbdHHMXAO0v5G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 14:23:00 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 43B1C73B44E40;
        Tue,  8 Aug 2017 13:22:51 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 8 Aug 2017 13:22:54 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v3 2/6] MIPS: microMIPS: Fix detection of addiusp instruction
Date:   Tue, 8 Aug 2017 13:22:31 +0100
Message-ID: <1502194955-18018-3-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1502194955-18018-1-git-send-email-matt.redfearn@imgtec.com>
References: <1502194955-18018-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

The addiusp instruction uses the pool16d opcode, with bit 0 of the
immediate set. The test for the addiusp opcode erroneously did a logical
and of the immediate with mm_addiusp_func, which has value 1, so this
test always passes when the immediate is non-zero.

Fix the test by replacing the logical and with a bitwise and.

Fixes: 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned access support.")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

Changes in v3:
- New patch to fix detection of addiusp instruction

Changes in v2: None

 arch/mips/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 5950ecf469e9..9d38faf01055 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -326,7 +326,7 @@ static inline int is_sp_move_ins(union mips_instruction *ip)
 	 */
 	if (mm_insn_16bit(ip->halfword[1])) {
 		return (ip->mm16_r3_format.opcode == mm_pool16d_op &&
-			ip->mm16_r3_format.simmediate && mm_addiusp_func) ||
+			ip->mm16_r3_format.simmediate & mm_addiusp_func) ||
 		       (ip->mm16_r5_format.opcode == mm_pool16d_op &&
 			ip->mm16_r5_format.rt == 29);
 	}
-- 
2.7.4
