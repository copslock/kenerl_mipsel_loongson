Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:36:23 +0100 (CET)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36392 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007002AbcCQDeqF0uqp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:46 +0100
Received: by mail-lf0-f66.google.com with SMTP id h198so2226356lfh.3;
        Wed, 16 Mar 2016 20:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NVr/+sXz22NoUw9a1qXsrdFbG9yrk1WBB7hlwCaAt4M=;
        b=Q0MRT7kcyJLaL5RujD5HVfM/5W07KkB/LoG+EAUPZ+cGysBgRiJOGWr47WhN1MIjtA
         iAF2Unv6wMzn/xJXo1tS/OyIPA6s6nhATmddzGeRvgxDO0d4m++zS647Z66fgloivLjQ
         lyYPyp3NleioWMnDHM/7c7277XAGCgFEmV3XHXydVSbvIn4YeYub0TN7mHM79bbqlNw6
         WeEgdhK0wFnd0tisEMgAz4lJXCxNvaUUsmeGQIFsYSMQQn305rYhOu20OvhhQkgtdwSF
         WZZEmftwfvEhTRk0j35CiCAd0QY9zAnAkUGnittTQgGm6SdFwo4vEU/L7s/0QCZiABE7
         oAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NVr/+sXz22NoUw9a1qXsrdFbG9yrk1WBB7hlwCaAt4M=;
        b=HjsyWxI/Gtx/aLgwxSqEjpTuOfxKZjU6brIEK6m8HhXVA+s9QqPOAaUQPJA80YbQA0
         xhnwceL0wtHbzyqsgmy3UwaEVCoAuzVztoLOa8EDeoQB2F67rfYKafGkpPNh5BJIOBOG
         dWAZRBrCNK2XPWgdThVbYI6gbdpYYJBWM2l/z3+d9mBINzrtE5HkHFCNVfyWdN7F3IbI
         JbhJnphFYQEeD87R87K6+qOLxGohynSpKveLyMiJEGcZicMqkowOpfwDBhKrJBdUhlFL
         SswyC9xWj3zQq5nBu0AO+uiruJSbbbfYeL4T1ZMgai8zKabwqcDqX7sXHJB7Q+gx0JOM
         WNfw==
X-Gm-Message-State: AD7BkJI3gFzA2p7+M0euOBrdwZSVJGqHV0mT6/1Tc8yKUgDuxUzrpzbJ+h3HHqKZg8GEZA==
X-Received: by 10.25.87.149 with SMTP id l143mr2679658lfb.145.1458185680844;
        Wed, 16 Mar 2016 20:34:40 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:40 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Alban Bedel <albeu@free.fr>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 06/18] MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: use "ref" for reference clock name
Date:   Thu, 17 Mar 2016 06:34:13 +0300
Message-Id: <1458185665-4521-7-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52620
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
can't get clk; here are the bootlog error messages:

    of_serial: probe of 18020000.uart failed with error -22
    ath79-spi: probe of 1f000000.spi failed with error -22

The problem is that clock code assumes that reference clock
name is "ref" but current dts-file uses another name: "oscillator".

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
index eb632a2..3c3b7ce 100644
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
