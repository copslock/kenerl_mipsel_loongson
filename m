Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 04:11:01 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34003 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990517AbcHLCJ4XI6Ex (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 04:09:56 +0200
Received: by mail-pf0-f193.google.com with SMTP id g202so664444pfb.1;
        Thu, 11 Aug 2016 19:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7elBgUaCnJwaeWMksWJyHNzWY1HrvCZZfsObj4OlQ0g=;
        b=X5MQf6Xe7b0Kaz4XpTbUjp4RkqMj0sHYOoDI8CffpmjhPNLAwd+HgT+8/2WzjjCO2n
         yusVlAjoJxRcMdT3X/qWw2HhrSUaVci+sFiRwGU01BGhJHjwRk/QEAvyV6A/e0gk5qbz
         GdrM69b2cEqv1YGVEJM37fovKk0ZN4ImeGWumyo/BQ4mxfqSbOHQ8GGrovzbX7gE+fY7
         mcuwVHHGULUWplUoK5H6fjySvwaWUq5vyVhnTW8H4vySC+QK4aqVkjjBwKTzs5cd3xvF
         Lx3zsuD2j24f2eWQ6szsWZ/OvwSX8nIGhtZjBKtkaOE4KvsaqkI8FEltYEHpeJbJzXaG
         N7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7elBgUaCnJwaeWMksWJyHNzWY1HrvCZZfsObj4OlQ0g=;
        b=ifUZmQ3vISNPGHwfW1dUY1xdPPx8KlMmHBri31rXnQtE1cpSTXEiZk+M2vFzfiLLP0
         7avXIVb9HCWgQW0fIyKL6HPn89gtKSLX5gTpQJ3FG9Wruk5PgfQGrCmc/qX9IIY/9863
         exk1Qfzc7r4skaXUY1jeKKSTGVlp8ny51xBu26DipK6bnEHkX4RzBeNqaeWKgzI716vc
         3LBevKV8smEYRIv/VxV+zheLyd0xemORjXsSAksNYeUTlK1GjCzFuNrU1QSetYGxPmT+
         a8wOweB3YStEbYoX2rPuK/WtGsZQ2iaE1o/HskWHsjkG1W7BWaKU07FHewMtvez0CFcY
         UjRQ==
X-Gm-Message-State: AEkoouucJNqgn3Fh6OTGBvb3I32+oDND1dyC3wee0qJ1rfvTjfFVY3C6q1aHzRJo1ormSQ==
X-Received: by 10.98.64.93 with SMTP id n90mr22945532pfa.29.1470967790237;
        Thu, 11 Aug 2016 19:09:50 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id ao6sm8209846pac.8.2016.08.11.19.09.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 19:09:49 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 3/5] MIPS: BMIPS: Add support SDHCI device nodes
Date:   Fri, 12 Aug 2016 11:09:21 +0900
Message-Id: <20160812020923.3299-4-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160812020923.3299-1-jaedon.shin@gmail.com>
References: <20160812020923.3299-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54488
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

Adds SDHCI device nodes to BCM7xxx MIPS based SoCs.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7346.dtsi      |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi      | 20 ++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi      | 20 ++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  4 ++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  |  4 ++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  4 ++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts  |  8 ++++++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts  |  8 ++++++++
 10 files changed, 92 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index 1ef7540238be..30af896ddb60 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -411,5 +411,13 @@
 				#phy-cells = <0>;
 			};
 		};
+
+		sdhci0: sdhci@413500 {
+			compatible = "brcm,bcm7425-sdhci";
+			reg = <0x413500 0x100>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <85>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index 0aeb3de7fbc2..05d868cbb5c0 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -330,5 +330,13 @@
 				#phy-cells = <0>;
 			};
 		};
+
+		sdhci0: sdhci@410000 {
+			compatible = "brcm,bcm7425-sdhci";
+			reg = <0x410000 0x100>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <82>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index 9a1f6ffc343d..ff555e52c088 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -326,5 +326,13 @@
 				#phy-cells = <0>;
 			};
 		};
+
+		sdhci0: sdhci@410000 {
+			compatible = "brcm,bcm7425-sdhci";
+			reg = <0x410000 0x100>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <82>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index 04306a92b8eb..4e387d05bb5b 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -410,5 +410,25 @@
 				#phy-cells = <0>;
 			};
 		};
+
+		sdhci0: sdhci@419000 {
+			compatible = "brcm,bcm7425-sdhci";
+			reg = <0x419000 0x100>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <43>;
+			sd-uhs-sdr50;
+			mmc-hs200-1_8v;
+			status = "disabled";
+		};
+
+		sdhci1: sdhci@419200 {
+			compatible = "brcm,bcm7425-sdhci";
+			reg = <0x419200 0x100>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <44>;
+			sd-uhs-sdr50;
+			mmc-hs200-1_8v;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index c4883643ab61..d3130f7b7b70 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -425,5 +425,25 @@
 				#phy-cells = <0>;
 			};
 		};
+
+		sdhci0: sdhci@41a000 {
+			compatible = "brcm,bcm7425-sdhci";
+			reg = <0x41a000 0x100>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <47>;
+			sd-uhs-sdr50;
+			mmc-hs200-1_8v;
+			status = "disabled";
+		};
+
+		sdhci1: sdhci@41a200 {
+			compatible = "brcm,bcm7425-sdhci";
+			reg = <0x41a200 0x100>;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <48>;
+			sd-uhs-sdr50;
+			mmc-hs200-1_8v;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
index 2c55ab094a29..27c9f127a7ca 100644
--- a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
@@ -100,3 +100,7 @@
 &sata_phy {
 	status = "okay";
 };
+
+&sdhci0 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
index 496e6ed9fae3..bed821b03013 100644
--- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
@@ -68,3 +68,7 @@
 &sata_phy {
 	status = "okay";
 };
+
+&sdhci0 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
index b880c018f3d8..1b9bc4b2d9ae 100644
--- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
@@ -64,3 +64,7 @@
 &sata_phy {
 	status = "okay";
 };
+
+&sdhci0 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
index f091e91b11c5..1c6b74daef56 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -94,3 +94,11 @@
 &ohci3 {
 	status = "okay";
 };
+
+&sdhci0 {
+	status = "okay";
+};
+
+&sdhci1 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index 9db84f2a6664..64bb1988dbc8 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -102,3 +102,11 @@
 &sata_phy {
 	status = "okay";
 };
+
+&sdhci0 {
+	status = "okay";
+};
+
+&sdhci1 {
+	status = "okay";
+};
-- 
2.9.2
