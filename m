Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2008 21:55:14 +0200 (CEST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:34655 "EHLO
	buildserver.ru.mvista.com") by lappi.linux-mips.net with ESMTP
	id S525911AbYDBTzE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Apr 2008 21:55:04 +0200
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 071798810; Thu,  3 Apr 2008 01:54:22 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH] PbAu1200: fix header breakage
Date:	Wed, 2 Apr 2008 23:53:19 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804022353.19379.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Looks like nobody ever cared since the code was merged -- there's no defconfig.

 include/asm-mips/mach-pb1x00/pb1200.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/include/asm-mips/mach-pb1x00/pb1200.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-pb1x00/pb1200.h
+++ linux-2.6/include/asm-mips/mach-pb1x00/pb1200.h
@@ -245,7 +245,7 @@ enum external_pb1200_ints {
 	PB1200_SD1_INSERT_INT,
 	PB1200_SD1_EJECT_INT,
 
-	PB1200_INT_END			(PB1200_INT_BEGIN + 15)
+	PB1200_INT_END		= PB1200_INT_BEGIN + 15
 };
 
 /* For drivers/pcmcia/au1000_db1x00.c */
