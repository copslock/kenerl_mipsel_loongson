Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2008 06:38:05 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:55232 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20135404AbYIKFiD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Sep 2008 06:38:03 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 184AC32083F;
	Thu, 11 Sep 2008 05:37:52 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu, 11 Sep 2008 05:37:51 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.222]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 10 Sep 2008 22:37:43 -0700
Message-ID: <48C8AEA6.6060901@avtrex.com>
Date:	Wed, 10 Sep 2008 22:37:42 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org
Subject: [Patch 1/6] MIPS: Add HARDWARE_WATCHPOINTS configure option.
References: <48C8ADEF.9020305@avtrex.com>
In-Reply-To: <48C8ADEF.9020305@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Sep 2008 05:37:43.0711 (UTC) FILETIME=[83802AF0:01C913D0]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Add HARDWARE_WATCHPOINTS configure option.

This is automatically set for all MIPS32 and MIPS64 processors.

Signed-off-by: David Daney <ddaney@avtrex.com>
---
 arch/mips/Kconfig |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 49896a2..7c724ea 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1272,6 +1272,13 @@ config CPU_SUPPORTS_32BIT_KERNEL
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
