Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Dec 2013 17:50:03 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:18601 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835489Ab3LBQtAabQm2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Dec 2013 17:49:00 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/3] MIPS: Malta: initialise the RTC at boot
Date:   Mon, 2 Dec 2013 16:48:36 +0000
Message-ID: <1386002918-32270-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1386002918-32270-1-git-send-email-paul.burton@imgtec.com>
References: <1386002918-32270-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2013_12_02_16_48_53
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The RTC is used on Malta to estimate the clock frequency of the CPU &
optionally the GIC. However the kernel previously did not initialise the
RTC, instead relying upon the bootloader having done so. In order to
minimise dependencies which the kernel has upon the bootloader this
patch causes the kernel to initialise the RTC itself prior to making use
of it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mti-malta/malta-time.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 136c5dc..3190099 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -166,11 +166,24 @@ unsigned int get_c0_compare_int(void)
 	return mips_cpu_timer_irq;
 }
 
+static void __init init_rtc(void)
+{
+	/* stop the clock whilst setting it up */
+	CMOS_WRITE(RTC_SET | RTC_24H, RTC_CONTROL);
+
+	/* 32KHz time base */
+	CMOS_WRITE(RTC_REF_CLCK_32KHZ, RTC_FREQ_SELECT);
+
+	/* start the clock */
+	CMOS_WRITE(RTC_24H, RTC_CONTROL);
+}
+
 void __init plat_time_init(void)
 {
 	unsigned int prid = read_c0_prid() & (PRID_COMP_MASK | PRID_IMP_MASK);
 	unsigned int freq;
 
+	init_rtc();
 	estimate_frequencies();
 
 	freq = mips_hpt_frequency;
-- 
1.8.4.2
