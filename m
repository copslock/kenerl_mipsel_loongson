Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2015 03:36:17 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35518 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012435AbbKSCfa0onMC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2015 03:35:30 +0100
Received: by pacej9 with SMTP id ej9so64370371pac.2;
        Wed, 18 Nov 2015 18:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Sfq3jGxDqIb+g33rE7ngsko3ml/U4slXMEns4V25iw=;
        b=kU1mA7p0M+7P8tgD0lnPakc5SFWB8MMeyoepiphAJyt7QSLGqGGVEb3MxI3+YmNDMo
         6BwjMawIFdEB28QxfP6sCFVLcHWrF7Y37QpcfxRMiC0xxhuozct84fbmSd4HLt8O8byT
         4QNCvjmHb2S7eQ/zLP/cjvz05aR/3StOy/GfsyRYaEv+/3bvjaHJ03JUo1sbgv+sRmSN
         wdlgoHkroUOwDUB0TwqMtAcGrU7eIr4YmaUJJrfvtUOKFQ3otOb8kvsVJ/YXGcKP2bi0
         MFs39UWc50XExvIIQiBl4/hMSWd5NrDV7sv+mOG0irl8iRfj63e29V4XOy0X/p87BWj9
         cAWg==
X-Received: by 10.68.219.3 with SMTP id pk3mr6984266pbc.85.1447900524732;
        Wed, 18 Nov 2015 18:35:24 -0800 (PST)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id ns1sm6719515pbc.67.2015.11.18.18.35.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Nov 2015 18:35:24 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 3/7] MIPS: BMIPS: fix phy name in device tree
Date:   Thu, 19 Nov 2015 11:34:49 +0900
Message-Id: <1447900493-1167-4-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.3
In-Reply-To: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com>
References: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49987
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

Fixes phy names with register properties in device tree files.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7346.dtsi | 2 +-
 arch/mips/boot/dts/brcm/bcm7362.dtsi | 2 +-
 arch/mips/boot/dts/brcm/bcm7425.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index 60018860878a..8836a096a920 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -334,7 +334,7 @@
 			};
 		};
 
-		sata_phy: sata-phy@1800000 {
+		sata_phy: sata-phy@180100 {
 			compatible = "brcm,bcm7425-sata-phy", "brcm,phy-sata3";
 			reg = <0x180100 0x0eff>;
 			reg-names = "phy";
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index e176dd50192e..6aede98a8185 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -257,7 +257,7 @@
 			};
 		};
 
-		sata_phy: sata-phy@1800000 {
+		sata_phy: sata-phy@180100 {
 			compatible = "brcm,bcm7425-sata-phy", "brcm,phy-sata3";
 			reg = <0x180100 0x0eff>;
 			reg-names = "phy";
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index 47d7bbb20dfd..dfeb112da954 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -243,7 +243,7 @@
 			};
 		};
 
-		sata_phy: sata-phy@1800000 {
+		sata_phy: sata-phy@180100 {
 			compatible = "brcm,bcm7425-sata-phy", "brcm,phy-sata3";
 			reg = <0x180100 0x0eff>;
 			reg-names = "phy";
-- 
2.6.3
