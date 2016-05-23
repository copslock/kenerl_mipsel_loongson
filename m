Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 13:39:15 +0200 (CEST)
Received: from mail-lb0-f194.google.com ([209.85.217.194]:34637 "EHLO
        mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033403AbcEWLjNAUMQb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 May 2016 13:39:13 +0200
Received: by mail-lb0-f194.google.com with SMTP id t6so1968494lbv.1;
        Mon, 23 May 2016 04:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LhEBkJJVX3tQgZrWP7MrKN89H8MNXwXOuQCC9wJk6qM=;
        b=SuIcZ5mWj5LeiJ3/uciFUdtQGYGuwZudzcF1M1gv3kp3dGXB9sdY+kVpFFbkSulWsl
         E5HRbIXIXfFyuFph9VnIOfJ7KSUeK0SSzbR1Ag6oAKY8NKB9+jhAbce7t94b2pPdCx7t
         aQmiox9FfqzFsxttZAYsfSBeWUadfbGNPbbWIriiQf1HZfpANoe00VaEp7UKAzG5ItMS
         dpzi1LTo2cxiTzXsBfJ68o5JITh8jAYdrEMHorvS0w4DmXMhbFI1ahVJF/UuJTAZYFg6
         GDoHej+b9j2CDU1llkzJ0ocIX9JpC7QxKlGRHYpCHSZMoqzJVh4aXN0/GgLWnaprJX/F
         33pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LhEBkJJVX3tQgZrWP7MrKN89H8MNXwXOuQCC9wJk6qM=;
        b=kXpukGR/J6kXZ87c5eL5IennccXkdWzkdv8q1rAwKh4IE+/VMW2jMY9pnxJS2778gJ
         UUgy5/Zq2NzYaZxM9h1gkNAEltCbmiBURLsLMSp//UwC+DYD5MAzRjvLrMU/hmPr77C/
         QGzZk7LkbiSqLTfPvLsQhdAcri68mB9pZK3EtGXhWIpYzS9bqKY0dxBsvdKSJK5uMalC
         QoBKlXD/pnWnJV9Xgr0mWewDGIUpMshLSxN7hBZxdNcmZbnEPUNZn0+CMyjPXajHvcK2
         UeyKC6hP7vfI6/+1lxN/nejjTBOzvZrwcwSPxtwkePoC7Lj7arBWOfs+WRTj85mCz8VT
         1mow==
X-Gm-Message-State: ALyK8tIGS8g4oXTUzagFMY6YYcoy+UWMQ3ITswUhydsF8v6o8cVUv1aZwGvVFUnTGD2/xg==
X-Received: by 10.112.150.71 with SMTP id ug7mr333953lbb.3.1464003547520;
        Mon, 23 May 2016 04:39:07 -0700 (PDT)
Received: from localhost.localdomain (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id a76sm5797941lfa.11.2016.05.23.04.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 May 2016 04:39:06 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: devicetree: fix cpu interrupt controller node-names
Date:   Mon, 23 May 2016 14:39:00 +0300
Message-Id: <1464003540-13009-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Here is the quote from [1]:

    The unit-address must match the first address specified
    in the reg property of the node. If the node has no reg property,
    the @ and unit-address must be omitted and the node-name alone
    differentiates the node from other nodes at the same level

This patch adjusts MIPS dts-files and devicetree binding
documentation in accordance with [1].

    [1] Power.org(tm) Standard for Embedded Power Architecture(tm)
        Platform Requirements (ePAPR). Version 1.1 – 08 April 2011.
        Chapter 2.2.1.1 Node Name Requirements

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/mips/cpu_irq.txt | 2 +-
 arch/mips/boot/dts/ingenic/jz4740.dtsi             | 2 +-
 arch/mips/boot/dts/ralink/mt7620a.dtsi             | 2 +-
 arch/mips/boot/dts/ralink/rt2880.dtsi              | 2 +-
 arch/mips/boot/dts/ralink/rt3050.dtsi              | 2 +-
 arch/mips/boot/dts/ralink/rt3883.dtsi              | 2 +-
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts           | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mips/cpu_irq.txt b/Documentation/devicetree/bindings/mips/cpu_irq.txt
index fc149f3..f080f06 100644
--- a/Documentation/devicetree/bindings/mips/cpu_irq.txt
+++ b/Documentation/devicetree/bindings/mips/cpu_irq.txt
@@ -13,7 +13,7 @@ Required properties:
 - compatible : Should be "mti,cpu-interrupt-controller"
 
 Example devicetree:
-	cpu-irq: cpu-irq@0 {
+	cpu-irq: cpu-irq {
 		#address-cells = <0>;
 
 		interrupt-controller;
diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 4a9c8f2..f6ae6ed 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -5,7 +5,7 @@
 	#size-cells = <1>;
 	compatible = "ingenic,jz4740";
 
-	cpuintc: interrupt-controller@0 {
+	cpuintc: interrupt-controller {
 		#address-cells = <0>;
 		#interrupt-cells = <1>;
 		interrupt-controller;
diff --git a/arch/mips/boot/dts/ralink/mt7620a.dtsi b/arch/mips/boot/dts/ralink/mt7620a.dtsi
index 08bf24f..793c0c7 100644
--- a/arch/mips/boot/dts/ralink/mt7620a.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7620a.dtsi
@@ -9,7 +9,7 @@
 		};
 	};
 
-	cpuintc: cpuintc@0 {
+	cpuintc: cpuintc {
 		#address-cells = <0>;
 		#interrupt-cells = <1>;
 		interrupt-controller;
diff --git a/arch/mips/boot/dts/ralink/rt2880.dtsi b/arch/mips/boot/dts/ralink/rt2880.dtsi
index 182afde..fb2faef 100644
--- a/arch/mips/boot/dts/ralink/rt2880.dtsi
+++ b/arch/mips/boot/dts/ralink/rt2880.dtsi
@@ -9,7 +9,7 @@
 		};
 	};
 
-	cpuintc: cpuintc@0 {
+	cpuintc: cpuintc {
 		#address-cells = <0>;
 		#interrupt-cells = <1>;
 		interrupt-controller;
diff --git a/arch/mips/boot/dts/ralink/rt3050.dtsi b/arch/mips/boot/dts/ralink/rt3050.dtsi
index e3203d4..d3cb57f 100644
--- a/arch/mips/boot/dts/ralink/rt3050.dtsi
+++ b/arch/mips/boot/dts/ralink/rt3050.dtsi
@@ -9,7 +9,7 @@
 		};
 	};
 
-	cpuintc: cpuintc@0 {
+	cpuintc: cpuintc {
 		#address-cells = <0>;
 		#interrupt-cells = <1>;
 		interrupt-controller;
diff --git a/arch/mips/boot/dts/ralink/rt3883.dtsi b/arch/mips/boot/dts/ralink/rt3883.dtsi
index 3b131dd..3d6fc9a 100644
--- a/arch/mips/boot/dts/ralink/rt3883.dtsi
+++ b/arch/mips/boot/dts/ralink/rt3883.dtsi
@@ -9,7 +9,7 @@
 		};
 	};
 
-	cpuintc: cpuintc@0 {
+	cpuintc: cpuintc {
 		#address-cells = <0>;
 		#interrupt-cells = <1>;
 		interrupt-controller;
diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
index 686ebd1..48d2112 100644
--- a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
+++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
@@ -10,7 +10,7 @@
 		reg = <0x0 0x08000000>;
 	};
 
-	cpuintc: interrupt-controller@0 {
+	cpuintc: interrupt-controller {
 		#address-cells = <0>;
 		#interrupt-cells = <1>;
 		interrupt-controller;
-- 
2.7.0
