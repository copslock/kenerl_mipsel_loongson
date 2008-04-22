Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2008 01:01:22 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:51383 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20043516AbYDVABT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Apr 2008 01:01:19 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 4277A318E74;
	Tue, 22 Apr 2008 00:02:46 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue, 22 Apr 2008 00:02:46 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 21 Apr 2008 17:01:04 -0700
Message-ID: <480D2ABF.5000005@avtrex.com>
Date:	Mon, 21 Apr 2008 17:01:03 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org
Subject: [Patch 1/6] Add HARDWARE_WATCHPOINTS configure option.
References: <480D2151.2020701@avtrex.com>
In-Reply-To: <480D2151.2020701@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Apr 2008 00:01:04.0870 (UTC) FILETIME=[F5652060:01C8A40B]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This first patch just adds the HARDWARE_WATCHPOINTS option to the
'Kernel type' menu.  If N, the watch register support is disabled.

Signed-off-by: David Daney <ddaney@avtrex.com>
---
 arch/mips/Kconfig |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8724ed3..98f46f6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1622,6 +1622,13 @@ config CPU_HAS_SMARTMIPS
 	  you don't know you probably don't have SmartMIPS and should say N
 	  here.
 
+config HARDWARE_WATCHPOINTS
+	bool "Debugger support for hardware watchpoints"
+	depends on (CPU_MIPS32 || CPU_MIPS64)
+	help
+	  Saying yes here allows you to utilize the hardware watchpoint
+	  registers.  Most people should say Y here.
+
 config CPU_HAS_WB
 	bool
 
-- 
1.5.5
