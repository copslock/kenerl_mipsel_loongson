Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Sep 2008 18:17:46 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:60128 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S32733745AbYITRQv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 20 Sep 2008 18:16:51 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 63DDC321498
	for <linux-mips@linux-mips.org>; Sat, 20 Sep 2008 17:16:49 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP
	for <linux-mips@linux-mips.org>; Sat, 20 Sep 2008 17:16:49 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.226]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 20 Sep 2008 10:16:36 -0700
Message-ID: <48D52FF4.2000905@avtrex.com>
Date:	Sat, 20 Sep 2008 10:16:36 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] Fix include paths in malta-amon.c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2008 17:16:36.0387 (UTC) FILETIME=[A30A7F30:01C91B44]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips


On linux-queue, malta doesn't build after the include file relocation.
This should fix it.

There some occurrences of 'asm-mips' in the comments of quite a few
files, but this is the only place I found it in any code.

Signed-off-by: David Daney <ddaney@avtrex.com>
---
 arch/mips/mti-malta/malta-amon.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mti-malta/malta-amon.c b/arch/mips/mti-malta/malta-amon.c
index 96236bf..df9e526 100644
--- a/arch/mips/mti-malta/malta-amon.c
+++ b/arch/mips/mti-malta/malta-amon.c
@@ -22,9 +22,9 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 
-#include <asm-mips/addrspace.h>
-#include <asm-mips/mips-boards/launch.h>
-#include <asm-mips/mipsmtregs.h>
+#include <asm/addrspace.h>
+#include <asm/mips-boards/launch.h>
+#include <asm/mipsmtregs.h>
 
 int amon_cpu_avail(int cpu)
 {
-- 
1.5.5.1
