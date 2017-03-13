Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2017 20:53:54 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:48892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993986AbdCMTwQMwkRP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Mar 2017 20:52:16 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0C07FADC3;
        Mon, 13 Mar 2017 19:52:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to 3.12-stable] MIPS: Fix is_jump_ins() handling of 16b microMIPS instructions
Date:   Mon, 13 Mar 2017 20:51:19 +0100
Message-Id: <20170313195209.25177-11-jslaby@suse.cz>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170313195209.25177-1-jslaby@suse.cz>
References: <20170313195209.25177-1-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57165
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

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kernel/process.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 664e61ef690b..92cec1380f8c 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -263,9 +263,14 @@ static inline int is_jump_ins(union mips_instruction *ip)
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
2.12.0
