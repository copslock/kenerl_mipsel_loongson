Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2017 10:20:24 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992267AbdCJJRpeKwcm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Mar 2017 10:17:45 +0100
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2157E360;
        Fri, 10 Mar 2017 09:17:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.9 006/153] MIPS: Clear ISA bit correctly in get_frame_info()
Date:   Fri, 10 Mar 2017 10:07:19 +0100
Message-Id: <20170310083947.505510611@linuxfoundation.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170310083947.108106897@linuxfoundation.org>
References: <20170310083947.108106897@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57117
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/process.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -303,17 +303,14 @@ static inline int is_sp_move_ins(union m
 
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
 
