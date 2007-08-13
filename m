Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2007 07:30:29 +0100 (BST)
Received: from DSL022.labridge.com ([206.117.136.22]:43282 "EHLO perches.com")
	by ftp.linux-mips.org with ESMTP id S20022009AbXHMGa0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Aug 2007 07:30:26 +0100
Received: from localhost ([192.168.1.128])
	by perches.com (8.9.3/8.9.3) with SMTP id XAA11322;
	Sun, 12 Aug 2007 23:53:11 -0700
Date:	Sun, 12 Aug 2007 23:30:06 -0700
From:	joe@perches.com
To:	torvalds@linux-foundation.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH] [261/2many] MAINTAINERS - IOC3 DRIVER
Message-ID: <46bffa6e.aluJMNuvp11tc2XU%joe@perches.com>
User-Agent: Heirloom mailx 12.2 01/07/07
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 6263958..207331c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2501,6 +2501,8 @@ P:	Ralf Baechle
 M:	ralf@linux-mips.org
 L:	linux-mips@linux-mips.org
 S:	Maintained
+F:	drivers/net/ioc3-eth.c
+F:	drivers/serial/ioc3_serial.c
 
 IP MASQUERADING:
 P:	Juanjo Ciarlante
