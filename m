Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 11:49:28 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:31388 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20021829AbXIKKtT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2007 11:49:19 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IV3Fy-0005TV-01
	for linux-mips@linux-mips.org; Tue, 11 Sep 2007 12:46:10 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id EB27BC3319; Tue, 11 Sep 2007 12:44:59 +0200 (CEST)
Date:	Tue, 11 Sep 2007 12:44:59 +0200
To:	linux-mips@linux-mips.org
Subject: [PATCH] IP22: Disable EARLY PRINTK, because it breaks serial console
Message-ID: <20070911104459.GB7624@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Disable EARLY PRINTK, because it breaks serial console

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3b807b4..1f0502d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -334,7 +334,6 @@ config SGI_IP22
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_R4X00
 	select SYS_HAS_CPU_R5000
-	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
-- 
1.4.4.4

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
