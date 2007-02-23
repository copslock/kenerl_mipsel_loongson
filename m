Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2007 00:44:57 +0000 (GMT)
Received: from mail04.hansenet.de ([213.191.73.12]:35490 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20038786AbXBWAov (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Feb 2007 00:44:51 +0000
Received: from [213.39.184.63] (213.39.184.63) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 45CB2EBD0062CE7F; Fri, 23 Feb 2007 01:41:00 +0100
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by mail.koeller.dyndns.org (Postfix) with ESMTP id 80719479FC;
	Fri, 23 Feb 2007 01:40:59 +0100 (CET)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Date:	Fri, 23 Feb 2007 01:40:34 +0100
Subject: [PATCH 1/2] excite: Rename CONFIG option
X-Length: 1020
X-UID:	9
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200702230140.35409.thomas.koeller@baslerweb.com>
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

This change is purely cosmetical.

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
---
 arch/mips/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9ccaddc..92b5b50 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -133,7 +133,7 @@ config MIPS_MIRAGE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config BASLER_EXCITE
-	bool "Basler eXcite smart camera support"
+	bool "Basler eXcite smart camera"
 	select DMA_COHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
@@ -146,7 +146,7 @@ config BASLER_EXCITE
 	select SYS_SUPPORTS_BIG_ENDIAN
 	help
 	  The eXcite is a smart camera platform manufactured by
-	  Basler Vision Technologies AG
+	  Basler Vision Technologies AG.
 
 config BASLER_EXCITE_PROTOTYPE
 	bool "Support for pre-release units"
-- 
1.5.0
