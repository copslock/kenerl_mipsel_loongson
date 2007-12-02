Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Dec 2007 12:01:31 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:18917 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20023297AbXLBMA7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Dec 2007 12:00:59 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IynVI-0001dY-01; Sun, 02 Dec 2007 13:00:56 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id BDBEFC2EB6; Sun,  2 Dec 2007 12:54:56 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
cc:	wim@iguana.be
Subject: [PATCH] PARTITION: Use DEFAULT_SGI_PARTITION for SGI_PARTION default
Message-Id: <20071202115456.BDBEFC2EB6@solo.franken.de>
Date:	Sun,  2 Dec 2007 12:54:56 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Use DEFAULT_SGI_PARTITION for SGI_PARTION default

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

Please apply for 2.6.25.

 fs/partitions/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/partitions/Kconfig b/fs/partitions/Kconfig
index a99acd8..cb5f0a3 100644
--- a/fs/partitions/Kconfig
+++ b/fs/partitions/Kconfig
@@ -198,7 +198,7 @@ config LDM_DEBUG
 
 config SGI_PARTITION
 	bool "SGI partition support" if PARTITION_ADVANCED
-	default y if (SGI_IP22 || SGI_IP27 || ((MACH_JAZZ || SNI_RM) && !CPU_LITTLE_ENDIAN))
+	default y if DEFAULT_SGI_PARTITION
 	help
 	  Say Y here if you would like to be able to read the hard disk
 	  partition table format used by SGI machines.
