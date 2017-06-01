Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jun 2017 17:44:50 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36878 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993923AbdFAPoWGv1R- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jun 2017 17:44:22 +0200
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1dGSGp-0004t5-9K; Thu, 01 Jun 2017 16:44:21 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1dGSGn-0007gZ-Vb; Thu, 01 Jun 2017 16:44:17 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, "Paul Burton" <paul.burton@imgtec.com>,
        "Leonid Yegoshin" <leonid.yegoshin@imgtec.com>
Date:   Thu, 01 Jun 2017 16:43:15 +0100
Message-ID: <lsq.1496331795.257908864@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 006/212] MIPS: Clear ISA bit correctly in
 get_frame_info()
In-Reply-To: <lsq.1496331794.574686034@decadent.org.uk>
X-SA-Exim-Connect-IP: 82.70.136.246
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58116
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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/process.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -331,17 +331,14 @@ static inline int is_sp_move_ins(union m
 
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
 
