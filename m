Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 21:19:01 +0100 (CET)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33050 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010779AbcAWURwDhpId (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jan 2016 21:17:52 +0100
Received: by mail-lb0-f171.google.com with SMTP id x4so57483480lbm.0
        for <linux-mips@linux-mips.org>; Sat, 23 Jan 2016 12:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XLClSTi/VzB6yj3iXnIMCHj8QwxXZoYj09GY+sLJ4k4=;
        b=rNtRdrIfDVRm+VZfXO2BplbjgP9nwGGRHxA0Rbsd5EpnRRqpugQLC3DWqhI3Rtl2Uh
         AD6Cc+F8qJaz7PIORYI55e9fPTNKgAFRPR2ABxCf+IHdavOih8k29aJEvVdd1H4OZy5b
         T6HV7VPPUVAf6QOOAy5iaz0zQZSektBDjcOrDPW+b++SIvoRvf+75xEehoCnrQ1KqpYB
         hhoRKuBfSHYhBxhTSMP7N66Q1Hi6WtR06GstAXmar/CEAxrC1zraUfQ2+zSTmkkCj+F4
         nZy+TCbWAaoe0sWKGuCndc4E0ViJ3henQTJxQYFtruw7xX3su4XysdJouiasKg8IhDX5
         ZwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XLClSTi/VzB6yj3iXnIMCHj8QwxXZoYj09GY+sLJ4k4=;
        b=J0sONXz2kDnu/mAIjfLEfiwnES4Yd0b4hrGyDIDaDUMiCm7tMQRkfWqOL/qMKPfK5U
         rrsp2tg09gNPrfsoUOkwgVHgZF9JXAXgbgBG38CRMHoImeew6C/QUt2PpyWAdPO0KMj/
         yl2jUcpMad8IAeRrwXioEmJ8t2luHtKP6x2GveiKm6Zoh9WpbPNqLSWJE2qSjtp7Rgxd
         uhjCWIku6bOFG5CnQLJN8xfFFBNo75dht+Y3Tc2dl/thNEg8EDoO310e9Eg57bHrHkk7
         1vX53lsOZ7Z2e1XW9EZWJojsWScm4RqR4gXLGoIpHxgTx/MX1Z6q4Bt0DKHftUTTsCJ6
         a9SQ==
X-Gm-Message-State: AG10YOQLqe1dn/LOjO8/5kNFzfM8QIkzELFerD+2hMLMrGqB8hY5P7dNRrvmMrRQq8ddPw==
X-Received: by 10.112.52.73 with SMTP id r9mr3509797lbo.64.1453580266628;
        Sat, 23 Jan 2016 12:17:46 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o82sm1664186lfo.47.2016.01.23.12.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Jan 2016 12:17:46 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [RFC v3 04/14] MIPS: dts: qca: ar9132: make extosc-related description shorter
Date:   Sat, 23 Jan 2016 23:17:21 +0300
Message-Id: <1453580251-2341-5-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51330
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
Cc: linux-clk@vger.kernel.org
---
 arch/mips/boot/dts/qca/ar9132.dtsi               |  9 ++++++++-
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 14 ++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index 4a537ea..cd1602f 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -28,6 +28,13 @@
 					<&ddr_ctrl 0>, <&ddr_ctrl 1>;
 	};
 
+	extosc: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+
+		/* The board must provide the extosc clock frequency */
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		ranges;
@@ -89,8 +96,8 @@
 						"qca,ar9130-pll";
 				reg = <0x18050000 0x20>;
 
+				clocks = <&extosc>;
 				clock-names = "ref";
-				/* The board must provides the ref clock */
 
 				#clock-cells = <1>;
 				clock-output-names = "cpu", "ddr", "ahb";
diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index 003015a..53057ca 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -18,21 +18,11 @@
 		reg = <0x0 0x2000000>;
 	};
 
-	extosc: oscillator {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <40000000>;
-	};
-
 	ahb {
 		apb {
 			uart@18020000 {
 				status = "okay";
 			};
-
-			pll-controller@18050000 {
-				clocks = <&extosc>;
-			};
 		};
 
 		spi@1f000000 {
@@ -110,3 +100,7 @@
 		};
 	};
 };
+
+&extosc {
+	clock-frequency = <40000000>;
+};
-- 
2.6.2
