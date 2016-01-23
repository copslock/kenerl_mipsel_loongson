Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 21:18:45 +0100 (CET)
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36586 "EHLO
        mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010588AbcAWURu47y-d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jan 2016 21:17:50 +0100
Received: by mail-lb0-f179.google.com with SMTP id oh2so56903719lbb.3
        for <linux-mips@linux-mips.org>; Sat, 23 Jan 2016 12:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E9C+fduGplW8lHzLHagt6fSMwgjFOSUkA1Dyup//100=;
        b=wBaXaROijpoKngRlKlJkNpIPq/yp9Yo23zMr1xYpHbwyVrkb/oFZbm3dcMtqTJlEtH
         Zx7+BwqDRr/ds83jlZ3rQjhJ331ujsAlnECgRfzxGXebjU5iiNgureZnpaEroT72Pd6C
         dFYFiHVxD5MkL6ehaiQ0xseCA3L6JB53Q1J5vmN3tTyqnB4/ecoXpxTPUzgxunAUVOqy
         XemdlFuvZcIY06or70y6CzEc+xEAtYaG2uZeVphhy8guAVnaegIh0zkIw5HDZ2Kh/Mu5
         L0TweTpOqdR1hupJ6ND70C2W3R961p5mN9BBHVDzhYFhX9wuLc16aXvYvmFMa42vimI5
         TNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E9C+fduGplW8lHzLHagt6fSMwgjFOSUkA1Dyup//100=;
        b=Bj19pNliTlMW2zSEpkYvu41ywMMyOkKKRR0AiDxzoTuebxsLE+wT7V0MjbMDp/IsVn
         IfnNFJX7TUFTiUdNs88Q0+yOBUsJbSSRDYM2AbCsGh6GPqeEF6a+EINVHlnSlyxb5LMQ
         edw8fawVOfCSfkXXxCYY2Py+QlD5LKYSDwjVJaQLAmGz9p+HAbF8YUBnC6sOJksLqd1/
         iGMWPGXzo76qb3zu5qMn7Y+VffMa10vaKhOoIImu33i3ul6YOdxfRLpN54+zxbeQNC7v
         bpVb1xxdUPpgLR00JHPlo1FdueqrLMTHctqrvT398llHE2o/38QvtfG5MvAjUBiG0Q3M
         Sw4Q==
X-Gm-Message-State: AG10YORtDxBZLMcHGNfwx0WEnIzfQpCQWt70uLmkOmvUJxtTgGQHIOmqW/6DwMqYN3OHSg==
X-Received: by 10.112.172.233 with SMTP id bf9mr3515892lbc.121.1453580265691;
        Sat, 23 Jan 2016 12:17:45 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o82sm1664186lfo.47.2016.01.23.12.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Jan 2016 12:17:45 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [RFC v3 03/14] MIPS: dts: qca: ar9132: use dt-bindings/clock/ath79-clk.h macros
Date:   Sat, 23 Jan 2016 23:17:20 +0300
Message-Id: <1453580251-2341-4-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51329
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

The old ar9132 clk implementation (see arch/mips/ath79/clock.c)
have had only 3 devicetree clks (cpu, ddr, ahb). Two additional
clocks (wdt and uart) have realized as aliases for ahb clock.
In the old ar9132 clk implementation the wdt and uart clocks
were inaccessible via devicetree so index "2" used for reference
to ahb clock instead, e.g.

    clocks = <&pll 2>;

In the new ar9132 clk implementation (see drivers/clk/clk-ath79.c)
the wdt and uart clks are accessible via devicetree
so appropriate ATH79_CLK_WDT and ATH79_CLK_UART are used in ar9132.dtsi.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: linux-clk@vger.kernel.org
---
 arch/mips/boot/dts/qca/ar9132.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index 13d0439..4a537ea 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -1,3 +1,5 @@
+#include <dt-bindings/clock/ath79-clk.h>
+
 / {
 	compatible = "qca,ar9132";
 
@@ -57,7 +59,7 @@
 				reg = <0x18020000 0x20>;
 				interrupts = <3>;
 
-				clocks = <&pll 2>;
+				clocks = <&pll ATH79_CLK_UART>;
 				clock-names = "uart";
 
 				reg-io-width = <4>;
@@ -100,7 +102,7 @@
 
 				interrupts = <4>;
 
-				clocks = <&pll 2>;
+				clocks = <&pll ATH79_CLK_WDT>;
 				clock-names = "wdt";
 			};
 
@@ -129,7 +131,7 @@
 			compatible = "qca,ar9132-spi", "qca,ar7100-spi";
 			reg = <0x1f000000 0x10>;
 
-			clocks = <&pll 2>;
+			clocks = <&pll ATH79_CLK_AHB>;
 			clock-names = "ahb";
 
 			status = "disabled";
-- 
2.6.2
