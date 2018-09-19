Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2018 16:33:27 +0200 (CEST)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:43308
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994645AbeISOdQ7axK9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Sep 2018 16:33:16 +0200
Received: by mail-qt0-x241.google.com with SMTP id g53-v6so5244372qtg.10;
        Wed, 19 Sep 2018 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6PZHZXzG2gUqodrftrjrMv9UkVaRrpj6xkdisoH7P94=;
        b=rbeZJ4ZRqjo4gMVplAcKiFPGdAUiBm9YmN08wucsOcjwpqggZ3LNvLFxG9YUk6Hlbk
         Q5dCrS8njA6aWAk3mqXsKcrsoty/IYS6WoTIyQmzspub7WQwdeDe5O3IjRsPDxLM9GXG
         TGlE3ePbSSwegWOlyVZ1JOjCVcMrgqNMsnXyrICPf35V9Ff91p3+RhfZBYEXFzLE1AKQ
         rx8F/6J/4xIaBwOHlDmZSwkBSutJDHXiv3Jg0wrLKseXpxwqJTteShj5syDk1zq+5A0o
         SoCj7i0erZyrIdxrJBPe8VkrCpwDAxu0C87+Fwz61CeHnLVVsjKu3+BbMF25x4xfDcP3
         1VOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6PZHZXzG2gUqodrftrjrMv9UkVaRrpj6xkdisoH7P94=;
        b=OkRtsyRyGZ2/8346LOpr5EmlqWszj1V91Q5ZReQI6PN/k690yxC+Rq+V7sTCabY+9I
         DpHkwkTrRhvP1mWIjJ3AeS+VZ+HPwpbY3c4MWGDQVICbj34n1iReOPZ2zBTTB5BBIK5w
         CW449NeSc2OFAI7Igw6FNPoKOwMcZzTsGviksBZT0KP8HHcY4GeYKPjS4D8ixIaa5CTZ
         IH4ysJpv/hXZGOw7AdfeUVKMUfOXFDRTmYDQ2xU5cgKEbs+E+TZCNFFCwzjz42wUOVFq
         qcYirekHyZMLkA3JZVrfwLeoZ4M/bttktj75S55BYUkhOYOlZmJtBZGZ6tJmCM7KvA65
         77xg==
X-Gm-Message-State: APzg51AsePvQjnfitHQwBGXFUed6lCY4KtEcJX2ceVYL/VGT5WmeMumF
        wKoYm/JpQ2iEs6vlucrYyzI=
X-Google-Smtp-Source: ANB0VdYMCF7809XbGq2W0XuyXMf2X9OtjIgXOlkST6NLOe2qPMVvwdvEQTsW2HE6/XTy6lM78PzukA==
X-Received: by 2002:ad4:4089:: with SMTP id l9-v6mr25041164qvp.160.1537367591135;
        Wed, 19 Sep 2018 07:33:11 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 17-v6sm2104051qkf.74.2018.09.19.07.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 07:33:10 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 08/12] MIPS: BMIPS: add PCI bindings for 7425, 7435
Date:   Wed, 19 Sep 2018 10:32:03 -0400
Message-Id: <1537367527-20773-9-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

Adds the PCIe nodes for the Broadcom STB PCIe root complex.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7425.dtsi     | 28 ++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi     | 28 ++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts |  4 ++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts |  4 ++++
 4 files changed, 64 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index 410e61e..0edcbe4 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -584,4 +584,32 @@
 			};
 		};
 	};
+
+	pcie: pcie@10410000 {
+		reg = <0x10410000 0x830c>;
+		compatible = "brcm,bcm7425-pcie";
+		interrupts = <37>, <37>;
+		interrupt-names = "pcie", "msi";
+		interrupt-parent = <&periph_intc>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		linux,pci-domain = <0>;
+		brcm,enable-ssc;
+		bus-range = <0x00 0xff>;
+		msi-controller;
+		#interrupt-cells = <1>;
+		/* 4x128mb windows */
+		ranges = <0x2000000 0x0 0xd0000000 0xd0000000 0x0 0x20000000>;
+		/* 768M or 1GB memc0, 0-1GB memc1 */
+		dma-ranges =
+			<0x02000000 0x0 0x00000000 0x00000000 0x0 0x10000000>,
+			<0x02000000 0x0 0x10000000 0x20000000 0x0 0x30000000>,
+			<0x02000000 0x0 0x40000000 0x90000000 0x0 0x40000000>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &periph_intc 33
+				 0 0 0 2 &periph_intc 34
+				 0 0 0 3 &periph_intc 35
+				 0 0 0 4 &periph_intc 36>;
+	};
+
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 8398b7f..50bc7a0 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -599,4 +599,32 @@
 			};
 		};
 	};
+
+	pcie: pcie@10410000 {
+		reg = <0x10410000 0x930c>;
+		interrupts = <0x27>, <0x27>;
+		interrupt-names = "pcie", "msi";
+		interrupt-parent = <&periph_intc>;
+		compatible = "brcm,bcm7435-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		linux,pci-domain = <0>;
+		brcm,enable-ssc;
+		bus-range = <0x00 0xff>;
+		msi-controller;
+		#interrupt-cells = <1>;
+		ranges = <0x2000000 0x0 0xd0000000 0xd0000000 0x0 0x20000000>;
+		/* 768M or 1GB memc0, 0-1GB memc1 */
+		dma-ranges =
+			<0x02000000 0x0 0x00000000 0x00000000 0x0 0x10000000>,
+			<0x02000000 0x0 0x10000000 0x20000000 0x0 0x30000000>,
+			<0x02000000 0x0 0x40000000 0x90000000 0x0 0x40000000>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &periph_intc 35
+				 0 0 0 2 &periph_intc 36
+				 0 0 0 3 &periph_intc 37
+				 0 0 0 4 &periph_intc 38>;
+		status = "disabled";
+	};
+
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
index 0ed2221..22270a9 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -152,3 +152,7 @@
 &waketimer {
 	status = "okay";
 };
+
+&pcie {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index 2c145a8..91bc1ec 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -128,3 +128,7 @@
 &waketimer {
 	status = "okay";
 };
+
+&pcie {
+	status = "okay";
+};
-- 
1.9.0.138.g2de3478
