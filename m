Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2007 21:20:07 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:29702 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20022935AbXG2UUF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 29 Jul 2007 21:20:05 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 0427DD8D1; Sun, 29 Jul 2007 20:19:27 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 9C90D54373; Sun, 29 Jul 2007 22:19:02 +0200 (CEST)
Date:	Sun, 29 Jul 2007 22:19:02 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Peter Horton <pdh@colonel-panic.org>
Subject: [PATCH] Enable UART on RaQ1
Message-ID: <20070729201902.GA29279@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Unlike the current code suggests, the RaQ1 actually has an UART.  Only
the Qube1 (Qube 2700) lacks one.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

--- a/arch/mips/cobalt/serial.c	2007-07-29 19:47:38.000000000 +0000
+++ b/arch/mips/cobalt/serial.c	2007-07-29 19:48:15.000000000 +0000
@@ -55,9 +55,9 @@
 	int retval;
 
 	/*
-	 * Cobalt Qube1 and RAQ1 have no UART.
+	 * Cobalt Qube1 has no UART.
 	 */
-	if (cobalt_board_id <= COBALT_BRD_ID_RAQ1)
+	if (cobalt_board_id == COBALT_BRD_ID_QUBE1)
 		return 0;
 
 	pdev = platform_device_alloc("serial8250", -1);

-- 
Martin Michlmayr
http://www.cyrius.com/
