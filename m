Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2009 00:54:30 +0100 (BST)
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:60511 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026843AbZD3XyR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2009 00:54:17 +0100
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n3UNrZUP016920;
	Thu, 30 Apr 2009 19:53:36 -0400 (EDT)
Received: from localhost (c-67-186-133-195.hsd1.ma.comcast.net [67.186.133.195])
	(authenticated bits=0)
        (User authenticated as tabbott@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n3UNrY3i011410;
	Thu, 30 Apr 2009 19:53:35 -0400 (EDT)
From:	Tim Abbott <tabbott@MIT.EDU>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Anders Kaseorg <andersk@mit.edu>,
	Waseem Daher <wdaher@mit.edu>,
	Denys Vlasenko <vda.linux@googlemail.com>,
	Jeff Arnold <jbarnold@mit.edu>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Tim Abbott <tabbott@mit.edu>
Subject: [PATCH 4/4] mips: use .text, not .text.start, for lasat boot loader.
Date:	Thu, 30 Apr 2009 19:53:30 -0400
Message-Id: <1241135610-9012-5-git-send-email-tabbott@mit.edu>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1241135610-9012-4-git-send-email-tabbott@mit.edu>
References: <1241135610-9012-1-git-send-email-tabbott@mit.edu>
 <1241135610-9012-2-git-send-email-tabbott@mit.edu>
 <1241135610-9012-3-git-send-email-tabbott@mit.edu>
 <1241135610-9012-4-git-send-email-tabbott@mit.edu>
X-Scanned-By: MIMEDefang 2.42
Return-Path: <tabbott@MIT.EDU>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tabbott@MIT.EDU
Precedence: bulk
X-list: linux-mips

There doesn't seem to be a reason to use a special section here, so
just use the normal .text.

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lasat/image/head.S           |    2 +-
 arch/mips/lasat/image/romscript.normal |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lasat/image/head.S b/arch/mips/lasat/image/head.S
index efb95f2..c699363 100644
--- a/arch/mips/lasat/image/head.S
+++ b/arch/mips/lasat/image/head.S
@@ -1,7 +1,7 @@
 #include <asm/lasat/head.h>
 
 	.text
-	.section .text.start, "ax"
+	.section .text, "ax"
 	.set noreorder
 	.set mips3
 
diff --git a/arch/mips/lasat/image/romscript.normal b/arch/mips/lasat/image/romscript.normal
index 988f8ad..f470353 100644
--- a/arch/mips/lasat/image/romscript.normal
+++ b/arch/mips/lasat/image/romscript.normal
@@ -4,7 +4,7 @@ SECTIONS
 {
   .text :
   {
-    *(.text.start)
+    *(.text)
   }
 
   /* Data in ROM */
-- 
1.6.2.1
