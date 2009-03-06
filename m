Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2009 16:23:10 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:35445 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S21366489AbZCFQUW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2009 16:20:22 +0000
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by mx1.rmicorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Mar 2009 08:20:10 -0800
Received: from localhost.localdomain (unknown [10.8.0.23])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id 18D99EE76AE;
	Fri,  6 Mar 2009 09:42:11 -0600 (CST)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Kevin Hickey <khickey@rmicorp.com>
Subject: [PATCH 09/10] Alchemy: Au1300: Add LCD framebuffer support
Date:	Fri,  6 Mar 2009 10:20:08 -0600
Message-Id: <02861156af87464c26e9cb564bef047fd83e054f.1236354153.git.khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <be27dee4c591cdb1ea1b9517bee2b825657024f5.1236354153.git.khickey@rmicorp.com>
References: <>
 <1236356409-32357-1-git-send-email-khickey@rmicorp.com>
 <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
 <0b447f7e26be90a9179bdf89ca2cfd1f34c5d16e.1236354153.git.khickey@rmicorp.com>
 <7afc5c84989c4bc0f94181397369f284f2bb6924.1236354153.git.khickey@rmicorp.com>
 <0946334bbaf9883076889fe060a362b72d31e6f4.1236354153.git.khickey@rmicorp.com>
 <394c116b9fa5bd1865ac21d11185f09e07bd2ab5.1236354153.git.khickey@rmicorp.com>
 <7e632686ab9b29a94eefeb2e5dca8b091a956b95.1236354153.git.khickey@rmicorp.com>
 <df58b8408730cf0eee532a93f0b6234ac709663c.1236354153.git.khickey@rmicorp.com>
 <be27dee4c591cdb1ea1b9517bee2b825657024f5.1236354153.git.khickey@rmicorp.com>
In-Reply-To: <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
References: <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
X-OriginalArrivalTime: 06 Mar 2009 16:20:10.0247 (UTC) FILETIME=[6BBAC970:01C99E77]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22024
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
