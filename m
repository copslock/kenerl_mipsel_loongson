Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2017 20:54:38 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:48904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993988AbdCMTwQwR9XP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Mar 2017 20:52:16 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B0490AD95;
        Mon, 13 Mar 2017 19:52:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     Paul Burton <paul.burton@imgtec.com>, Tony Wu <tung7970@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to 3.12-stable] MIPS: Handle microMIPS jumps in the same way as MIPS32/MIPS64 jumps
Date:   Mon, 13 Mar 2017 20:51:21 +0100
Message-Id: <20170313195209.25177-13-jslaby@suse.cz>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170313195209.25177-1-jslaby@suse.cz>
References: <20170313195209.25177-1-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57167
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

commit 096a0de427ea333f56f0ee00328cff2a2731bcf1 upstream.

is_jump_ins() checks for plain jump ("j") instructions since commit
e7438c4b893e ("MIPS: Fix sibling call handling in get_frame_info") but
that commit didn't make the same change to the microMIPS code, leaving
it inconsistent with the MIPS32/MIPS64 code. Handle the microMIPS
encoding of the jump instruction too such that it behaves consistently.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: e7438c4b893e ("MIPS: Fix sibling call handling in get_frame_info")
Cc: Tony Wu <tung7970@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14533/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index a79bcd66778f..77e938d34f44 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -315,6 +315,8 @@ static inline int is_jump_ins(union mips_instruction *ip)
 		return 0;
 	}
 
+	if (ip->j_format.opcode == mm_j32_op)
+		return 1;
 	if (ip->j_format.opcode == mm_jal32_op)
 		return 1;
 	if (ip->r_format.opcode != mm_pool32a_op ||
-- 
2.12.0
