Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 00:31:34 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:33614 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994683AbeCQXaDWpbSh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 00:30:03 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 8/8] MAINTAINERS: Add myself as maintainer for Ingenic TCU drivers
Date:   Sun, 18 Mar 2018 00:29:01 +0100
Message-Id: <20180317232901.14129-9-paul@crapouillou.net>
In-Reply-To: <20180317232901.14129-1-paul@crapouillou.net>
References: <20180110224838.16711-2-paul@crapouillou.net>
 <20180317232901.14129-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1521329402; bh=U8F/+5MsdletlxJ+5hrqkYP3avn1DbxO3kYAcR40CZA=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=e9ghgvon8WfCdQpjsN2zxCWsdRpuQl/R2+vZYajG0kqREjZLDCz3vcgO5mWBUPVEVdk0JQ4eZSudmnUY8aPXp1ki950i6VOVF1gZZEKvXMNDGP1k/gy/IpP/B/a7SsGQOsiY3lV996e1vGJNjYApdzBnFdI8WBkBy6+SoNOx0iI=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Add myself as maintainer for the ingenic-tcu-intc interrupt controller
driver, the ingenic-tcu-clocks clock driver, and the ingenic-tcu
clocksource driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

 v2: No change
 v3: No change
 v4: No change

diff --git a/MAINTAINERS b/MAINTAINERS
index 4623caf8d72d..46d3955b92aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6959,6 +6959,15 @@ L:	linux-mtd@lists.infradead.org
 S:	Maintained
 F:	drivers/mtd/nand/jz4780_*
 
+INGENIC JZ47xx TCU drivers
+M:	Paul Cercueil <paul@crapouillou.net>
+S:	Maintained
+F:	drivers/clk/ingenic/tcu.c
+F:	drivers/irqchip/irq-ingenic-tcu.c
+F:	drivers/clocksource/timer-ingenic.c
+F:	include/linux/mfd/syscon/ingenic-tcu.h
+F:	include/dt-bindings/clock/ingenic,tcu.h
+
 INOTIFY
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
-- 
2.11.0
