Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 21:19:35 +0100 (CET)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36597 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014734AbcAWURx6PuFd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jan 2016 21:17:53 +0100
Received: by mail-lb0-f178.google.com with SMTP id oh2so56904119lbb.3
        for <linux-mips@linux-mips.org>; Sat, 23 Jan 2016 12:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e+J2ts10S5JGEjoIQgkwjj+Vq30pUUDNEmE1ERTazfw=;
        b=O2uRAI6N9K0otxGQZ+AcSo8jBv2wxVuPJ3jqsy0xttEF8bUWncYAwA/Gv8XAD1QF/z
         PEkmZt8ajEV6vOD3zJNxnU40UefEY+0LxBrqZt0+m6mPArDl88+8D3CMjhDtxJaP08hQ
         wKtOC6mQFNthH1OCeuTwM84DOcavo5/WXS6tyUa8YGJY/zFiFwjoJEG4BnHI4ulGQpDW
         fAUyov5XU5jVQldA0e4t+FSGi7vpMfSG5hvTyAkwQcwBecKEsKr3BGlJnOKd4gPZptAq
         068Eh5DDIFfJB5wPiZ5CbDMbe/rT64oS9/lgBJy2s0qQa5BoAu/cqB0osLtcWJY0054B
         xCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e+J2ts10S5JGEjoIQgkwjj+Vq30pUUDNEmE1ERTazfw=;
        b=Uz9JkeMhvO4Uy3zlT5YYk7eqkskcHHPzCaLtN4oFkob/1K1vqZMWYA/lCi87pXlVvN
         Pg37NR0ebTPTOzQzb/Ins9FE+TMjBrQKYM85a2noHoW77x/yX7vZPC2+1g8bdKwJwaRC
         u+ZYddQhvyZhRzAOdlUMOmZr2EQohNYMtAbryLhhN0f+Mjf2/FENxQrE3xjsH3/F3uE7
         5z9yDVdBZzyrwENcUjU/fQ/UGYZzN/lkD1QIiwRRqO5TcCupeZ1Unzr96nigGe480zHl
         Ihi/M4D5ngj17kHHbuSeiKNT6cHie7mf7ryIlX10wLusMTbBsa0F0J73w8+vd2JuwznX
         lAjw==
X-Gm-Message-State: AG10YOQpFSIVYu5lFPRgGb/uPQUei7wGCbuO5uqiuNEtc+2P70u1yfqcw1xzq6aa8dxgUg==
X-Received: by 10.112.219.35 with SMTP id pl3mr2845788lbc.32.1453580268696;
        Sat, 23 Jan 2016 12:17:48 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o82sm1664186lfo.47.2016.01.23.12.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Jan 2016 12:17:48 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>, devicetree@vger.kernel.org
Subject: [RFC v3 06/14] MIPS: dts: qca: ar9132: use short references for uart and spi nodes
Date:   Sat, 23 Jan 2016 23:17:23 +0300
Message-Id: <1453580251-2341-7-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51332
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
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/boot/dts/qca/ar9132.dtsi               |  4 +-
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 70 +++++++++++-------------
 2 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index cd1602f..a14f6f2 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -61,7 +61,7 @@
 				#qca,ddr-wb-channel-cells = <1>;
 			};
 
-			uart@18020000 {
+			uart: uart@18020000 {
 				compatible = "ns8250";
 				reg = <0x18020000 0x20>;
 				interrupts = <3>;
@@ -134,7 +134,7 @@
 			};
 		};
 
-		spi@1f000000 {
+		spi: spi@1f000000 {
 			compatible = "qca,ar9132-spi", "qca,ar7100-spi";
 			reg = <0x1f000000 0x10>;
 
diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index 9618105..f22c22c 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -14,43 +14,6 @@
 		reg = <0x0 0x2000000>;
 	};
 
-	ahb {
-		apb {
-			uart@18020000 {
-				status = "okay";
-			};
-		};
-
-		spi@1f000000 {
-			status = "okay";
-			num-cs = <1>;
-
-			flash@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "s25sl064a";
-				reg = <0>;
-				spi-max-frequency = <25000000>;
-
-				partition@0 {
-					label = "u-boot";
-					reg = <0x000000 0x020000>;
-				};
-
-				partition@1 {
-					label = "firmware";
-					reg = <0x020000 0x7D0000>;
-				};
-
-				partition@2 {
-					label = "art";
-					reg = <0x7F0000 0x010000>;
-					read-only;
-				};
-			};
-		};
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys-polled";
 		#address-cells = <1>;
@@ -100,3 +63,36 @@
 &extosc {
 	clock-frequency = <40000000>;
 };
+
+&uart {
+	status = "okay";
+};
+
+&spi {
+	status = "okay";
+	num-cs = <1>;
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "s25sl064a";
+		reg = <0>;
+		spi-max-frequency = <25000000>;
+
+		partition@0 {
+			label = "u-boot";
+			reg = <0x000000 0x020000>;
+		};
+
+		partition@1 {
+			label = "firmware";
+			reg = <0x020000 0x7D0000>;
+		};
+
+		partition@2 {
+			label = "art";
+			reg = <0x7F0000 0x010000>;
+			read-only;
+		};
+	};
+};
-- 
2.6.2
