Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2007 16:10:10 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:22940 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20026189AbXHFPKI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Aug 2007 16:10:08 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1II4Da-0006Si-Sx; Mon, 06 Aug 2007 17:10:02 +0200
Date:	Mon, 6 Aug 2007 17:10:02 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org
Cc:	Michael Buesch <mb@bu3sch.de>, Waldemar Brodkorb <wbx@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
Subject: [PATCH -mm 4/4] MIPS: Add BCM947xx to Makefile
Message-ID: <20070806151002.GI24308@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

The patch below against 2.6.23-rc1-mm2 adds BCM947xx to 
arch/mips/Makefile.

Cc: Michael Buesch <mb@bu3sch.de>
Cc: Waldemar Brodkorb <wbx@openwrt.org>
Cc: Felix Fietkau <nbd@openwrt.org>
Cc: Florian Schirmer <jolt@tuxbox.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -549,6 +549,12 @@
 load-$(CONFIG_SIBYTE_BIGSUR)	:= 0xffffffff80100000
 
 #
+# Broadcom BCM947XX boards
+#
+core-$(CONFIG_BCM947XX)		+= arch/mips/bcm947xx/
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
