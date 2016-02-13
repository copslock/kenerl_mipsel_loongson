Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Feb 2016 22:58:51 +0100 (CET)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36161 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012168AbcBMV6cDJ8Ni (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Feb 2016 22:58:32 +0100
Received: by mail-lf0-f68.google.com with SMTP id h198so5750327lfh.3;
        Sat, 13 Feb 2016 13:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lh7Api79kc6G9GmTHi8YILJv0u6rlTsfyK1ybShvh0k=;
        b=SRocw5gAWvc2EPGdWq4C7s4xbu/jFu2P48mBe0p/YHIBevu3abxRzoRYASW4h9zop1
         5RpNpAhm1KRwAfpd9eS27O2/T+7M4XOP3JX5+OsaEetOnURim49HmF8yGeZFZq3larWO
         MH3H66EX/JG38AP+tI1i/KOBBTEOkL7cOOfmboeGqUeAk5fbZNCQ8Lq3phjzvSRs+VTv
         xkw3ZY/0U9czcy/B907EmuaoWLAVsZEdLgk91UJT3dH7GjFYUB6p0H9fUTyzGGiQayHm
         H4+ST3YE2of6NiJVVGNBdonenagO/6NqUg+Zj3auzpIP0n36fRzMreqr+DIvmqWTuti1
         dM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lh7Api79kc6G9GmTHi8YILJv0u6rlTsfyK1ybShvh0k=;
        b=KQBPkKZ0BHKa5NmouVkfv8lYJbWCOqRWpBc8LbC56YpB8mjHHrr0tAPtwKytSHwkUh
         zekPFz8WS5Qzg7bwwydmkvhl96+Yv7STs82PCcSRMqzDj9nkDmXbHLVSp95YWBYI/mta
         9DhVTEIsLZ3LxJ5SHvyif967fEcGmBQbHgEE72yJXDC+qb5L5ekyl/a2ynwqXsn5mxr4
         MVDJcKK/XfGXzgi+xwrDTxdOWb5HRIHqyYVxro7lI1X7MFB4aUEo6L0asOC4kxYK3crZ
         n729qMmGNbC1KcaQof81f1kY5wSVKDZKA/DyslX+UAGmzN83pGi95AZ3ngSbArNL/FE6
         d2Yg==
X-Gm-Message-State: AG10YORDYhs9NoLB8fEfupdtc5qGOSugJMV/llPNq0mqUPRAIif8yXgo5mstzISlX31kow==
X-Received: by 10.25.161.6 with SMTP id k6mr3550735lfe.17.1455400706311;
        Sat, 13 Feb 2016 13:58:26 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id jr10sm2624949lbc.42.2016.02.13.13.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Feb 2016 13:58:25 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 01/10] dt-bindings: clock: qca,ath79-pll: fix copy-paste typos
Date:   Sun, 14 Feb 2016 00:58:08 +0300
Message-Id: <1455400697-29898-2-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52033
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
Acked-by: Marek Vasut <marex@denx.de>
Acked-by: Alban Bedel <albeu@free.fr>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/qca,ath79-pll.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt b/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
index e0fc2c1..ae99f22 100644
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
@@ -21,7 +21,7 @@ Optional properties:
 
 Example:
 
-	memory-controller@18050000 {
+	pll-controller@18050000 {
 		compatible = "qca,ar9132-ppl", "qca,ar9130-pll";
 		reg = <0x18050000 0x20>;
 
-- 
2.7.0
