Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2005 20:55:36 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:8362 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8134136AbVKVUzS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2005 20:55:18 +0000
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jAMKvtF2027194;
	Tue, 22 Nov 2005 14:57:55 -0600
Received: from 163.181.250.1 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Tue, 22 Nov 2005 14:57:46 -0600
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jAMKvkeP022275; Tue,
 22 Nov 2005 14:57:46 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id F0D291FF4; Tue, 22 Nov 2005
 13:57:45 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jAML2w9T004569; Tue, 22 Nov 2005 14:02:58
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jAML2wfP004568; Tue, 22 Nov 2005 14:02:58
 -0700
Date:	Tue, 22 Nov 2005 14:02:58 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Subject: [PATCH] Fix BSCR accesses
Message-ID: <20051122210258.GT18119@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F9D59C01M8574078-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

Last one from Sergei:

Fix BSCR accesses in the board setup code.
---

 arch/mips/au1000/db1x00/board_setup.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/au1000/db1x00/board_setup.c b/arch/mips/au1000/db1x00/board_setup.c
index ac05ba0..f00ec3b 100644
--- a/arch/mips/au1000/db1x00/board_setup.c
+++ b/arch/mips/au1000/db1x00/board_setup.c
@@ -45,13 +45,12 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/db1x00.h>
 
-/* not correct for db1550 */
-static BCSR * const bcsr = (BCSR *)0xAE000000;
+static BCSR * const bcsr = (BCSR *)BCSR_KSEG1_ADDR;
 
 void board_reset (void)
 {
 	/* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
-	au_writel(0x00000000, 0xAE00001C);
+	bcsr->swreset = 0x0000;
 }
 
 void __init board_setup(void)
@@ -75,7 +74,7 @@ void __init board_setup(void)
 	bcsr->resets |= BCSR_RESETS_IRDA_MODE_OFF;
 	au_sync();
 #endif
-	au_writel(0, 0xAE000010); /* turn off pcmcia power */
+	bcsr->pcmcia = 0x0000; /* turn off PCMCIA power */
 
 #ifdef CONFIG_MIPS_MIRAGE
 	/* enable GPIO[31:0] inputs */
