Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 01:12:07 +0100 (CET)
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35894 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011930AbcBAAK56q09A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 01:10:57 +0100
Received: by mail-lf0-f49.google.com with SMTP id 78so37424209lfy.3
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 16:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KDOjxUReIUdoLAueIUE1tdiwjcdOe+6pxBXTWAN0UEU=;
        b=jASjKrR6NkoYUYpGKYEoVsL59H/31eegNrjKFkW3qR3uX0Ro/4zHkXtdCFx3SMR+Tq
         yJF/KzlwZhQW46/zZY7iCQ/Tefp21UDgBj60ew+MtT9a7sTRINSk5kBP/f5l1ZAYjJxE
         1uqvErdsgiWTCgu3KvUKmtlFKG9evqTr5xSBtfQGnaHZPQ6DVPz3KnfAjZYaNzkY2xzA
         qTT2IUJru68wHsLopxp+gyAkPuFuKyUsaqho27oGJifDCnidpBaccQDKlgbn6Kgw7aLO
         0BaN3L4ZZSkx+pZwu5stFGw9aPkbqgprL8gwckWPnh/PPJR7qBeVYydUezWAoTf2CKdZ
         0YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KDOjxUReIUdoLAueIUE1tdiwjcdOe+6pxBXTWAN0UEU=;
        b=gKQeVLXfBdgeNILbXsnwNoPOEDobMyvZ6xYeElIp+P7cEUZKSzf6+ZJaNJKvrz4b0H
         +vpG9mHR/GUWPZtZYMZBKJ8uUqPU1fSaQldmQa/6MseIBybOaMHwfD0zJN2+uxdA/qnW
         TUTaRae2izuTNW21YIwggDJEEgXPnPAsXgsQmmwKZEKM1GV2oxeltGgsbpyFhFHiQq4S
         yWmot1U1U9ZwKlMB9aUxQyEIu7U6/17N19F02Y2jqpvhmtnabHcwCMXXqIolSTfJGdkc
         9b3H4YlwjTyx5xsy5fxEbkTNfh2RGDJVLgTmJxuu6YmCXdEPnpivnWwtv/0Rx5IfQi47
         bKAg==
X-Gm-Message-State: AG10YOSZJhYFflNlQO0A3DLdtMq9XhZrvHSXQkwiL1anXZQfhkvkCKsPwemx71+fh+ikfg==
X-Received: by 10.25.43.212 with SMTP id r203mr7460789lfr.162.1454285452711;
        Sun, 31 Jan 2016 16:10:52 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o97sm2807958lfi.25.2016.01.31.16.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 16:10:52 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [RFC v4 04/15] MIPS: dts: qca: ar9132: use dt-bindings/clock/ath79-clk.h macros
Date:   Mon,  1 Feb 2016 03:10:29 +0300
Message-Id: <1454285440-18916-5-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
References: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51565
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
index 3ad4ba9..a1b4fa1 100644
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
 
@@ -144,7 +146,7 @@
 			compatible = "qca,ar9132-spi", "qca,ar7100-spi";
 			reg = <0x1f000000 0x10>;
 
-			clocks = <&pll 2>;
+			clocks = <&pll ATH79_CLK_AHB>;
 			clock-names = "ahb";
 
 			status = "disabled";
-- 
2.7.0
