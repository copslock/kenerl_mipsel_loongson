Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2008 04:27:19 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:18675 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20031567AbYEMD07 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 May 2008 04:26:59 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m4D3QioF003671;
	Tue, 13 May 2008 05:26:44 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m4D3QhHB003667;
	Tue, 13 May 2008 04:26:43 +0100
Date:	Tue, 13 May 2008 04:26:43 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Alessandro Zummo <a.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	David Woodhouse <dwmw2@infradead.org>,
	Jean Delvare <khali@linux-fr.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>
cc:	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] RTC: Build SWARM support as an object (#2)
Message-ID: <Pine.LNX.4.55.0805130238550.535@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Build the SWARM platform library is as an object rather than an archive
so that files which only contain symbols used by initcalls and do not
provide any symbols that would pull them from an archive still work.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
patch-2.6.26-rc1-20080505-swarm-core-16
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/arch/mips/Makefile linux-2.6.26-rc1-20080505/arch/mips/Makefile
--- linux-2.6.26-rc1-20080505.macro/arch/mips/Makefile	2008-05-05 02:55:23.000000000 +0000
+++ linux-2.6.26-rc1-20080505/arch/mips/Makefile	2008-05-05 21:10:50.000000000 +0000
@@ -538,19 +538,19 @@ cflags-$(CONFIG_SIBYTE_BCM1x80)	+= -Iinc
 # Sibyte SWARM board
 # Sibyte BCM91x80 (BigSur) board
 #
-libs-$(CONFIG_SIBYTE_CARMEL)	+= arch/mips/sibyte/swarm/
+core-$(CONFIG_SIBYTE_CARMEL)	+= arch/mips/sibyte/swarm/
 load-$(CONFIG_SIBYTE_CARMEL)	:= 0xffffffff80100000
-libs-$(CONFIG_SIBYTE_CRHINE)	+= arch/mips/sibyte/swarm/
+core-$(CONFIG_SIBYTE_CRHINE)	+= arch/mips/sibyte/swarm/
 load-$(CONFIG_SIBYTE_CRHINE)	:= 0xffffffff80100000
-libs-$(CONFIG_SIBYTE_CRHONE)	+= arch/mips/sibyte/swarm/
+core-$(CONFIG_SIBYTE_CRHONE)	+= arch/mips/sibyte/swarm/
 load-$(CONFIG_SIBYTE_CRHONE)	:= 0xffffffff80100000
-libs-$(CONFIG_SIBYTE_RHONE)	+= arch/mips/sibyte/swarm/
+core-$(CONFIG_SIBYTE_RHONE)	+= arch/mips/sibyte/swarm/
 load-$(CONFIG_SIBYTE_RHONE)	:= 0xffffffff80100000
-libs-$(CONFIG_SIBYTE_SENTOSA)	+= arch/mips/sibyte/swarm/
+core-$(CONFIG_SIBYTE_SENTOSA)	+= arch/mips/sibyte/swarm/
 load-$(CONFIG_SIBYTE_SENTOSA)	:= 0xffffffff80100000
-libs-$(CONFIG_SIBYTE_SWARM)	+= arch/mips/sibyte/swarm/
+core-$(CONFIG_SIBYTE_SWARM)	+= arch/mips/sibyte/swarm/
 load-$(CONFIG_SIBYTE_SWARM)	:= 0xffffffff80100000
-libs-$(CONFIG_SIBYTE_BIGSUR)	+= arch/mips/sibyte/swarm/
+core-$(CONFIG_SIBYTE_BIGSUR)	+= arch/mips/sibyte/swarm/
 load-$(CONFIG_SIBYTE_BIGSUR)	:= 0xffffffff80100000
 
 #
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/arch/mips/sibyte/swarm/Makefile linux-2.6.26-rc1-20080505/arch/mips/sibyte/swarm/Makefile
--- linux-2.6.26-rc1-20080505.macro/arch/mips/sibyte/swarm/Makefile	2004-01-29 04:57:05.000000000 +0000
+++ linux-2.6.26-rc1-20080505/arch/mips/sibyte/swarm/Makefile	2008-05-06 01:18:21.000000000 +0000
@@ -1,3 +1,3 @@
-lib-y				= setup.o rtc_xicor1241.o rtc_m41t81.o
+obj-y				:= setup.o rtc_xicor1241.o rtc_m41t81.o
 
-lib-$(CONFIG_KGDB)		+= dbg_io.o
+obj-$(CONFIG_KGDB)		+= dbg_io.o
