Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Dec 2008 23:44:53 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:27338 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24208278AbYLXXou (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Dec 2008 23:44:50 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4952c95c0000>; Wed, 24 Dec 2008 18:44:28 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 24 Dec 2008 15:44:32 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 24 Dec 2008 15:44:31 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mBONiRKR004086;
	Wed, 24 Dec 2008 15:44:27 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mBONiQqO004084;
	Wed, 24 Dec 2008 15:44:26 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/1] MIPS: Fix a typo in watchpoint register structure.
Date:	Wed, 24 Dec 2008 15:44:26 -0800
Message-Id: <1230162266-4061-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.6
X-OriginalArrivalTime: 24 Dec 2008 23:44:31.0690 (UTC) FILETIME=[917222A0:01C96621]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This fixes the ptrace ABI for watch registers, and should allow 64bit
kernels to use the watch register support.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/ptrace.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 1f30d16..ce47118 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -105,7 +105,7 @@ struct pt_watch_regs {
 	enum pt_watch_style style;
 	union {
 		struct mips32_watch_regs mips32;
-		struct mips32_watch_regs mips64;
+		struct mips64_watch_regs mips64;
 	};
 };
 
-- 
1.5.6.6
