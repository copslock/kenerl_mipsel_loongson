Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2017 17:17:21 +0200 (CEST)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:37477
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992215AbdI0PQQRrBFl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Sep 2017 17:16:16 +0200
Received: by mail-pf0-x241.google.com with SMTP id e69so7030441pfg.4;
        Wed, 27 Sep 2017 08:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=10Pb1mrCBXHmZYCX5ym4hREQ84BEAvBxr5n9TqHa2Ro=;
        b=LKoAGP4ytjC8bS3KUHIzzzJ2/qSJGPRVJDX9Kcz+sz/3PHbBd2YTi2OsxTVNkQWfFO
         nfUGapR2/XRFEUrRCSORswDpxek4q9RMDOji7II7spEFEywgnkcjWA/uWEFHYTIVY+jy
         MFPravIZMt3dfR3bsVqTetJZ7k+9mGFWjWuuoynS4if7fFyXE+8nVyQpFsSSUq315oMp
         uMiSf3OnRCLtkS7y23CmiW9MkPfNM/Nn1UjPTfZ6IpqqkCP/ZUxEiMk9BUYPNXkTKWZw
         uIldklItxRW7OskCH9fDcFdKqEUaOagq/ZzK/IedyLqTxULi41yHcFtMPGqw/kudcZAq
         FQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=10Pb1mrCBXHmZYCX5ym4hREQ84BEAvBxr5n9TqHa2Ro=;
        b=NuCK+IK4iYWiw6u3WPypzXsiBuuGhypa/rgC7y5Gu1anmzW6JnLIkoq1M5Os2HvqDh
         ja5+bzEWoD5FXI5E4G9VgwAXdslUij393keVQK0X1FNh8wdh4eU2QtO4oCz2Nqv94Ss5
         cPvB1Qy0E2xKVx+qpGtuWd/TIBpa1gRmtgTMDndwByzV2neV2jpttHl7B3rjk8ZqXkRW
         NxrASeXEPgauiCwrRASlnP0hm+z/g3iLHlLciNHmwXf8ZWfIT1amsc7NOoHkVzNSOZU2
         CO4Su8ezjMpWXSNkd+7hCG/w1ZgfLn6E4bSQ5j11Zj84Wc2xQDT7syrpuc2hnnCBZC43
         JrKA==
X-Gm-Message-State: AHPjjUiJ2JSWo+Sh8L71Sp1AS4vzCoe6Bj20NVyM/Nq0KDxhAtVrKFm0
        FfjZ5mldOgAVabeRKgNAqUs=
X-Google-Smtp-Source: AOwi7QDqjAshkFdBqAJ6GthovFVGkDC/Y5jz2mnvAyOWhLJ3YfshdiFKvH1sL1cdYsDzUgG5Zb51AQ==
X-Received: by 10.99.163.67 with SMTP id v3mr1632887pgn.206.1506525370149;
        Wed, 27 Sep 2017 08:16:10 -0700 (PDT)
Received: from linux.local ([42.109.141.25])
        by smtp.gmail.com with ESMTPSA id b65sm21289624pfj.97.2017.09.27.08.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 08:16:09 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, malat@debian.org, dom.peklo@gmail.com
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [RFC 3/4] MIPS: Ingenic: Initial X1000 SoC support
Date:   Wed, 27 Sep 2017 20:45:26 +0530
Message-Id: <20170927151527.25570-4-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Add initial Ingenic X1000 SoC support. Provide minimum necessary
information to boot kernel to an initramfs userspace.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 arch/mips/boot/dts/ingenic/x1000.dtsi | 93 +++++++++++++++++++++++++++++++++++
 arch/mips/jz4740/Kconfig              |  6 +++
 arch/mips/jz4740/time.c               |  2 +-
 3 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/boot/dts/ingenic/x1000.dtsi

diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
new file mode 100644
index 0000000..abbb9ec
--- /dev/null
+++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
@@ -0,0 +1,93 @@
+/*
+ * Copyright (C) 2016 PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <dt-bindings/clock/x1000-cgu.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ingenic,x1000";
+
+	cpuintc: interrupt-controller {
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		compatible = "mti,cpu-interrupt-controller";
+	};
+
+	intc: interrupt-controller@10001000 {
+		compatible = "ingenic,x1000-intc", "ingenic,jz4780-intc";
+		reg = <0x10001000 0x50>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <2>;
+	};
+
+	ext: ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	rtc: rtc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+
+	cgu: jz4780-cgu@10000000 {
+		compatible = "ingenic,x1000-cgu";
+		reg = <0x10000000 0x100>;
+
+		clocks = <&ext>, <&rtc>;
+		clock-names = "ext", "rtc";
+
+		#clock-cells = <1>;
+	};
+
+	uart0: serial@10030000 {
+		compatible = "ingenic,x1000-uart", "ingenic,jz4780-uart";
+		reg = <0x10030000 0x100>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <51>;
+
+		clocks = <&ext>, <&cgu X1000_CLK_UART0>;
+		clock-names = "baud", "module";
+
+		status = "disabled";
+	};
+
+	uart1: serial@10031000 {
+		compatible = "ingenic,x1000-uart", "ingenic,jz4780-uart";
+		reg = <0x10031000 0x100>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <50>;
+
+		clocks = <&ext>, <&cgu X1000_CLK_UART1>;
+		clock-names = "baud", "module";
+
+		status = "disabled";
+	};
+
+	uart2: serial@10032000 {
+		compatible = "ingenic,x1000-uart", "ingenic,jz4780-uart";
+		reg = <0x10032000 0x100>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <49>;
+
+		clocks = <&ext>, <&cgu X1000_CLK_UART2>;
+		clock-names = "baud", "module";
+
+		status = "disabled";
+	};
+};
diff --git a/arch/mips/jz4740/Kconfig b/arch/mips/jz4740/Kconfig
index 36f8201..338bc3f 100644
--- a/arch/mips/jz4740/Kconfig
+++ b/arch/mips/jz4740/Kconfig
@@ -22,3 +22,9 @@ config MACH_JZ4780
 	select MIPS_CPU_SCACHE
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_SUPPORTS_HIGHMEM
+
+config MACH_X1000
+	bool
+	select MIPS_CPU_SCACHE
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_HAS_EARLY_PRINTK
diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index bb1ad51..e28c734 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -113,7 +113,7 @@ static struct clock_event_device jz4740_clockevent = {
 #ifdef CONFIG_MACH_JZ4740
 	.irq = JZ4740_IRQ_TCU0,
 #endif
-#ifdef CONFIG_MACH_JZ4780
+#if defined CONFIG_MACH_JZ4780 || defined CONFIG_MACH_X1000
 	.irq = JZ4780_IRQ_TCU2,
 #endif
 };
-- 
2.10.0
