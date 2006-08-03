Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2006 08:32:27 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:61052 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133779AbWHCHaN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Aug 2006 08:30:13 +0100
Received: by nf-out-0910.google.com with SMTP id q29so939695nfc
        for <linux-mips@linux-mips.org>; Thu, 03 Aug 2006 00:30:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SJzNVPGFlD8h3+ehkGR0MOifxUKxzLC/w6ic+ZOhJzwpU8kelh+IX9ljw5+oDa7KIhMiR8vVO7WW2BFL7nvRCLYD9lk9hlo/RzFPnf3bHDA9dbsSLZ0jOSzqh2qlwF4mp7v6Ld8EFgHFPdWm0vOQTTRXCGF6yAUKfRD6mbTpdks=
Received: by 10.48.202.19 with SMTP id z19mr3367529nff;
        Thu, 03 Aug 2006 00:30:12 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id k23sm661722nfc.2006.08.03.00.30.11;
        Thu, 03 Aug 2006 00:30:12 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 3251E23F759; Thu,  3 Aug 2006 09:29:21 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 1/7] Make get_frame_info() more readable.
Date:	Thu,  3 Aug 2006 09:29:15 +0200
Message-Id: <11545901611185-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11545901611096-git-send-email-vagabon.xyz@gmail.com>
References: <11545901611096-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/process.c |   67 ++++++++++++++++++++++++--------------------
 1 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 8709a46..93d5432 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -281,48 +281,53 @@ static struct mips_frame_info {
 } *schedule_frame, mfinfo[64];
 static int mfinfo_num;
 
+static inline int is_ra_save_ins(union mips_instruction *ip)
+{
+	/* sw / sd $ra, offset($sp) */
+	return (ip->i_format.opcode == sw_op || ip->i_format.opcode == sd_op) &&
+		ip->i_format.rs == 29 &&
+		ip->i_format.rt == 31;
+}
+
+static inline int is_jal_jalr_jr_ins(union mips_instruction *ip)
+{
+	if (ip->j_format.opcode == jal_op)
+		return 1;
+	if (ip->r_format.opcode != spec_op)
+		return 0;
+	return ip->r_format.func == jalr_op || ip->r_format.func == jr_op;
+}
+
+static inline int is_sp_move_ins(union mips_instruction *ip)
+{
+	/* addiu/daddiu sp,sp,-imm */
+	if (ip->i_format.rs != 29 || ip->i_format.rt != 29)
+		return 0;
+	if (ip->i_format.opcode == addiu_op || ip->i_format.opcode == daddiu_op)
+		return 1;
+	return 0;
+}
+
 static int get_frame_info(struct mips_frame_info *info)
 {
-	int i;
-	void *func = info->func;
-	union mips_instruction *ip = (union mips_instruction *)func;
+	union mips_instruction *ip = info->func;
+	int i, max_insns =
+		min(128UL, info->func_size / sizeof(union mips_instruction));
+
 	info->pc_offset = -1;
 	info->frame_size = 0;
-	for (i = 0; i < 128; i++, ip++) {
-		/* if jal, jalr, jr, stop. */
-		if (ip->j_format.opcode == jal_op ||
-		    (ip->r_format.opcode == spec_op &&
-		     (ip->r_format.func == jalr_op ||
-		      ip->r_format.func == jr_op)))
-			break;
 
-		if (info->func_size && i >= info->func_size / 4)
+	for (i = 0; i < max_insns; i++, ip++) {
+
+		if (is_jal_jalr_jr_ins(ip))
 			break;
-		if (
-#ifdef CONFIG_32BIT
-		    ip->i_format.opcode == addiu_op &&
-#endif
-#ifdef CONFIG_64BIT
-		    ip->i_format.opcode == daddiu_op &&
-#endif
-		    ip->i_format.rs == 29 &&
-		    ip->i_format.rt == 29) {
-			/* addiu/daddiu sp,sp,-imm */
+		if (is_sp_move_ins(ip)) {
 			if (info->frame_size)
 				continue;
 			info->frame_size = - ip->i_format.simmediate;
 		}
 
-		if (
-#ifdef CONFIG_32BIT
-		    ip->i_format.opcode == sw_op &&
-#endif
-#ifdef CONFIG_64BIT
-		    ip->i_format.opcode == sd_op &&
-#endif
-		    ip->i_format.rs == 29 &&
-		    ip->i_format.rt == 31) {
-			/* sw / sd $ra, offset($sp) */
+		if (is_ra_save_ins(ip)) {
 			if (info->pc_offset != -1)
 				continue;
 			info->pc_offset =
-- 
1.4.2.rc2
