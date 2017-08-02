Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2017 11:38:38 +0200 (CEST)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:33360
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994833AbdHBJfYSUHAy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Aug 2017 11:35:24 +0200
Received: by mail-wm0-x241.google.com with SMTP id q189so6457608wmd.0;
        Wed, 02 Aug 2017 02:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hXGrcsND3714USKaG/lt7xTRVwcfKrZQmICtuKiKuho=;
        b=I7n3Nu1kJaxOhR7ohrdnai8v3yoeo+QNtY78Ueq+RjVGeCudPnGY7pHPi3ordaTg5g
         k1ASxXCZaYcAzIrFIvvJoH+/brbsx1Vx9JqWr/XiPgmbED8N5cjjRzQZUK4JxPQ3yrT5
         QesANHPQQg4VujXYYJg/1csEXp0MOr5k0gfOzDog3qbsnoVhLR59noh8KzgGnExeaN5i
         /cXWw1XEtyHcSSc25b+Ff891oKl4tBUE8bbZrQpfucjX4658RrcPua4wYusLuoPj/7r/
         xmSmPraM6Lx/QNddu1p+LH5qhKnc/i/ePe3lt7d9lpw4XTaI8SO+gq0kePoL005Vbud6
         oWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hXGrcsND3714USKaG/lt7xTRVwcfKrZQmICtuKiKuho=;
        b=akAy6DDtKPF7spWVNUX83KXwRvOKrd14GKBmmemHR6+0UsTyTgtb2Y9erF23uUNBDu
         Su5pboAVOQXz7ePaSS+B0DQcugZhSNh3+JpCWAy3APhJgUU/zljivdZntVSB+uZ350fp
         ybd7eWZsOxe/DwbOZrPzD12MJRcYJC0Z9T69FD36wSjLcQHM494f/9+iHRuvO57tk7ys
         3CquVoUos8+wW2te5bFqHui7+IBpEGCpo1dTXKFQM6Hyb1rRwxG+Ba5vrpCA9d2NOlYY
         Eh6w/6h+29knrZs4vHtft7iZfz9Ps1CxmfDwppwwBDKuwnBP3nhlkogjWk9AqBVTnRy7
         7qwg==
X-Gm-Message-State: AIVw113J/k/k/604D4LMkEhubJkYNUt2xs31bH1IAiSjl/TASb0CBWFP
        PNW/i1CC7eAIda2Z52k=
X-Received: by 10.28.211.65 with SMTP id k62mr3407915wmg.89.1501666518823;
        Wed, 02 Aug 2017 02:35:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id 91sm32058876wrg.83.2017.08.02.02.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Aug 2017 02:35:18 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 8/8] MIPS: BMIPS: name the refclk clock for uart
Date:   Wed,  2 Aug 2017 11:34:29 +0200
Message-Id: <20170802093429.12572-9-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170802093429.12572-1-jonas.gorski@gmail.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59324
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

Add the clock name to the uart nodes, to name the input clock
properly.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm3368.dtsi  | 2 ++
 arch/mips/boot/dts/brcm/bcm63268.dtsi | 2 ++
 arch/mips/boot/dts/brcm/bcm6328.dtsi  | 2 ++
 arch/mips/boot/dts/brcm/bcm6358.dtsi  | 2 ++
 arch/mips/boot/dts/brcm/bcm6362.dtsi  | 2 ++
 arch/mips/boot/dts/brcm/bcm6368.dtsi  | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm3368.dtsi b/arch/mips/boot/dts/brcm/bcm3368.dtsi
index bee855cb8073..772fb42b7730 100644
--- a/arch/mips/boot/dts/brcm/bcm3368.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm3368.dtsi
@@ -82,6 +82,7 @@
 			interrupts = <2>;
 
 			clocks = <&periph_clk>;
+			clock-names = "refclk";
 
 			status = "disabled";
 		};
@@ -94,6 +95,7 @@
 			interrupts = <3>;
 
 			clocks = <&periph_clk>;
+			clock-names = "refclk";
 
 			status = "disabled";
 		};
diff --git a/arch/mips/boot/dts/brcm/bcm63268.dtsi b/arch/mips/boot/dts/brcm/bcm63268.dtsi
index 7e6bf2cc0287..b033a23b5e13 100644
--- a/arch/mips/boot/dts/brcm/bcm63268.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm63268.dtsi
@@ -83,6 +83,7 @@
 			interrupts = <5>;
 
 			clocks = <&periph_clk>;
+			clock-names = "refclk";
 
 			status = "disabled";
 		};
@@ -95,6 +96,7 @@
 			interrupts = <34>;
 
 			clocks = <&periph_clk>;
+			clock-names = "refclk";
 
 			status = "disabled";
 		};
diff --git a/arch/mips/boot/dts/brcm/bcm6328.dtsi b/arch/mips/boot/dts/brcm/bcm6328.dtsi
index 5633b9d90f55..7c3061ba6d38 100644
--- a/arch/mips/boot/dts/brcm/bcm6328.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6328.dtsi
@@ -68,6 +68,7 @@
 			interrupt-parent = <&periph_intc>;
 			interrupts = <28>;
 			clocks = <&periph_clk>;
+			clock-names = "refclk";
 			status = "disabled";
 		};
 
@@ -77,6 +78,7 @@
 			interrupt-parent = <&periph_intc>;
 			interrupts = <39>;
 			clocks = <&periph_clk>;
+			clock-names = "refclk";
 			status = "disabled";
 		};
 
diff --git a/arch/mips/boot/dts/brcm/bcm6358.dtsi b/arch/mips/boot/dts/brcm/bcm6358.dtsi
index f9d8d392162b..ab9d6c268a84 100644
--- a/arch/mips/boot/dts/brcm/bcm6358.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6358.dtsi
@@ -92,6 +92,7 @@
 			interrupts = <2>;
 
 			clocks = <&periph_clk>;
+			clock-names = "refclk";
 
 			status = "disabled";
 		};
@@ -104,6 +105,7 @@
 			interrupts = <3>;
 
 			clocks = <&periph_clk>;
+			clock-names = "refclk";
 
 			status = "disabled";
 		};
diff --git a/arch/mips/boot/dts/brcm/bcm6362.dtsi b/arch/mips/boot/dts/brcm/bcm6362.dtsi
index c507da594f2f..ca93c9a6f23f 100644
--- a/arch/mips/boot/dts/brcm/bcm6362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6362.dtsi
@@ -83,6 +83,7 @@
 			interrupts = <3>;
 
 			clocks = <&periph_clk>;
+			clock-names = "refclk";
 
 			status = "disabled";
 		};
@@ -95,6 +96,7 @@
 			interrupts = <4>;
 
 			clocks = <&periph_clk>;
+			clock-names = "refclk";
 
 			status = "disabled";
 		};
diff --git a/arch/mips/boot/dts/brcm/bcm6368.dtsi b/arch/mips/boot/dts/brcm/bcm6368.dtsi
index d0e3a70b32e2..da4ec89710fd 100644
--- a/arch/mips/boot/dts/brcm/bcm6368.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6368.dtsi
@@ -89,6 +89,7 @@
 			interrupt-parent = <&periph_intc>;
 			interrupts = <2>;
 			clocks = <&periph_clk>;
+			clock-names = "refclk";
 			status = "disabled";
 		};
 
@@ -98,6 +99,7 @@
 			interrupt-parent = <&periph_intc>;
 			interrupts = <3>;
 			clocks = <&periph_clk>;
+			clock-names = "refclk";
 			status = "disabled";
 		};
 
-- 
2.13.2
