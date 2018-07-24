Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 01:21:44 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:56032 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994562AbeGXXUVKqJCu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jul 2018 01:20:21 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 07/21] MAINTAINERS: Add myself as maintainer for Ingenic TCU drivers
Date:   Wed, 25 Jul 2018 01:19:44 +0200
Message-Id: <20180724231958.20659-8-paul@crapouillou.net>
In-Reply-To: <20180724231958.20659-1-paul@crapouillou.net>
References: <20180724231958.20659-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532474420; bh=DtPYdTDkBrcKtIO8UHeqVD4/3vCKgyfZGF0Y7iVEjug=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OdMR57aUUEggOf02EmTf3fQdS42ceoFemtDYElm1v5YZL7mV9v+3+8B/d2umEP57onrqoYD+2tQZJ0q5P7YLbRbGZwybENCh1fiDtTgV5SVG/6U2kok8tOeso85heC2QEVMYu20AGZpsO+oyOQ69wAGsQ+0aorzZiWu1CImlMiw=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65106
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

Add myself as maintainer for the ingenic-timer and ingenic-ost drivers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

 v2: No change

 v3: No change

 v4: No change

 v5: Update with new files

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fe4228f78cb..bd62185623e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7073,6 +7073,15 @@ L:	linux-mtd@lists.infradead.org
 S:	Maintained
 F:	drivers/mtd/nand/raw/jz4780_*
 
+INGENIC TCU driver
+M:	Paul Cercueil <paul@crapouillou.net>
+S:	Maintained
+F:	drivers/clocksource/ingenic-ost.c
+F:	drivers/clocksource/ingenic-timer.c
+F:	drivers/clocksource/ingenic-timer.h
+F:	include/linux/mfd/ingenic-tcu.h
+F:	include/dt-bindings/clock/ingenic,tcu.h
+
 INOTIFY
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
-- 
2.11.0
