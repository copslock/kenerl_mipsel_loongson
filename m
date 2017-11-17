Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 03:20:58 +0100 (CET)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:42012
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992910AbdKQCUIqNhZV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 03:20:08 +0100
Received: by mail-pg0-x241.google.com with SMTP id j16so803240pgn.9;
        Thu, 16 Nov 2017 18:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8DmSFBjvG+m9llrc6NA6YP/ALnh8Tdkd8ZcgMhJRxgM=;
        b=aFAuSnDwwHUmYSkr3CkLWxF127oNyJpqK9fmPT4F8fwSbObZy0yo2XOuV4aFL/Wir2
         BEi4iWraBxx7216TOehaPSUoI20hOyivDE3O2GFkgFyitcXGjpHytcujQuiZGXJ+ifir
         IZauKRQcu6nEiSIKd5JBaNr+EO5wfWMQ8m6LWms4NUdQqu1z44OpgIlHoHbNc3VMzWQ+
         77EX0kWat81BGhKDlcGijnVWYZT/zTWScexlioCxVJus0N9IyxYWr+NbHK9dPnwasr44
         j/2vdYKLJEagUuEfHnH8YvfWKFOuxzlAcMWqAq39fxpC4weCTsZBypQxRIHxqP58AgN/
         MG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8DmSFBjvG+m9llrc6NA6YP/ALnh8Tdkd8ZcgMhJRxgM=;
        b=stHpZD6xbx9ABbSwC8RAOOE+szd6GUWA7StYEf5pZyEaLo23xJIZFo/NRYg2ONA9h5
         WNmlbS4kiIe8XjQmIqkRxu9o4gJP5/ZlfLFXIBgbzIA/pG/aNin5dApKTrbULLTs7G1b
         REt74y7r8xyhVKa/Fv+6NpKbfdLuREPcU78MZlX9uuQYOwAUWPacmPbVBEWRg+RtJMSV
         NSvgTpCKqyK5Am/IJSu8Td3ujW5QKZO/jkztUapGDawQqk+46GLcGZMLvKfn2n9h7Nkh
         uj66CxBlJkxgpnbUYZGb5JANOoSzVhmcOPmzz3tnq9fWXNev6VTzwsKJSjDZ/mdZh7r8
         LOcQ==
X-Gm-Message-State: AJaThX6tPyBV/ag42OS+q9HgMb1M2/4JDImnLCWzgD3Kdz1gbJqyErUa
        s+fOTRJWUlPNNbXu8oaB2+zz6QHA
X-Google-Smtp-Source: AGs4zMZK0OPdYY+DhwyrLmh9/XiRT6yiCZRDaX+py4+1jhXgiSf2+GF0JTe6MPixaNBxmmZ2x+Kt4w==
X-Received: by 10.99.177.8 with SMTP id r8mr3598687pgf.237.1510885202156;
        Thu, 16 Nov 2017 18:20:02 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id s4sm5393280pgp.40.2017.11.16.18.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2017 18:20:01 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 2/3] MIPS: BMIPS: Add Broadcom STB wake-up timer nodes
Date:   Fri, 17 Nov 2017 11:19:43 +0900
Message-Id: <20171117021944.894-3-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171117021944.894-1-jaedon.shin@gmail.com>
References: <20171117021944.894-1-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60981
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

Adds wake-up timer device nodes to BCM7xxx MIPS based SoCs.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 10 ++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi      | 10 ++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 10 ++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 10 ++++++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi      | 10 ++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi      | 10 ++++++++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  4 ++++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts  |  4 ++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  |  4 ++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  4 ++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts  |  4 ++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts  |  4 ++++
 12 files changed, 84 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7346.dtsi b/arch/mips/boot/dts/brcm/bcm7346.dtsi
index 8aa5b72d652d..228184dedada 100644
--- a/arch/mips/boot/dts/brcm/bcm7346.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7346.dtsi
@@ -494,6 +494,16 @@
 			interrupt-names = "mspi_done";
 			status = "disabled";
 		};
