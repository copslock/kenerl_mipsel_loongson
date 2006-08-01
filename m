Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2006 10:30:00 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:4888 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133590AbWHAJ2M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Aug 2006 10:28:12 +0100
Received: by nf-out-0910.google.com with SMTP id q29so210806nfc
        for <linux-mips@linux-mips.org>; Tue, 01 Aug 2006 02:28:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OWyOSYRjBkh7EaqqlYjLsWKRNSqrWoSk1+JiYscmaF7f+vj7ADqdlyTbsGvWXlzFAySazoumOtpqDaYgUBKa06/Grm7PU3KE8z840ydChlOtp2OoGR9G20R1LqvQSF3aJ4945CEduZJMA7bdTEGYiP+zVwSIQuhoYmIVIWNnZ/s=
Received: by 10.48.202.19 with SMTP id z19mr390784nff;
        Tue, 01 Aug 2006 02:28:12 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id l32sm168916nfa.2006.08.01.02.28.11;
        Tue, 01 Aug 2006 02:28:12 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 79AF023F76F; Tue,  1 Aug 2006 11:27:18 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 2/7] Make get_frame_info() more robust
Date:	Tue,  1 Aug 2006 11:27:12 +0200
Message-Id: <11544244384089-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
References: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Now get_frame_info() wants to detect move sp instruction first. It
assumes that the save ra in the stack instruction can't happen
before allocating frame size space into the stack.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/process.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 8d0e4fa..333f0bb 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -317,17 +317,15 @@ static int get_frame_info(struct mips_fr
 
 		if (is_jal_jalr_jr_ins(ip))
 			break;
-		if (is_sp_move_ins(ip)) {
-			if (info->frame_size)
-				continue;
-			info->frame_size = - ip->i_format.simmediate;
+		if (!info->frame_size) {
+			if (is_sp_move_ins(ip))
+				info->frame_size = - ip->i_format.simmediate;
+			continue;
 		}
-
-		if (is_ra_save_ins(ip)) {
-			if (info->pc_offset != -1)
-				continue;
+		if (info->pc_offset == -1 && is_ra_save_ins(ip)) {
 			info->pc_offset =
 				ip->i_format.simmediate / sizeof(long);
+			break;
 		}
 	}
 	if (info->frame_size && info->pc_offset >= 0) /* nested */
-- 
1.4.2.rc2
