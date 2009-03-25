Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2009 16:53:27 +0000 (GMT)
Received: from mail-bw0-f177.google.com ([209.85.218.177]:21449 "EHLO
	mail-bw0-f177.google.com") by ftp.linux-mips.org with ESMTP
	id S28575240AbZCYQtm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Mar 2009 16:49:42 +0000
Received: by bwz25 with SMTP id 25so142149bwz.0
        for <linux-mips@linux-mips.org>; Wed, 25 Mar 2009 09:49:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=TmPPgqzHwTN26v5gpwS8t5kuoiCL/LWsk2XtTg9zxYI=;
        b=Kf+z48ayFpjjNh6goE+bn+NnWIsScLruVgN+6rcBOK4EbQJqVAXirLZiRuPnQLwEzF
         I908odvP2Shq0hoMOlzoPR2BLmw2L4tE6pqwJ+LB+R27CF/ukcIE2/K2qwptM+c0SY5O
         U+l1lTPSRo3evBZk0mwc3GBSd1sPq/psbrmlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=GZTP3NQzKpF2K9S3TnNblNJF/omvyVJ+4ETebEsrIwBAHcp5jNiBUOnN0825Bgjj10
         BB4IdsgZm/KV4NP+aFTNp8SmgbSl99Dgn5yXJ9CksKuN7O7jcCeq1r7vTxspHlhkduYa
         kvl+QPRL8GIJ49LfUnRx0xIOPuhc93lCQWQ/s=
Received: by 10.103.250.1 with SMTP id c1mr4280569mus.64.1237999776518;
        Wed, 25 Mar 2009 09:49:36 -0700 (PDT)
Received: from localhost.localdomain (p5496CCD7.dip.t-dialin.net [84.150.204.215])
        by mx.google.com with ESMTPS id e10sm14966093muf.41.2009.03.25.09.49.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 09:49:36 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 4/6] Alchemy: PB1200: use SMC91X platform data.
Date:	Wed, 25 Mar 2009 17:49:31 +0100
Message-Id: <1237999773-5174-5-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1237999773-5174-4-git-send-email-mano@roarinelk.homelinux.net>
References: <1237999773-5174-1-git-send-email-mano@roarinelk.homelinux.net>
 <1237999773-5174-2-git-send-email-mano@roarinelk.homelinux.net>
 <1237999773-5174-3-git-send-email-mano@roarinelk.homelinux.net>
 <1237999773-5174-4-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Add platform data for the smc91x on the PB1200/DB1200, and remove the
now unused AU1X00 entry in smc91x.h.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/devboards/pb1200/platform.c |   10 +++++++
 drivers/net/smc91x.h                          |   32 -------------------------
 2 files changed, 10 insertions(+), 32 deletions(-)

diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index 9530329..0d68e19 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
+#include <linux/smc91x.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
@@ -131,6 +132,12 @@ static struct platform_device ide_device = {
 	.resource	= ide_resources
 };
 
+static struct smc91x_platdata smc_data = {
+	.flags	= SMC91X_NOWAIT | SMC91X_USE_16BIT,
+	.leda	= RPC_LED_100_10,
+	.ledb	= RPC_LED_TX_RX,
+};
+
 static struct resource smc91c111_resources[] = {
 	[0] = {
 		.name	= "smc91x-regs",
@@ -146,6 +153,9 @@ static struct resource smc91c111_resources[] = {
 };
 
 static struct platform_device smc91c111_device = {
+	.dev	= {
+		.platform_data	= &smc_data,
+	},
 	.name		= "smc91x",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(smc91c111_resources),
diff --git a/drivers/net/smc91x.h b/drivers/net/smc91x.h
index c4ccd12..45f4f8f 100644
--- a/drivers/net/smc91x.h
+++ b/drivers/net/smc91x.h
@@ -345,38 +345,6 @@ static inline void LPD7_SMC_outsw (unsigned char* a, int r,
 #define RPC_LSA_DEFAULT		RPC_LED_TX_RX
 #define RPC_LSB_DEFAULT		RPC_LED_100_10
 
-#elif defined(CONFIG_SOC_AU1X00)
-
-#include <au1xxx.h>
-
-/* We can only do 16-bit reads and writes in the static memory space. */
-#define SMC_CAN_USE_8BIT	0
-#define SMC_CAN_USE_16BIT	1
-#define SMC_CAN_USE_32BIT	0
-#define SMC_IO_SHIFT		0
-#define SMC_NOWAIT		1
-
-#define SMC_inw(a, r)		au_readw((unsigned long)((a) + (r)))
-#define SMC_insw(a, r, p, l)	\
-	do {	\
-		unsigned long _a = (unsigned long)((a) + (r)); \
-		int _l = (l); \
-		u16 *_p = (u16 *)(p); \
-		while (_l-- > 0) \
-			*_p++ = au_readw(_a); \
-	} while(0)
-#define SMC_outw(v, a, r)	au_writew(v, (unsigned long)((a) + (r)))
-#define SMC_outsw(a, r, p, l)	\
-	do {	\
-		unsigned long _a = (unsigned long)((a) + (r)); \
-		int _l = (l); \
-		const u16 *_p = (const u16 *)(p); \
-		while (_l-- > 0) \
-			au_writew(*_p++ , _a); \
-	} while(0)
-
-#define SMC_IRQ_FLAGS		(0)
-
 #elif	defined(CONFIG_ARCH_VERSATILE)
 
 #define SMC_CAN_USE_8BIT	1
-- 
1.6.2
