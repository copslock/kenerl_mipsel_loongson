Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 23:48:47 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:55106 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994776AbeHIVrDPkSHJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2018 23:47:03 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 22/24] MIPS: CI20: Reduce system timer and clocksource to 3 MHz
Date:   Thu,  9 Aug 2018 23:46:52 +0200
Message-Id: <20180809214654.21308-1-paul@crapouillou.net>
In-Reply-To: <20180809214414.20905-1-paul@crapouillou.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533851222; bh=q6N4aFUckHjIT1Gw609cpOW99FGehMvCTSFaPBsLIuQ=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nN4xd2doiYSDqZez+Xag8dyCXcY3B2YfpeaAN9Um6Vu3r52SPqTsd2pYtQbo7rLjtnxEkSqUXS7K/R5GGBPNkxYtQa9MxbjtxlUtlY46js2IY5vK8Fdm/npYSVdVKesvAgy8Hc4BuKCpDFsbh1IYnFU4NUwG8zzAgwKqqj19EVA=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65529
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

The default clock (48 MHz) is too fast for the system timer, which fails
to report time accurately.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 6 ++++++
 1 file changed, 6 insertions(+)

 v5: New patch

 v6: Set also the rate for the clocksource channel's clock

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 50cff3cbcc6d..f64d32443097 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -238,3 +238,9 @@
 		bias-disable;
 	};
 };
+
+&tcu {
+	/* 3 MHz for the system timer and clocksource */
+	assigned-clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>;
+	assigned-clock-rates = <3000000>, <3000000>;
+};
-- 
2.11.0
