Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2006 16:58:18 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:12000 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8126937AbWGaP6G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 31 Jul 2006 16:58:06 +0100
Received: from localhost (p3075-ipad208funabasi.chiba.ocn.ne.jp [60.43.104.75])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8926BA85D; Tue,  1 Aug 2006 00:58:00 +0900 (JST)
Date:	Tue, 01 Aug 2006 00:59:33 +0900 (JST)
Message-Id: <20060801.005933.76462287.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44CE26FA.8070909@innova-card.com>
References: <44CE1494.4080801@innova-card.com>
	<20060801.003311.75758612.anemo@mba.ocn.ne.jp>
	<44CE26FA.8070909@innova-card.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 31 Jul 2006 17:51:22 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> while you're at it, (union mips_instruction *) cast is useless and "func"
> local too. Just write 
> 
> 	union mips_instruction *ip = info->func;
> 
> is more readable, IMHO.

Indeed.  Revised.


Subject: [PATCH] make get_frame_info() more readable.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 8709a46..cd99bc8 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -284,20 +284,18 @@ static int mfinfo_num;
 static int get_frame_info(struct mips_frame_info *info)
 {
 	int i;
-	void *func = info->func;
-	union mips_instruction *ip = (union mips_instruction *)func;
+	union mips_instruction *ip = info->func;
+	int max_insns =
+		min(128UL, info->func_size / sizeof(union mips_instruction));
 	info->pc_offset = -1;
 	info->frame_size = 0;
-	for (i = 0; i < 128; i++, ip++) {
+	for (i = 0; i < max_insns; i++, ip++) {
 		/* if jal, jalr, jr, stop. */
 		if (ip->j_format.opcode == jal_op ||
 		    (ip->r_format.opcode == spec_op &&
 		     (ip->r_format.func == jalr_op ||
 		      ip->r_format.func == jr_op)))
 			break;
-
-		if (info->func_size && i >= info->func_size / 4)
-			break;
 		if (
 #ifdef CONFIG_32BIT
 		    ip->i_format.opcode == addiu_op &&
