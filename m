Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2015 17:39:54 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:20498 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012912AbbH0PjejlPnx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Aug 2015 17:39:34 +0200
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t7RFdO3w019006
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2015 15:39:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t7RFdMYZ014105
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 27 Aug 2015 15:39:22 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t7RFdMSw017901;
        Thu, 27 Aug 2015 15:39:22 GMT
Received: from lappy.us.oracle.com (/10.154.183.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Aug 2015 08:39:21 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: Malta: Don't reinitialise RTC
Date:   Thu, 27 Aug 2015 11:37:19 -0400
Message-Id: <1440689954-10813-1-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.4
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: James Hogan <james.hogan@imgtec.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 106eccb4d20f35ebc58ff2286c170d9e79c5ff68 ]

On Malta, since commit a87ea88d8f6c ("MIPS: Malta: initialise the RTC at
boot"), the RTC is reinitialised and forced into binary coded decimal
(BCD) mode during init, even if the bootloader has already initialised
it, and may even have already put it into binary mode (as YAMON does).
This corrupts the current time, can result in the RTC seconds being an
invalid BCD (e.g. 0x1a..0x1f) for up to 6 seconds, as well as confusing
YAMON for a while after reset, enough for it to report timeouts when
attempting to load from TFTP (it actually uses the RTC in that code).

Therefore only initialise the RTC to the extent that is necessary so
that Linux avoids interfering with the bootloader setup, while also
allowing it to estimate the CPU frequency without hanging, without a
bootloader necessarily having done anything with the RTC (for example
when the kernel is loaded via EJTAG).

The divider control is configured for a 32KHZ reference clock if
necessary, and the SET bit of the RTC_CONTROL register is cleared if
necessary without changing any other bits (this bit will be set when
coming out of reset if the battery has been disconnected).

Fixes: a87ea88d8f6c ("MIPS: Malta: initialise the RTC at boot")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.14+
Patchwork: https://patchwork.linux-mips.org/patch/10739/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/mti-malta/malta-time.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 3778a35..38748da 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -158,14 +158,17 @@ unsigned int get_c0_compare_int(void)
 
 static void __init init_rtc(void)
 {
-	/* stop the clock whilst setting it up */
-	CMOS_WRITE(RTC_SET | RTC_24H, RTC_CONTROL);
+	unsigned char freq, ctrl;
 
-	/* 32KHz time base */
-	CMOS_WRITE(RTC_REF_CLCK_32KHZ, RTC_FREQ_SELECT);
+	/* Set 32KHz time base if not already set */
+	freq = CMOS_READ(RTC_FREQ_SELECT);
+	if ((freq & RTC_DIV_CTL) != RTC_REF_CLCK_32KHZ)
+		CMOS_WRITE(RTC_REF_CLCK_32KHZ, RTC_FREQ_SELECT);
 
-	/* start the clock */
-	CMOS_WRITE(RTC_24H, RTC_CONTROL);
+	/* Ensure SET bit is clear so RTC can run */
+	ctrl = CMOS_READ(RTC_CONTROL);
+	if (ctrl & RTC_SET)
+		CMOS_WRITE(ctrl & ~RTC_SET, RTC_CONTROL);
 }
 
 void __init plat_time_init(void)
-- 
2.1.4
