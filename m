Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2017 03:24:14 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38121 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993022AbdKVCU1qoZXn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Nov 2017 03:20:27 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1eHKeE-0004YS-IN; Wed, 22 Nov 2017 02:20:22 +0000
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1eHKe8-0003C8-FV; Wed, 22 Nov 2017 02:20:16 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paul Burton" <paul.burton@imgtec.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Marcin Nowakowski" <marcin.nowakowski@imgtec.com>,
        "James Hogan" <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        "Matt Redfearn" <matt.redfearn@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Wed, 22 Nov 2017 01:58:13 +0000
Message-ID: <lsq.1511315893.991518738@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 096/133] MIPS: Stacktrace: Fix microMIPS stack
 unwinding on big endian systems
In-Reply-To: <lsq.1511315892.657723235@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61044
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

3.16.51-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@imgtec.com>

commit 41885b02127c7ae169dc94542de4a8eed175495a upstream.

The stack unwinding code uses the mips_instuction union to decode the
instructions it finds. That union uses the __BITFIELD_FIELD macro to
reorder depending on endianness. The stack unwinding code always places
16bit instructions in halfword 1 of the union. This makes the union
accesses correct for little endian systems. Similarly, 32bit
instructions are reordered such that they are correct for little endian
systems. This handling leaves unwinding the stack on big endian systems
broken, as the mips_instruction union will then look for the fields in
the wrong halfword.

To fix this, use a logical shift to place the 16bit instruction into the
correct position in the word field of the union. Use the same shifting
to order the 2 halfwords of 32bit instuctions. Then replace accesses to
the halfword with accesses to the shifted word.
In the case of the ADDIUS5 instruction, switch to using the
mm16_r5_format union member to avoid the need for a 16bit shift.

Fixes: 34c2f668d0f6 ("MIPS: microMIPS: Add unaligned access support.")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16956/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/process.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -235,7 +235,7 @@ static inline int is_ra_save_ins(union m
 	 *
 	 * microMIPS is way more fun...
 	 */
-	if (mm_insn_16bit(ip->halfword[1])) {
+	if (mm_insn_16bit(ip->word >> 16)) {
 		switch (ip->mm16_r5_format.opcode) {
 		case mm_swsp16_op:
 			if (ip->mm16_r5_format.rt != 31)
@@ -314,7 +314,7 @@ static inline int is_jump_ins(union mips
 	 *
 	 * microMIPS is kind of more fun...
 	 */
-	if (mm_insn_16bit(ip->halfword[1])) {
+	if (mm_insn_16bit(ip->word >> 16)) {
 		if ((ip->mm16_r5_format.opcode == mm_pool16c_op &&
 		    (ip->mm16_r5_format.rt & mm_jr16_op) == mm_jr16_op))
 			return 1;
@@ -351,7 +351,7 @@ static inline int is_sp_move_ins(union m
 	 *
 	 * microMIPS is not more fun...
 	 */
-	if (mm_insn_16bit(ip->halfword[1])) {
+	if (mm_insn_16bit(ip->word >> 16)) {
 		return (ip->mm16_r3_format.opcode == mm_pool16d_op &&
 			ip->mm16_r3_format.simmediate & mm_addiusp_func) ||
 		       (ip->mm16_r5_format.opcode == mm_pool16d_op &&
@@ -390,12 +390,10 @@ static int get_frame_info(struct mips_fr
 	for (i = 0; i < max_insns && ip < ip_end; i++) {
 		ip = (void *)ip + last_insn_size;
 		if (is_mmips && mm_insn_16bit(ip->halfword[0])) {
-			insn.halfword[0] = 0;
-			insn.halfword[1] = ip->halfword[0];
+			insn.word = ip->halfword[0] << 16;
 			last_insn_size = 2;
 		} else if (is_mmips) {
-			insn.halfword[0] = ip->halfword[1];
-			insn.halfword[1] = ip->halfword[0];
+			insn.word = ip->halfword[0] << 16 | ip->halfword[1];
 			last_insn_size = 4;
 		} else {
 			insn.word = ip->word;
@@ -409,7 +407,7 @@ static int get_frame_info(struct mips_fr
 			if (is_sp_move_ins(&insn))
 			{
 #ifdef CONFIG_CPU_MICROMIPS
-				if (mm_insn_16bit(ip->halfword[0]))
+				if (mm_insn_16bit(insn.word >> 16))
 				{
 					unsigned short tmp;
 
@@ -422,7 +420,7 @@ static int get_frame_info(struct mips_fr
 							tmp ^= 0x100;
 						info->frame_size = -(signed short)(tmp << 2);
 					} else {
-						tmp = (ip->halfword[0] >> 1);
+						tmp = (ip->mm16_r5_format.imm >> 1);
 						info->frame_size = -(signed short)(tmp & 0xf);
 					}
 				} else
