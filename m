Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 01:07:08 +0200 (CEST)
Received: from gateway-1237.mvista.com ([12.44.186.158]:33519 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1122987AbSIPXHH>;
	Tue, 17 Sep 2002 01:07:07 +0200
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g8GMsdf20722;
	Mon, 16 Sep 2002 15:54:39 -0700
Date: Mon, 16 Sep 2002 15:54:39 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] make xconfig work again
Message-ID: <20020916155439.B17321@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Kind of guess the fix for au1000 and decstation....

Jun

--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="020916.a.make-xconfig-work-again.patch"

diff -Nru link/arch/mips/config-shared.in.orig link/arch/mips/config-shared.in
--- link/arch/mips/config-shared.in.orig	Mon Sep 16 14:19:06 2002
+++ link/arch/mips/config-shared.in	Mon Sep 16 15:30:31 2002
@@ -479,7 +479,7 @@
 if [ "$CONFIG_CPU_SB1" = "y" ]; then
    choice 'SB1 Pass' \
 	 "Pass1   CONFIG_CPU_SB1_PASS_1  \
-	  Pass2   CONFIG_CPU_SB1_PASS_2
+	  Pass2   CONFIG_CPU_SB1_PASS_2  \
 	  Pass2.2 CONFIG_CPU_SB1_PASS_2_2" Pass1
    if [ "$CONFIG_CPU_SB1_PASS_1" = "y" ]; then
       define_bool CONFIG_SB1_PASS_1_WORKAROUNDS y
diff -Nru link/drivers/pcmcia/Config.in.orig link/drivers/pcmcia/Config.in
--- link/drivers/pcmcia/Config.in.orig	Wed Aug 21 15:45:59 2002
+++ link/drivers/pcmcia/Config.in	Mon Sep 16 15:49:30 2002
@@ -30,9 +30,9 @@
       dep_tristate '  M8xx support' CONFIG_PCMCIA_M8XX $CONFIG_PCMCIA
    fi
    if [ "$CONFIG_MIPS_AU1000" = "y" ]; then
-      dep_tristate '  Au1x00 pcmcia support' CONFIG_PCMCIA_AU1000 $CONFIG_PCMCIA 
+      dep_tristate '  Au1x00 pcmcia support' CONFIG_PCMCIA_AU1000 $CONFIG_PCMCIA
       if [ "$CONFIG_PCMCIA_AU1000" != "n" ]; then
-        dep_tristate '  Pb1x00 board support' CONFIG_PCMCIA_PB1X00
+         bool '  Pb1x00 board support' CONFIG_PCMCIA_PB1X00
       fi
    fi
 fi
diff -Nru link/drivers/video/Config.in.orig link/drivers/video/Config.in
--- link/drivers/video/Config.in.orig	Mon Sep 16 14:20:33 2002
+++ link/drivers/video/Config.in	Mon Sep 16 15:34:42 2002
@@ -213,7 +213,7 @@
    if [ "$CONFIG_DECSTATION" = "y" ]; then
       dep_bool '  PMAG-BA TURBOchannel framebuffer support' CONFIG_FB_PMAG_BA $CONFIG_TC
       dep_bool '  PMAGB-B TURBOchannel framebuffer support' CONFIG_FB_PMAGB_B $CONFIG_TC
-      dep_bool '  Maxine (Personal DECstation) onboard framebuffer support' CONFIG_FB_MAXINE
+      dep_bool '  Maxine (Personal DECstation) onboard framebuffer support' CONFIG_FB_MAXINE  $CONFIG_TC
    fi
    if [ "$CONFIG_NINO" = "y" ]; then
       bool '  TMPTX3912/PR31700 frame buffer support' CONFIG_FB_TX3912

--i0/AhcQY5QxfSsSZ--
