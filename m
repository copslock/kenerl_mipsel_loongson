Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2008 22:45:19 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:50366 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S28575144AbYH1VpR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Aug 2008 22:45:17 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 60028320CAD;
	Thu, 28 Aug 2008 21:45:22 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu, 28 Aug 2008 21:45:22 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.14]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 28 Aug 2008 14:45:05 -0700
Message-ID: <48B71C61.3020004@avtrex.com>
Date:	Thu, 28 Aug 2008 14:45:05 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org
Subject: Patch [1/6] MIPS: Add HARDWARE_WATCHPOINTS configure option.
References: <48B71ADD.601@avtrex.com>
In-Reply-To: <48B71ADD.601@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Aug 2008 21:45:05.0707 (UTC) FILETIME=[557167B0:01C90957]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20380
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
index 4da736e..f5b3fca 100644
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
