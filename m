Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 20:28:19 +0000 (GMT)
Received: from smtp.gentoo.org ([134.68.220.30]:20380 "EHLO smtp.gentoo.org")
	by ftp.linux-mips.org with ESMTP id S3457351AbWAWU2B (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2006 20:28:01 +0000
Received: from kumba by smtp.gentoo.org with local (Exim 4.54)
	id 1F18M9-0001nw-QO; Mon, 23 Jan 2006 20:32:05 +0000
Date:	Mon, 23 Jan 2006 20:32:05 +0000
From:	Kumba <kumba@gentoo.org>
To:	linux-fbdev-devel@lists.sourceforge.net
Cc:	linux-mips@linux-mips.org
Subject: [PATCH]: Fix SGI O2 Compile error in drivers/video/gbefb.c
Message-ID: <20060123203205.GB499@toucan.gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Around line ~1247 in drivers/video/gbefb.c, gbefb_remove_sysfs uses the wrong parameter, causing an O2 kernel build 
to break when using this driver.  The attached patch supplies the correct parameter, allowing the build to succeed.


--Kumba


--
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands do them because they must, while the 
eyes of the great are elsewhere." --Elrond

--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="misc-2.6.15-ip32-fix-another-gbefb-typo.patch"

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

--lEGEL1/lMxI0MVQ2--
