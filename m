Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jan 2009 23:31:09 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:53743 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24190235AbZAEXbG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Jan 2009 23:31:06 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B496297d10000>; Mon, 05 Jan 2009 18:29:26 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 5 Jan 2009 15:29:18 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 5 Jan 2009 15:29:18 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n05NTFMY018505;
	Mon, 5 Jan 2009 15:29:15 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n05NTFrX018503;
	Mon, 5 Jan 2009 15:29:15 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Use hardware watchpoints on all R1 and R2 CPUs.
Date:	Mon,  5 Jan 2009 15:29:14 -0800
Message-Id: <1231198154-18480-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.6
X-OriginalArrivalTime: 05 Jan 2009 23:29:18.0310 (UTC) FILETIME=[6DFC6860:01C96F8D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The previous definition inadvertently omits Octeon.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ea2b262..39b7081 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1360,7 +1360,7 @@ config CPU_SUPPORTS_64BIT_KERNEL
 #
 config HARDWARE_WATCHPOINTS
        bool
-       default y if CPU_MIPS32 || CPU_MIPS64
+       default y if CPU_MIPSR1 || CPU_MIPSR2
 
 menu "Kernel type"
 
-- 
1.5.6.6
