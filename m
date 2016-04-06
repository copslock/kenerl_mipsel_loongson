Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 09:04:41 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:32948 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006869AbcDFHEkS3dMQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Apr 2016 09:04:40 +0200
Received: by mail-pa0-f66.google.com with SMTP id q6so3316803pav.0;
        Wed, 06 Apr 2016 00:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7WlSxxpUZ1DqRx/nNDfHrMpmcLIs0vCo2WE434gWy84=;
        b=Yx6tzioY+ZmvlcI3oJ3/gG8wNuJA9bGBltT1hZMtLQzRL/cRarVzv3Nz5fCH0GK7RF
         EaV4VTQobeTwNg6BncuWjE2NNQD3sn6KtL3q+KiTC+fUa6BngcszLVZNb08Fa/abaW6Z
         4fNfHIkE2DDrgt6r1MPBjpFFv3B3tw3Mc3bVhAIqIfv3EhZ4cSfviDzi5MR2v42P/J6G
         yRTsY8DJ4e9ri42xD3nYi5cYSen6kRaaknzjtP71OrK+/vMGAjIdeArSySyxQPiHlges
         Q9am2zbsyf28Cbt0UUfZId5GNTWHfNL8MLiwO3Jj+gS2hxcwtE703rsUSfVdFvOyqm+y
         9pBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7WlSxxpUZ1DqRx/nNDfHrMpmcLIs0vCo2WE434gWy84=;
        b=CAd5Z40TrS9E6dDLApi9ZSGIEiislNGO9K2jYi7MNpqmedoKpHaCy3GbszhTPphZ1W
         xuqfhMjJ3Zq2gDkdbZLuPagn5bFuYB40tBg643CoOIuK+Af7MHTLBbWHcuPh46ZuR9mt
         1fn1IUEh9yWnn4FVjpioQG6HtWGG3nU5ZoHvApXyqkO4jnKmUuQeixlddUwwTiBMwSZG
         SIooPY3u+07QFaH7FkmmKgZmkSL2gGjpA89iSVUdHtjptg95SM3Tst80sxe3Wf/U7KdW
         3wnB0wDah9wA73zpIC5RR6ATXNNpnA0EH85GIv1Nqiem+s5xFA++F9mAkN+eJ+57aHOV
         AVjg==
X-Gm-Message-State: AD7BkJJa1fYPjvOyVMV2wkYTLnaJAgJWr7c7vHEyoQCRim/d789eNoRDDI7ddZboe/MgQg==
X-Received: by 10.66.123.105 with SMTP id lz9mr20732142pab.37.1459922296664;
        Tue, 05 Apr 2016 22:58:16 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id s197sm1661165pfs.62.2016.04.05.22.58.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 05 Apr 2016 22:58:16 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] MIPS: BMIPS: Fix interrupt and remove needless properties
Date:   Wed,  6 Apr 2016 14:58:01 +0900
Message-Id: <1459922281-11144-1-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.8.0
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52891
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

Fixes wrong bcm7425 SATA AHCI hardware interrupt property value with
periph_intc and SATA PHY unit address, and removes needless
brcm,broken-{ncq,phy} properties what are not used anywhere.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7346.dtsi | 4 +---
 arch/mips/boot/dts/brcm/bcm7362.dtsi | 4 +---
 arch/mips/boot/dts/brcm/bcm7425.dtsi | 6 ++----
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index be7991917d29..7ae7b3e6e0f8 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -323,8 +323,6 @@
 			interrupts = <40>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			brcm,broken-ncq;
-			brcm,broken-phy;
 			status = "disabled";
 
 			sata0: sata-port@0 {
@@ -338,7 +336,7 @@
 			};
 		};
 
-		sata_phy: sata-phy@1800000 {
+		sata_phy: sata-phy@180100 {
 			compatible = "brcm,bcm7425-sata-phy", "brcm,phy-sata3";
 			reg = <0x180100 0x0eff>;
 			reg-names = "phy";
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index d3b1b762e6c3..8177676d497a 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -246,8 +246,6 @@
 			interrupts = <86>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			brcm,broken-ncq;
-			brcm,broken-phy;
 			status = "disabled";
 
 			sata0: sata-port@0 {
@@ -261,7 +259,7 @@
 			};
 		};
 
-		sata_phy: sata-phy@1800000 {
+		sata_phy: sata-phy@180100 {
 			compatible = "brcm,bcm7425-sata-phy", "brcm,phy-sata3";
 			reg = <0x180100 0x0eff>;
 			reg-names = "phy";
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index 15b27aae15a9..8214d45bad46 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -227,11 +227,9 @@
 			reg-names = "ahci", "top-ctrl";
 			reg = <0x181000 0xa9c>, <0x180020 0x1c>;
 			interrupt-parent = <&periph_intc>;
-			interrupts = <40>;
+			interrupts = <41>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			brcm,broken-ncq;
-			brcm,broken-phy;
 			status = "disabled";
 
 			sata0: sata-port@0 {
@@ -245,7 +243,7 @@
 			};
 		};
 
-		sata_phy: sata-phy@1800000 {
+		sata_phy: sata-phy@180100 {
 			compatible = "brcm,bcm7425-sata-phy", "brcm,phy-sata3";
 			reg = <0x180100 0x0eff>;
 			reg-names = "phy";
-- 
2.8.0
