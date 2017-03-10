Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2017 10:11:06 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37026 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992214AbdCJJK5u0gKm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Mar 2017 10:10:57 +0100
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 36966958;
        Fri, 10 Mar 2017 09:10:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Tony Wu <tung7970@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 10/91] MIPS: Handle microMIPS jumps in the same way as MIPS32/MIPS64 jumps
Date:   Fri, 10 Mar 2017 10:08:09 +0100
Message-Id: <20170310083901.244542169@linuxfoundation.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170310083900.730556986@linuxfoundation.org>
References: <20170310083900.730556986@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/process.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -289,6 +289,8 @@ static inline int is_jump_ins(union mips
 		return 0;
 	}
 
+	if (ip->j_format.opcode == mm_j32_op)
+		return 1;
 	if (ip->j_format.opcode == mm_jal32_op)
 		return 1;
 	if (ip->r_format.opcode != mm_pool32a_op ||
