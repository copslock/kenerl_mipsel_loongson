Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2016 11:59:12 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36236 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992489AbcHCJ6YhHlw0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Aug 2016 11:58:24 +0200
Received: by mail-wm0-f67.google.com with SMTP id x83so35402743wma.3;
        Wed, 03 Aug 2016 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SjCO2MRUQXNvzl9WBWB8RcaHz7AC592Hd4JJe12v8y0=;
        b=CC9/Hylt3UlkqAKJec3r7XSd7ALKZUm3M7xjmfjsKyV4Ni07wF34fBCu9BVh6wupbn
         O79aKcjh/SH8i66Qc3Uk0vbNEEsvOPSnmwOiUnUVeUHBueJ6D0Hd5Z0BhlvQAAmpbGiV
         woyD1iGfpWPc2R1mYEtzg8IWe1JYueC3yHgoxqQ0PHRsDhRrZQvAzKyikzQaR7INELi6
         J3ZETQdT+3FnU7Xus/X3I1ZP7nQEXzTujPrh/xjlNR7dJMntRRiZQ8JDR2PjWp13s6c6
         3BMocCb7AZmnqDFPETGeY/5ijA7BuXtmDcsKMA0zpUVz8X3FE+nr0OywU8pZloZm57WQ
         gV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SjCO2MRUQXNvzl9WBWB8RcaHz7AC592Hd4JJe12v8y0=;
        b=RtsUqIx4vdjD3+snfH1HLBd/Fbq27frNzDF+x0UsdYBJdUsvqWFibL4W+CQHPOKSZ5
         WO/uRJHopEqXb6FvX/SVZuHF5UbFwhE3q8gkef9OV9qIrX0SCV6SS4oJPuj01uvb5TLk
         +2WE09bjLasYssc5pxytMFytK4sFh8bs4LnqmhWyefePsRzZVWHLzIxPOetWRkGTxu7/
         D1PHqouJi9QWnulxJoN5TitIipXUUzJR7ZgT0Y0F+FLOcFQ4dfcN87icz7C4BlkZ38/e
         rnuOUluGG8yKhd/tTyU/YP9f3v6nXUttbWRfN2rdcASpIZ4N5T7jd7z7copw4RIVVkC2
         E/Wg==
X-Gm-Message-State: AEkoousfk6SGs1Jx7Z/sRjJm9RRFPNXNtt+7J2aLyjeG41P8cgXuUO6ES8cxwkn4N6C8UQ==
X-Received: by 10.194.187.134 with SMTP id fs6mr31526583wjc.3.1470218297776;
        Wed, 03 Aug 2016 02:58:17 -0700 (PDT)
Received: from localhost.localdomain (219.red-83-55-40.dynamicip.rima-tde.net. [83.55.40.219])
        by smtp.gmail.com with ESMTPSA id d80sm26368107wmd.14.2016.08.03.02.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 02:58:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu, john@phrozen.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 2/7] MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom
Date:   Wed,  3 Aug 2016 11:58:25 +0200
Message-Id: <1470218310-2978-2-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

The prefix bcm9* should only be used for reference and evaluation boards from
Broadcom.
Also adds missing console output to bootargs.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/bmips/Kconfig                            |  8 ++--
 arch/mips/boot/dts/brcm/Makefile                   |  3 +-
 .../boot/dts/brcm/bcm6358-neufbox4-sercomm.dts     | 47 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm96358nb4ser.dts         | 46 ---------------------
 4 files changed, 53 insertions(+), 51 deletions(-)
 create mode 100644 arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dts
 delete mode 100644 arch/mips/boot/dts/brcm/bcm96358nb4ser.dts

diff --git a/arch/mips/bmips/Kconfig b/arch/mips/bmips/Kconfig
index 264328d..c8f1427 100644
--- a/arch/mips/bmips/Kconfig
+++ b/arch/mips/bmips/Kconfig
@@ -21,10 +21,6 @@ config DT_BCM93384WVG_VIPER
 	bool "BCM93384WVG Viper CPU (EXPERIMENTAL)"
 	select BUILTIN_DTB
 
