Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jan 2016 11:02:31 +0100 (CET)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34946 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009313AbcAQKCN6agJR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Jan 2016 11:02:13 +0100
Received: by mail-wm0-f65.google.com with SMTP id 123so3708503wmz.2;
        Sun, 17 Jan 2016 02:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=CVUXCI4bUtHFvxY3JTx9eZHINANYFCa/PXQW8ew1lsM=;
        b=bXGEocxiS4Ci1ivinTVkSuTfOTBRRglPJUeOE3hGAMWDxlCQERI2nwdsKEzJFELSPE
         aZZyovlmQ6fjqOxgGHmVza5Pxz+kqBrhR17wSH6ft07D+HUqrgFtfKRQca1YsBPUvAKm
         8VZSJBqsqYcYQzO9vMYkPJRQN/74pqGHQ4yFZrsSDErjkyxZG3Bib7E3QeQpqBn/b9+6
         GBHtP5hZaII16Pw1RB5uc/Nmxc2dLMSUHbD0PWupSNF6tB32CkThYSItoQ0qrB453RTH
         +jAydsrJXRx/y7uLkfQZAqT7I+qJxt6KahdUqzXnHqNGTd708z4pWB2VYcJzVubMTOPP
         hwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=CVUXCI4bUtHFvxY3JTx9eZHINANYFCa/PXQW8ew1lsM=;
        b=N2wWzxjP2KutptnXmeIxat6kDinzcs7nvR0Xu9n6zDOCh0rDGbEf5cBC+kirWppGzy
         78d8koK8oiGHShdpHGehotHFEtHwTzE9EbJcFrDEhazbtKg92X5EqTYrECc8F9YFIIJF
         bhVnBg9AprcBXom1pfPwuhIvWd2Za3ufo+iEyRqztu1ukL4iIFdrAMJkw3CuD4YCzg8u
         l58QPCvKOB4fy/onSJmeDGiA4aYUTAswYr+12dPbd0U99HSxodSe/CId2YxCQJ6vM1hP
         k6foK1QoQh9NCZoz9Q00BQo8iktDP0FGRjGtxBnGHEaWiiDCdo0quZh46b2yKRPFcR+R
         5J0w==
X-Gm-Message-State: AG10YOS1dArOywvt9BB5aXaumSlWyC7ubHG9Bkbwwnde1BtMaakYdV+HsXcKAi/w63i7hg==
X-Received: by 10.194.191.229 with SMTP id hb5mr1864877wjc.164.1453024928728;
        Sun, 17 Jan 2016 02:02:08 -0800 (PST)
Received: from skynet.lan (140.Red-83-35-232.dynamicIP.rima-tde.net. [83.35.232.140])
        by smtp.gmail.com with ESMTPSA id j3sm10527556wmj.19.2016.01.17.02.02.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jan 2016 02:02:07 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 2/2] bmips: improve BCM6368 device tree
Date:   Sun, 17 Jan 2016 11:02:35 +0100
Message-Id: <1453024955-13570-2-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51175
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

Adds brcm,bcm6358-leds node to bcm6368.dtsi
Adds reboot support (syscon-reboot as defined in BCM6328)

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm6368.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm6368.dtsi b/arch/mips/boot/dts/brcm/bcm6368.dtsi
index 45152bc..9c8d3fe2 100644
--- a/arch/mips/boot/dts/brcm/bcm6368.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6368.dtsi
@@ -32,6 +32,7 @@
 	};
 
 	aliases {
+		leds0 = &leds0;
 		uart0 = &uart0;
 	};
 
@@ -50,6 +51,19 @@
 		compatible = "simple-bus";
 		ranges;
 
+		periph_cntl: syscon@10000000 {
+			compatible = "syscon";
+			reg = <0x10000000 0x14>;
+			little-endian;
+		};
+
+		reboot: syscon-reboot@10000008 {
+			compatible = "syscon-reboot";
+			regmap = <&periph_cntl>;
+			offset = <0x8>;
+			mask = <0x1>;
+		};
+
 		periph_intc: periph_intc@10000020 {
 			compatible = "brcm,bcm3380-l2-intc";
 			reg = <0x10000024 0x4 0x1000002c 0x4>,
@@ -62,6 +76,14 @@
 			interrupts = <2>;
 		};
 
+		leds0: led-controller@100000d0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm6358-leds";
+			reg = <0x100000d0 0x8>;
+			status = "disabled";
+		};
+
 		uart0: serial@10000100 {
 			compatible = "brcm,bcm6345-uart";
 			reg = <0x10000100 0x18>;
-- 
1.9.1
