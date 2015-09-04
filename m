Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Sep 2015 14:29:38 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:22855 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013139AbbIDM3gR0hgK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Sep 2015 14:29:36 +0200
Received: from localhost.localdomain (unknown [78.54.106.103])
        (Authenticated sender: albeu)
        by smtp4-g21.free.fr (Postfix) with ESMTPA id 7BCDB4C80E6;
        Fri,  4 Sep 2015 14:29:26 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Brian Norris <computersforpeace@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH] MIPS: Fix the build on jz4740 after removing the custom gpio.h
Date:   Fri,  4 Sep 2015 14:29:16 +0200
Message-Id: <1441369756-20887-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Somehow the wrong version of the patch to remove the use of custom
gpio.h on mips has been merged. This patch add the missing fixes for a
build error on jz4740 because linux/gpio.h doesn't provide any machine
specfics definitions anymore.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/jz4740/board-qi_lb60.c | 1 +
 arch/mips/jz4740/gpio.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 4e62bf8..459cb01 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -26,6 +26,7 @@
 #include <linux/power/jz4740-battery.h>
 #include <linux/power/gpio-charger.h>
 
+#include <asm/mach-jz4740/gpio.h>
 #include <asm/mach-jz4740/jz4740_fb.h>
 #include <asm/mach-jz4740/jz4740_mmc.h>
 #include <asm/mach-jz4740/jz4740_nand.h>
diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
index 6cd69fd..3866263 100644
--- a/arch/mips/jz4740/gpio.c
+++ b/arch/mips/jz4740/gpio.c
@@ -28,6 +28,7 @@
 #include <linux/seq_file.h>
 
 #include <asm/mach-jz4740/base.h>
+#include <asm/mach-jz4740/gpio.h>
 
 #define JZ4740_GPIO_BASE_A (32*0)
 #define JZ4740_GPIO_BASE_B (32*1)
-- 
2.0.0
