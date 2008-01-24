Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2008 16:58:38 +0000 (GMT)
Received: from smtp06.mtu.ru ([62.5.255.53]:62970 "EHLO smtp06.mtu.ru")
	by ftp.linux-mips.org with ESMTP id S20037141AbYAXQxM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2008 16:53:12 +0000
Received: from smtp06.mtu.ru (localhost [127.0.0.1])
	by smtp06.mtu.ru (Postfix) with ESMTP id 969F58FF4D5;
	Thu, 24 Jan 2008 19:53:03 +0300 (MSK)
Received: from localhost.localdomain (ppp85-140-77-152.pppoe.mtu-net.ru [85.140.77.152])
	by smtp06.mtu.ru (Postfix) with ESMTP id 77AAF8FF38B;
	Thu, 24 Jan 2008 19:53:03 +0300 (MSK)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/17] [MIPS] Malta: make the helper function static
Date:	Thu, 24 Jan 2008 19:52:55 +0300
Message-Id: <1201193577-4261-16-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp06.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

One helper function can become static. This patch adds the needed
keyword.

No functional changes introduced.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/malta/malta_setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mips-boards/malta/malta_setup.c b/arch/mips/mips-boards/malta/malta_setup.c
index 8d62966..541f4e7 100644
--- a/arch/mips/mips-boards/malta/malta_setup.c
+++ b/arch/mips/mips-boards/malta/malta_setup.c
@@ -80,7 +80,7 @@ const char display_string[] = "        LINUX ON MALTA       ";
 #endif /* CONFIG_MIPS_MT_SMTC */
 
 #ifdef CONFIG_BLK_DEV_FD
-void __init fd_activate(void)
+static void __init fd_activate(void)
 {
 	/*
 	 * Activate Floppy Controller in the SMSC FDC37M817 Super I/O
-- 
1.5.3
