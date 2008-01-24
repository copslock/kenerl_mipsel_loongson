Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2008 16:55:10 +0000 (GMT)
Received: from smtp06.mtu.ru ([62.5.255.53]:50682 "EHLO smtp06.mtu.ru")
	by ftp.linux-mips.org with ESMTP id S20037137AbYAXQxH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2008 16:53:07 +0000
Received: from smtp06.mtu.ru (localhost [127.0.0.1])
	by smtp06.mtu.ru (Postfix) with ESMTP id 988798FCD79;
	Thu, 24 Jan 2008 19:53:01 +0300 (MSK)
Received: from localhost.localdomain (ppp85-140-77-152.pppoe.mtu-net.ru [85.140.77.152])
	by smtp06.mtu.ru (Postfix) with ESMTP id 757ED8FCC2B;
	Thu, 24 Jan 2008 19:53:01 +0300 (MSK)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/17] [MIPS] Malta: set up the screen info in a separate function
Date:	Thu, 24 Jan 2008 19:52:44 +0300
Message-Id: <1201193577-4261-5-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp06.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

This patch adds a separate short and sweet function to initialize
the screen_info global variable.

This improves readability of the Malta board setup code.

No functional changes introduced.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/malta/malta_setup.c |   39 ++++++++++++++++------------
 1 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/mips/mips-boards/malta/malta_setup.c b/arch/mips/mips-boards/malta/malta_setup.c
index 79d74ea..8b391ee 100644
--- a/arch/mips/mips-boards/malta/malta_setup.c
+++ b/arch/mips/mips-boards/malta/malta_setup.c
@@ -132,6 +132,26 @@ static void __init pci_clock_check(void)
 }
 #endif
 
+#if defined(CONFIG_VT) && defined(CONFIG_VGA_CONSOLE)
+static void __init screen_info_setup(void)
+{
+	screen_info = (struct screen_info) {
+		.orig_x = 0,
+		.orig_y = 25,
+		.ext_mem_k = 0,
+		.orig_video_page = 0,
+		.orig_video_mode = 0,
+		.orig_video_cols = 80,
+		.unused2 = 0,
+		.orig_video_ega_bx = 0,
+		.unused3 = 0,
+		.orig_video_lines = 25,
+		.orig_video_isVGA = VIDEO_TYPE_VGAC,
+		.orig_video_points = 16
+	};
+}
+#endif
+
 void __init plat_mem_setup(void)
 {
 	unsigned int i;
@@ -200,23 +220,8 @@ void __init plat_mem_setup(void)
 #ifdef CONFIG_BLK_DEV_FD
 	fd_activate();
 #endif
-#ifdef CONFIG_VT
-#if defined(CONFIG_VGA_CONSOLE)
-	screen_info = (struct screen_info) {
-		.orig_x = 0,
-		.orig_y = 25,
-		.ext_mem_k = 0,
-		.orig_video_page = 0,
-		.orig_video_mode = 0,
-		.orig_video_cols = 80,
-		.unused2 = 0,
-		.orig_video_ega_bx = 0,
-		.unused3 = 0,
-		.orig_video_lines = 25,
-		.orig_video_isVGA = VIDEO_TYPE_VGAC,
-		.orig_video_points = 16
-	};
-#endif
+#if defined(CONFIG_VT) && defined(CONFIG_VGA_CONSOLE)
+	screen_info_setup();
 #endif
 	mips_reboot_setup();
 }
-- 
1.5.3
