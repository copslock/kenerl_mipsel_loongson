Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2007 00:45:23 +0000 (GMT)
Received: from mail02.hansenet.de ([213.191.73.62]:988 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20038790AbXBWAov (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Feb 2007 00:44:51 +0000
Received: from [213.39.184.63] (213.39.184.63) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 45DAB2230012E7F9; Fri, 23 Feb 2007 01:41:00 +0100
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by mail.koeller.dyndns.org (Postfix) with ESMTP id 37634479F5;
	Fri, 23 Feb 2007 01:40:59 +0100 (CET)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Date:	Fri, 23 Feb 2007 01:39:41 +0100
Subject: [PATCH 2/2] excite: Set serial driver iotype to UPIO_RM9000
X-Length: 835
X-UID:	10
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702230139.42492.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
---
 arch/mips/basler/excite/excite_setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/basler/excite/excite_setup.c 
b/arch/mips/basler/excite/excite_setup.c
index a1ce458..42f0eda 100644
--- a/arch/mips/basler/excite/excite_setup.c
+++ b/arch/mips/basler/excite/excite_setup.c
@@ -112,7 +112,7 @@ static int __init excite_init_console(void)
 	up.irq		= TITAN_IRQ;
 	up.uartclk	= TITAN_UART_CLK;
 	up.regshift	= 0;
-	up.iotype	= UPIO_MEM32;
+	up.iotype	= UPIO_RM9000;
 	up.type		= PORT_RM9000;
 	up.flags	= UPF_SHARE_IRQ;
 	up.line		= 0;
-- 
1.5.0
