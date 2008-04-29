Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2008 02:29:32 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:10668 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20205440AbYD2B33 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Apr 2008 02:29:29 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 3159D319B2D;
	Tue, 29 Apr 2008 01:33:22 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue, 29 Apr 2008 01:33:21 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 28 Apr 2008 18:29:14 -0700
Message-ID: <481679E9.8030205@avtrex.com>
Date:	Mon, 28 Apr 2008 18:29:13 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	Linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] Add HARDWARE_WATCHPOINTS configure option.
References: <48167832.3090103@avtrex.com>
In-Reply-To: <48167832.3090103@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Apr 2008 01:29:14.0372 (UTC) FILETIME=[6F135440:01C8A998]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19044
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
index 8724ed3..a52d3a8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1344,6 +1344,13 @@ config CPU_SUPPORTS_32BIT_KERNEL
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
1.5.5