-config DT_BCM96358NB4SER
-	bool "BCM96358NB4SER"
-	select BUILTIN_DTB
-
 config DT_BCM96368MVWG
 	bool "BCM96368MVWG"
 	select BUILTIN_DTB
@@ -65,6 +61,10 @@ config DT_BCM97435SVMB
 	bool "BCM97435SVMB"
 	select BUILTIN_DTB
 
+config DT_SFR_NEUFBOX4_SERCOMM
+	bool "SFR Neufbox 4 (Sercomm)"
+	select BUILTIN_DTB
+
 endchoice
 
 endif
diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index 87e07e2..0abe298 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -1,6 +1,5 @@
 dtb-$(CONFIG_DT_BCM93384WVG)		+= bcm93384wvg.dtb
 dtb-$(CONFIG_DT_BCM93384WVG_VIPER)	+= bcm93384wvg_viper.dtb
-dtb-$(CONFIG_DT_BCM96358NB4SER)		+= bcm96358nb4ser.dtb
 dtb-$(CONFIG_DT_BCM96368MVWG)		+= bcm96368mvwg.dtb
 dtb-$(CONFIG_DT_BCM9EJTAGPRB)		+= bcm9ejtagprb.dtb
 dtb-$(CONFIG_DT_BCM97125CBMB)		+= bcm97125cbmb.dtb
@@ -11,8 +10,10 @@ dtb-$(CONFIG_DT_BCM97362SVMB)		+= bcm97362svmb.dtb
 dtb-$(CONFIG_DT_BCM97420C)		+= bcm97420c.dtb
 dtb-$(CONFIG_DT_BCM97425SVMB)		+= bcm97425svmb.dtb
 dtb-$(CONFIG_DT_BCM97435SVMB)		+= bcm97435svmb.dtb
+dtb-$(CONFIG_DT_SFR_NEUFBOX4_SERCOMM)	+= bcm6358-neufbox4-sercomm.dtb
 
 dtb-$(CONFIG_DT_NONE) += \
+	bcm6358-neufbox4-sercomm.dtb \
 	bcm93384wvg.dtb \
 	bcm93384wvg_viper.dtb \
 	bcm96358nb4ser.dtb \
diff --git a/arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dts b/arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dts
new file mode 100644
index 0000000..702eae2
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm6358-neufbox4-sercomm.dts
@@ -0,0 +1,47 @@
+/dts-v1/;
+
+/include/ "bcm6358.dtsi"
+
+/ {
+	compatible = "sfr,nb4-ser", "brcm,bcm6358";
+	model = "SFR Neufbox 4 (Sercomm)";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x02000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+};
+
+&leds0 {
+	status = "ok";
+
+	led@0 {
+		reg = <0>;
+		active-low;
+		label = "nb4-ser:white:alarm";
+	};
+	led@2 {
+		reg = <2>;
+		active-low;
+		label = "nb4-ser:white:tv";
+	};
+	led@3 {
+		reg = <3>;
+		active-low;
+		label = "nb4-ser:white:tel";
+	};
+	led@4 {
+		reg = <4>;
+		active-low;
+		label = "nb4-ser:white:adsl";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
deleted file mode 100644
index f412117..0000000
--- a/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
+++ /dev/null
@@ -1,46 +0,0 @@
-/dts-v1/;
-
-/include/ "bcm6358.dtsi"
-
-/ {
-	compatible = "sfr,nb4-ser", "brcm,bcm6358";
-	model = "SFR Neufbox 4 (Sercomm)";
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x00000000 0x02000000>;
-	};
-
-	chosen {
-		stdout-path = &uart0;
-	};
-};
-
-&leds0 {
-	status = "ok";
-
-	led@0 {
-		reg = <0>;
-		active-low;
-		label = "nb4-ser:white:alarm";
-	};
-	led@2 {
-		reg = <2>;
-		active-low;
-		label = "nb4-ser:white:tv";
-	};
-	led@3 {
-		reg = <3>;
-		active-low;
-		label = "nb4-ser:white:tel";
-	};
-	led@4 {
-		reg = <4>;
-		active-low;
-		label = "nb4-ser:white:adsl";
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
-- 
2.1.4
