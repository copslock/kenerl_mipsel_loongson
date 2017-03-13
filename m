Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2017 20:52:43 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:48874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993983AbdCMTwPXA8UP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Mar 2017 20:52:15 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F1580ADAA;
        Mon, 13 Mar 2017 19:52:14 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to 3.12-stable] MIPS: Clear ISA bit correctly in get_frame_info()
Date:   Mon, 13 Mar 2017 20:51:16 +0100
Message-Id: <20170313195209.25177-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170313195209.25177-1-jslaby@suse.cz>
References: <20170313195209.25177-1-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57162
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

commit ccaf7caf2c73c6db920772bf08bf1d47b2170634 upstream.

get_frame_info() can be called in microMIPS kernels with the ISA bit
already clear. For example this happens when unwind_stack_by_address()
is called because we begin with a PC that has the ISA bit set & subtract
the (odd) offset from the preceding symbol (which does not have the ISA
bit set). Since get_frame_info() unconditionally subtracts 1 from the PC
in microMIPS kernels it incorrectly misaligns the address it then
attempts to access code at, leading to an address error exception.

Fix this by using msk_isa16_mode() to clear the ISA bit, which allows
get_frame_info() to function regardless of whether it is provided with a
PC that has the ISA bit set or not.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned access support.")
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14528/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kernel/process.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index ddc76103e78c..c5880a894a25 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -325,17 +325,14 @@ static inline int is_sp_move_ins(union mips_instruction *ip)
 
 static int get_frame_info(struct mips_frame_info *info)
 {
-#ifdef CONFIG_CPU_MICROMIPS
-	union mips_instruction *ip = (void *) (((char *) info->func) - 1);
-#else
-	union mips_instruction *ip = info->func;
-#endif
+	union mips_instruction *ip;
 	unsigned max_insns = info->func_size / sizeof(union mips_instruction);
 	unsigned i;
 
 	info->pc_offset = -1;
 	info->frame_size = 0;
 
+	ip = (void *)msk_isa16_mode((ulong)info->func);
 	if (!ip)
 		goto err;
 
-- 
2.12.0
