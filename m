Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2012 13:53:35 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:60585 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826612Ab2KKMutfkFGo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2012 13:50:49 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so2053447bkw.36
        for <multiple recipients>; Sun, 11 Nov 2012 04:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hl4KHNEtFQFf1J2mWzt0qkKhxmiZuO00eunggusDmLE=;
        b=xaIrzXWbMUl4f9oqIPDiCcGjZa4zP+aQAtCb1MWt7MLjNWhOn1hotIImX0/TTIyJPm
         epBHspa3+lxqruHgk25mGH5dziwmwlujn+ou6z05v2LQ1p/f1s8erNEND9XKqZnrnopc
         9TMbELa89BI6QzcvD+rSI+CKn/qgrRaS56+NeT8uJHveTzTS29lLpIlm8KPU1o63P9pX
         5JlL3q19D0yZ8VFGkLDAQ94hPQM9teq7QajOSrSuIFvtS13/AtE0y1l6OCXgwT0wBbEn
         SUAc4cuVlhB2suRXAA5Dl1pccwG8b3dB3ug2cCD/8fuUAIb9MmB6VihcD/S/Yxw+SpbI
         mSkQ==
Received: by 10.204.150.209 with SMTP id z17mr5946248bkv.8.1352638249324;
        Sun, 11 Nov 2012 04:50:49 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id z22sm1436133bkw.2.2012.11.11.04.50.47
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 04:50:48 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC] MIPS: BCM63XX: add Device Tree clock definitions
Date:   Sun, 11 Nov 2012 13:50:43 +0100
Message-Id: <1352638249-29298-10-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 34940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Add definitions for the clocks found and used in all supported SoCs.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/dts/bcm6328.dtsi |   90 ++++++++++++++++++++++++++
 arch/mips/bcm63xx/dts/bcm6338.dtsi |   47 +++++++++++++
 arch/mips/bcm63xx/dts/bcm6345.dtsi |   33 ++++++++++
 arch/mips/bcm63xx/dts/bcm6348.dtsi |   54 +++++++++++++++
 arch/mips/bcm63xx/dts/bcm6358.dtsi |   85 ++++++++++++++++++++++++
 arch/mips/bcm63xx/dts/bcm6368.dtsi |  125 ++++++++++++++++++++++++++++++++++++
 6 files changed, 434 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm63xx/dts/bcm6328.dtsi b/arch/mips/bcm63xx/dts/bcm6328.dtsi
index a41033a..9055187 100644
--- a/arch/mips/bcm63xx/dts/bcm6328.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6328.dtsi
@@ -41,6 +41,96 @@
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
+
+			clocks {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				periph: pll {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-frequency = <50000000>;
+					clock-output-names = "periph";
+				};
+
+				phymips: clock@0 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "phymips";
+					brcm,gate-bit = <0>;
+				};
+
+				adsl_qproc: clock@1 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "adsl-qproc";
+					brcm,gate-bit = <1>;
+				};
+
+				adsl_afe: clock@2 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "adsl-afe";
+					brcm,gate-bit = <2>;
+				};
+
+				adsl: clock@3 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "adsl";
+					brcm,gate-bit = <3>;
+				};
+
+				sar: clock@5 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "sar", "xtm";
+					brcm,gate-bit = <5>;
+				};
+
+				pcm: clock@6 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "pcm";
+					brcm,gate-bit = <6>;
+				};
+
+				usbd: clock@7 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "usbd";
+					brcm,gate-bit = <7>;
+				};
+
+				usbh: clock@8 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "usbh";
+					brcm,gate-bit = <8>;
+				};
+
+				hsspi: clock@9 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "hsspi";
+					clock-frequency = <133333333>;
+					brcm,gate-bit = <9>;
+				};
+
+				pcie: clock@10 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "pcie";
+					brcm,gate-bit = <10>;
+				};
+
+				enetsw: clock@11 {
+					compatible = "brcm,bcm63xx-enetsw-clock";
+					#clock-cells = <0>;
+					clock-output-names = "enetsw";
+					brcm,gate-bit = <11>;
+				};
+			};
 		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/bcm6338.dtsi b/arch/mips/bcm63xx/dts/bcm6338.dtsi
index 8ecbc4f..6346a7e 100644
--- a/arch/mips/bcm63xx/dts/bcm6338.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6338.dtsi
@@ -41,6 +41,53 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 			};
+
+			clocks {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				periph: pll {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-frequency = <50000000>;
+					clock-output-names = "periph";
+				};
+
+				adsl: clock@0 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "adsl";
+					brcm,gate-bit = <0>;
+				};
+
+				mpi: clock@1 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "mpi";
+					brcm,gate-bit = <1>;
+				};
+
+				enet_usbd: clock@5 {
+					#clock-cells = <0>;
+					compatible = "brcm,bcm63xx-clock";
+					clock-output-names = "enet", "enet0", "usbd";
+					brcm,gate-bit = <5>;
+				};
+
+				sar: clock@6 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "sar", "atm";
+					brcm,gate-bit = <6>;
+				};
+
+				spi: clock@7 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "spi";
+					brcm,gate-bit = <9>;
+				};
+			};
 		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/bcm6345.dtsi b/arch/mips/bcm63xx/dts/bcm6345.dtsi
