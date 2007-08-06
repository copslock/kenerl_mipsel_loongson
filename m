Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2007 16:12:49 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:30851 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20026192AbXHFPMq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Aug 2007 16:12:46 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1II4D6-0006SF-1F; Mon, 06 Aug 2007 17:09:32 +0200
Date:	Mon, 6 Aug 2007 17:09:31 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org
Cc:	Michael Buesch <mb@bu3sch.de>, Waldemar Brodkorb <wbx@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
Subject: [PATCH -mm 3/4] MIPS: Add BCM947XX to Kconfig
Message-ID: <20070806150931.GH24308@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

The patch below against 2.6.23-rc1-mm2 adds a BCM947XX option to 
Kconfig.

Cc: Michael Buesch <mb@bu3sch.de>
Cc: Waldemar Brodkorb <wbx@openwrt.org>
Cc: Felix Fietkau <nbd@openwrt.org>
Cc: Florian Schirmer <jolt@tuxbox.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -38,6 +38,22 @@
 	  Lemote Fulong mini-PC board based on the Chinese Loongson-2E CPU and
 	  an FPGA northbridge
 
+config BCM947XX
+	bool "Support for BCM947xx based boards"
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select IRQ_CPU
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SSB
+	select SSB_SERIAL
+	select SSB_DRIVER_PCICORE
+	select SSB_PCICORE_HOSTMODE
+	select GENERIC_GPIO
+	help
+	 Support for BCM947xx based boards
+
 config MACH_ALCHEMY
 	bool "Alchemy processor based machines"
 
-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
