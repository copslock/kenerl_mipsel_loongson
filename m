Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 01:04:58 +0200 (CEST)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:50562 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993954AbdFGXESamm5m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Jun 2017 01:04:18 +0200
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id v57N1PHD000376;
        Thu, 8 Jun 2017 01:01:25 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux@roeck-us.net
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 144/250] MIPS: Fix get_frame_info() handling of microMIPS function size
Date:   Thu,  8 Jun 2017 00:58:50 +0200
Message-Id: <1496876436-32402-145-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1496876436-32402-1-git-send-email-w@1wt.eu>
References: <1496876436-32402-1-git-send-email-w@1wt.eu>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58298
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

commit b6c7a324df37bf05ef7a2c1580683cf10d082d97 upstream.

get_frame_info() is meant to iterate over up to the first 128
instructions within a function, but for microMIPS kernels it will not
reach that many instructions unless the function is 512 bytes long since
we calculate the maximum number of instructions to check by dividing the
function length by the 4 byte size of a union mips_instruction. In
microMIPS kernels this won't do since instructions are variable length.

Fix this by instead checking whether the pointer to the current
instruction has reached the end of the function, and use max_insns as a
simple constant to check the number of iterations against.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned access support.")
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14530/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kernel/process.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 71110b9..e67e17a 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -312,9 +312,9 @@ static inline int is_sp_move_ins(union mips_instruction *ip)
 static int get_frame_info(struct mips_frame_info *info)
 {
 	bool is_mmips = IS_ENABLED(CONFIG_CPU_MICROMIPS);
-	union mips_instruction insn, *ip;
-	unsigned max_insns = info->func_size / sizeof(union mips_instruction);
-	unsigned i;
+	union mips_instruction insn, *ip, *ip_end;
+	const unsigned int max_insns = 128;
+	unsigned int i;
 
 	info->pc_offset = -1;
 	info->frame_size = 0;
@@ -323,11 +323,9 @@ static int get_frame_info(struct mips_frame_info *info)
 	if (!ip)
 		goto err;
 
-	if (max_insns == 0)
-		max_insns = 128U;	/* unknown function size */
-	max_insns = min(128U, max_insns);
+	ip_end = (void *)ip + info->func_size;
 
-	for (i = 0; i < max_insns; i++, ip++) {
+	for (i = 0; i < max_insns && ip < ip_end; i++, ip++) {
 		if (is_mmips && mm_insn_16bit(ip->halfword[0])) {
 			insn.halfword[0] = 0;
 			insn.halfword[1] = ip->halfword[0];
-- 
2.8.0.rc2.1.gbe9624a
