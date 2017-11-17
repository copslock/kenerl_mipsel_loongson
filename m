Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 03:20:35 +0100 (CET)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:46630
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992188AbdKQCUGRLw6V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 03:20:06 +0100
Received: by mail-pg0-x241.google.com with SMTP id z184so796234pgd.13;
        Thu, 16 Nov 2017 18:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wzoAsWVEjKBeAWNWULFmnNJ9N4ieFZrwprAFIeFKMWI=;
        b=PCE0wuxHLxflI4LJyHKXHhje2MZUBjFE2fIMqDVBMdPVIT2yX6aXIAry0g9ggHaMR6
         nE0io9Qq9ynd0kBnkm2YUfG0yIZF2FztrZ/xVaHkIxisLE+5mHYLLI7HBqnMKNZdA336
         GVUFeCRxbgfsOTrXN+RYp48FCbNlYLV/LA+ONVhHOFU0s+CyHGbA5Yv+wqFluFl1OKkx
         vynSohkl5qZIEagi87vMe/CVOV+w6Mer0+11PSKggfStqZmeHyzQA2Pr6r8LW/dp5cY5
         Jj486Tb1JltgchKVh2LBUvQj3GZ+jUApbEVZ7Qx35zdHk4r2pjWn1hyp/AVzvPoBWodo
         G+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wzoAsWVEjKBeAWNWULFmnNJ9N4ieFZrwprAFIeFKMWI=;
        b=C5B/YQWl0cds4ejV68VT3bdMwi99Nk5F3YN1KJ21AAIlBcOd7vcFEro9I3/PyUOJW1
         nxZ034bBO3wTKcLFprpDH8quh5FLQ2lCnmxAAmSLwEnpWjc9rA1p2lta7vTGgnVwI4mI
         VjiRDn1Gfe4cxEHyK5xQsMJUccIK1EWOh2wC97ANTzoEcAGdp7vXeOfaFHd7cmCa3d95
         Q3JCqSzR5rFPLBKeGaKCLV0nfOCBIJZgt3TdzKq5BKHVkgdwGk3HCe55VZgvrkIGZ0Ui
         ntwbvQjBrnjcx3bMR78dRRFYeew8KKCcxdmALpsGti7X0ykOLEpvIg0Z6VZpYZJ22D6g
         ARrg==
X-Gm-Message-State: AJaThX7Uxq5jvAVBqEKhQG3JBJ+ZmnkhI9WnoIVOhNmyoQTtCRVMRzQ8
        uuHrV0o6gj3RQgbx4Pd7VCTEK+V3
X-Google-Smtp-Source: AGs4zMaKdI9OjyrAJS3c7UKLdrDzx0kYzZ/ZO1AjGVVoiCRwn5gAaWlWz7DW8GabwLU67rZsMBPzvQ==
X-Received: by 10.159.207.134 with SMTP id z6mr3776493plo.144.1510885199277;
        Thu, 16 Nov 2017 18:19:59 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id s4sm5393280pgp.40.2017.11.16.18.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2017 18:19:58 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 1/3] MIPS: BMIPS: Add Broadcom STB power management nodes
Date:   Fri, 17 Nov 2017 11:19:42 +0900
Message-Id: <20171117021944.894-2-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171117021944.894-1-jaedon.shin@gmail.com>
References: <20171117021944.894-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60980
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

Adds power management nodes to BCM7xxx MIPS based SoCs.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7346.dtsi | 45 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi | 45 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi | 45 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi | 72 ++++++++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi | 72 ++++++++++++++++++++++++++++++++++++
 5 files changed, 279 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index 02e426fe6013..8aa5b72d652d 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -243,6 +243,17 @@
 			brcm,irq-can-wake;
 		};
 
+		aon_ctrl: syscon@408000 {
+			compatible = "brcm,brcmstb-aon-ctrl";
+			reg = <0x408000 0x100>, <0x408200 0x200>;
+			reg-names = "aon-ctrl", "aon-sram";
+		};
+
+		timers: timer@4067c0 {
+			compatible = "brcm,brcmstb-timers";
+			reg = <0x4067c0 0x40>;
+		};
+
 		upg_gio: gpio@406700 {
 			compatible = "brcm,brcmstb-gpio";
 			reg = <0x406700 0x60>;
@@ -484,4 +495,38 @@
 			status = "disabled";
 		};
 	};
