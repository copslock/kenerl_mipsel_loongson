Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:34:57 +0100 (CET)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36381 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006514AbcCQDekPdJOp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:40 +0100
Received: by mail-lf0-f68.google.com with SMTP id h198so2226290lfh.3;
        Wed, 16 Mar 2016 20:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9zyByL5s4b1E6VqA36wTqur8d/lyR9Lxry9rU9JVgP0=;
        b=X5L5V//DHgbNHXL/KSZ6oEDlMtRH9apN2rBE92qdWhjYH/GjeyVW6JkpQ5aS9apBaq
         CF2JZFWaAXLVFFWm0xuJ4/l3L73hx2J19jEpQ+qtQt2CrXkKERZtUtuD4JOWmzru5wXm
         WdwJTHIOBU5MMtmK5cCPBjjMkPmTnwDPVl5KkXh26XoHzhGnl6PtFglCaGu7yRxaQmo4
         ULaClr9BPUMPpIvlsp0zMzI9VAPAz9rJX1SsZKzqlQwggYgHumGF1l2/32MPv5BT3plU
         s3Akx9w9tQSPc7c67zrhtrOH3hAz8Ar9T+orjhyzMBbGWS9/GV/p9vUAF2Uncv7Frhbe
         B9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9zyByL5s4b1E6VqA36wTqur8d/lyR9Lxry9rU9JVgP0=;
        b=QbgCUn04njVxCCv8pCCY5/KAzdyPJCHXHfWVYtv5pc0F+wUYVKs+eIqozeTSfYK7I3
         uP1oY4L7ARNZAjsOgFzW/J5SyDEcM4B4iyl8v2N7vkgYc7Bpm9roGQ640y6LrB4Jt8Wh
         pUfb+vk0Ug9jyuv++smz+nbeyIqTHhSC+RfZAnDdcz63Jo1Q9we1I1hgGrD1Rul8ynaR
         1kV9FIawq5XBcOyLk1ENDbiEIyCbkYhxawGMJeFR1KsN+MeQRv0rG2H12y87ZnMgQJmx
         kW2mGPoFHuVlXvrtgcl6blKJU9sVr3YGw8jYfszs1oMUfwds8kBiiL78KfGZcWWWtB+8
         MHOA==
X-Gm-Message-State: AD7BkJKIIcfSIFjECJooNViTTZUhZowuu2W8IK2FXvqp2z3HEkiWOqL0Ap3fzGIg9XKbig==
X-Received: by 10.25.135.8 with SMTP id j8mr2695872lfd.64.1458185674648;
        Wed, 16 Mar 2016 20:34:34 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:33 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Alban Bedel <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 01/18] dt-bindings: clock: qca,ath79-pll: fix copy-paste typos
Date:   Thu, 17 Mar 2016 06:34:08 +0300
Message-Id: <1458185665-4521-2-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52615
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

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Alban Bedel <albeu@free.fr>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Acked-by: Rob Herring <robh@kernel.org>

---
Changes since v1:
  * dt-bindings: clock: qca,ath79-pll: fix copy-paste

v1:
Acked-by: Marek Vasut <marex@denx.de>
Acked-by: Alban Bedel <albeu@free.fr>
---
 Documentation/devicetree/bindings/clock/qca,ath79-pll.txt | 6 +++---
 arch/mips/boot/dts/qca/ar9132.dtsi                        | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt b/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
index e0fc2c1..241fb05 100644
--- a/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
+++ b/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
@@ -3,7 +3,7 @@ Binding for Qualcomm Atheros AR7xxx/AR9XXX PLL controller
 The PPL controller provides the 3 main clocks of the SoC: CPU, DDR and AHB.
 
 Required Properties:
-- compatible: has to be "qca,<soctype>-cpu-intc" and one of the following
+- compatible: has to be "qca,<soctype>-pll" and one of the following
   fallbacks:
   - "qca,ar7100-pll"
   - "qca,ar7240-pll"
@@ -21,8 +21,8 @@ Optional properties:
 
 Example:
 
-	memory-controller@18050000 {
-		compatible = "qca,ar9132-ppl", "qca,ar9130-pll";
+	pll-controller@18050000 {
+		compatible = "qca,ar9132-pll", "qca,ar9130-pll";
 		reg = <0x18050000 0x20>;
 
 		clock-names = "ref";
diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index 3ad4ba9..3c2ed9e 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -83,7 +83,7 @@
 			};
 
 			pll: pll-controller@18050000 {
-				compatible = "qca,ar9132-ppl",
+				compatible = "qca,ar9132-pll",
 						"qca,ar9130-pll";
 				reg = <0x18050000 0x20>;
 
-- 
2.7.0
