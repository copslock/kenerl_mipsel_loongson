Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2015 18:24:06 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35573 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009708AbbJFQXedWT0Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Oct 2015 18:23:34 +0200
Received: by wicge5 with SMTP id ge5so174703169wic.0
        for <linux-mips@linux-mips.org>; Tue, 06 Oct 2015 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=udAPDISF0YFwJsvgkJLKOEjAFgwjf7S6TOjYagcpu4k=;
        b=0ZpKBozpNlx1N093Xa/42wlwSXwmrmWp7WMhQR9L9YfL+Noo2nVZtJ3RWNDzkYC0Nj
         xwir66kxTZQQmIQCVOvrCipiLL7BovleB5XlCkqSavjQToIeSvHxPwrG8U3Ht4lv9Ugy
         4h1Ie3fIhO+BQzw/RhpnseZlyExA3N4FmdvzmQJswNNpJqGOQoWUfzqIevvlVtxRT3UI
         bYTChRlgG2nGXDymXL9xi4+vNdw6nGmMhydTx02HTcdulvvHxfpBLrs4bV0/fODz4L/Z
         +5UVQJOt4V0ijLUyzYx4Vfyw5WQFl2uW5jqCDIFZXv4oOPjTJgQJP85rjMJ3Ng/s3f8G
         jr8g==
X-Received: by 10.180.187.141 with SMTP id fs13mr20293998wic.13.1444148608014;
        Tue, 06 Oct 2015 09:23:28 -0700 (PDT)
Received: from dargo.Speedport_W_724V_Typ_A_05011603_00_007 (p200300874C091B9836E6D7FFFE14BFA6.dip0.t-ipconnect.de. [2003:87:4c09:1b98:36e6:d7ff:fe14:bfa6])
        by smtp.gmail.com with ESMTPSA id he3sm33485381wjc.48.2015.10.06.09.23.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Oct 2015 09:23:27 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        linux-fbdev <linux-fbdev@vger.kernel.org>
Subject: [PATCH 3/3] video: fbdev: au1200fb: alloc mem from coherent pool/CMA
Date:   Tue,  6 Oct 2015 18:23:23 +0200
Message-Id: <1444148603-45454-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1444148603-45454-1-git-send-email-manuel.lauss@gmail.com>
References: <1444148603-45454-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Change framebuffer memory allocation to grab some memory from the
coherent pool, which on MIPS causes the allocator to first try
to look for CMA-reserved memory.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>
---
Tested on Db1200 and Db1300 boards, with no issues

 drivers/video/fbdev/au1200fb.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index f9507b1..0884197 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1647,7 +1647,6 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 	struct au1200fb_device *fbdev;
 	struct au1200fb_platdata *pd;
 	struct fb_info *fbi = NULL;
-	unsigned long page;
 	int bpp, plane, ret, irq;
 
 	print_info("" DRIVER_DESC "");
@@ -1693,7 +1692,7 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 		/* Allocate the framebuffer to the maximum screen size */
 		fbdev->fb_len = (win->w[plane].xres * win->w[plane].yres * bpp) / 8;
 
-		fbdev->fb_mem = dmam_alloc_noncoherent(&dev->dev,
+		fbdev->fb_mem = dmam_alloc_coherent(&dev->dev,
 				PAGE_ALIGN(fbdev->fb_len),
 				&fbdev->fb_phys, GFP_KERNEL);
 		if (!fbdev->fb_mem) {
@@ -1702,16 +1701,6 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 			return -ENOMEM;
 		}
 
-		/*
-		 * Set page reserved so that mmap will work. This is necessary
-		 * since we'll be remapping normal memory.
-		 */
-		for (page = (unsigned long)fbdev->fb_phys;
-		     page < PAGE_ALIGN((unsigned long)fbdev->fb_phys +
-			     fbdev->fb_len);
-		     page += PAGE_SIZE) {
-			SetPageReserved(pfn_to_page(page >> PAGE_SHIFT)); /* LCD DMA is NOT coherent on Au1200 */
-		}
 		print_dbg("Framebuffer memory map at %p", fbdev->fb_mem);
 		print_dbg("phys=0x%08x, size=%dK", fbdev->fb_phys, fbdev->fb_len / 1024);
 
-- 
2.5.3
