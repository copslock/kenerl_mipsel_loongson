Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jul 2018 18:41:19 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:46730 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992479AbeGZQlMphOgD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Jul 2018 18:41:12 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1BE0520908; Thu, 26 Jul 2018 18:41:07 +0200 (CEST)
Received: from localhost (unknown [88.128.80.18])
        by mail.bootlin.com (Postfix) with ESMTPSA id D526B20893;
        Thu, 26 Jul 2018 18:40:56 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] MIPS: TXx9: remove useless RTC definitions
Date:   Thu, 26 Jul 2018 18:40:54 +0200
Message-Id: <20180726164054.9092-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The RTC definitions were moved to the driver, remove them from the platform
header.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/include/asm/txx9/tx4939.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/mips/include/asm/txx9/tx4939.h b/arch/mips/include/asm/txx9/tx4939.h
index 6d667087f2aa..f173bef405d3 100644
--- a/arch/mips/include/asm/txx9/tx4939.h
+++ b/arch/mips/include/asm/txx9/tx4939.h
@@ -101,13 +101,6 @@ struct tx4939_irc_reg {
 	struct tx4939_le_reg maskext;
 };
 
-struct tx4939_rtc_reg {
-	__u32 ctl;
-	__u32 adr;
-	__u32 dat;
-	__u32 tbc;
-};
-
 struct tx4939_crypto_reg {
 	struct tx4939_le_reg csr;
 	struct tx4939_le_reg idesptr;
@@ -369,26 +362,6 @@ struct tx4939_vpc_desc {
 #define TX4939_CLKCTR_SIO0RST	0x00000002
 #define TX4939_CLKCTR_CYPRST	0x00000001
 
-/*
- * RTC
- */
-#define TX4939_RTCCTL_ALME	0x00000080
-#define TX4939_RTCCTL_ALMD	0x00000040
-#define TX4939_RTCCTL_BUSY	0x00000020
-
-#define TX4939_RTCCTL_COMMAND	0x00000007
-#define TX4939_RTCCTL_COMMAND_NOP	0x00000000
-#define TX4939_RTCCTL_COMMAND_GETTIME	0x00000001
-#define TX4939_RTCCTL_COMMAND_SETTIME	0x00000002
-#define TX4939_RTCCTL_COMMAND_GETALARM	0x00000003
-#define TX4939_RTCCTL_COMMAND_SETALARM	0x00000004
-
-#define TX4939_RTCTBC_PM	0x00000080
-#define TX4939_RTCTBC_COMP	0x0000007f
-
-#define TX4939_RTC_REG_RAMSIZE	0x00000100
-#define TX4939_RTC_REG_RWBSIZE	0x00000006
-
 /*
  * CRYPTO
  */
-- 
2.18.0
