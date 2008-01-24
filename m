Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2008 17:00:31 +0000 (GMT)
Received: from smtp06.mtu.ru ([62.5.255.53]:251 "EHLO smtp06.mtu.ru")
	by ftp.linux-mips.org with ESMTP id S20037146AbYAXQxM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2008 16:53:12 +0000
Received: from smtp06.mtu.ru (localhost [127.0.0.1])
	by smtp06.mtu.ru (Postfix) with ESMTP id 6F1878FF270;
	Thu, 24 Jan 2008 19:53:03 +0300 (MSK)
Received: from localhost.localdomain (ppp85-140-77-152.pppoe.mtu-net.ru [85.140.77.152])
	by smtp06.mtu.ru (Postfix) with ESMTP id 4F65B8FF267;
	Thu, 24 Jan 2008 19:53:03 +0300 (MSK)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] [MIPS] Malta: fix braces at single statement blocks
Date:	Thu, 24 Jan 2008 19:52:54 +0300
Message-Id: <1201193577-4261-15-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp06.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

This patch fixes a couple of warnings reported by checkpatch.pl.

No functional changes introduced.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/malta/malta_int.c   |    3 ++-
 arch/mips/mips-boards/malta/malta_setup.c |    3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mips-boards/malta/malta_int.c b/arch/mips/mips-boards/malta/malta_int.c
index 92e6e2d..dbe60eb 100644
--- a/arch/mips/mips-boards/malta/malta_int.c
+++ b/arch/mips/mips-boards/malta/malta_int.c
@@ -114,7 +114,8 @@ static void malta_hw0_irqdispatch(void)
 
 	irq = get_int();
 	if (irq < 0) {
-		return;  /* interrupt has already been cleared */
+		/* interrupt has already been cleared */
+		return;
 	}
 
 	do_IRQ(MALTA_INT_BASE + irq);
diff --git a/arch/mips/mips-boards/malta/malta_setup.c b/arch/mips/mips-boards/malta/malta_setup.c
index 8dacb6a..8d62966 100644
--- a/arch/mips/mips-boards/malta/malta_setup.c
+++ b/arch/mips/mips-boards/malta/malta_setup.c
@@ -202,9 +202,8 @@ void __init plat_mem_setup(void)
 #endif
 	}
 #ifdef CONFIG_DMA_COHERENT
-	else {
+	else
 		panic("Hardware DMA cache coherency not supported");
-	}
 #endif
 
 #ifdef CONFIG_BLK_DEV_IDE
-- 
1.5.3
