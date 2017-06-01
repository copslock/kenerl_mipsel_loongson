Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jun 2017 17:48:11 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36904 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993983AbdFAPoafH0E- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jun 2017 17:44:30 +0200
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1dGSGx-0004uH-OC; Thu, 01 Jun 2017 16:44:27 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1dGSGo-0007gx-SC; Thu, 01 Jun 2017 16:44:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        "Tony Wu" <tung7970@gmail.com>
Date:   Thu, 01 Jun 2017 16:43:15 +0100
Message-ID: <lsq.1496331795.409631640@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 011/212] MIPS: Handle microMIPS jumps in the same way
 as MIPS32/MIPS64 jumps
In-Reply-To: <lsq.1496331794.574686034@decadent.org.uk>
X-SA-Exim-Connect-IP: 82.70.136.246
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58122
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

3.16.44-rc1 review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -321,6 +321,8 @@ static inline int is_jump_ins(union mips
 		return 0;
 	}
 
+	if (ip->j_format.opcode == mm_j32_op)
+		return 1;
 	if (ip->j_format.opcode == mm_jal32_op)
 		return 1;
 	if (ip->r_format.opcode != mm_pool32a_op ||