+
+	memory_controllers {
+		compatible = "simple-bus";
+		ranges = <0x0 0x103b0000 0xa000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		memory-controller@0 {
+			compatible = "brcm,brcmstb-memc", "simple-bus";
+			ranges = <0x0 0x0 0xa000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			memc-arb@1000 {
+				compatible = "brcm,brcmstb-memc-arb";
+				reg = <0x1000 0x248>;
+			};
+
+			memc-ddr@2000 {
+				compatible = "brcm,brcmstb-memc-ddr";
+				reg = <0x2000 0x300>;
+			};
+
+			ddr-phy@6000 {
+				compatible = "brcm,brcmstb-ddr-phy";
+				reg = <0x6000 0xc8>;
+			};
+
+			shimphy@8000 {
+				compatible = "brcm,brcmstb-ddr-shimphy";
+				reg = <0x8000 0x13c>;
+			};
+		};
+	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index 4b87ebec407a..f68285c2dff0 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -219,6 +219,17 @@
 			brcm,irq-can-wake;
 		};
 
+		aon_ctrl: syscon@408000 {
+			compatible = "brcm,brcmstb-aon-ctrl";
+			reg = <0x408000 0x100>, <0x408200 0x200>;
+			reg-names = "aon-ctrl", "aon-sram";
+		};
+
+		timers: timer@406680 {
+			compatible = "brcm,brcmstb-timers";
+			reg = <0x406680 0x40>;
+		};
+
 		upg_gio: gpio@406500 {
 			compatible = "brcm,brcmstb-gpio";
 			reg = <0x406500 0xa0>;
@@ -403,4 +414,38 @@
 			status = "disabled";
 		};
 	};
+
+	memory_controllers {
+		compatible = "simple-bus";
+		ranges = <0x0 0x103b0000 0xa000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		memory-controller@0 {
+			compatible = "brcm,brcmstb-memc", "simple-bus";
+			ranges = <0x0 0x0 0xa000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			memc-arb@1000 {
+				compatible = "brcm,brcmstb-memc-arb";
+				reg = <0x1000 0x248>;
+			};
+
+			memc-ddr@2000 {
+				compatible = "brcm,brcmstb-memc-ddr";
+				reg = <0x2000 0x300>;
+			};
+
+			ddr-phy@6000 {
+				compatible = "brcm,brcmstb-ddr-phy";
+				reg = <0x6000 0xc8>;
+			};
+
+			shimphy@8000 {
+				compatible = "brcm,brcmstb-ddr-shimphy";
+				reg = <0x8000 0x13c>;
+			};
+		};
+	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index ca657df34b6d..a4bfa5f2b006 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -215,6 +215,17 @@
 			brcm,irq-can-wake;
 		};
 
+		aon_ctrl: syscon@408000 {
+			compatible = "brcm,brcmstb-aon-ctrl";
+			reg = <0x408000 0x100>, <0x408200 0x200>;
+			reg-names = "aon-ctrl", "aon-sram";
+		};
+
+		timers: timer@406680 {
+			compatible = "brcm,brcmstb-timers";
+			reg = <0x406680 0x40>;
+		};
+
 		upg_gio: gpio@406500 {
 			compatible = "brcm,brcmstb-gpio";
 			reg = <0x406500 0xa0>;
@@ -399,4 +410,38 @@
 			status = "disabled";
 		};
 	};
+
+	memory_controllers {
+		compatible = "simple-bus";
+		ranges = <0x0 0x103b0000 0xa000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		memory-controller@0 {
+			compatible = "brcm,brcmstb-memc", "simple-bus";
+			ranges = <0x0 0x0 0xa000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			memc-arb@1000 {
+				compatible = "brcm,brcmstb-memc-arb";
+				reg = <0x1000 0x248>;
+			};
+
+			memc-ddr@2000 {
+				compatible = "brcm,brcmstb-memc-ddr";
+				reg = <0x2000 0x300>;
+			};
+
+			ddr-phy@6000 {
+				compatible = "brcm,brcmstb-ddr-phy";
+				reg = <0x6000 0xc8>;
+			};
+
+			shimphy@8000 {
+				compatible = "brcm,brcmstb-ddr-shimphy";
+				reg = <0x8000 0x13c>;
+			};
+		};
+	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index e4fb9b6e6dce..6cb535235efa 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -242,6 +242,17 @@
 			brcm,irq-can-wake;
 		};
 
