Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2015 03:35:58 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32896 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012418AbbKSCf1u9Q1C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2015 03:35:27 +0100
Received: by pabfh17 with SMTP id fh17so66570653pab.0;
        Wed, 18 Nov 2015 18:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KPcEMNkOHgQ2Yi4MOfe4f486QZf9b+cHvlz6GJH3dSs=;
        b=cI3omgxTPjBeChJ9SKYtHKeCrGGi7ljOPe+lGiKwrLkuT24cgP3AAHhkBa3Ko07TR0
         klv0PwNRgALA4e5ODVe2yk1SnD6jNPpIaoLEpc2LibZjIa/5fx9q2AuG+XzeAUpZ4xRD
         E0sUr/wxUe8NB118aoPSWWogWnIInjTrisOEjk696NE2QwLsHy/ukdxbQvMgRfKjklbw
         K7ybGxwrOQZ0Q2jEBMGIUcql11qYQAcyGuq+FDEC9kGVVCIzqKBVydqrlLQ1uv2L8KGw
         WPuxuo5e6cRDDFs6L6f3zGr0Q9Nj/djmZrKsKcqqb+sEpnEQxU2HpH8liyHuADPsJOBR
         MCTw==
X-Received: by 10.66.62.131 with SMTP id y3mr6979461par.104.1447900522226;
        Wed, 18 Nov 2015 18:35:22 -0800 (PST)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id ns1sm6719515pbc.67.2015.11.18.18.35.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Nov 2015 18:35:21 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 2/7] MIPS: BMIPS: remove wrong sata properties
Date:   Thu, 19 Nov 2015 11:34:48 +0900
Message-Id: <1447900493-1167-3-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.3
In-Reply-To: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com>
References: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49986
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

The brcm,broken-{ncq,phy} properties are not used anywhere in device
tree, and the sata driver for BMIPS_GENERIC is not used it too.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7346.dtsi | 2 --
 arch/mips/boot/dts/brcm/bcm7362.dtsi | 2 --
 arch/mips/boot/dts/brcm/bcm7425.dtsi | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index 36d88e621b15..60018860878a 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -321,8 +321,6 @@
 			interrupts = <40>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			brcm,broken-ncq;
-			brcm,broken-phy;
 			status = "disabled";
 
 			sata0: sata-port@0 {
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index 82d4fac58228..e176dd50192e 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -244,8 +244,6 @@
 			interrupts = <86>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			brcm,broken-ncq;
-			brcm,broken-phy;
 			status = "disabled";
 
 			sata0: sata-port@0 {
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index e24d41ab4e30..47d7bbb20dfd 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -230,8 +230,6 @@
 			interrupts = <40>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			brcm,broken-ncq;
-			brcm,broken-phy;
 			status = "disabled";
 
 			sata0: sata-port@0 {
-- 
2.6.3
