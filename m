Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2007 01:46:20 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:58530 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20021681AbXHIAqC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2007 01:46:02 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1IIwA1-0001Uf-Mf; Thu, 09 Aug 2007 02:45:57 +0200
Date:	Thu, 9 Aug 2007 02:45:57 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-mips@linux-mips.org
Cc:	Andrew Morton <akpm@linux-foundation.org>, mb@bu3sch.de,
	nbd@openwrt.org, jolt@tuxbox.org
Subject: [PATCH 4/4][RFC] MIPS: Add BCM947xx to Makefile
Message-ID: <20070809004557.GE4682@hall.aurel32.net>
References: <20070806150900.GG24308@hall.aurel32.net> <200708062005.29657.mb@bu3sch.de> <20070806183316.GB32465@hall.aurel32.net> <200708062037.05995.mb@bu3sch.de> <20070806191712.GA2019@hall.aurel32.net> <20070807094045.2c6eaa38.yoichi_yuasa@tripeaks.co.jp> <20070807121638.GA9953@hall.aurel32.net> <20070807183302.1e38a4df.akpm@linux-foundation.org> <20070809004156.GA4682@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20070809004156.GA4682@hall.aurel32.net>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

The patch below against 2.6.23-rc1-mm2 adds BCM947xx to 
arch/mips/Makefile.

Cc: Michael Buesch <mb@bu3sch.de>
Cc: Felix Fietkau <nbd@openwrt.org>
Cc: Florian Schirmer <jolt@tuxbox.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -549,6 +549,13 @@
 load-$(CONFIG_SIBYTE_BIGSUR)	:= 0xffffffff80100000
 
 #
+# Broadcom BCM947XX boards
+#
+core-$(CONFIG_BCM947XX)		+= arch/mips/bcm947xx/
+cflags-$(CONFIG_BCM947XX)	+= -Iinclude/asm-mips/mach-bcm947xx
+load-$(CONFIG_BCM947XX)		:= 0xffffffff80001000
+
+#
 # SNI RM
 #
 core-$(CONFIG_SNI_RM)		+= arch/mips/sni/

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
