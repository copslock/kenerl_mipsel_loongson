Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 13:17:54 +0200 (CEST)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:35288
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993918AbdITLQTw0QyX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Sep 2017 13:16:19 +0200
Received: by mail-wm0-x243.google.com with SMTP id e64so2126097wmi.2;
        Wed, 20 Sep 2017 04:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cqVPQGainFh9P49hJyGNpQkjXSK3BMhwAQa2Fdw2oA8=;
        b=Fhy52v/wgUuerUonpaTy1Nk/Xu7G2XHu9OJFhJ2EwXpNX3xKqD7DksdjmQ23VsqfGQ
         PjD5T6muiYOqbUm40yRvrRdpmv2DcgmAuM12nedSD6Dpsh8KRrHD9/S4nJ4kIKChcT4G
         hZYgIxqqbwbofouKg2dLltwseMe3XHEhSyNiHV4+u5yrFqZoub7zPLQ6iBEfafTJ/r1L
         ovLhPDJmVvt3WdOkQeBLzz2nwl0J07YEq6YAy8LvMfwm3BTG+4sgfctGupwLMe65a17K
         v6i/HxAnGhsZCGhngardYGTyAdHpyxIhB83TzvuSF5/dxqZsOjHwT2OxbPKd83Co0Mcs
         m9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cqVPQGainFh9P49hJyGNpQkjXSK3BMhwAQa2Fdw2oA8=;
        b=AcLVvUAefDmolazcEZqbEeA2L/L5f52SkJslnt2XcbmAhj6YQzuCoapmAX7bh+vvfq
         lIi5SpxSagNRNwCdWRVYdnkez7FhRyU6dkWrIPKati/70bUUi//YUnqUiQ2I+m/i9qht
         XRAcow64qu//GykWf/JyNc6JGF6WZipTsC7vrxY2GodhZDJiC0GOaEJqDzb7LLJFlTLP
         C27HAiAyTP9JpJxgIJ0FNEmPgmPKlJBCc9W5JM7uDXlWWPHiy2PMRzr1TzE5jMDEE0o2
         FSD0xZBCPzIS2Q2zerY+5WZp5dfVy7U2PacNYMOi52gr1jympWrPCYbIWBJ118kBdqvN
         Vaig==
X-Gm-Message-State: AHPjjUhb+LXLgSVwKyLPMxFdK07GDwuWAdxRdTPdBowQ4+fLVPcXDwqB
        jtffq3/kAQKNC23bniYGiuQgZA==
X-Google-Smtp-Source: AOwi7QCPqpLg6cPjVbbyoKAQc3OzjacwiM15sV5KBRxVTiwj6J/BiJQ6e3Esup2XahkAgkwaNj0L9A==
X-Received: by 10.80.135.65 with SMTP id 1mr4121495edv.266.1505906174345;
        Wed, 20 Sep 2017 04:16:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id s12sm884513edd.25.2017.09.20.04.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 04:16:13 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH V2 5/8] MIPS: BMIPS: name the refclk clock for uart
Date:   Wed, 20 Sep 2017 13:14:05 +0200
Message-Id: <20170920111408.29711-6-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170920111408.29711-1-jonas.gorski@gmail.com>
References: <20170920111408.29711-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60089
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

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
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
