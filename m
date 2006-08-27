Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Aug 2006 12:57:38 +0100 (BST)
Received: from mail04.hansenet.de ([213.191.73.12]:20218 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20038656AbWH0L4r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 27 Aug 2006 12:56:47 +0100
Received: from [213.39.141.67] (213.39.141.67) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 44EC4423000F6380; Sun, 27 Aug 2006 13:56:40 +0200
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by sarkovy.koeller.dyndns.org (Postfix) with ESMTP id 41B291770BD;
	Sun, 27 Aug 2006 13:56:40 +0200 (CEST)
X-Mailbox-Line:	From 7cf22dd5aa18b77584cfff4136ae0ac806897d04 Mon Sep 17 00:00:00 2001
From:	thomas@koeller.dyndns.org
Date:	Sun, 27 Aug 2006 13:51:48 +0200
Subject: [PATCH] Add configuration variables for RM9xxx processor
Organization: Basler AG
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thomas =?iso-8859-15?q?K=F6ller?= <thomas.koeller@baslerweb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608271351.48462.thomas@koeller.dyndns.org>
Return-Path: <thomas@koeller.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@koeller.dyndns.org
Precedence: bulk
X-list: linux-mips

This patch introduces a number of configuration variables. These allow to
specify presence/absence of integrated peripherals found on the MIPS
RM9xxx processor family, based on the particular processor model used.

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
---
 arch/mips/Kconfig |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 96165d7..8affac6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -126,6 +126,7 @@ config BASLER_EXCITE
 	select IRQ_CPU
 	select IRQ_CPU_RM7K
 	select IRQ_CPU_RM9K
+	select MIPS_RM9122
 	select SYS_HAS_CPU_RM9000
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
@@ -971,6 +972,12 @@ config MIPS_TX3927
 	bool
 	select HAS_TXX9_SERIAL
 
+config MIPS_RM9122
+	bool
+	select SERIAL_RM9000
+	select GPI_RM9000
+	select WDT_RM9000
+
 config PCI_MARVELL
 	bool
 
@@ -1021,6 +1028,15 @@ config EMMA2RH
 	depends on MARKEINS
 	default y
 
+config SERIAL_RM9000
+	bool
+
+config GPI_RM9000
+	bool
+
+config WDT_RM9000
+	bool
+
 #
 # Unfortunately not all GT64120 systems run the chip at the same clock.
 # As the user for the clock rate and try to minimize the available options.
-- 
1.4.0


-- 
Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com
