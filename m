Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2005 18:08:58 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:21426 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S3458525AbVLISIk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Dec 2005 18:08:40 +0000
Received: (qmail 4219 invoked from network); 9 Dec 2005 18:08:31 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 9 Dec 2005 18:08:31 -0000
Message-ID: <4399C8AB.4080403@ru.mvista.com>
Date:	Fri, 09 Dec 2005 21:10:51 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS <linux-mips@linux-mips.org>
CC:	Manish Lachwani <mlachwani@mvista.com>,
	Konstantin Baidarov <kbaidarov@ru.mvista.com>
Subject: [PATCH] SiMotion VoyagerGX framebuffer: blue stripped background
Content-Type: multipart/mixed;
 boundary="------------050205090103050403070109"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050205090103050403070109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    This driver was using an incorrect typecast when setting pseudopalette,
hence were the blue strips on the black char background. As this driver
happens to be maintaned by Linux/MIPS, here's the patch (I've also noticed a
typo in the head comment, hence comes another hunk)...

WBR, Sergei

Signed-off-by: Konstantin Baydarov <kbaidarov@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>




--------------050205090103050403070109
Content-Type: text/plain;
 name="VoyagerGX-blue-strips.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="VoyagerGX-blue-strips.patch"

diff --git a/drivers/video/smivgxfb.c b/drivers/video/smivgxfb.c
index d5755c5..c521069 100644
--- a/drivers/video/smivgxfb.c
+++ b/drivers/video/smivgxfb.c
@@ -1,5 +1,5 @@
 /***************************************************************************
- *  Silicon Motion VoyaagerGX framebuffer driver
+ *  Silicon Motion VoyagerGX framebuffer driver
  *
  * 	ported to 2.6 by Embedded Alley Solutions, Inc
  * 	Copyright (C) 2005 Embedded Alley Solutions, Inc
@@ -162,7 +162,7 @@ smi_setcolreg(unsigned regno, unsigned r
 	if (regno > 255)
 		return 1;
 
-	((u16 *)(info->pseudo_palette))[regno] =
+	((u32 *)(info->pseudo_palette))[regno] =
 		    ((red & 0xf800) >> 0) |
 		    ((green & 0xfc00) >> 5) |
 		    ((blue & 0xf800) >> 11);




--------------050205090103050403070109--
