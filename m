Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2009 20:55:34 +0100 (BST)
Received: from n1b.bullet.mail.ac4.yahoo.com ([76.13.13.71]:20929 "HELO
	n1b.bullet.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S20023425AbZD3Tz2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2009 20:55:28 +0100
Received: from [76.13.13.26] by n1.bullet.mail.ac4.yahoo.com with NNFMP; 30 Apr 2009 19:55:21 -0000
Received: from [76.13.10.179] by t3.bullet.mail.ac4.yahoo.com with NNFMP; 30 Apr 2009 19:55:21 -0000
Received: from [127.0.0.1] by omp120.mail.ac4.yahoo.com with NNFMP; 30 Apr 2009 19:55:21 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 954915.57676.bm@omp120.mail.ac4.yahoo.com
Received: (qmail 52851 invoked by uid 60001); 30 Apr 2009 19:55:21 -0000
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1241121321; bh=2Bt7nDxwhyubyqS/GFJwEREwzJ6M3fSjvMUOxBlBwec=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type; b=L94yUyQTmUWkqyjHjcvGBylADVjDlk1tqXXjg2hQbSx+UOZXjlzW1QBSNXP72Nf2X0bfANOeqFnqSuO0yXVmO6GeQE1frvK8xf1Mye/pJhobaU41H9Z3Qkhez1ivk+KWbiLe6TcWqHiRvO/6Gqty1c0uQ+z+xQNd8q0pvbZReJ8=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=l5PMaO5Dp4L2YFF6HW0iecUN7c9I+51Uf3OvD1lbEUPC7VMcdy7JT5WuA1w+WWO91bqPd3eH4wDnwP5Hrmvei+D/t4r/Lhyz/wkFQCjy8YueWFq4/3vfc0WDX/wfvVlKKFKVK8MjNKju1OsuE5TaPRhcyRacJcyeGoTiD/AHJsM=;
Message-ID: <309181.52579.qm@web59814.mail.ac4.yahoo.com>
X-YMail-OSG: 9lwl8I0VM1muYkCIXwr_MfL.XWorgEdHKDt6yot7jtN102ZQI8QMeaF6VH7WC8TmM7.4WvDlV_X.fW_2oXCIa5jng3NHgI1YgcoSeCP2lxtfuxjf5ULtzDPI0rJWUTq7xvGT6PfolvQzLATneEeq_ms.jgdT.wens6RtmYNCCQ1TQz8Z6A291kej4pDLdZpQQPpQcNRfwTJiQHzJMCq7KN_LX8pEnJucB5K2uJVgjwxvFKC6YYWDCyx3_wmGf5RssPE9r3OQoteOXfQcP4jx1tipZovzfFrQCW1OjpT4JAkhR.7zHq0QggNzbk4cphmW.gc9C.VTGherddo-
Received: from [91.196.252.17] by web59814.mail.ac4.yahoo.com via HTTP; Thu, 30 Apr 2009 12:55:20 PDT
X-Mailer: YahooMailWebService/0.7.289.1
Date:	Thu, 30 Apr 2009 12:55:20 -0700 (PDT)
From:	Andrew Randrianasulu <randrik_a@yahoo.com>
Reply-To: randrik_a@yahoo.com
Subject: [PATCH] 0002-sgi-o2-gbe-mte-init.diff
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <randrik_a@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: randrik_a@yahoo.com
Precedence: bulk
X-list: linux-mips


Very simple test patch, broke nothing for me.

diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
index ed732a8..1d3b599 100644
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -31,6 +31,7 @@
 #include <asm/tlbflush.h>
 
 #include <video/gbe.h>
+#include <video/crmfbreg.h>
 
 static struct sgi_gbe *gbe;
 
@@ -651,6 +652,7 @@ static void gbe_set_timing_info(struct gbe_timing_info *timing)
 static int gbefb_set_par(struct fb_info *info)
 {
 	int i;
+	unsigned int mte_current_mode; /* temporary  */
 	unsigned int val;
 	int wholeTilesX, partTilesX, maxPixelsPerTileX;
 	int height_pix;
@@ -695,6 +697,16 @@ static int gbefb_set_par(struct fb_info *info)
 	/* Initialize interrupts */
 	gbe->sgi_gbe_vt.vt_intr01 = 0xffffffff;
 	gbe->sgi_gbe_vt.vt_intr23 = 0xffffffff;
+	
+	/* Initialize MTE */
+	mte_current_mode = MTE_MODE_DST_ECC | 
+			    (MTE_TLB_A << MTE_DST_TLB_SHIFT) |
+			    (MTE_TLB_A << MTE_SRC_TLB_SHIFT) |
+			    (MTE_DEPTH_8 << MTE_DEPTH_SHIFT) |
+			    MTE_MODE_COPY; 
+	gbe->sgi_crm_mte.crm_mte_mode =  mte_current_mode;
+	gbe->sgi_crm_mte.crm_mte_dst_y_step = 1;
+	gbe->sgi_crm_mte.crm_mte_src_y_step = 1;
 
 	/* HACK:
 	   The GBE hardware uses a tiled memory to screen mapping. Tiles are



      
