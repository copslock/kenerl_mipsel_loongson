Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2006 08:37:26 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:38269 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133809AbWHCHaP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Aug 2006 08:30:15 +0100
Received: by nf-out-0910.google.com with SMTP id q29so939691nfc
        for <linux-mips@linux-mips.org>; Thu, 03 Aug 2006 00:30:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=E9wOh2qzG5p/ItjTYsVq6dEiPkkX7q64YH+vxY7yj6MgtkOns2Ea5AuqOCmEEHEeyh1F6XquoU+kM1Y9HBLY8yAfEEV8vMTSpKuNrBzF9VID524Tx3KTML0Q+ahH3tVQoL7ZS7yvvKqlrDISm450YQzfrZXLDiu0C554EIik89I=
Received: by 10.49.90.4 with SMTP id s4mr3358607nfl;
        Thu, 03 Aug 2006 00:30:15 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id k9sm661837nfc.2006.08.03.00.30.14;
        Thu, 03 Aug 2006 00:30:15 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 19EE823F770; Thu,  3 Aug 2006 09:29:22 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 6/7] Make get_frame_info() more robust
Date:	Thu,  3 Aug 2006 09:29:20 +0200
Message-Id: <11545901628-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11545901611096-git-send-email-vagabon.xyz@gmail.com>
References: <11545901611096-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12173
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
index da332d7..309bfa4 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -321,17 +321,15 @@ static int get_frame_info(struct mips_fr
 
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
