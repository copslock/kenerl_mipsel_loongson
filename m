Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2008 14:20:01 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:60505 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S28573782AbYHANTy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Aug 2008 14:19:54 +0100
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by hq-ex-mb01.razamicroelectronics.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 1 Aug 2008 06:19:46 -0700
Received: from localhost.localdomain (unknown [10.8.0.25])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id 85D2C6DA533;
	Fri,  1 Aug 2008 08:12:33 -0500 (CDT)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Kevin Hickey <khickey@rmicorp.com>
Subject: [PATCH] [MIPS] DB1200: fix compile fail when CONFIG_FB_AU1200 is not selected
Date:	Fri,  1 Aug 2008 08:19:59 -0500
Message-Id: <1217596799-16754-1-git-send-email-khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
X-OriginalArrivalTime: 01 Aug 2008 13:19:46.0755 (UTC) FILETIME=[44C93930:01C8F3D9]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

There is a temporary variable declared in board_setup that is only used when
CONFIG_FB_AU1200 is selected.  It needs to be ifdef protected to prevent
compile failures.

Signed-off-by: Kevin Hickey <khickey@rmicorp.com>
---
 arch/mips/au1000/pb1200/board_setup.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/au1000/pb1200/board_setup.c b/arch/mips/au1000/pb1200/board_setup.c
index 6cb2115..fa03f44 100644
--- a/arch/mips/au1000/pb1200/board_setup.c
+++ b/arch/mips/au1000/pb1200/board_setup.c
@@ -41,7 +41,9 @@ void board_reset(void)
 
 void __init board_setup(void)
 {
+#ifdef CONFIG_FB_AU1200
 	char *argptr = NULL;
+#endif
 
 #if 0
 	{
-- 
1.5.4.3
