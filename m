Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2015 08:09:12 +0200 (CEST)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36400 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008230AbbFXGIzu3zis (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jun 2015 08:08:55 +0200
Received: by pdcu2 with SMTP id u2so23240224pdc.3;
        Tue, 23 Jun 2015 23:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QUIUbyNYjM2QmtoltgdSrXt7CacAiSlW1PE/o4RvlNc=;
        b=lHmDLZcdnxggKVyVeyvppFWkzy+zXdIUrME+4ZtCa7BYovhywYL3vgEPk4fed/PZ+q
         1nue8rvQDQxO+mSR9Tw9Pxz336zmnnt3bLXJoHd3VC/lUJmAAgjpfIH7HljvzAUpnzzJ
         o+9fz+tVcab15HXxYoIxY7Ge/MUZvLpoO17VEbEy4MWAS1QuyS+RC5YH2SFcL++U0akM
         pmmCdcpn5+Q+jEJEH2YHuu04x1Vl91rMotrNAKGVkO9R07kJJx6o+LSzs2qnUeHyMZcg
         47sTxaInHMa7lmqkkoIr7s1bhk5SBpYR3JlsdJQrnl+rYdCgQNWNVfywpBXhe6mCgkLE
         eE2g==
X-Received: by 10.66.65.195 with SMTP id z3mr39924463pas.6.1435126129497;
        Tue, 23 Jun 2015 23:08:49 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by mx.google.com with ESMTPSA id cd10sm25396180pac.7.2015.06.23.23.08.47
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Jun 2015 23:08:49 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 1/4] MIPS: BMIPS: bcm7346: add nodes for NAND
Date:   Wed, 24 Jun 2015 15:08:31 +0900
Message-Id: <1544bf6110b43fbaa8dbb3b06a18e08ae87b386d.1435124524.git.jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <cover.1435124524.git.jaedon.shin@gmail.com>
References: <cover.1435124524.git.jaedon.shin@gmail.com>
In-Reply-To: <cover.1435124524.git.jaedon.shin@gmail.com>
References: <cover.1435124524.git.jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48012
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

Add NAND device nodes to BMIPS based BCM7346 platform.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 22 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts | 23 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index 1f30728a3177..5080df3fc594 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -220,5 +220,27 @@
 			interrupts = <76>;
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
diff --git a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
index 70f196d89d26..ee9a68f945fd 100644
--- a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
@@ -56,3 +56,26 @@
 &ohci3 {
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
