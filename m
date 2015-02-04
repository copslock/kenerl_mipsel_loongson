Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 16:26:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17860 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012482AbbBDPWkPOFhH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 16:22:40 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C4B136409CFA1;
        Wed,  4 Feb 2015 15:22:31 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 4 Feb 2015 15:22:34 +0000
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 4 Feb 2015 15:22:33 +0000
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Zubair.Kakakhel@imgtec.com>,
        <gregkh@linuxfoundation.org>, <mturquette@linaro.org>,
        <sboyd@codeaurora.org>, <ralf@linux-mips.org>, <jslaby@suse.cz>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <lars@metafoo.de>,
        <paul.burton@imgtec.com>
Subject: [PATCH_V2 12/34] MIPS: jz4740: call jz4740_clock_init earlier
Date:   Wed, 4 Feb 2015 15:21:41 +0000
Message-ID: <1423063323-19419-13-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

From: Paul Burton <paul.burton@imgtec.com>

Call jz4740_clock_init before any uses of jz4740_clock_bdata occur. This
is in preparation for replacing uses of that struct with calls to
clk_get_rate, which will allow the clocks to be migrated towards common
clock framework & devicetree.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/include/asm/mach-jz4740/clock.h | 2 ++
 arch/mips/jz4740/clock.c                  | 3 +--
 arch/mips/jz4740/time.c                   | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/clock.h b/arch/mips/include/asm/mach-jz4740/clock.h
index 16659cd..01d8468 100644
--- a/arch/mips/include/asm/mach-jz4740/clock.h
+++ b/arch/mips/include/asm/mach-jz4740/clock.h
@@ -20,6 +20,8 @@ enum jz4740_wait_mode {
 	JZ4740_WAIT_MODE_SLEEP,
 };
 
+int jz4740_clock_init(void);
+
 void jz4740_clock_set_wait_mode(enum jz4740_wait_mode mode);
 
 void jz4740_clock_udc_enable_auto_suspend(void);
diff --git a/arch/mips/jz4740/clock.c b/arch/mips/jz4740/clock.c
index 1b5f554..c257073 100644
--- a/arch/mips/jz4740/clock.c
+++ b/arch/mips/jz4740/clock.c
@@ -889,7 +889,7 @@ void jz4740_clock_resume(void)
 		JZ_CLOCK_GATE_TCU | JZ_CLOCK_GATE_DMAC | JZ_CLOCK_GATE_UART0);
 }
 
-static int jz4740_clock_init(void)
+int jz4740_clock_init(void)
 {
 	uint32_t val;
 
@@ -921,4 +921,3 @@ static int jz4740_clock_init(void)
 
 	return 0;
 }
-arch_initcall(jz4740_clock_init);
diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index 5e430ce..9424344 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -19,6 +19,7 @@
 
 #include <linux/clockchips.h>
 
+#include <asm/mach-jz4740/clock.h>
 #include <asm/mach-jz4740/irq.h>
 #include <asm/mach-jz4740/timer.h>
 #include <asm/time.h>
@@ -109,6 +110,7 @@ void __init plat_time_init(void)
 	uint32_t clk_rate;
 	uint16_t ctrl;
 
+	jz4740_clock_init();
 	jz4740_timer_init();
 
 	clk_rate = jz4740_clock_bdata.ext_rate >> 4;
-- 
1.9.1