index ed17c12..1771775 100644
--- a/arch/mips/bcm63xx/dts/bcm6345.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6345.dtsi
@@ -41,6 +41,39 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 			};
+
+			clocks {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				periph: pll {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-frequency = <50000000>;
+					clock-output-names = "periph";
+				};
+
+				adsl: clock@4 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "adsl";
+					brcm,gate-bit = <4>;
+				};
+
+				enet: clock@5 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "enet", "enet0";
+					brcm,gate-bit = <5>;
+				};
+
+				usbd: clock@6 {
+					#clock-cells = <0>;
+					compatible = "brcm,bcm63xx-clock";
+					clock-output-names = "usbd";
+					brcm,gate-bit = <6>;
+				};
+			};
 		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/bcm6348.dtsi b/arch/mips/bcm63xx/dts/bcm6348.dtsi
index d54cf20..14f1996 100644
--- a/arch/mips/bcm63xx/dts/bcm6348.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6348.dtsi
@@ -41,6 +41,60 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 			};
+
+			clocks {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				periph: pll {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-frequency = <50000000>;
+					clock-output-names = "periph";
+				};
+
+				adsl: clock@0 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "adsl";
+					brcm,gate-bit = <0>;
+				};
+
+				enet: clock@4 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "enet", "enet0", "enet1";
+					brcm,gate-bit = <4>;
+				};
+
+				sar: clock@5 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "sar", "atm";
+					brcm,gate-bit = <5>;
+				};
+
+				usbd: clock@6 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "usbd";
+					brcm,gate-bit = <6>;
+				};
+
+				usbh: clock@7 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "usbh";
+					brcm,gate-bit = <7>;
+				};
+
+				spi: clock@8 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "spi";
+					brcm,gate-bit = <8>;
+				};
+			};
 		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/bcm6358.dtsi b/arch/mips/bcm63xx/dts/bcm6358.dtsi
index 6ef283f..943b480 100644
--- a/arch/mips/bcm63xx/dts/bcm6358.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6358.dtsi
@@ -44,6 +44,91 @@
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
+
+			clocks {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				periph: pll {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-frequency = <50000000>;
+					clock-output-names = "periph";
+				};
+
+				adslphy: clock@5 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "adslphy";
+					brcm,gate-bit = <5>;
+				};
+
+				pcm: clock@8 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "pcm";
+					brcm,gate-bit = <8>;
+				};
+
+				spi: clock@9 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "spi";
+					brcm,gate-bit = <9>;
+				};
+
+				usbd: clock@10 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "usbd";
+					brcm,gate-bit = <10>;
+				};
+
+				sar: clock@11 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "sar", "atm";
+					brcm,gate-bit = <11>;
+				};
+
+
+				enet_misc: clock@17 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "enet-misc";
+					brcm,gate-bit = <17>;
+				};
+
+				enet0: clock@18 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <1>;
+					clocks = <&enet_misc>;
+					clock-output-names = "enet0";
+					brcm,gate-bit = <18>;
+				};
+
+				enet1: clock@19 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <1>;
+					clocks = <&enet_misc>;
+					clock-output-names = "enet1";
+					brcm,gate-bit = <19>;
+				};
+
+				usbsu: clock@20 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "usbsu";
+					brcm,gate-bit = <20>;
+				};
+
+				ephy: clock@21 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "ephy";
+					brcm,gate-bit = <21>;
+				};
+			};
 		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/bcm6368.dtsi b/arch/mips/bcm63xx/dts/bcm6368.dtsi
index ae1b584..2156be0 100644
--- a/arch/mips/bcm63xx/dts/bcm6368.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6368.dtsi
@@ -44,6 +44,131 @@
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
+
+			clocks {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				periph: pll {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-frequency = <50000000>;
+					clock-output-names = "periph";
+				};
+
+				vdsl_qproc: clock@2 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "vdsl-qproc";
+					brcm,gate-bit = <2>;
+				};
+
+				vdsl_afe: clock@3 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "vdsl-afe";
+					brcm,gate-bit = <3>;
+				};
+
+				vdsl_bonding: clock@4 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "vdsl-bonding";
+					brcm,gate-bit = <4>;
+				};
+
+				vdsl: clock@5 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "vdsl";
+					brcm,gate-bit = <5>;
+				};
+
+				phymips: clock@6 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "phymips";
+					brcm,gate-bit = <6>;
+				};
+
+				enetsw_usb: clock@7 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "enetsw-usb";
+					brcm,gate-bit = <7>;
+				};
+
+				enetsw_sar: clock@8 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "enetsw-sar";
+					brcm,gate-bit = <8>;
+				};
+
+				spi: clock@9 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "spi";
+					brcm,gate-bit = <9>;
+				};
+
+				usbd: clock@10 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "usbd";
+					brcm,gate-bit = <10>;
+				};
+
+				sar: clock@11 {
+					compatible = "brcm,bcm63xx-sar-clock";
+					#clock-cells = <1>;
+					clocks = <&enetsw_sar>;
+					clock-output-names = "sar";
+					brcm,gate-bit = <11>;
+				};
+
+				enetsw: clock@12 {
+					compatible = "brcm,bcm6368-enetsw-clock";
+					#clock-cells = <0>;
+					clock-output-names = "enetsw";
+					brcm,gate-bit = <12>;
+				};
+
+				utopia: clock@13 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "utopia";
+					brcm,gate-bit = <13>;
+				};
+
+				pcm: clock@14 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "pcm";
+					brcm,gate-bit = <14>;
+				};
+
+				usbh: clock@15 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "usbh";
+					brcm,gate-bit = <15>;
+				};
+
+				nand: clock@17 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "nand";
+					brcm,gate-bit = <17>;
+				};
+
+				ipsec: clock@18 {
+					compatible = "brcm,bcm63xx-clock";
+					#clock-cells = <0>;
+					clock-output-names = "ipsec";
+					brcm,gate-bit = <18>;
+				};
+			};
 		};
 	};
 };
-- 
1.7.2.5
