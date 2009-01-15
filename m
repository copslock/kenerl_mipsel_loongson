Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 17:57:45 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:45700 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21365949AbZAOR5l (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Jan 2009 17:57:41 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B496f79090002>; Thu, 15 Jan 2009 12:57:29 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 09:56:31 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 09:56:31 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n0FHuR3C004838;
	Thu, 15 Jan 2009 09:56:27 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n0FHuRSC004837;
	Thu, 15 Jan 2009 09:56:27 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH] MIPS: Only allow Cavium OCTEON to be configured for boards that support it (v2).
Date:	Thu, 15 Jan 2009 09:56:27 -0800
Message-Id: <1232042187-4814-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.6
X-OriginalArrivalTime: 15 Jan 2009 17:56:31.0552 (UTC) FILETIME=[99006C00:01C9773A]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
CC: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Kconfig |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 6dddea3..31191c5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -603,7 +603,7 @@ config CAVIUM_OCTEON_SIMULATOR
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
-	select CPU_CAVIUM_OCTEON
+	select SYS_HAS_CPU_CAVIUM_OCTEON
 	help
 	  The Octeon simulator is software performance model of the Cavium
 	  Octeon Processor. It supports simulating Octeon processors on x86
@@ -618,7 +618,7 @@ config CAVIUM_OCTEON_REFERENCE_BOARD
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_HAS_EARLY_PRINTK
-	select CPU_CAVIUM_OCTEON
+	select SYS_HAS_CPU_CAVIUM_OCTEON
 	select SWAP_IO_SPACE
 	help
 	  This option supports all of the Octeon reference boards from Cavium
@@ -1237,6 +1237,7 @@ config CPU_SB1
 
 config CPU_CAVIUM_OCTEON
 	bool "Cavium Octeon processor"
+	depends on SYS_HAS_CPU_CAVIUM_OCTEON
 	select IRQ_CPU
 	select IRQ_CPU_OCTEON
 	select CPU_HAS_PREFETCH
@@ -1317,6 +1318,9 @@ config SYS_HAS_CPU_RM9000
 config SYS_HAS_CPU_SB1
 	bool
 
+config SYS_HAS_CPU_CAVIUM_OCTEON
+	bool
+
 #
 # CPU may reorder R->R, R->W, W->R, W->W
 # Reordering beyond LL and SC is handled in WEAK_REORDERING_BEYOND_LLSC
-- 
1.5.6.6
