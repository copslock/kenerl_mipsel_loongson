Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Oct 2002 18:57:16 +0200 (CEST)
Received: from luonnotar.infodrom.org ([195.124.48.78]:3085 "EHLO
	luonnotar.infodrom.org") by linux-mips.org with ESMTP
	id <S1123900AbSJSQ5P>; Sat, 19 Oct 2002 18:57:15 +0200
Received: by luonnotar.infodrom.org (Postfix, from userid 10)
	id 8BAA3366B55; Sat, 19 Oct 2002 18:57:09 +0200 (CEST)
Received: at Infodrom Oldenburg (/\##/\ Smail-3.2.0.102 1998-Aug-2 #2)
	from infodrom.org by finlandia.Infodrom.North.DE
	via smail from stdin
	id <m182woQ-000okWC@finlandia.Infodrom.North.DE>
	for ralf@linux-mips.org; Sat, 19 Oct 2002 18:50:54 +0200 (CEST) 
Date: Sat, 19 Oct 2002 18:50:54 +0200
From: Martin Schulze <joey@infodrom.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] Correct colour handling
Message-ID: <20021019165053.GR14430@finlandia.infodrom.north.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <joey@infodrom.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joey@infodrom.org
Precedence: bulk
X-list: linux-mips

Moin Ralf,

please apply the patch below which will correct colour handling.  The
outcome of this patch will only be visible with a monochrome graphics
card since they can see what is written on the screen again.

As you can see, not all occasions where the currently used colour is
changed, isn't protected by the 'if (can_do_color)' check.  Some
occurrences though use it.

This patch is done basically by Thiemo Seufer during this years'
Oldenburg meeting.

Regards,

	Joey


Index: console.c
===================================================================
RCS file: /home/cvs/linux/drivers/char/console.c,v
retrieving revision 1.37.2.2
diff -u -r1.37.2.2 console.c
--- console.c	26 Jun 2002 22:35:32 -0000	1.37.2.2
+++ console.c	19 Oct 2002 16:47:01 -0000
@@ -1046,7 +1046,8 @@
 	underline = 0;
 	reverse = 0;
 	blink = 0;
-	color = def_color;
+	if (can_do_color)
+		color = def_color;
 }
 
 /* console_sem is held */
@@ -1119,7 +1120,8 @@
 				  * with white underscore (Linux - use
 				  * default foreground).
 				  */
-				color = (def_color & 0x0f) | background;
+			        if (can_do_color)
+					color = (def_color & 0x0f) | background;
 				underline = 1;
 				break;
 			case 39: /* ANSI X3.64-1979 (SCO-ish?)
@@ -1127,11 +1129,13 @@
 				  * Reset colour to default? It did this
 				  * before...
 				  */
-				color = (def_color & 0x0f) | background;
+			        if (can_do_color)
+					color = (def_color & 0x0f) | background;
 				underline = 0;
 				break;
 			case 49:
-				color = (def_color & 0xf0) | foreground;
+			  	if (can_do_color)
+					color = (def_color & 0xf0) | foreground;
 				break;
 			default:
 				if (par[i] >= 30 && par[i] <= 37)
@@ -1274,9 +1278,11 @@
 			}
 			break;
 		case 8:	/* store colors as defaults */
-			def_color = attr;
-			if (hi_font_mask == 0x100)
-				def_color >>= 1;
+			if (can_do_color) {
+				def_color = attr;
+				if (hi_font_mask == 0x100)
+					def_color >>= 1;
+			}
 			default_attr(currcons);
 			update_attr(currcons);
 			break;
-- 
Every use of Linux is a proper use of Linux.  -- Jon "Maddog" Hall
