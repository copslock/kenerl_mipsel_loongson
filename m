Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2017 03:23:24 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37974 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992998AbdKVCUZukKln (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Nov 2017 03:20:25 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1eHKeE-0004YN-JD; Wed, 22 Nov 2017 02:20:22 +0000
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1eHKe8-0003Bt-D8; Wed, 22 Nov 2017 02:20:16 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ingo Molnar" <mingo@kernel.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Matt Redfearn" <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org,
        "Marcin Nowakowski" <marcin.nowakowski@imgtec.com>
Date:   Wed, 22 Nov 2017 01:58:13 +0000
Message-ID: <lsq.1511315893.41480273@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 093/133] MIPS: microMIPS: Fix detection of addiusp
 instruction
In-Reply-To: <lsq.1511315892.657723235@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61042
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

3.16.51-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@imgtec.com>

commit b332fec0489295ee7a0aab4a89bd7257cd126f7f upstream.

The addiusp instruction uses the pool16d opcode, with bit 0 of the
immediate set. The test for the addiusp opcode erroneously did a logical
and of the immediate with mm_addiusp_func, which has value 1, so this
test always passes when the immediate is non-zero.

Fix the test by replacing the logical and with a bitwise and.

Fixes: 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned access support.")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16954/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -353,7 +353,7 @@ static inline int is_sp_move_ins(union m
 	 */
 	if (mm_insn_16bit(ip->halfword[1])) {
 		return (ip->mm16_r3_format.opcode == mm_pool16d_op &&
-			ip->mm16_r3_format.simmediate && mm_addiusp_func) ||
+			ip->mm16_r3_format.simmediate & mm_addiusp_func) ||
 		       (ip->mm16_r5_format.opcode == mm_pool16d_op &&
 			ip->mm16_r5_format.rt == 29);
 	}
