Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2012 13:54:51 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:60585 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826614Ab2KKMu4lOzES (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2012 13:50:56 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so2053447bkw.36
        for <multiple recipients>; Sun, 11 Nov 2012 04:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Xtk2b/3YFVCckSufDhJzdSrIIgwSlg8ICrglAmfTk50=;
        b=ufsiHw4MEyuBcWrdkhQJ1KdM7cciiiuMRmkUcnHYwjPcI2NqtBZpxNdyGv9Pq+Ik9f
         xlv548jE4cNknjqIzWHX95Ylk/qklnFT8Ikjr+hmq+m+Myc72qOeXn7nL1HVKV1VQmnl
         vSj8GGbWQqhnvRbuiGy/5Bk578ffJ+uL2dLAkEYnkRPYM2IFJYnmZ6B0F+sjOoh9iGcp
         TmAGhdlCfgjRHCKe88Tu79qihYoed/TABDwKeg2uGlmxoQItpIXRPVh2fqw2wBDdR3EU
         LNiw4dKmy/eF/kRssBxRnvSjmZ5fmqmXwlHGyJqgHLN4KKY75poljyedp6eYytSqkvDK
         sbTQ==
Received: by 10.204.8.195 with SMTP id i3mr5869889bki.120.1352638256452;
        Sun, 11 Nov 2012 04:50:56 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id z22sm1436133bkw.2.2012.11.11.04.50.54
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 04:50:55 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC] MIPS: BCM63XX: add serial blocks to Device Tree includes
Date:   Sun, 11 Nov 2012 13:50:47 +0100
Message-Id: <1352638249-29298-14-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 34944
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

Add the serial block to the Device Tree includes for all SoCs.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/dts/bcm6328.dtsi |   14 ++++++++++++++
 arch/mips/bcm63xx/dts/bcm6338.dtsi |    7 +++++++
 arch/mips/bcm63xx/dts/bcm6345.dtsi |    8 ++++++++
 arch/mips/bcm63xx/dts/bcm6348.dtsi |    7 +++++++
 arch/mips/bcm63xx/dts/bcm6358.dtsi |   14 ++++++++++++++
 arch/mips/bcm63xx/dts/bcm6368.dtsi |   14 ++++++++++++++
 6 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm63xx/dts/bcm6328.dtsi b/arch/mips/bcm63xx/dts/bcm6328.dtsi
index e2e92c3..d29d43c 100644
--- a/arch/mips/bcm63xx/dts/bcm6328.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6328.dtsi
@@ -140,5 +140,19 @@
 			#gpio-cells = <2>;
 			ngpio = <32>;
 		};
+
+		uart0: serial@100 {
+			compatible = "brcm,bcm63xx-uart";
+			reg = <0x100 0x18>;
+			interrupts = <28>;
+			status = "disabled";
+		};
+
+		uart1: serial@120 {
+			compatible = "brcm,bcm63xx-uart";
+			reg = <0x120 0x18>;
+			interrupts = <39>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/bcm6338.dtsi b/arch/mips/bcm63xx/dts/bcm6338.dtsi
index 28e7cb6..c7b45c1 100644
--- a/arch/mips/bcm63xx/dts/bcm6338.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6338.dtsi
@@ -90,6 +90,13 @@
 			};
 		};
 
+		uart0: serial@300 {
+			compatible = "brcm,bcm63xx-uart";
+			reg = <0x300 0x18>;
+			interrupts = <2>;
+			status = "disabled";
+		};
+
 		gpio0: gpio@400 {
 			compatible = "brcm,bcm63xx-gpio";
 			reg = <0x400 0x80>;
diff --git a/arch/mips/bcm63xx/dts/bcm6345.dtsi b/arch/mips/bcm63xx/dts/bcm6345.dtsi
index 1ebc024..055f66c 100644
--- a/arch/mips/bcm63xx/dts/bcm6345.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6345.dtsi
@@ -75,6 +75,14 @@
 				};
 			};
 		};
+
+		uart0: serial@300 {
+			compatible = "brcm,bcm63xx-uart";
+			reg = <0x300 0x18>;
+			interrupts = <2>;
+			status = "disabled";
+		};
+
 		gpio0: gpio@400 {
 			compatible = "brcm,bcm63xx-gpio";
 			reg = <0x400 0x80>;
diff --git a/arch/mips/bcm63xx/dts/bcm6348.dtsi b/arch/mips/bcm63xx/dts/bcm6348.dtsi
index 89acec7..5d1d10a 100644
--- a/arch/mips/bcm63xx/dts/bcm6348.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6348.dtsi
@@ -97,6 +97,13 @@
 			};
 		};
 
+		uart0: serial@300 {
+			compatible = "brcm,bcm63xx-uart";
+			reg = <0x300 0x18>;
+			interrupts = <2>;
+			status = "disabled";
+		};
+
 		gpio0: gpio@400 {
 			compatible = "brcm,bcm63xx-gpio";
 			regs = <0x400 0x80>;
diff --git a/arch/mips/bcm63xx/dts/bcm6358.dtsi b/arch/mips/bcm63xx/dts/bcm6358.dtsi
index 52170d6..702882d 100644
--- a/arch/mips/bcm63xx/dts/bcm6358.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6358.dtsi
@@ -138,5 +138,19 @@
 			#gpio-cells = <2>;
 			ngpio = <40>;
 		};
+
+		uart0: serial@100 {
+			compatible = "brcm,bcm63xx-uart";
+			reg = <0x100 0x18>;
+			interrupts = <2>;
+			status = "disabled";
+		};
+
+		uart1: serial@120 {
+			compatible = "brcm,bcm63xx-uart";
+			reg = <0x120 0x18>;
+			interrupts = <3>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/bcm6368.dtsi b/arch/mips/bcm63xx/dts/bcm6368.dtsi
index 068231b..82cd030 100644
--- a/arch/mips/bcm63xx/dts/bcm6368.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6368.dtsi
@@ -178,5 +178,19 @@
 			#gpio-cells = <2>;
 			ngpio = <38>;
 		};
+
+		uart0: serial@100 {
+			compatible = "brcm,bcm63xx-uart";
+			reg = <0x100 0x18>;
+			interrupts = <2>;
+			status = "disabled";
+		};
+
+		uart1: serial@120 {
+			compatible = "brcm,bcm63xx-uart";
+			reg = <0x120 0x18>;
+			interrupts = <3>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.2.5
