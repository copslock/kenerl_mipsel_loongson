Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Feb 2016 23:00:37 +0100 (CET)
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36259 "EHLO
        mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012323AbcBMV6iR7-Fi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Feb 2016 22:58:38 +0100
Received: by mail-lb0-f195.google.com with SMTP id zr1so4957194lbb.3;
        Sat, 13 Feb 2016 13:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TNXDy+jaKADldNxKXSavRWGSckv51vTTxJBfSbbCjsU=;
        b=f0gZsQsjMpBu+XcQxE4+e3+Do5VM6OGKEOPQSuYSKW+0uoTPUBFfftfPTAm8jr5Vw9
         qinGXJAkV6CoumWt5PlXQ00z1bYgElxnaXR3SnTi6R0LMnpYSxRVT2frgs17AZLpU+Fo
         tdTktEKXPpUi/ssVGKhNVwfxtwAA60OSWiLNF28BZWIxJI+3HGx/B7BLROvrVNmVA+4O
         x3bK3/fiSGLFLjquxRuA7VGlLEI8bIiiLkPTYV31jPIpLzwmueVISqTLpuvR89vosExO
         pXcX87D/2/do049gEYIkHe3APfumY5Pchbhl4+0QGHOzoIf3/mvbzy3H/12t7zTYhv24
         LLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TNXDy+jaKADldNxKXSavRWGSckv51vTTxJBfSbbCjsU=;
        b=JWpDO4imZB3LLGM3ATBK3cLyYDVgGRD1CMP0GP1nCfLeyXp8Y/Nkt7RsLjzE+nbxs1
         tCj8MBSgsXHVkyXm4Ynw6EU0oIXrpnOlm0m4yeQLv/2VEpYNpY7BhzIvPnE9Hf3E3FZA
         o0M4VU17E39FoyE9LjMZhKrnst/oCAyZ1xYzGV1UH8E8kYqPD3D7yd/E6aOzzSqp6hEG
         8YqwrH7BQAmkWbYXTUyvTFWt4gZtcH9TKoawIDK55mJCeKgsj0ai9jThr0C9+JNV+tRo
         puD8d/HABgu+j5xyiHZRcpIWvLFuDs40ztRTYc3KLTVOEklTY5L9THCJH4//Uxat358y
         sKSg==
X-Gm-Message-State: AG10YOSCITBkJ4e9CyKu08FHED1Zv6eowO6JU/u9MXYCDWKULo5UUo/oOCVU8LNtsHmvfw==
X-Received: by 10.112.168.5 with SMTP id zs5mr3765240lbb.56.1455400713032;
        Sat, 13 Feb 2016 13:58:33 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id jr10sm2624949lbc.42.2016.02.13.13.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Feb 2016 13:58:32 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 07/10] MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: use "ref" for reference clock name
Date:   Sun, 14 Feb 2016 00:58:14 +0300
Message-Id: <1455400697-29898-8-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Current ath79 clock.c code does not read reference clock and
pll setup from devicetree. The ar724x_clocks_init() function
recreates the clocks from scratch so devicetree clock
information is dropped. After adding the code which picked up
reference clock from devicetree I have found
that kernel does not boot anymore. The SPI and UART drivers
can't get clk; here are a bootlog error messages:

    of_serial: probe of 18020000.uart failed with error -22
    ath79-spi: probe of 1f000000.spi failed with error -22

The problem is that clock code assumes that reference clock
name is "ref" by current dts-file uses another name: "oscillator".

This patch fixes the problem by changing external oscillator
dt node name to "ref".

Please note that there is an alternative solution for the problem:

    > --- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
    > +++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
    > @@ -16,6 +16,7 @@
    >
    >         extosc: oscillator {
    >                 compatible = "fixed-clock";
    > +               clock-output-names = "ref";
    >                 #clock-cells = <0>;
    >                 clock-frequency = <40000000>;
    >         };

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Alban Bedel <albeu@free.fr>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index 9528ebd..bae72da 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -14,7 +14,7 @@
 		reg = <0x0 0x2000000>;
 	};
 
-	extosc: oscillator {
+	extosc: ref {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <40000000>;
-- 
2.7.0
