Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2008 16:55:40 +0000 (GMT)
Received: from smtp06.mtu.ru ([62.5.255.53]:62970 "EHLO smtp06.mtu.ru")
	by ftp.linux-mips.org with ESMTP id S20037119AbYAXQxM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2008 16:53:12 +0000
Received: from smtp06.mtu.ru (localhost [127.0.0.1])
	by smtp06.mtu.ru (Postfix) with ESMTP id 056D38FE0A8;
	Thu, 24 Jan 2008 19:53:02 +0300 (MSK)
Received: from localhost.localdomain (ppp85-140-77-152.pppoe.mtu-net.ru [85.140.77.152])
	by smtp06.mtu.ru (Postfix) with ESMTP id D78A18FE00F;
	Thu, 24 Jan 2008 19:53:01 +0300 (MSK)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/17] [MIPS] Malta: remove a dead function declaration
Date:	Thu, 24 Jan 2008 19:52:46 +0300
Message-Id: <1201193577-4261-7-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp06.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Neither is the mips_rtc_get_time() routine defined anywhere in
the MIPS architecture-specific code, nor does anyone call it any
more. This patch removes the extern declaration of this fossil.

This patch does not introduce any functional changes.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/malta/malta_setup.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mips-boards/malta/malta_setup.c b/arch/mips/mips-boards/malta/malta_setup.c
index 8b391ee..480521f 100644
--- a/arch/mips/mips-boards/malta/malta_setup.c
+++ b/arch/mips/mips-boards/malta/malta_setup.c
@@ -36,7 +36,6 @@
 #endif
 
 extern void mips_reboot_setup(void);
-extern unsigned long mips_rtc_get_time(void);
 
 #ifdef CONFIG_KGDB
 extern void kgdb_config(void);
-- 
1.5.3
