Return-Path: <SRS0=fNfu=SN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDBBC10F14
	for <linux-mips@archiver.kernel.org>; Thu, 11 Apr 2019 12:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF8D2083E
	for <linux-mips@archiver.kernel.org>; Thu, 11 Apr 2019 12:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="MVoBvzfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfDKMUo (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:20:44 -0400
Received: from forward102p.mail.yandex.net ([77.88.28.102]:56397 "EHLO
        forward102p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfDKMUo (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Thu, 11 Apr 2019 08:20:44 -0400
Received: from mxback18o.mail.yandex.net (mxback18o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::69])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id 8E00B1D40DEE;
        Thu, 11 Apr 2019 15:20:39 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback18o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id cIn8lcdc7U-KdXG4wLQ;
        Thu, 11 Apr 2019 15:20:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1554985239;
        bh=kKBpvcVvrtiH9aoD3v7PDFu3OKMew8i8TQqetv57afs=;
        h=In-Reply-To:Subject:To:From:Message-Id:Cc:References:Date;
        b=MVoBvzfSZMHBZZuffP/oshLTaXCLqJPNPOx3i+Lb+SvAVWj6rKuAyPYtLurX08gsX
         B8L/Yjjlp2sZBDhVjioVb6bkl4Pjgzvb96rCoOzg8uVPwQdZz+jl+1AGVjCyRCebCT
         fmFUh9rAbohWSZgEIpA5CjOcXSRLe6ZKHeemeJuU=
Authentication-Results: mxback18o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id QbB7ClwXzg-KWCm1uVT;
        Thu, 11 Apr 2019 15:20:37 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     devicetree@vger.kernel.org, paul.burton@mips.com,
        robh+dt@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 6/6] MIPS: Loongson32: dts: add ls1b & ls1c
Date:   Thu, 11 Apr 2019 20:19:15 +0800
Message-Id: <20190411121915.8040-7-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411121915.8040-1-jiaxun.yang@flygoat.com>
References: <20190312091520.8863-2-jiaxun.yang@flygoat.com>
 <20190411121915.8040-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add devicetree skeleton for ls1b and ls1c.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/boot/dts/loongson/Makefile  |   6 ++
 arch/mips/boot/dts/loongson/ls1b.dts  |  30 ++++++++
 arch/mips/boot/dts/loongson/ls1c.dts  |  34 +++++++++
 arch/mips/boot/dts/loongson/ls1x.dtsi | 103 ++++++++++++++++++++++++++
 4 files changed, 173 insertions(+)
 create mode 100644 arch/mips/boot/dts/loongson/Makefile
 create mode 100644 arch/mips/boot/dts/loongson/ls1b.dts
 create mode 100644 arch/mips/boot/dts/loongson/ls1c.dts
 create mode 100644 arch/mips/boot/dts/loongson/ls1x.dtsi

diff --git a/arch/mips/boot/dts/loongson/Makefile b/arch/mips/boot/dts/loongson/Makefile
new file mode 100644
index 000000000000..447801568f33
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_LOONGSON1_LS1B)	+= ls1b.dtb
+
+dtb-$(CONFIG_LOONGSON1_LS1B)	+= ls1c.dtb
+
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/loongson/ls1b.dts b/arch/mips/boot/dts/loongson/ls1b.dts
new file mode 100644
index 000000000000..11b516c77d22
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/ls1b.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+/dts-v1/;
+#include <ls1x.dtsi>
+
+/ {
+	model = "Loongson LS1B";
+
+	cpus {
+	#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "loongson,ls1b";
+			reg = <0>;
+		};
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
\ No newline at end of file
diff --git a/arch/mips/boot/dts/loongson/ls1c.dts b/arch/mips/boot/dts/loongson/ls1c.dts
new file mode 100644
index 000000000000..edca46234cfc
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/ls1c.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+/dts-v1/;
+#include <ls1x.dtsi>
+
+/ {
+	model = "Loongson LS1C";
+
+	cpus {
+	#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "loongson,ls1c";
+			reg = <0>;
+		};
+	};
+};
+
+&platintc4 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
\ No newline at end of file
diff --git a/arch/mips/boot/dts/loongson/ls1x.dtsi b/arch/mips/boot/dts/loongson/ls1x.dtsi
new file mode 100644
index 000000000000..1aca0c990fea
--- /dev/null
+++ b/arch/mips/boot/dts/loongson/ls1x.dtsi
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+/dts-v1/;
+#include <dt-bindings/interrupt-controller/irq.h>
+
+
+/ {
+    #address-cells = <1>;
+	#size-cells = <1>;
+
+	cpu_intc: interrupt-controller {
+		#address-cells = <0>;
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		compatible = "simple-bus";
+		ranges;
+
+
+		platintc0: interrupt-controller@1fd01040 {
+			compatible = "loongson,ls1x-intc";
+			reg = <0x1fd01040 0x18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <2>;
+		};
+
+		platintc1: interrupt-controller@1fd01058 {
+			compatible = "loongson,ls1x-intc";
+			reg = <0x1fd01058 0x18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <3>;
+		};
+
+		platintc2: interrupt-controller@1fd01070 {
+			compatible = "loongson,ls1x-intc";
+			reg = <0x1fd01070 0x18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <4>;
+		};
+
+		platintc3: interrupt-controller@1fd01088 {
+			compatible = "loongson,ls1x-intc";
+			reg = <0x1fd01088 0x18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <5>;
+		};
+
+		platintc4: interrupt-controller@1fd010a0 {
+			compatible = "loongson,ls1x-intc";
+			reg = <0x1fd010a0 0x18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <6>;
+			status = "disabled";
+		};
+
+		ehci0: usb@1fe20000 {
+			compatible = "generic-ehci";
+			reg = <0x1fe20000 0x100>;
+			interrupt-parent = <&platintc1>;
+			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			};
+
+		ohci0: usb@1fe28000 {
+			compatible = "generic-ohci";
+			reg = <0x1fe28000 0x100>;
+			interrupt-parent = <&platintc1>;
+			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			};
+
+	};
+};
-- 
2.21.0