+
+		waketimer: waketimer@408e80 {
+			compatible = "brcm,brcmstb-waketimer";
+			reg = <0x408e80 0x14>;
+			interrupts = <0x3>;
+			interrupt-parent = <&aon_pm_l2_intc>;
+			interrupt-names = "timer";
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
 	};
 
 	memory_controllers {
diff --git a/arch/mips/boot/dts/brcm/bcm7358.dtsi b/arch/mips/boot/dts/brcm/bcm7358.dtsi
index 1089d6ebc841..398521c7070f 100644
--- a/arch/mips/boot/dts/brcm/bcm7358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7358.dtsi
@@ -362,5 +362,15 @@
 			interrupt-names = "mspi_done";
 			status = "disabled";
 		};
+
+		waketimer: waketimer@408e80 {
+			compatible = "brcm,brcmstb-waketimer";
+			reg = <0x408e80 0x14>;
+			interrupts = <0x3>;
+			interrupt-parent = <&aon_pm_l2_intc>;
+			interrupt-names = "timer";
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7360.dtsi b/arch/mips/boot/dts/brcm/bcm7360.dtsi
index f68285c2dff0..28f5a0c1c149 100644
--- a/arch/mips/boot/dts/brcm/bcm7360.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7360.dtsi
@@ -413,6 +413,16 @@
 			interrupt-names = "mspi_done";
 			status = "disabled";
 		};
+
+		waketimer: waketimer@408e80 {
+			compatible = "brcm,brcmstb-waketimer";
+			reg = <0x408e80 0x14>;
+			interrupts = <0x3>;
+			interrupt-parent = <&aon_pm_l2_intc>;
+			interrupt-names = "timer";
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
 	};
 
 	memory_controllers {
diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index a4bfa5f2b006..ab2dd57571a0 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -409,6 +409,16 @@
 			interrupt-names = "mspi_done";
 			status = "disabled";
 		};
+
+		waketimer: waketimer@408e80 {
+			compatible = "brcm,brcmstb-waketimer";
+			reg = <0x408e80 0x14>;
+			interrupts = <0x3>;
+			interrupt-parent = <&aon_pm_l2_intc>;
+			interrupt-names = "timer";
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
 	};
 
 	memory_controllers {
diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index 6cb535235efa..23479f988aa5 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -505,6 +505,16 @@
 			interrupt-names = "mspi_done";
 			status = "disabled";
 		};
+
+		waketimer: waketimer@409580 {
+			compatible = "brcm,brcmstb-waketimer";
+			reg = <0x409580 0x14>;
+			interrupts = <0x3>;
+			interrupt-parent = <&aon_pm_l2_intc>;
+			interrupt-names = "timer";
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
 	};
 
 	memory_controllers {
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 1e0545c7f5b7..af75b0123c06 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -520,6 +520,16 @@
 			interrupt-names = "mspi_done";
 			status = "disabled";
 		};
+
+		waketimer: waketimer@409580 {
+			compatible = "brcm,brcmstb-waketimer";
+			reg = <0x409580 0x14>;
+			interrupts = <0x3>;
+			interrupt-parent = <&aon_pm_l2_intc>;
+			interrupt-names = "timer";
+			clocks = <&upg_clk>;
+			status = "disabled";
+		};
 	};
 
 	memory_controllers {
diff --git a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
index 9e7d5228f2b7..b50dbb3cbeee 100644
--- a/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97346dbsmb.dts
@@ -114,3 +114,7 @@
 &mspi {
 	status = "okay";
 };
+
+&waketimer {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97358svmb.dts b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
index 708207a0002d..2986ce353e57 100644
--- a/arch/mips/boot/dts/brcm/bcm97358svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97358svmb.dts
@@ -106,3 +106,7 @@
 &mspi {
 	status = "okay";
 };
+
+&waketimer {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97360svmb.dts b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
index 73c6dc9c8c6d..8d48ae317b8c 100644
--- a/arch/mips/boot/dts/brcm/bcm97360svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97360svmb.dts
@@ -109,3 +109,7 @@
 &mspi {
 	status = "okay";
 };
+
+&waketimer {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
index 37bacfdcf9d9..4a1d0631e9e6 100644
--- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
@@ -78,3 +78,7 @@
 &mspi {
 	status = "okay";
 };
+
+&waketimer {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
index ce762c7b2e54..488e12a9e4aa 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -144,3 +144,7 @@
 &mspi {
 	status = "okay";
 };
+
+&waketimer {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index d4dd31a543fd..e14337cc51fd 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -120,3 +120,7 @@
 &mspi {
 	status = "okay";
 };
+
+&waketimer {
+	status = "okay";
+};
-- 
2.15.0
