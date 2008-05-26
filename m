Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2008 00:15:19 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:3245 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28578180AbYEZXPR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 May 2008 00:15:17 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1K0luO-0001Xr-01; Tue, 27 May 2008 01:15:16 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 66C20FA1C3; Tue, 27 May 2008 01:15:20 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Add RM200 with R5000 CPU to known ARC machines
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080526231520.66C20FA1C3@solo.franken.de>
Date:	Tue, 27 May 2008 01:15:20 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

RM200 with R5ks have a little bit different arcname

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/fw/arc/identify.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/fw/arc/identify.c b/arch/mips/fw/arc/identify.c
index 28dfd2e..2306698 100644
--- a/arch/mips/fw/arc/identify.c
+++ b/arch/mips/fw/arc/identify.c
@@ -67,6 +67,11 @@ static struct smatch mach_table[] = {
 		.liname		= "SNI RM200_PCI",
 		.type		= MACH_SNI_RM200_PCI,
 		.flags		= PROM_FLAG_DONT_FREE_TEMP,
+	}, {
+		.arcname	= "RM200PCI-R5K",
+		.liname		= "SNI RM200_PCI-R5K",
+		.type		= MACH_SNI_RM200_PCI,
+		.flags		= PROM_FLAG_DONT_FREE_TEMP,
 	}
 };
 
