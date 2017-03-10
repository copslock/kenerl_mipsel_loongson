Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2017 10:30:54 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:40880 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992244AbdCJJ1pln6oY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Mar 2017 10:27:45 +0100
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C8AAC8A6;
        Fri, 10 Mar 2017 09:27:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.10 008/167] MIPS: Fix get_frame_info() handling of microMIPS function size
Date:   Fri, 10 Mar 2017 10:07:31 +0100
Message-Id: <20170310083957.373560192@linuxfoundation.org>
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
X-archive-position: 57128
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/process.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -293,9 +293,9 @@ static inline int is_sp_move_ins(union m
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
@@ -304,11 +304,9 @@ static int get_frame_info(struct mips_fr
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
