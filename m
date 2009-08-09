Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Aug 2009 11:48:48 +0200 (CEST)
Received: from mgw1.diku.dk ([130.225.96.91]:35355 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492240AbZHIJsm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 9 Aug 2009 11:48:42 +0200
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id B77CB52C404;
	Sun,  9 Aug 2009 11:48:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x+X8d9TzOqsM; Sun,  9 Aug 2009 11:48:39 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id C4B7952C45F;
	Sun,  9 Aug 2009 11:42:32 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 9C2AB6DFD13; Sun,  9 Aug 2009 11:41:31 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3767)
	id A279A154F68; Sun,  9 Aug 2009 11:42:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ask.diku.dk (Postfix) with ESMTP id 9F8A51549A9;
	Sun,  9 Aug 2009 11:42:32 +0200 (CEST)
Date:	Sun, 9 Aug 2009 11:42:32 +0200 (CEST)
From:	Julia Lawall <julia@diku.dk>
To:	Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Cc:	linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [Linux-fbdev-devel] [PATCH 3/3] drivers/video: Correct use of 
 request_region/request_mem_region
In-Reply-To: <10f740e80908090224p13d2119do9e4f4d7730ed001e@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0908091141150.13271@ask.diku.dk>
References: <Pine.LNX.4.64.0908090943560.13271@ask.diku.dk>
 <10f740e80908090224p13d2119do9e4f4d7730ed001e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

From: Julia Lawall <julia@diku.dk>

request_region should be used with release_region, not request_mem_region.

Geert Uytterhoeven pointed out that in the case of drivers/video/gbefb.c,
the problem is actually the other way around; request_mem_region should be
used instead of request_region.

The semantic patch that finds/fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r1@
expression start;
@@

request_region(start,...)

@b1@
expression r1.start;
@@

request_mem_region(start,...)

@depends on !b1@
expression r1.start;
expression E;
@@

- release_mem_region
+ release_region
  (start,E)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/video/gbefb.c  |    2 +-
 drivers/video/tdfxfb.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -u -p a/drivers/video/gbefb.c b/drivers/video/gbefb.c
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -1147,7 +1147,7 @@ static int __init gbefb_probe(struct pla
 	gbefb_setup(options);
 #endif
 
-	if (!request_region(GBE_BASE, sizeof(struct sgi_gbe), "GBE")) {
+	if (!request_mem_region(GBE_BASE, sizeof(struct sgi_gbe), "GBE")) {
 		printk(KERN_ERR "gbefb: couldn't reserve mmio region\n");
 		ret = -EBUSY;
 		goto out_release_framebuffer;
diff -u -p a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -1571,8 +1571,8 @@ out_err_iobase:
 	if (default_par->mtrr_handle >= 0)
 		mtrr_del(default_par->mtrr_handle, info->fix.smem_start,
 			 info->fix.smem_len);
-	release_mem_region(pci_resource_start(pdev, 2),
-			   pci_resource_len(pdev, 2));
+	release_region(pci_resource_start(pdev, 2),
+		       pci_resource_len(pdev, 2));
 out_err_screenbase:
 	if (info->screen_base)
 		iounmap(info->screen_base);
