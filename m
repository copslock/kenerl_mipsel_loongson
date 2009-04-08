Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 00:38:26 +0100 (BST)
Received: from mx1.rmicorp.com ([12.239.216.72]:17511 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S20032087AbZDHXgV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 00:36:21 +0100
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by mx1.rmicorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 8 Apr 2009 16:36:09 -0700
Received: from localhost.localdomain (unknown [10.8.0.44])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id C91B27B7FCA;
	Sat,  4 Apr 2009 05:34:46 -0600 (CST)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Kevin Hickey <khickey@rmicorp.com>
Subject: [PATCH v3 5/5] Alchemy: Au1300: Add LCD framebuffer support
Date:	Wed,  8 Apr 2009 18:36:08 -0500
Message-Id: <1239233768-11927-6-git-send-email-khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1239233768-11927-5-git-send-email-khickey@rmicorp.com>
References: <>
 <1239233768-11927-1-git-send-email-khickey@rmicorp.com>
 <1239233768-11927-2-git-send-email-khickey@rmicorp.com>
 <1239233768-11927-3-git-send-email-khickey@rmicorp.com>
 <1239233768-11927-4-git-send-email-khickey@rmicorp.com>
 <1239233768-11927-5-git-send-email-khickey@rmicorp.com>
X-OriginalArrivalTime: 08 Apr 2009 23:36:09.0884 (UTC) FILETIME=[CBB85DC0:01C9B8A2]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips


Signed-off-by: Kevin Hickey <khickey@rmicorp.com>
---
 drivers/video/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index fb19803..9f571df 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1713,7 +1713,7 @@ config FB_AU1100
 
 config FB_AU1200
 	bool "Au1200 LCD Driver"
-	depends on (FB = y) && MIPS && SOC_AU1200
+	depends on (FB = y) && MIPS && (SOC_AU1200 || SOC_AU13XX)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.5.4.3
