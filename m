Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Oct 2002 19:07:16 +0200 (CEST)
Received: from luonnotar.infodrom.org ([195.124.48.78]:5133 "EHLO
	luonnotar.infodrom.org") by linux-mips.org with ESMTP
	id <S1123900AbSJSRHP>; Sat, 19 Oct 2002 19:07:15 +0200
Received: by luonnotar.infodrom.org (Postfix, from userid 10)
	id 1FC92366B55; Sat, 19 Oct 2002 19:07:10 +0200 (CEST)
Received: at Infodrom Oldenburg (/\##/\ Smail-3.2.0.102 1998-Aug-2 #2)
	from infodrom.org by finlandia.Infodrom.North.DE
	via smail from stdin
	id <m182x2c-000og9C@finlandia.Infodrom.North.DE>
	for ralf@linux-mips.org; Sat, 19 Oct 2002 19:05:34 +0200 (CEST) 
Date: Sat, 19 Oct 2002 19:05:34 +0200
From: Martin Schulze <joey@infodrom.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] Correct monochrome selection
Message-ID: <20021019170534.GS14430@finlandia.infodrom.north.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <joey@infodrom.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joey@infodrom.org
Precedence: bulk
X-list: linux-mips

Hi Ralf,

please apply the patch below which will add proper handling for
monochrome graphic cards.

Both changes are required since there are graphic cards out in the
voi^Wwild that are monochrome but have bits_per_pixel set to something
else than 1, e.g. PMAG-AA which uses 8 bits per pixel but ignores 7 of
it.

Since currently no such card is supported, this change wasn't
required.  However, we developed support for the PMAG-AA card and we
would like to add support for it to the Linux kernel, of course.

Regards,

	Joey


Index: fbcon.c
===================================================================
RCS file: /home/cvs/linux/drivers/video/fbcon.c,v
retrieving revision 1.28.2.4
diff -u -r1.28.2.4 fbcon.c
--- fbcon.c	2 Oct 2002 13:28:31 -0000	1.28.2.4
+++ fbcon.c	19 Oct 2002 16:57:40 -0000
@@ -711,7 +711,8 @@
     if ((p->var.yres % fontheight(p)) &&
 	(p->var.yres_virtual % fontheight(p) < p->var.yres % fontheight(p)))
 	p->vrows--;
-    conp->vc_can_do_color = p->var.bits_per_pixel != 1;
+    conp->vc_can_do_color = (p->fb_info->fix.visual != FB_VISUAL_MONO10 &&
+			     p->fb_info->fix.visual != FB_VISUAL_MONO01);
     conp->vc_complement_mask = conp->vc_can_do_color ? 0x7700 : 0x0800;
     if (charcnt == 256) {
     	conp->vc_hi_font_mask = 0;
@@ -2177,7 +2178,12 @@
 					   p->fb_info);
 	}
 	
-    if (depth >= 8) {
+    if (p->visual == FB_VISUAL_MONO10 ||
+	p->visual == FB_VISUAL_MONO01) {
+	logo = linux_logo_bw;
+	logo_depth = 1;
+    }
+    else if (depth >= 8) {
 	logo = linux_logo;
 	logo_depth = 8;
     }

-- 
Every use of Linux is a proper use of Linux.  -- Jon "Maddog" Hall
