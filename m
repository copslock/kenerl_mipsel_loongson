Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Aug 2015 11:40:59 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:36855 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008923AbbHVJk5x7xu- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Aug 2015 11:40:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Message-Id:Date:Subject:Cc:To:From; bh=bKPrIMUURRSfpcna7AP8uzjU+b/+AbYzIWsm0uWOKGE=;
        b=iVDIlea6ow6etUPGo5gtrdEn+rXocpHK9hCQdL/htTCQGtyFwiaMkLZZGIQjAg6tSDfvE0iEyVvTZV9kB8Gk39oXjF/s2uUJOSlsMhNaE91pDZu1uD7RrqR1SMC2QRLQnamCJ8I6VvUDpzD8QAulMcX5ceVOk5RgwSyEvqS59Gg=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:48374 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1ZT5IA-0048XD-Gq; Sat, 22 Aug 2015 09:40:50 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH -next] mips: Enable common clock framework for malta and sead3
Date:   Sat, 22 Aug 2015 02:40:41 -0700
Message-Id: <1440236441-10815-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.1.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Since commit e69b3d70ac57 ("CLOCKSOURCE: mips-gic: Update clockevent
frequency on clock rate changes"), malta_defconfig and sead3_defconfig
fail to build as follows.

drivers/clocksource/mips-gic-timer.c: In function 'gic_clk_notifier':
drivers/clocksource/mips-gic-timer.c:102:16:
	error: 'POST_RATE_CHANGE' undeclared
drivers/clocksource/mips-gic-timer.c:103:48:
	error: dereferencing pointer to incomplete type
drivers/clocksource/mips-gic-timer.c: In function 'gic_clocksource_of_init':
drivers/clocksource/mips-gic-timer.c:209:3:
	error: implicit declaration of function 'clk_notifier_register'

Fix by enabling COMMON_CLK for both configurations. Build tested for
malta_defconfig and sead3_defconfig. Tested with qemu malta emulation.

Fixes: e69b3d70ac57 ("CLOCKSOURCE: mips-gic: Update clockevent frequency on clock rate changes")
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/mips/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 09b8fe95aeb0..7af84b4d3269 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -409,6 +409,7 @@ config MIPS_MALTA
 	select CEVT_R4K
 	select CSRC_R4K
 	select CLKSRC_MIPS_GIC
+	select COMMON_CLK
 	select DMA_MAYBE_COHERENT
 	select GENERIC_ISA_DMA
 	select HAVE_PCSPKR_PLATFORM
@@ -459,6 +460,7 @@ config MIPS_SEAD3
 	select CEVT_R4K
 	select CSRC_R4K
 	select CLKSRC_MIPS_GIC
+	select COMMON_CLK
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select DMA_NONCOHERENT
-- 
2.1.4
