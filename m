Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2007 16:32:37 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:11993 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022738AbXDOP2A (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2007 16:28:00 +0100
Received: (qmail 19472 invoked by uid 511); 15 Apr 2007 15:28:06 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.197)
  by lemote.com with SMTP; 15 Apr 2007 15:28:06 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Fuxin Zhang <zhangfx@lemote.com>
Subject: [PATCH 9/16] add serial port definition for lemote fulong
Date:	Sun, 15 Apr 2007 23:25:58 +0800
Message-Id: <1176650766907-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <117665076617-git-send-email-tiansm@lemote.com>
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <11766507662638-git-send-email-tiansm@lemote.com> <11766507661133-git-send-email-tiansm@lemote.com> <11766507661526-git-send-email-tiansm@lemote.com> <11766507662650-git-send-email-tiansm@lemote.com> <11766507661684-git-send-email-tiansm@lemote.com> <117665076617-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

From: Fuxin Zhang <zhangfx@lemote.com>


Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 include/asm-mips/serial.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/serial.h b/include/asm-mips/serial.h
index d7a6513..0f78438 100644
--- a/include/asm-mips/serial.h
+++ b/include/asm-mips/serial.h
@@ -204,6 +204,12 @@
 #define IP32_SERIAL_PORT_DEFNS
 #endif /* CONFIG_SGI_IP32 */
 
+#if defined(CONFIG_LEMOTE_FULONG)
+#define LEMOTE_FULONG_SERIAL_PORT_DEFNS			\
+	/* UART CLK   PORT IRQ     FLAGS        */	\
+	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */
+#endif
+
 #define SERIAL_PORT_DFNS				\
 	DDB5477_SERIAL_PORT_DEFNS			\
 	EV64120_SERIAL_PORT_DEFNS			\
@@ -213,6 +219,7 @@
 	MOMENCO_OCELOT_G_SERIAL_PORT_DEFNS		\
 	MOMENCO_OCELOT_C_SERIAL_PORT_DEFNS		\
 	MOMENCO_OCELOT_SERIAL_PORT_DEFNS		\
-	MOMENCO_OCELOT_3_SERIAL_PORT_DEFNS
+	MOMENCO_OCELOT_3_SERIAL_PORT_DEFNS		\
+	LEMOTE_FULONG_SERIAL_PORT_DEFNS
 
 #endif /* _ASM_SERIAL_H */
-- 
1.4.4.1
