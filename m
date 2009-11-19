Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2009 17:40:32 +0100 (CET)
Received: from sorrow.cyrius.com ([65.19.161.204]:58442 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1494039AbZKSQkZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2009 17:40:25 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 99368D8C6; Thu, 19 Nov 2009 16:40:22 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 699AD1501ED; Thu, 19 Nov 2009 16:40:09 +0000 (GMT)
Date:	Thu, 19 Nov 2009 16:40:09 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Disable EARLY_PRINTK on IP22 to make the system boot
Message-ID: <20091119164009.GA15038@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Some Debian users have reported that the kernel hangs early
during boot on some IP22 systems.  Thomas Bogendoerfer found
that this is due to a "bad interaction between CONFIG_EARLY_PRINTK
and overwritten prom memory during early boot".  Since there's
no fix yet, disable CONFIG_EARLY_PRINTK for now.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1aad0d9..42e1ac1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -358,7 +358,9 @@ config SGI_IP22
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_R4X00
 	select SYS_HAS_CPU_R5000
-	select SYS_HAS_EARLY_PRINTK
+# Disable EARLY_PRINTK for now since it leads to overwritten prom memory
+# during early boot on some machines.
+#	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN

-- 
Martin Michlmayr
http://www.cyrius.com/
