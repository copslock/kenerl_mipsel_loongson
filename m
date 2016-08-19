Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 04:54:01 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35020 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992215AbcHSCwz0o9si (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 04:52:55 +0200
Received: by mail-pa0-f66.google.com with SMTP id cf3so2668998pad.2;
        Thu, 18 Aug 2016 19:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xo6kS2nqyCKlI3M1nlMQ0klf9IdaESEtmSXy+1ILWVk=;
        b=c0GuqVeHn2NfknWBdu9kQETNPg+z9PeSQFpfWt+WaC24wXT4w7k/jW9X5vGTPONWZo
         4OrYnj+oHHg2dntlds46Vqvnkk7Vw0cL3U/pbrc9YKKAjIZQ2wz8ypO3LfEk4dPa/t1l
         hrWxjZtrMBXk7BrkfucNbsWJi5GvrBiEcigIqQAvN5oNvTVZR+uz+wF9CYM1lb1AnHKq
         b973+q+2YWvvydOvvYpOQStK8Sn7K/Iuquy49Q6dPRrKSEm/Bvs2BdjjviDlyDqDsMqc
         UMvSH5NYBygR63l0U9vS1yNeikx1KPhWi6cuK/ZvZnR9ZJbSeZnmKnraLYNaR0lMMq4C
         F2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xo6kS2nqyCKlI3M1nlMQ0klf9IdaESEtmSXy+1ILWVk=;
        b=hfqCtcNMaYQ0iyJJ5syRWLzdU7KKjM+eyV7XI63J7xD39J98b3bKNJAyiXG0BqYI8t
         YeIz/jDvibzqEc+lvPnhfahRzDVYQSRBQB7k0F5QQpH8KmqF0k06Cx9aTsELunaVMXmk
         kUAFKD4/mV+toLwJKpxFAk55P/ItQctZyhpH+YZ4d8vS9NxH3el30F4zdtE4UAWylvS7
         Mj+1YTQJzFjr2IZoA6NmTciMTPzsZapolZqBgVNr6izSuvXnr54mvN+7/CN7w69iwWrr
         HZs7twbXaas8Ee3EfI1bs4F/vQeQqPM849Ca+oDVzNGKUkz4c61RmT9cx9o4aWo82Vgi
         m4FA==
X-Gm-Message-State: AEkoouvPYkbJ+x2kY4skV94S7WoHN9MQMepTayNFG3wmJ5bfQbb3pnCB+qfZDPVSzDq/rw==
X-Received: by 10.66.52.47 with SMTP id q15mr9365755pao.67.1471575169652;
        Thu, 18 Aug 2016 19:52:49 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id 132sm1886744pfu.6.2016.08.18.19.52.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 18 Aug 2016 19:52:49 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v4 3/5] MIPS: BMIPS: Add support SDHCI device nodes
Date:   Fri, 19 Aug 2016 11:52:28 +0900
Message-Id: <20160819025230.31882-4-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160819025230.31882-1-jaedon.shin@gmail.com>
References: <20160819025230.31882-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54672
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
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
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
index 0105e4e5130b..0da4f8a3744b 100644
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
index f0f63cb2bd2b..9f72d3490427 100644
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
index ac42b98e31bb..ff734f45df92 100644
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
index 8b05b98f2a9c..1c8d3b4033a0 100644
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
index b7bb1024089c..2b28d91762ef 100644
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
2.9.3
