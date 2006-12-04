Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2006 09:36:49 +0000 (GMT)
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:37640 "EHLO
	tuxland.pl") by ftp.linux-mips.org with ESMTP id S20038708AbWLDJgp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Dec 2006 09:36:45 +0000
Received: from [192.168.1.3] (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by tuxland.pl (Postfix) with ESMTP id 70C4F6EF87;
	Mon,  4 Dec 2006 10:36:23 +0100 (CET)
Received: from [192.168.1.3] ([192.168.1.3])
	by tuxland.pl (AISK); Mon, 04 Dec 2006 10:36:22 +0100 (CET)
From:	Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To:	ralf@linux-mips.org
Subject: [2.4 PATCH] mips/mips64 mv64340 parenthesis fixes
Date:	Mon, 4 Dec 2006 10:36:21 +0100
User-Agent: KMail/1.9.5
Cc:	linux-mips@linux-mips.org, Willy Tarreau <wtarreau@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612041036.21953.m.kozlowski@tuxland.pl>
Return-Path: <m.kozlowski@tuxland.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.kozlowski@tuxland.pl
Precedence: bulk
X-list: linux-mips

Hello,

        This patch fixes parenthesis mv64340 stuff in both mips and mips64 code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-mips/mv64340.h   |    2 +-
 include/asm-mips64/mv64340.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -upr linux-2.4.34-pre6-a/include/asm-mips/mv64340.h linux-2.4.34-pre6-b/include/asm-mips/mv64340.h
--- linux-2.4.34-pre6-a/include/asm-mips/mv64340.h	2003-08-25 13:44:43.000000000 +0200
+++ linux-2.4.34-pre6-b/include/asm-mips/mv64340.h	2006-12-01 11:56:57.000000000 +0100
@@ -718,7 +718,7 @@
 #define MV64340_ETH_RX_FIFO_URGENT_THRESHOLD_REG(port)             (0x2470 + (port<<10))
 #define MV64340_ETH_TX_FIFO_URGENT_THRESHOLD_REG(port)             (0x2474 + (port<<10))
 #define MV64340_ETH_RX_MINIMAL_FRAME_SIZE_REG(port)                (0x247c + (port<<10))
-#define MV64340_ETH_RX_DISCARDED_FRAMES_COUNTER(port)              (0x2484 + (port<<10)
+#define MV64340_ETH_RX_DISCARDED_FRAMES_COUNTER(port)              (0x2484 + (port<<10))
 #define MV64340_ETH_PORT_DEBUG_0_REG(port)                         (0x248c + (port<<10))
 #define MV64340_ETH_PORT_DEBUG_1_REG(port)                         (0x2490 + (port<<10))
 #define MV64340_ETH_PORT_INTERNAL_ADDR_ERROR_REG(port)             (0x2494 + (port<<10))
diff -upr linux-2.4.34-pre6-a/include/asm-mips64/mv64340.h linux-2.4.34-pre6-b/include/asm-mips64/mv64340.h
--- linux-2.4.34-pre6-a/include/asm-mips64/mv64340.h	2003-08-25 13:44:44.000000000 +0200
+++ linux-2.4.34-pre6-b/include/asm-mips64/mv64340.h	2006-12-01 12:01:03.000000000 +0100
@@ -718,7 +718,7 @@
 #define MV64340_ETH_RX_FIFO_URGENT_THRESHOLD_REG(port)             (0x2470 + (port<<10))
 #define MV64340_ETH_TX_FIFO_URGENT_THRESHOLD_REG(port)             (0x2474 + (port<<10))
 #define MV64340_ETH_RX_MINIMAL_FRAME_SIZE_REG(port)                (0x247c + (port<<10))
-#define MV64340_ETH_RX_DISCARDED_FRAMES_COUNTER(port)              (0x2484 + (port<<10)
+#define MV64340_ETH_RX_DISCARDED_FRAMES_COUNTER(port)              (0x2484 + (port<<10))
 #define MV64340_ETH_PORT_DEBUG_0_REG(port)                         (0x248c + (port<<10))
 #define MV64340_ETH_PORT_DEBUG_1_REG(port)                         (0x2490 + (port<<10))
 #define MV64340_ETH_PORT_INTERNAL_ADDR_ERROR_REG(port)             (0x2494 + (port<<10))


-- 
Regards,

	Mariusz Kozlowski
