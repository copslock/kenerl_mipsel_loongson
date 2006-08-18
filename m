Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2006 15:18:37 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.198]:50882 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20037789AbWHROSg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Aug 2006 15:18:36 +0100
Received: by nz-out-0102.google.com with SMTP id s1so522641nze
        for <linux-mips@linux-mips.org>; Fri, 18 Aug 2006 07:18:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ekjc+sc8B1UjcKOjn7GvnohBWQqjtV8FqGs05jeNIZNufCAqe0UpGMxr0CHqlN0xa2UTOxX+RctqduH0Ee0WS4YLtB1CWsJHWQ08ko778No3hRNQdLt+RxIP9+GXb5zzqZzoL4J/3NSla8lY30pleXtyseLbGOO3GyjTCc4R1jA=
Received: by 10.65.97.18 with SMTP id z18mr3757354qbl;
        Fri, 18 Aug 2006 07:18:34 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id e19sm1003317qba.2006.08.18.07.18.33;
        Fri, 18 Aug 2006 07:18:34 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id ABD0023F76E; Fri, 18 Aug 2006 16:18:09 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 2/3] get_frame_info(): null function size means size is unknown
Date:	Fri, 18 Aug 2006 16:18:08 +0200
Message-Id: <11559106892565-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc4
In-Reply-To: <11559106892428-git-send-email-vagabon.xyz@gmail.com>
References: <11559106892428-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

This patch adds 2 sanity checks.

The first one test that the start address of the function to analyze has been
set by the caller. If not return an error since nothing usefull can be done
without.

The second one checks that the function's size has been set. A null size can
happen if CONFIG_KALLSYMS is not set and it means that we don't know the size
of the function to analyze. In this case, we make it equal to 128 instructions
by default.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/process.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index e7b0b38..cc67bf7 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -311,12 +311,19 @@ static inline int is_sp_move_ins(union m
 static int get_frame_info(struct mips_frame_info *info)
 {
 	union mips_instruction *ip = info->func;
-	int i, max_insns =
-		min(128UL, info->func_size / sizeof(union mips_instruction));
+	unsigned max_insns = info->func_size / sizeof(union mips_instruction);
+	unsigned i;
 
 	info->pc_offset = -1;
 	info->frame_size = 0;
 
+	if (!ip)
+		goto err;
+	
+	if (max_insns == 0)
+		max_insns = 128U;	/* unknown function size */
+	max_insns = min(128U, max_insns);
+
 	for (i = 0; i < max_insns; i++, ip++) {
 
 		if (is_jal_jalr_jr_ins(ip))
@@ -337,6 +344,7 @@ static int get_frame_info(struct mips_fr
 	if (info->pc_offset < 0) /* leaf */
 		return 1;
 	/* prologue seems boggus... */
+err:
 	return -1;
 }
 
-- 
1.4.2.rc4
