Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Nov 2005 09:17:26 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:15052 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133533AbVK3JRI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Nov 2005 09:17:08 +0000
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id D6D5DC00F;
	Wed, 30 Nov 2005 10:20:26 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 2B6EB1BC08C;
	Wed, 30 Nov 2005 10:20:28 +0100 (CET)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 3D22B1A18B3;
	Wed, 30 Nov 2005 10:20:27 +0100 (CET)
Subject: [PATCH] Simple patch to power off DBAU1200
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	linux-mips@linux-mips.org
Cc:	Jordan Crouse <jordan.crouse@amd.com>
Content-Type: multipart/mixed; boundary="=-a7eAy1rQKAiMSuebxj5O"
Date:	Wed, 30 Nov 2005 10:20:01 +0100
Message-Id: <1133342401.24526.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips


--=-a7eAy1rQKAiMSuebxj5O
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

Please, find the attached patch which enables
powering off the DBAU1200 board.

BR,
Matej

--=-a7eAy1rQKAiMSuebxj5O
Content-Disposition: attachment; filename=linux-2.6.14-dbau1200-poweroff.patch
Content-Type: text/x-patch; name=linux-2.6.14-dbau1200-poweroff.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Patch to enable powering off DBAU1200

Signed-off-by: Matej Kupljen <matej.kupljen@ultra.si>

--- a/arch/mips/au1000/common/reset.c	2005-10-24 13:36:24.000000000 +0200
+++ b/arch/mips/au1000/common/reset.c	2005-08-24 14:39:58.000000000 +0200
@@ -175,6 +175,9 @@
 #ifdef CONFIG_MIPS_MIRAGE
 	au_writel((1 << 26) | (1 << 10), GPIO2_OUTPUT);
 #endif
+#ifdef CONFIG_MIPS_DB1200
+	au_writew(au_readw(0xB980001C) | (1<<14), 0xB980001C);
+#endif
 #ifdef CONFIG_PM
 	au_sleep();
 

--=-a7eAy1rQKAiMSuebxj5O--
