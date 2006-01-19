Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 14:13:03 +0000 (GMT)
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:39043 "EHLO
	rwcrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8134397AbWASOMk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jan 2006 14:12:40 +0000
Received: from [192.168.1.4] (pcp04414054pcs.nrockv01.md.comcast.net[69.140.185.48])
          by comcast.net (rwcrmhc14) with ESMTP
          id <200601191416230140026h8ce>; Thu, 19 Jan 2006 14:16:23 +0000
Message-ID: <43CF9F33.8000907@gentoo.org>
Date:	Thu, 19 Jan 2006 09:16:19 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: Fix SGI O2 Compile error in drivers/video/gbefb.c
Content-Type: multipart/mixed;
 boundary="------------040904000604090402090204"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040904000604090402090204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Around line ~1247, a sysfs function call uses the wrong parameter, and thus 
breaks a build on SGI O2 with current git.  The following patch fixes this.


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

--------------040904000604090402090204
Content-Type: text/plain;
 name="misc-2.6.15-ip32-fix-another-gbefb-typo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.6.15-ip32-fix-another-gbefb-typo.patch"

diff -Naurp linux-2.6.15.1.orig/drivers/video/gbefb.c linux-2.6.15.1/drivers/video/gbefb.c
--- linux-2.6.15.1.orig/drivers/video/gbefb.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15.1/drivers/video/gbefb.c	2006-01-18 23:22:29.000000000 -0500
@@ -1244,7 +1244,7 @@ static int __devexit gbefb_remove(struct
 			  (void *)gbe_tiles.cpu, gbe_tiles.dma);
 	release_mem_region(GBE_BASE, sizeof(struct sgi_gbe));
 	iounmap(gbe);
-	gbefb_remove_sysfs(dev);
+	gbefb_remove_sysfs(&p_dev->dev);
 	framebuffer_release(info);
 
 	return 0;

--------------040904000604090402090204--
