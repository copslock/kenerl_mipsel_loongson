Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2015 20:19:18 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:49598 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009956AbbAHTTR3Xc8Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Jan 2015 20:19:17 +0100
Received: from p4fe24cda.dip0.t-ipconnect.de ([79.226.76.218]:53953 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1Y9Ic0-0000pd-FY; Thu, 08 Jan 2015 20:19:16 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: pmcmsp: remove dead code
Date:   Thu,  8 Jan 2015 20:19:00 +0100
Message-Id: <1420744740-26468-1-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.3
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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

CPPCHECK rightfully says:

drivers/i2c/busses/i2c-pmcmsp.c:151: style: The function 'pmcmsptwi_reg_to_clock' is never used.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-pmcmsp.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index 44f03eed00dd..d37d9db6681e 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -148,13 +148,6 @@ static inline u32 pmcmsptwi_clock_to_reg(
 	return ((clock->filter & 0xf) << 12) | (clock->clock & 0x03ff);
 }
 
-static inline void pmcmsptwi_reg_to_clock(
-			u32 reg, struct pmcmsptwi_clock *clock)
-{
-	clock->filter = (reg >> 12) & 0xf;
-	clock->clock = reg & 0x03ff;
-}
-
 static inline u32 pmcmsptwi_cfg_to_reg(const struct pmcmsptwi_cfg *cfg)
 {
 	return ((cfg->arbf & 0xf) << 12) |
-- 
2.1.3
