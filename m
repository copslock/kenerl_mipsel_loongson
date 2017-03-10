Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2017 10:31:28 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:40892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993949AbdCJJ1tO7HfY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Mar 2017 10:27:49 +0100
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C6C07258;
        Fri, 10 Mar 2017 09:27:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.10 009/167] MIPS: Fix is_jump_ins() handling of 16b microMIPS instructions
Date:   Fri, 10 Mar 2017 10:07:32 +0100
Message-Id: <20170310083957.437807978@linuxfoundation.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170310083956.767605269@linuxfoundation.org>
References: <20170310083956.767605269@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57129
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

4.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/process.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -241,9 +241,14 @@ static inline int is_jump_ins(union mips
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
