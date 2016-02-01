Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 01:12:25 +0100 (CET)
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35214 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011936AbcBAAK6w0kDA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 01:10:58 +0100
Received: by mail-lf0-f44.google.com with SMTP id l143so18959565lfe.2
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 16:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x0jdAzIVXQZLRco3v1zh/CYg38tyJB7BY3IwAEuqWFs=;
        b=jf55hjilcEomq1Nof9tX7Lvcn9K7W1j4x5p6inJ3kyMMoPMMxYD1bmHgRv8bm01gfN
         Mw9EbeOWI1ErLqB6sp9WKSyVOicTawIf8TTccYWO9exU/i4QvUf7eoOhCzpIV0+d0y8f
         iqIARYo4u1WCEzjY/FQtPpK/9euV8tHxzmO6iHJW82H+tS9NQDCqjSwgwESBP5lYn0qh
         n4BI8QGzI0uJyB1eW0iPdn7zkmJW2nl1G2MQtFuOMIrOJqClkN4UykZWa+gq3Sml79dW
         vZOAsC2e0nuI+vgnVZUhzIxyB4LhQFBwizjYQLHU+foQ4oBJuASEGku7ns8iF5VWhexQ
         ScMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x0jdAzIVXQZLRco3v1zh/CYg38tyJB7BY3IwAEuqWFs=;
        b=KTJYrhvkUJvbldAxkDgRMQpkAlmyNTkfiNf0mBUNMrsscx8NwmT5d0oVPTwcCA859d
         osW47bJiwM/kDuXaOZRqf/RS84ae6vHCLaGslMNBNKdmjfHLTAqFplu6K7coNFDnopbh
         zKsP2cOT8eEqRQtHvq3xj+PCh7xhpfmpGM+2+XrMwAaDlxLmKTtZEY0r6GDw1oMv8GY7
         /5THM0d6Jr9fCOBXNUngq9atBH4gTcdXragUcnAU79y/RIDFywYoRroZvTN/goiJInp3
         fDP2N9Xwy7dnmhpCk+m9ppnR5w9/u43XmbSp5bpsDKpI0DaLzbQiVKYA3hVtk/nc8kh/
         rgeA==
X-Gm-Message-State: AG10YOSszEn0tkMVyUNk18bfAMSeDayo4bcjlAQAIgPh2apAiuODfe1iQoY0eK/zfBCw2w==
X-Received: by 10.25.143.208 with SMTP id r199mr7269667lfd.148.1454285453629;
        Sun, 31 Jan 2016 16:10:53 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o97sm2807958lfi.25.2016.01.31.16.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 16:10:53 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [RFC v4 05/15] MIPS: dts: qca: ar9132: make extosc-related description shorter
Date:   Mon,  1 Feb 2016 03:10:30 +0300
Message-Id: <1454285440-18916-6-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
References: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51566
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
index a1b4fa1..e6baa1e 100644
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
index e535ee3..9b4132f 100644
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
 
 		usb@1b000100 {
@@ -118,3 +108,7 @@
 		};
 	};
 };
+
+&extosc {
+	clock-frequency = <40000000>;
+};
-- 
2.7.0
