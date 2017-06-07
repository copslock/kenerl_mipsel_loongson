Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 01:05:56 +0200 (CEST)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:50693 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993984AbdFGXE7wXOFm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Jun 2017 01:04:59 +0200
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id v57N1Qlu000379;
        Thu, 8 Jun 2017 01:01:26 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux@roeck-us.net
Cc:     Paul Burton <paul.burton@imgtec.com>, Tony Wu <tung7970@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 147/250] MIPS: Handle microMIPS jumps in the same way as MIPS32/MIPS64 jumps
Date:   Thu,  8 Jun 2017 00:58:53 +0200
Message-Id: <1496876436-32402-148-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1496876436-32402-1-git-send-email-w@1wt.eu>
References: <1496876436-32402-1-git-send-email-w@1wt.eu>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58300
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
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 5a93369..3cfa3bc 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -312,6 +312,8 @@ static inline int is_jump_ins(union mips_instruction *ip)
 		return 0;
 	}
 
+	if (ip->j_format.opcode == mm_j32_op)
+		return 1;
 	if (ip->j_format.opcode == mm_jal32_op)
 		return 1;
 	if (ip->r_format.opcode != mm_pool32a_op ||
-- 
2.8.0.rc2.1.gbe9624a
