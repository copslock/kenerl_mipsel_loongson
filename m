Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2005 20:27:30 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:196 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S3458535AbVLIU1N (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Dec 2005 20:27:13 +0000
Received: (qmail 5682 invoked from network); 9 Dec 2005 20:27:13 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 9 Dec 2005 20:27:13 -0000
Message-ID: <4399E92C.6010408@ru.mvista.com>
Date:	Fri, 09 Dec 2005 23:29:32 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS <linux-mips@linux-mips.org>
CC:	Manish Lachwani <mlachwani@mvista.com>,
	Konstantin Baidarov <kbaidarov@ru.mvista.com>
Subject: Re: [PATCH] SiMotion VoyagerGX framebuffer: blue stripped background
References: <4399C8AB.4080403@ru.mvista.com>
In-Reply-To: <4399C8AB.4080403@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------080605090102030609060704"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080605090102030609060704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Sergei Shtylylov wrote:

>    This driver was using an incorrect typecast when setting pseudopalette,
> hence were the blue strips on the black char background. As this driver
> happens to be maintaned by Linux/MIPS, here's the patch (I've also 
> noticed a
> typo in the head comment, hence comes another hunk)...

     Have noticed that regno check in smi_setcolreg() is too relaxed as
pseudo-palette has only 16 entries. So, had to update the patch.

WBR, Sergei

Signed-off-by: Konstantin Baydarov <kbaidarov@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------080605090102030609060704
Content-Type: text/plain;
 name="VoyagerGX-blue-strips.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="VoyagerGX-blue-strips.patch"

diff --git a/drivers/video/smivgxfb.c b/drivers/video/smivgxfb.c
index d5755c5..944ff4a 100644
--- a/drivers/video/smivgxfb.c
+++ b/drivers/video/smivgxfb.c
@@ -1,5 +1,5 @@
 /***************************************************************************
- *  Silicon Motion VoyaagerGX framebuffer driver
+ *  Silicon Motion VoyagerGX framebuffer driver
  *
  * 	ported to 2.6 by Embedded Alley Solutions, Inc
  * 	Copyright (C) 2005 Embedded Alley Solutions, Inc
@@ -159,10 +159,10 @@ smi_setcolreg(unsigned regno, unsigned r
 	unsigned blue, unsigned transp,
 	struct fb_info *info)
 {
-	if (regno > 255)
+	if (regno > 15)
 		return 1;
 
-	((u16 *)(info->pseudo_palette))[regno] =
+	((u32 *)(info->pseudo_palette))[regno] =
 		    ((red & 0xf800) >> 0) |
 		    ((green & 0xfc00) >> 5) |
 		    ((blue & 0xf800) >> 11);
@@ -318,9 +318,9 @@ static int __devinit vgx_pci_probe(struc
 	if (!info.pseudo_palette) {
 		return -ENOMEM;
 	}
-	memset(info.pseudo_palette, 0, sizeof(u32) *16);
+	memset(info.pseudo_palette, 0, sizeof(u32) * 16);
 
-	fb_alloc_cmap(&info.cmap,256,0);
+	fb_alloc_cmap(&info.cmap, 256, 0);
 
 	smi_setmode();
 


--------------080605090102030609060704--
