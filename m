Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 01:08:33 +0200 (CEST)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:50968 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993932AbdFGXIZj11gm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Jun 2017 01:08:25 +0200
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id v57N1PGn000377;
        Thu, 8 Jun 2017 01:01:25 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux@roeck-us.net
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 145/250] MIPS: Fix is_jump_ins() handling of 16b microMIPS instructions
Date:   Thu,  8 Jun 2017 00:58:51 +0200
Message-Id: <1496876436-32402-146-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1496876436-32402-1-git-send-email-w@1wt.eu>
References: <1496876436-32402-1-git-send-email-w@1wt.eu>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

From: Paul Burton <paul.burton@imgtec.com>

commit 67c75057709a6d85c681c78b9b2f9b71191f01a2 upstream.

is_jump_ins() checks 16b instruction fields without verifying that the
instruction is indeed 16b, as is done by is_ra_save_ins() &
is_sp_move_ins(). Add the appropriate check.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned access support.")
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14531/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kernel/process.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index e67e17a..427187b1 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -260,9 +260,14 @@ static inline int is_jump_ins(union mips_instruction *ip)
 	 *
 	 * microMIPS is kind of more fun...
 	 */
-	if ((ip->mm16_r5_format.opcode == mm_pool16c_op &&
-	    (ip->mm16_r5_format.rt & mm_jr16_op) == mm_jr16_op) ||
-	    ip->j_format.opcode == mm_jal32_op)
+	if (mm_insn_16bit(ip->halfword[1])) {
+		if ((ip->mm16_r5_format.opcode == mm_pool16c_op &&
+		    (ip->mm16_r5_format.rt & mm_jr16_op) == mm_jr16_op))
+			return 1;
+		return 0;
+	}
+
+	if (ip->j_format.opcode == mm_jal32_op)
 		return 1;
 	if (ip->r_format.opcode != mm_pool32a_op ||
 			ip->r_format.func != mm_pool32axf_op)
-- 
2.8.0.rc2.1.gbe9624a