+		aon_ctrl: syscon@408000 {
+			compatible = "brcm,brcmstb-aon-ctrl";
+			reg = <0x408000 0x100>, <0x408200 0x200>;
+			reg-names = "aon-ctrl", "aon-sram";
+		};
+
+		timers: timer@4067c0 {
+			compatible = "brcm,brcmstb-timers";
+			reg = <0x4067c0 0x40>;
+		};
+
 		upg_gio: gpio@406700 {
 			compatible = "brcm,brcmstb-gpio";
 			reg = <0x406700 0x80>;
@@ -495,4 +506,65 @@
 			status = "disabled";
 		};
 	};
+
+	memory_controllers {
+		compatible = "simple-bus";
+		ranges = <0x0 0x103b0000 0x1a000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		memory-controller@0 {
+			compatible = "brcm,brcmstb-memc", "simple-bus";
+			ranges = <0x0 0x0 0xa000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			memc-arb@1000 {
+				compatible = "brcm,brcmstb-memc-arb";
+				reg = <0x1000 0x248>;
+			};
+
+			memc-ddr@2000 {
+				compatible = "brcm,brcmstb-memc-ddr";
+				reg = <0x2000 0x300>;
+			};
+
+			ddr-phy@6000 {
+				compatible = "brcm,brcmstb-ddr-phy";
+				reg = <0x6000 0xc8>;
+			};
+
+			shimphy@8000 {
+				compatible = "brcm,brcmstb-ddr-shimphy";
+				reg = <0x8000 0x13c>;
+			};
+		};
+
+		memory-controller@1 {
+			compatible = "brcm,brcmstb-memc", "simple-bus";
+			ranges = <0x0 0x10000 0xa000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			memc-arb@1000 {
+				compatible = "brcm,brcmstb-memc-arb";
+				reg = <0x1000 0x248>;
+			};
+
+			memc-ddr@2000 {
+				compatible = "brcm,brcmstb-memc-ddr";
+				reg = <0x2000 0x300>;
+			};
+
+			ddr-phy@6000 {
+				compatible = "brcm,brcmstb-ddr-phy";
+				reg = <0x6000 0xc8>;
+			};
+
+			shimphy@8000 {
+				compatible = "brcm,brcmstb-ddr-shimphy";
+				reg = <0x8000 0x13c>;
+			};
+		};
+	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 1484e8990e52..1e0545c7f5b7 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -257,6 +257,17 @@
 			brcm,irq-can-wake;
 		};
 
+		aon_ctrl: syscon@408000 {
+			compatible = "brcm,brcmstb-aon-ctrl";
+			reg = <0x408000 0x100>, <0x408200 0x200>;
+			reg-names = "aon-ctrl", "aon-sram";
+		};
+
+		timers: timer@4067c0 {
+			compatible = "brcm,brcmstb-timers";
+			reg = <0x4067c0 0x40>;
+		};
+
 		upg_gio: gpio@406700 {
 			compatible = "brcm,brcmstb-gpio";
 			reg = <0x406700 0x80>;
@@ -510,4 +521,65 @@
 			status = "disabled";
 		};
 	};
+
+	memory_controllers {
+		compatible = "simple-bus";
+		ranges = <0x0 0x103b0000 0x1a000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		memory-controller@0 {
+			compatible = "brcm,brcmstb-memc", "simple-bus";
+			ranges = <0x0 0x0 0xa000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			memc-arb@1000 {
+				compatible = "brcm,brcmstb-memc-arb";
+				reg = <0x1000 0x248>;
+			};
+
+			memc-ddr@2000 {
+				compatible = "brcm,brcmstb-memc-ddr";
+				reg = <0x2000 0x300>;
+			};
+
+			ddr-phy@6000 {
+				compatible = "brcm,brcmstb-ddr-phy";
+				reg = <0x6000 0xc8>;
+			};
+
+			shimphy@8000 {
+				compatible = "brcm,brcmstb-ddr-shimphy";
+				reg = <0x8000 0x13c>;
+			};
+		};
+
+		memory-controller@1 {
+			compatible = "brcm,brcmstb-memc", "simple-bus";
+			ranges = <0x0 0x10000 0xa000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			memc-arb@1000 {
+				compatible = "brcm,brcmstb-memc-arb";
+				reg = <0x1000 0x248>;
+			};
+
+			memc-ddr@2000 {
+				compatible = "brcm,brcmstb-memc-ddr";
+				reg = <0x2000 0x300>;
+			};
+
+			ddr-phy@6000 {
+				compatible = "brcm,brcmstb-ddr-phy";
+				reg = <0x6000 0xc8>;
+			};
+
+			shimphy@8000 {
+				compatible = "brcm,brcmstb-ddr-shimphy";
+				reg = <0x8000 0x13c>;
+			};
+		};
+	};
 };
-- 
2.15.0
