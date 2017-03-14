Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 14:17:29 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:45780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991948AbdCNNP57BV4N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Mar 2017 14:15:57 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C6D85AD79;
        Tue, 14 Mar 2017 13:15:57 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 09/60] MIPS: Fix get_frame_info() handling of microMIPS function size
Date:   Tue, 14 Mar 2017 14:15:00 +0100
Message-Id: <aae839a7f81cf4311a5276f22fea654fd2e0ad7e.1489497268.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <d93cf67053e241539a1ef7c30ee8583022bc0e89.1489497268.git.jslaby@suse.cz>
References: <d93cf67053e241539a1ef7c30ee8583022bc0e89.1489497268.git.jslaby@suse.cz>
In-Reply-To: <cover.1489497268.git.jslaby@suse.cz>
References: <cover.1489497268.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kernel/process.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 5b91c4d88f46..664e61ef690b 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -315,9 +315,9 @@ static inline int is_sp_move_ins(union mips_instruction *ip)
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
@@ -326,11 +326,9 @@ static int get_frame_info(struct mips_frame_info *info)
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
2.12.0
