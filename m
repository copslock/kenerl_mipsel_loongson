Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2009 20:53:43 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:60824 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S20809009AbZCTUwB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Mar 2009 20:52:01 +0000
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by mx1.rmicorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Mar 2009 13:51:49 -0700
Received: from localhost.localdomain (unknown [10.8.0.60])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id 419D8EE76DD;
	Fri, 20 Mar 2009 14:11:47 -0600 (CST)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Kevin Hickey <khickey@rmicorp.com>
Subject: [PATCH v2 6/6] Alchemy: Au1300: Add LCD framebuffer support
Date:	Fri, 20 Mar 2009 15:51:46 -0500
Message-Id: <1237582306-10800-7-git-send-email-khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1237582306-10800-6-git-send-email-khickey@rmicorp.com>
References: <>
 <1237582306-10800-1-git-send-email-khickey@rmicorp.com>
 <1237582306-10800-2-git-send-email-khickey@rmicorp.com>
 <1237582306-10800-3-git-send-email-khickey@rmicorp.com>
 <1237582306-10800-4-git-send-email-khickey@rmicorp.com>
 <1237582306-10800-5-git-send-email-khickey@rmicorp.com>
 <1237582306-10800-6-git-send-email-khickey@rmicorp.com>
X-OriginalArrivalTime: 20 Mar 2009 20:51:49.0868 (UTC) FILETIME=[B0D812C0:01C9A99D]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22108
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
