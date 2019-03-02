Return-Path: <SRS0=FRkd=RF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE35C43381
	for <linux-mips@archiver.kernel.org>; Sat,  2 Mar 2019 23:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FB82086D
	for <linux-mips@archiver.kernel.org>; Sat,  2 Mar 2019 23:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="qQGDKCqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfCBXg5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 2 Mar 2019 18:36:57 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:35846 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfCBXg5 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 2 Mar 2019 18:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551569813; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=d1n75EL0YwMRDmo9Nsj0mJyLjEkAcDsj7MXfFDG59LE=;
        b=qQGDKCqiGir2MLBXIgVr5JEsbKd+hxAMn5b5bOrvWp4ikvXlizp5QmcBkYxM+imD9+UC2O
        rI2MhGPqmlTJg2MA85sho38JLSZDnvRhqqJKRPS357RoRtC4yDHDCXUFf4czfnLiqZaAl9
        oJ4+CsVV9gR9EoKqR5D+Se7DAle5K58=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v10 23/27] MIPS: CI20: Reduce system timer and clocksource to 3 MHz
Date:   Sat,  2 Mar 2019 20:34:09 -0300
Message-Id: <20190302233413.14813-24-paul@crapouillou.net>
In-Reply-To: <20190302233413.14813-1-paul@crapouillou.net>
References: <20190302233413.14813-1-paul@crapouillou.net>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The default clock (48 MHz) is too fast for the system timer.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
         v5: New patch
    
         v6: Set also the rate for the clocksource channel's clock
    
         v7: No change
    
         v8: No change
    
         v9: Don't configure clock timer1, as the OS Timer is used as
             clocksource on this SoC
    
         v10: Revert back to v8 bahaviour. Let the user choose what
              clocksource should be used.

 arch/mips/boot/dts/ingenic/ci20.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 4f7b1fa31cf5..30b01cfaaf5a 100644
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

