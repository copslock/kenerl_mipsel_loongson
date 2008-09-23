Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2008 08:04:52 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:51591 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S28582572AbYIWHEn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Sep 2008 08:04:43 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 63ABE3211EF
	for <linux-mips@linux-mips.org>; Tue, 23 Sep 2008 07:04:31 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP
	for <linux-mips@linux-mips.org>; Tue, 23 Sep 2008 07:04:31 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.229]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 23 Sep 2008 00:04:27 -0700
Message-ID: <48D894FA.70506@avtrex.com>
Date:	Tue, 23 Sep 2008 00:04:26 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [Patch 1/6] MIPS: Add HARDWARE_WATCHPOINTS configure option.
References: <48D89470.5090404@avtrex.com>
In-Reply-To: <48D89470.5090404@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2008 07:04:27.0357 (UTC) FILETIME=[9E1288D0:01C91D4A]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips


This is automatically set for all MIPS32 and MIPS64 processors.

Signed-off-by: David Daney <ddaney@avtrex.com>
---
 arch/mips/Kconfig |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ccf2b0e..2d27ab8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1267,6 +1267,13 @@ config CPU_SUPPORTS_32BIT_KERNEL
 config CPU_SUPPORTS_64BIT_KERNEL
 	bool
 
+#
+# Set to y for ptrace access to watch registers.
+#
+config HARDWARE_WATCHPOINTS
+       bool
+       default y if CPU_MIPS32 || CPU_MIPS64
+
 menu "Kernel type"
 
 choice
-- 
1.5.5.1
