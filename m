Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 02:49:32 +0100 (BST)
Received: from mx01.hansenet.de ([213.191.73.25]:5870 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20023124AbXIKBtY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Sep 2007 02:49:24 +0100
Received: from [80.171.14.88] (80.171.14.88) by webmail.hansenet.de (7.3.118.12) (authenticated as mbx20228207@koeller-hh.org)
        id 46E1A14F0033FF4E; Tue, 11 Sep 2007 03:49:17 +0200
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by mail.koeller.dyndns.org (Postfix) with ESMTP id 701A6479DF;
	Tue, 11 Sep 2007 03:49:16 +0200 (CEST)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Date:	Tue, 11 Sep 2007 02:35:49 +0200
Subject: [PATCH] [MIPS] Introduced GPI_RM9000 configuration parameter.
X-Length: 963
X-UID:	14
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709110235.50359.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

GPI_RM9000 indicates the presence of FM9000-style GPI
(General Purpose Interface) hardware.

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
---
 arch/mips/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4a54d21..23ad4cc 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -791,6 +791,7 @@ config MIPS_TX3927
 config MIPS_RM9122
 	bool
 	select SERIAL_RM9000
+	select GPI_RM9000
 
 config PNX8550
 	bool
@@ -818,6 +819,9 @@ config EMMA2RH
 config SERIAL_RM9000
 	bool
 
+config GPI_RM9000
+	bool
+
 #
 # Unfortunately not all GT64120 systems run the chip at the same clock.
 # As the user for the clock rate and try to minimize the available options.
-- 
1.5.1.2
