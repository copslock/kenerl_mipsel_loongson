Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 10:54:11 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33821 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992880AbcHLIw6nN4B- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 10:52:58 +0200
Received: by mail-pa0-f66.google.com with SMTP id hh10so1176209pac.1;
        Fri, 12 Aug 2016 01:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eapLXA7qOxou41/xodKBp2OqOhJjwo27oWdv8255C8M=;
        b=LEzqav3Zi4tF8DcXgQ9zEGmnCVzLc1vxpcVqg3GL0iRJZjqkMgxhjolYPy+anT7fPB
         WuhTkK786r/asBF/ohPEad/ZkwBTKbALZrEbcd4JehVKJHz8v3U97dSwccubYP5g50Jz
         8o3GPnMU7fnSFJoQv0fuilZJEzUVR5PPEFayMuQsY+6lQzebIg0mc2KXaIZFX9KWaE/1
         uYZ9/dt+dQSAFxua1aG2bC24lxTKM5YasUZ/kgupC+X1BB6As6Qw6aSQoluoPEjCKEBF
         rk1XE3r43itVXdCfpTqXIm/ringVzWaePqChuMOJcKLSdsGvTof6UXcryIWOBpMPp1Hh
         yarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eapLXA7qOxou41/xodKBp2OqOhJjwo27oWdv8255C8M=;
        b=AOUu2wxsldVeMZEjg7Gjb+Bnd/jG1hidZlBONe9g5ey8Ii0lyX86U7gtQ6J3ED/if/
         Tvd6LplX1hOB88QbUVMWUIhlPGMTH2TnklPbFFing7SnYCbqIQ9adTBmdHnbt3JCEHOm
         v/bj4dhQ9dS66Ex9dzsweuTDtdaLu37SdyHaboL1jvxmBjoZF2BaFthU54CySJh0DBAM
         5hFpiwM7onkE3YdTBL7s5r3QywYDXgy0veixRoy9FHUp4Ej8izAY6iBk9ezs2EYN7Ce0
         ci1Xiq/R6r9u8QkMrk91GlNeM+gMnKMDnylhixipPSsuD6r4pubEOtXjn0wq04HJlrFY
         UPzw==
X-Gm-Message-State: AEkooutd7p8lmugWqxovWfbV5UGMzueDc4ZxhJzIWjsKkMLuocO2tcovdbnya8acSCN8uQ==
X-Received: by 10.66.132.38 with SMTP id or6mr25042619pab.84.1470991972705;
        Fri, 12 Aug 2016 01:52:52 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id ty6sm11024819pac.18.2016.08.12.01.52.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 01:52:52 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v3 3/5] MIPS: BMIPS: Add support SDHCI device nodes
Date:   Fri, 12 Aug 2016 17:52:29 +0900
Message-Id: <20160812085231.53290-4-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160812085231.53290-1-jaedon.shin@gmail.com>
References: <20160812085231.53290-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54498
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
index f29e68a84086..8c0466bd84d0 100644
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
index 269ab73db354..bcab913aea36 100644
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
index 95f07a65c9dd..9214ec55ffc2 100644
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
index f7f0833ef403..de4c7744caab 100644
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
index 4bbe4888d8a6..7a9c76d59ff3 100644
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
