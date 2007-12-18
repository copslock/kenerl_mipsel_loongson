Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2007 00:35:25 +0000 (GMT)
Received: from mx01.hansenet.de ([213.191.73.25]:21634 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S28577085AbXLRAfQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Dec 2007 00:35:16 +0000
Received: from [213.39.184.147] (213.39.184.147) by webmail.hansenet.de (7.3.118.12) (authenticated as mbx20228207@koeller-hh.org)
        id 4761398E00AECD10; Tue, 18 Dec 2007 01:31:47 +0100
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by mail.koeller.dyndns.org (Postfix) with ESMTP id 4415847A63;
	Tue, 18 Dec 2007 01:31:40 +0100 (CET)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Date:	Tue, 18 Dec 2007 01:26:19 +0100
Subject: [PATCH 1/4] Introduced GPI_RM9000 configuration parameter
X-Length: 809
X-UID:	18
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20071218003140.4415847A63@mail.koeller.dyndns.org>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c6fc405..62bc553 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -856,6 +856,9 @@ config GENERIC_ISA_DMA_SUPPORT_BROKEN
 config GENERIC_GPIO
 	bool
 
+config GPI_RM9000
+       bool
+
 #
 # Endianess selection.  Sufficiently obscure so many users don't know what to
 # answer,so we try hard to limit the available choices.  Also the use of a
@@ -927,6 +930,7 @@ config MIPS_TX3927
 config MIPS_RM9122
 	bool
 	select SERIAL_RM9000
+	select GPI_RM9000
 
 config PNX8550
 	bool
-- 
1.5.3.6
