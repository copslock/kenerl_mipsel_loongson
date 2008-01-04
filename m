Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2008 22:38:41 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:45202 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20025877AbYADWid (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2008 22:38:33 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JAvBQ-0007Fb-00; Fri, 04 Jan 2008 23:38:32 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 15FF4C2EF3; Fri,  4 Jan 2008 23:38:31 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Assume newer R4000/R4400 don't have the mfc0 count bug
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080104223831.15FF4C2EF3@solo.franken.de>
Date:	Fri,  4 Jan 2008 23:38:31 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Assume newer R4000/R4400 don't have the mfc0 count bug

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 1ecfbb7..2995be1 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -147,9 +147,9 @@ static __init int cpu_has_mfc0_count_bug(void)
 			return 1;
 
 		/*
-		 * I don't have erratas for newer R4400 so be paranoid.
+		 * we assume newer revisions are ok
 		 */
-		return 1;
+		return 0;
 	}
 
 	return 0;
