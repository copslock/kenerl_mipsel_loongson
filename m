Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 16:09:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27374 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991984AbcKGPJEFonUw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 16:09:04 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 24E0A1234749;
        Mon,  7 Nov 2016 15:08:55 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 15:08:57 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        "# v3 . 10+" <stable@vger.kernel.org>
Subject: [PATCH 4/6] MIPS: Fix is_jump_ins() handling of 16b microMIPS instructions
Date:   Mon, 7 Nov 2016 15:07:05 +0000
Message-ID: <20161107150707.5079-5-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161107150707.5079-1-paul.burton@imgtec.com>
References: <20161107150707.5079-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

is_jump_ins() checks 16b instruction fields without verifying that the
instruction is indeed 16b, as is done by is_ra_save_ins() &
is_sp_move_ins(). Add the appropriate check.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned access support.")
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: <stable@vger.kernel.org> # v3.10+
---

 arch/mips/kernel/process.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index d56ef4b..298dc33 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -241,9 +241,14 @@ static inline int is_jump_ins(union mips_instruction *ip)
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
2.10.2
