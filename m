Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2015 03:35:42 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34031 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012412AbbKSCfZ4rSEC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2015 03:35:25 +0100
Received: by padhx2 with SMTP id hx2so64420038pad.1;
        Wed, 18 Nov 2015 18:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6iUttyr/ld0984VZRTtql7KKZUrNSoji9WVUz8dxtZE=;
        b=j8RnunOSiSKh33tBAr91CzThlhYzQRo8SZXZSp3xPoq9rwpfkDIbmmOTZlpqTBEjxQ
         jis2Y7PCcbpe2X0nwDzqkp5XW0/UBy2gHA1gE3ak5YR7fEa8i8bAN+ewe98wUp3f6OlY
         EhNA+XpFAsp+7uy7+/spxdqWg8WXLvVzTtVpAq0BTUtgR27qRP5p1cL9p3BGrXQ/ThCs
         Z5o1scjGcL35J9I5rLix4nrPjO/lYQyXVqJ9S4jbQbjvo6jtCLW+LeKSgLCtYs54Q4wy
         debzY3Xj9TPJ/o2F/VowjKIY56g4CLZ0mrGgM3U2nwwMZUACTZqOrWccyAE8wpcEWncL
         7nlw==
X-Received: by 10.66.63.37 with SMTP id d5mr7012754pas.103.1447900519691;
        Wed, 18 Nov 2015 18:35:19 -0800 (PST)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id ns1sm6719515pbc.67.2015.11.18.18.35.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Nov 2015 18:35:19 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 1/7] MIPS: BMIPS: remove unused aliases in device tree
Date:   Thu, 19 Nov 2015 11:34:47 +0900
Message-Id: <1447900493-1167-2-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.3
In-Reply-To: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com>
References: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Remove unused aliases in bcm7xxx device tree. The uart{1,2} aliases are
not used from device tree files.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7346.dtsi | 2 --
 arch/mips/boot/dts/brcm/bcm7358.dtsi | 2 --
 arch/mips/boot/dts/brcm/bcm7360.dtsi | 2 --
 arch/mips/boot/dts/brcm/bcm7362.dtsi | 2 --
 4 files changed, 8 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index d4bf52cfcf17..36d88e621b15 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -24,8 +24,6 @@
 
 	aliases {
 		uart0 = &uart0;
-		uart1 = &uart1;
-		uart2 = &uart2;
 	};
 
 	cpu_intc: cpu_intc {
diff --git a/arch/mips/boot/dts/brcm/bcm7358.dtsi b/arch/mips/boot/dts/brcm/bcm7358.dtsi
index 8e2501694d03..2cdb53719797 100644
--- a/arch/mips/boot/dts/brcm/bcm7358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
@@ -18,8 +18,6 @@
 
 	aliases {
 		uart0 = &uart0;
-		uart1 = &uart1;
-		uart2 = &uart2;
 	};
 
 	cpu_intc: cpu_intc {
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index 7e5f76040fb8..90b1b038a41a 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -18,8 +18,6 @@
 
 	aliases {
 		uart0 = &uart0;
-		uart1 = &uart1;
-		uart2 = &uart2;
 	};
 
 	cpu_intc: cpu_intc {
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index c739ea77acb0..82d4fac58228 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -24,8 +24,6 @@
 
 	aliases {
 		uart0 = &uart0;
-		uart1 = &uart1;
-		uart2 = &uart2;
 	};
 
 	cpu_intc: cpu_intc {
-- 
2.6.3
