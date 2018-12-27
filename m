Return-Path: <SRS0=uIlq=PE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028A3C43444
	for <linux-mips@archiver.kernel.org>; Thu, 27 Dec 2018 18:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB9620856
	for <linux-mips@archiver.kernel.org>; Thu, 27 Dec 2018 18:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="inGNFDP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeL0SOP (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 27 Dec 2018 13:14:15 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:54728 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbeL0SOP (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 27 Dec 2018 13:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1545934451; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QNeFphZ9hUGkh5Yk3GbZdG621Ws/p+nAIHYSiHDJAPE=;
        b=inGNFDP4u+szGVWW/QS6brBJhsGki+GK/44lyG2HU4dYYlcWJ3Qhr/ChyrcIQVTapQv3UV
        /rV48VpTWqYe/V20RjyPV4pjuYXT3dsSf7lUKSjgh4meAMiWDSsCO0Hyc217gq75JPIAB7
        jJ2LFI4vqGffI1nFdjEDOrmL3OctpFw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v9 23/27] MIPS: CI20: Reduce system timer to 3 MHz
Date:   Thu, 27 Dec 2018 19:13:15 +0100
Message-Id: <20181227181319.31095-24-paul@crapouillou.net>
In-Reply-To: <20181227181319.31095-1-paul@crapouillou.net>
References: <20181227181319.31095-1-paul@crapouillou.net>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The default clock (48 MHz) is too fast for the system timer.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v5: New patch
    
     v6: Set also the rate for the clocksource channel's clock
    
     v7: No change

     v8: No change

     v9: Don't configure clock timer1, as the OS Timer is used as
         clocksource on this SoC

 arch/mips/boot/dts/ingenic/ci20.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 50cff3cbcc6d..700cf28a52ec 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -238,3 +238,9 @@
 		bias-disable;
 	};
 };
+
+&tcu {
+	/* 3 MHz for the system timer */
+	assigned-clocks = <&tcu TCU_CLK_TIMER0>;
+	assigned-clock-rates = <3000000>;
+};
-- 
2.11.0

