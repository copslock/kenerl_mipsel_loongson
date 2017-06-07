Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 01:01:39 +0200 (CEST)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:50005 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990508AbdFGXBbPpLim (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Jun 2017 01:01:31 +0200
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id v57N1PBJ000374;
        Thu, 8 Jun 2017 01:01:25 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux@roeck-us.net
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 142/250] MIPS: Clear ISA bit correctly in get_frame_info()
Date:   Thu,  8 Jun 2017 00:58:48 +0200
Message-Id: <1496876436-32402-143-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1496876436-32402-1-git-send-email-w@1wt.eu>
References: <1496876436-32402-1-git-send-email-w@1wt.eu>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58293
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
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kernel/process.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index c6a041d..11468a0 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -322,17 +322,14 @@ static inline int is_sp_move_ins(union mips_instruction *ip)
 
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
2.8.0.rc2.1.gbe9624a
