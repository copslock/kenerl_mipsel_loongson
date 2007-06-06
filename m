Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 05:47:22 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:21228 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022095AbXFFEn7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2007 05:43:59 +0100
Received: (qmail 26300 invoked by uid 511); 6 Jun 2007 04:50:07 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.233)
  by lemote.com with SMTP; 6 Jun 2007 04:50:07 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Songmao Tian <tiansm@lemote.com>
Subject: [PATCH] add serial port definition for lemote fulong
Date:	Wed,  6 Jun 2007 12:42:36 +0800
Message-Id: <11811049642577-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11811049622818-git-send-email-tiansm@lemote.com>
References: <11811049622818-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

From: Songmao Tian <tiansm@lemote.com>

Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 include/asm-mips/serial.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/serial.h b/include/asm-mips/serial.h
index ce51213..1237704 100644
--- a/include/asm-mips/serial.h
+++ b/include/asm-mips/serial.h
@@ -164,6 +164,12 @@
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
@@ -172,6 +178,7 @@
 	STD_SERIAL_PORT_DEFNS				\
 	MOMENCO_OCELOT_C_SERIAL_PORT_DEFNS		\
 	MOMENCO_OCELOT_SERIAL_PORT_DEFNS		\
-	MOMENCO_OCELOT_3_SERIAL_PORT_DEFNS
+	MOMENCO_OCELOT_3_SERIAL_PORT_DEFNS		\
+	LEMOTE_FULONG_SERIAL_PORT_DEFNS
 
 #endif /* _ASM_SERIAL_H */
-- 
1.5.2.1
