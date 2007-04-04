Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2007 15:31:56 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:19175 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022002AbXDDObN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Apr 2007 15:31:13 +0100
Received: (qmail 16927 invoked by uid 511); 4 Apr 2007 14:30:21 -0000
Received: from unknown (HELO heart.lemote.com) (192.168.2.206)
  by lemote.com with SMTP; 4 Apr 2007 14:30:21 -0000
Message-ID: <258685.371696146-sendEmail@heart>
From:	"zhangfx@lemote.com" <zhangfx@lemote.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject:  [PATCH 9/16] add serial port definition for lemote fulong
Date:	Wed, 4 Apr 2007 14:38:19 +0000
X-Mailer: sendEmail-1.55
MIME-Version: 1.0
Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-322815.350796194"
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-322815.350796194
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 include/asm-mips/serial.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/serial.h b/include/asm-mips/serial.h
index d7a6513..9c9660e 100644
--- a/include/asm-mips/serial.h
+++ b/include/asm-mips/serial.h
@@ -204,6 +204,12 @@
 #define IP32_SERIAL_PORT_DEFNS
 #endif /* CONFIG_SGI_IP32 */
 
+#if defined(CONFIG_LEMOTE_FULONG)
+#define LEMOTE_FULONG_SERIAL_PORT_DEFNS					\
+	/* UART CLK   PORT IRQ     FLAGS        */			\
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
1.4.4.4



------MIME delimiter for sendEmail-322815.350796194--
