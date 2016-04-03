Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Apr 2016 14:13:29 +0200 (CEST)
Received: from mail-lb0-f194.google.com ([209.85.217.194]:36188 "EHLO
        mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014198AbcDCMNMl5rKB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Apr 2016 14:13:12 +0200
Received: by mail-lb0-f194.google.com with SMTP id q4so16799812lbq.3
        for <linux-mips@linux-mips.org>; Sun, 03 Apr 2016 05:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80Wex0hZqVhNezIUIHPTztfDWv0yMMVFV3jdEcOcGvQ=;
        b=zSkxLVXlbXyMgC+tm4rMX4G+bopzDbIzmdbHCoHVrV0MUeNPAeEWmORhufxtaGzA/M
         b/hND6ttQc2f+q9no9+885lm9b5w2jvyV/9MLFMOD2xmFPVu0IYC59CR/mcpLLrq+HzE
         YPoKH3T4/vnLMT4HWhiM06A1ajVjJ+g/HLHr6txPDdKjeZNrXYhD+rd6bySTmXmgAuOe
         jf1lkJqotmBHNKJV3amgfThX7K0Bybw+zN0GgQk2oFXWWB6cNosW3gSei7PH1n9Z2QCq
         fgD16Nb036cNl4FcLXWqCz9xBnRxnsq/Y2RUatef8z9iZY7aX5prxou7AG4IEAcRv0RG
         qNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80Wex0hZqVhNezIUIHPTztfDWv0yMMVFV3jdEcOcGvQ=;
        b=drhc/SjgrgwThDrQP3l7RkpBPzPOqWgHnLob9xZcERliFIRCGJx5mzVCoMVhntwsMO
         AiDQ9fLoksgjk+M3A8NvTseYUe1vd0JVHujMQ2AJS/CfJ4EsPu6V4uXmVkIS/GP98syl
         Qv3JGD4nf+Y9eE2hx5coOZnooII1TR9FHv2l5fZpovK1MA47hAFHn7nwZ4/Z1EwfFmAn
         ywYjhEbCprLbFA/8q4T/1h6cg+d9DYHEqFNeIONVDY7KzTW5h76SFbicKzP/+ushqHQ9
         uvZWpqwKVx/gGDn8c7nXLBxlbqOGkLHv27RiqFKnRA53vBFLMM60Xodk6CB0/Cgw4YyZ
         iT8w==
X-Gm-Message-State: AD7BkJJNXcJRTww5XvfNZPvb3oEl3emKwALr04HTGuQKLGWCAjoQx42pNg9sHcLYMqUdyg==
X-Received: by 10.28.109.4 with SMTP id i4mr7058781wmc.44.1459685587298;
        Sun, 03 Apr 2016 05:13:07 -0700 (PDT)
Received: from localhost.localdomain (228.red-83-55-41.dynamicip.rima-tde.net. [83.55.41.228])
        by smtp.gmail.com with ESMTPSA id i2sm23547388wje.22.2016.04.03.05.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Apr 2016 05:13:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        jogo@openwrt.org, cernekee@gmail.com, simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 2/3] MIPS: BMIPS: improve BCM6358 device tree
Date:   Sun,  3 Apr 2016 14:13:04 +0200
Message-Id: <1459685585-11747-2-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1459685585-11747-1-git-send-email-noltari@gmail.com>
References: <1459685585-11747-1-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52843
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

- Switch to bcm6345-l1-intc interrupt controller.
- Add ehci0 and ohci0 nodes.
- Use proper native-endian syscon property.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm6358.dtsi | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm6358.dtsi b/arch/mips/boot/dts/brcm/bcm6358.dtsi
index 5ac1ef0..5dc8432 100644
--- a/arch/mips/boot/dts/brcm/bcm6358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6358.dtsi
@@ -53,7 +53,7 @@
 		periph_cntl: syscon@fffe0000 {
 			compatible = "syscon";
 			reg = <0xfffe0000 0xc>;
-			little-endian;
+			native-endian;
 		};
 
 		reboot: syscon-reboot@fffe0008 {
@@ -64,15 +64,15 @@
 		};
 
 		periph_intc: interrupt-controller@fffe000c {
-			compatible = "brcm,bcm3380-l2-intc";
-			reg = <0xfffe0010 0x4 0xfffe000c 0x4>,
-			      <0xfffe003c 0x4 0xfffe0038 0x4>;
+			compatible = "brcm,bcm6345-l1-intc";
+			reg = <0xfffe000c 0x8>,
+			      <0xfffe0038 0x8>;
 
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
 			interrupt-parent = <&cpu_intc>;
-			interrupts = <2>;
+			interrupts = <2>, <3>;
 		};
 
 		leds0: led-controller@fffe00d0 {
@@ -107,5 +107,24 @@
 
 			status = "disabled";
 		};
+
+		ehci0: usb@fffe1300 {
+			compatible = "brcm,bcm6358-ehci", "generic-ehci";
+			reg = <0xfffe1300 0x100>;
+			big-endian;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <10>;
+			status = "disabled";
+		};
+
+		ohci0: usb@fffe1400 {
+			compatible = "brcm,bcm6358-ohci", "generic-ohci";
+			reg = <0xfffe1400 0x100>;
+			big-endian;
+			no-big-frame-no;
+			interrupt-parent = <&periph_intc>;
+			interrupts = <5>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.1.4
