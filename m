Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2008 17:00:01 +0000 (GMT)
Received: from smtp06.mtu.ru ([62.5.255.53]:65274 "EHLO smtp06.mtu.ru")
	by ftp.linux-mips.org with ESMTP id S20037145AbYAXQxM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2008 16:53:12 +0000
Received: from smtp06.mtu.ru (localhost [127.0.0.1])
	by smtp06.mtu.ru (Postfix) with ESMTP id 1A6F08FEFA1;
	Thu, 24 Jan 2008 19:53:03 +0300 (MSK)
Received: from localhost.localdomain (ppp85-140-77-152.pppoe.mtu-net.ru [85.140.77.152])
	by smtp06.mtu.ru (Postfix) with ESMTP id EF70F8FEF02;
	Thu, 24 Jan 2008 19:53:02 +0300 (MSK)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/17] [MIPS] Malta: Use C89 style for comments
Date:	Thu, 24 Jan 2008 19:52:52 +0300
Message-Id: <1201193577-4261-13-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp06.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Remove comments in C99 style and make checkpatch.pl happy.

No functional changes introduced.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/malta/malta_int.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mips-boards/malta/malta_int.c b/arch/mips/mips-boards/malta/malta_int.c
index 2473a77..92e6e2d 100644
--- a/arch/mips/mips-boards/malta/malta_int.c
+++ b/arch/mips/mips-boards/malta/malta_int.c
@@ -214,9 +214,9 @@ static inline unsigned int irq_ffs(unsigned int pending)
 
 	t0 = pending & 0x8000;
 	t0 = t0 < 1;
-	//t0 = t0 << 2;
+	/* t0 = t0 << 2; */
 	a0 = a0 - t0;
-	//pending = pending << t0;
+	/* pending = pending << t0; */
 
 	return a0;
 #endif
-- 
1.5.3
