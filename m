Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 01:12:59 +0100 (CET)
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33602 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011938AbcBAALAjAU0A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 01:11:00 +0100
Received: by mail-lf0-f46.google.com with SMTP id m1so10788068lfg.0
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 16:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XVzQ4msGTlmmKCvafW0OMWqYxplJDh3fvlhLMBkYuQg=;
        b=EhxkxfueiTOi7A2qGFIzZRpYTOl5W7ByS/B3zlirus5nEXbJ7ai+3Vwe5KYbapTyhx
         KAEzTpjnKbFe8Ud49luzm7M5bK07Hz5beO8zl1DYjkBFJTPoPiGmshjbL/dCkMM5J0Qu
         o89Ryr7XfmwnE/WxsgfjDBBjUOKuRkkEUCiRIYIDz+8gHYxIaqKnk1kJHx5qmvn2wNef
         42ZqDQovsoEGFOwUbFs1nN1JLuS7QLWb1IVjbVuaObSV6JytdcIkZkj3CQHkvMhAdnJi
         OEH0juRJgY7S2gsmxel7mXkp5au507qZzUMKRU+/kS5Bf/vBy0gvhi/iHo3mOfftZqwU
         oz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XVzQ4msGTlmmKCvafW0OMWqYxplJDh3fvlhLMBkYuQg=;
        b=CT/NBl9rsEVnyvRiIa98UfSoU3sDakiBsT351sq+opIKMPe1s0OK000DrtkVAsUCCP
         7G62ZYVl02/1FJfkFxlweQpwHotDFEONQW9noXIR/DbhmmTO5tChcccjXcxJiu5m31Jo
         Vg4u3xwiVRfuRQpbj/ba7sJEvOuQmGDYNldRXf4pJnps/88xaHW/mywNQm2cNrer1ReG
         NqlkqrHfneq1iPJI3TfoQD5oVWKxBI2LidL9FvfilKrANqBp7BjpwQN4cdCxUb3/Es/1
         nrq2nPFma5GdkC+cL0L+UEMGXRNOJNo0kVisUBV20KhxRR7bjMgvD9Ej1NSX7UNJW0NO
         JxJQ==
X-Gm-Message-State: AG10YOTPw6SPGm36swUTPTvmoT817CRTMkLGhQRQn1s6rPeSDZeZXoQONWuY4hmNrfJvug==
X-Received: by 10.25.81.144 with SMTP id f138mr906501lfb.146.1454285455411;
        Sun, 31 Jan 2016 16:10:55 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o97sm2807958lfi.25.2016.01.31.16.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 16:10:54 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>, devicetree@vger.kernel.org
Subject: [RFC v4 07/15] MIPS: dts: qca: ar9132: use short references for uart, usb and spi nodes
Date:   Mon,  1 Feb 2016 03:10:32 +0300
Message-Id: <1454285440-18916-8-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
References: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51568
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
 arch/mips/boot/dts/qca/ar9132.dtsi               |  6 +-
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 86 +++++++++++-------------
 2 files changed, 44 insertions(+), 48 deletions(-)

diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index e6baa1e..f4023fd 100644
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
 
-		usb@1b000100 {
+		usb: usb@1b000100 {
 			compatible = "qca,ar7100-ehci", "generic-ehci";
 			reg = <0x1b000100 0x100>;
 
@@ -149,7 +149,7 @@
 			status = "disabled";
 		};
 
-		spi@1f000000 {
+		spi: spi@1f000000 {
 			compatible = "qca,ar9132-spi", "qca,ar7100-spi";
 			reg = <0x1f000000 0x10>;
 
diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index 89703cf..9f04a3c 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -14,51 +14,6 @@
 		reg = <0x0 0x2000000>;
 	};
 
-	ahb {
-		apb {
-			uart@18020000 {
-				status = "okay";
-			};
-		};
-
-		usb@1b000100 {
-			status = "okay";
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
-	usb-phy {
-		status = "okay";
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys-polled";
 		#address-cells = <1>;
@@ -108,3 +63,44 @@
 &extosc {
 	clock-frequency = <40000000>;
 };
+
+&uart {
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+};
+
+&usb_phy {
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
2.7.0
