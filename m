Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2015 08:10:04 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36395 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008388AbbFXGJCYHt2s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jun 2015 08:09:02 +0200
Received: by paceq1 with SMTP id eq1so22269894pac.3;
        Tue, 23 Jun 2015 23:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kb2YbD9lxRp4UtywC3+mkyrA20lCW8pQOiTxxrzjiYg=;
        b=k1ApB1jGiJksnW8mmgiSsEjG6gljkmHM8BjtYQYt0zoz0hrPjEO0V1pcC0TJA+suCj
         +nY+5DxUH+wsOqWpxiixPfbAp63oMr7E9QpMrFUUEmdz/JLyrjxPfN9A+RL/mcRQQQdB
         I5LKwMjqkiURdtqUvlqy0Og6sFMz2Y79cH2hdx+byEPu0cXCrJ6rV27Hr/0sfsCwi6lJ
         a5gu/wXto3svXsYxJay7p0JZH6/3jT17iEp7PQ7L+4ZevYLf+tGzqLz716gyZLmMDlwL
         5MN9JCjF/9EoIM2L5rt2lMXBgblrUM5Pnp2trMiRdkDiMUN3+TaVR4ggr2TbG4x3UhR8
         KPpw==
X-Received: by 10.66.156.68 with SMTP id wc4mr1709597pab.126.1435126136763;
        Tue, 23 Jun 2015 23:08:56 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by mx.google.com with ESMTPSA id cd10sm25396180pac.7.2015.06.23.23.08.54
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Jun 2015 23:08:56 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 4/4] MIPS: BMIPS: bcm7362: add nodes for NAND
Date:   Wed, 24 Jun 2015 15:08:34 +0900
Message-Id: <21fa822ca7f49134595d1102c7ebcd13227b85d2.1435124524.git.jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <cover.1435124524.git.jaedon.shin@gmail.com>
References: <cover.1435124524.git.jaedon.shin@gmail.com>
In-Reply-To: <cover.1435124524.git.jaedon.shin@gmail.com>
References: <cover.1435124524.git.jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48015
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

Add NAND device nodes to BMIPS based BCM7362 platform.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7362.dtsi     | 22 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts | 23 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index da99db665bbc..175998e388cf 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -163,5 +163,27 @@
 			interrupts = <66>;
 			status = "disabled";
 		};
+
+		hif_intr2_intc: interrupt-controller@411000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x411000 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <30>;
+			interrupt-names = "hif";
+		};
+
+		nand0: nand@412800 {
+			compatible = "brcm,brcmnand-v5.0", "brcm,brcmnand";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg-names = "nand";
+			reg = <0x412800 0x400>;
+			interrupt-parent = <&hif_intr2_intc>;
+			interrupt-names = "nand_ctlrdy";
+			interrupts = <24>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
index b7b88e5dc9e7..4fe069c5392b 100644
--- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
@@ -32,3 +32,26 @@
 &ohci0 {
 	status = "okay";
 };
+
+&nand0 {
+	status = "okay";
+
+	nandcs@1 {
+		compatible = "brcm,nandcs";
+		reg = <1>;
+		nand-ecc-step-size = <512>;
+		nand-ecc-strength = <8>;
+		nand-on-flash-bbt;
+
+		#size-cells = <2>;
+		#address-cells = <2>;
+
+		flash1.rootfs0@0 {
+			reg = <0x0 0x0 0x0 0x80000000>;
+		};
+
+		flash1.rootfs1@80000000 {
+			reg = <0x0 0x80000000 0x0 0x80000000>;
+		};
+	};
+};
-- 
2.4.4
