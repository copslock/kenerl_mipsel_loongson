Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Oct 2002 18:47:21 +0200 (CEST)
Received: from luonnotar.infodrom.org ([195.124.48.78]:2061 "EHLO
	luonnotar.infodrom.org") by linux-mips.org with ESMTP
	id <S1123900AbSJSQrU>; Sat, 19 Oct 2002 18:47:20 +0200
Received: by luonnotar.infodrom.org (Postfix, from userid 10)
	id 42E8A366B55; Sat, 19 Oct 2002 18:47:11 +0200 (CEST)
Received: at Infodrom Oldenburg (/\##/\ Smail-3.2.0.102 1998-Aug-2 #2)
	from infodrom.org by finlandia.Infodrom.North.DE
	via smail from stdin
	id <m182wiA-000pG2C@finlandia.Infodrom.North.DE>
	for ralf@linux-mips.org; Sat, 19 Oct 2002 18:44:26 +0200 (CEST) 
Date: Sat, 19 Oct 2002 18:44:26 +0200
From: Martin Schulze <joey@infodrom.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] Update DECstation FB description
Message-ID: <20021019164426.GQ14430@finlandia.infodrom.north.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <joey@infodrom.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joey@infodrom.org
Precedence: bulk
X-list: linux-mips

Moin Ralf,

please apply the patch below from Karsten Merker which corrects
and update the description for three DECstation framebuffers.

Regards,

	Joey



Index: Configure.help
===================================================================
RCS file: /home/cvs/linux/Documentation/Attic/Configure.help,v
retrieving revision 1.109.2.9
diff -u -r1.109.2.9 Configure.help
--- Configure.help	3 Oct 2002 01:27:58 -0000	1.109.2.9
+++ Configure.help	19 Oct 2002 16:42:28 -0000
@@ -4416,21 +4416,20 @@
 
 Maxine (Personal DECstation) onboard framebuffer support
 CONFIG_FB_MAXINE
-  Say Y here to directly support the on-board framebuffer in the
-  Maxine (5000/20, /25, /33) version of the DECstation.  There is a
-  page dedicated to Linux on DECstations at <http://decstation.unix-ag.org/>.
+  Support for the onboard framebuffer (1024x768x8) in the Personal
+  DECstation series (Personal DECstation 5000/20, /25, /33, /50,
+  Codename "Maxine").
 
 PMAG-BA TURBOchannel framebuffer support
 CONFIG_FB_PMAG_BA
-  Say Y here to directly support the on-board PMAG-BA framebuffer in
-  the 5000/1xx versions of the DECstation.  There is a page dedicated
-  to Linux on DECstations at <http://decstation.unix-ag.org/>.
+  Support for the PMAG-BA TURBOchannel framebuffer card (1024x864x8)
+  used mainly in the MIPS-based DECstation series.
 
 PMAGB-B TURBOchannel framebuffer support
 CONFIG_FB_PMAGB_B
-  Say Y here to directly support the on-board PMAGB-B framebuffer in
-  the 5000/1xx versions of the DECstation.  There is a page dedicated
-  to Linux on DECstations at <http://decstation.unix-ag.org/>.
+  Support for the PMAGB-B TURBOchannel framebuffer card used mainly
+  in the MIPS-based DECstation series. The card is currently only 
+  supported in 1280x1024x8 mode.  
 
 FutureTV PCI card
 CONFIG_ARCH_FTVPCI

-- 
Every use of Linux is a proper use of Linux.  -- Jon "Maddog" Hall
