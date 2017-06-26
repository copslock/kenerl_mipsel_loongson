Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 00:36:00 +0200 (CEST)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:36151
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993965AbdFZWeGSaE2t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jun 2017 00:34:06 +0200
Received: by mail-qt0-x241.google.com with SMTP id v31so1878065qtb.3;
        Mon, 26 Jun 2017 15:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iO1DVnM964v5WeqigX0v/D+TBMbTm9k35mFmg3u/xgY=;
        b=d1oBTMkcQGGUKsktwdL2ISx1VrbhJ5RL4Aba4LkahPkFuweO/1cB8ih82rRZT6to/n
         6lvuBUn7PyUhMWKGXF6Vamam12FJVA81Mf93xUP+SU66ydO2ALrf/lnE+Q3k/Q9k0Fjp
         f5BGJHEtJbG7ReVroElvBwXrBWh/W0J/Fry3hc3CpJaWE64b11NhU5oW49ItTMmsYPhq
         w4zPDrs4wCgX66HNBkQC1Hxxd3Jx7T4RqpvcaymZmoUeYB/b6XBMJyNdJ74w656b5o6W
         NvXxhXMRX5YJJlIZuSR/WE1gp3wRTt0GW3jWQPg6IOSE7AoTG3aGFxNmz4jjhpvvYDWL
         bBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iO1DVnM964v5WeqigX0v/D+TBMbTm9k35mFmg3u/xgY=;
        b=LQ6Baw8sxSsxL+4Oxkb3p1MSjNTGMmvT1l9EcnQytTj7adWP8Z6uxkxAxyNpyJ2/0P
         LcUddQLou2tA8qlcrrz/oP35ThHa3iKYxvDqM86wrCSZ0lv2hJ0keWG+YryAyl+BbE7+
         CKGGNNzzC/3+uMZFIjjrNpDJL2LTjcv1ORaKGcNGrOYbWAYM2ZrrlVPUNZSVqUy+dl1G
         PxmnQSsgg+XW3xoTT4W59fjLw/1Y2OJ3neywWMLtbbeLQMbLKG5qe9t1UmTaCViJgxHj
         gXgyZxKd4KsP5PpIWyG8oBCnU8BnHbZFXnrnJNS+FqQ0gdsvXNukiwPvwHSK3hn8xKCM
         XKZA==
X-Gm-Message-State: AKS2vOx9HPld0r8QwXkQbYbInbwo3a80mJUdm4hAVo/OVbGMxLDFzN86
        d4GOP5dUoSmMxQ==
X-Received: by 10.200.58.39 with SMTP id w36mr2972915qte.241.1498516440625;
        Mon, 26 Jun 2017 15:34:00 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id j65sm965542qkf.38.2017.06.26.15.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 15:34:00 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Justin Chen <justinpopo6@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        linux-mips@linux-mips.org (open list:BROADCOM BCM47XX MIPS ARCHITECTURE),
        linux-pm@vger.kernerl.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 3/4] dt-bindings: Document MIPS Broadcom STB power management nodes
Date:   Mon, 26 Jun 2017 15:32:45 -0700
Message-Id: <20170626223248.14199-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170626223248.14199-1-f.fainelli@gmail.com>
References: <20170626223248.14199-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Document the different nodes required for supporting S2/S3/S5 suspend
states on MIPS-based Broadcom STB SoCs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/mips/brcm/soc.txt          | 153 +++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
index e4e1cd91fb1f..6bfe217668d6 100644
--- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
+++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
@@ -11,3 +11,156 @@ Required properties:
 
 The experimental -viper variants are for running Linux on the 3384's
 BMIPS4355 cable modem CPU instead of the BMIPS5000 application processor.
+
+Power management
+----------------
+
+For power management (particularly, S2/S3/S5 system suspend), the following SoC
+components are needed:
+
+= Always-On control block (AON CTRL)
+
+This hardware provides control registers for the "always-on" (even in low-power
+modes) hardware, such as the Power Management State Machine (PMSM).
+
+Required properties:
+- compatible     : should be one of
+		   "brcm,bcm7425-aon-ctrl"
+		   "brcm,bcm7429-aon-ctrl"
+		   "brcm,bcm7435-aon-ctrl" and
+		   "brcm,brcmstb-aon-ctrl"
+- reg            : the register start and length for the AON CTRL block
+
+Example:
+
+syscon@410000 {
+	compatible = "brcm,bcm7425-aon-ctrl", "brcm,brcmstb-aon-ctrl";
+	reg = <0x410000 0x400>;
+};
+
+= Memory controllers
+
+A Broadcom STB SoC typically has a number of independent memory controllers,
+each of which may have several associated hardware blocks, which are versioned
+independently (control registers, DDR PHYs, etc.). One might consider
+describing these controllers as a parent "memory controllers" block, which
+contains N sub-nodes (one for each controller in the system), each of which is
+associated with a number of hardware register resources (e.g., its PHY.
+
+== MEMC (MEMory Controller)
+
+Represents a single memory controller instance.
+
+Required properties:
+- compatible     : should contain "brcm,brcmstb-memc" and "simple-bus"
+- ranges	 : should contain the child address in the parent address
+		   space, must be 0 here, and the register start and length of
+		   the entire memory controller (including all sub nodes: DDR PHY,
+		   arbiter, etc.)
+- #address-cells : must be 1
+- #size-cells	 : must be 1
+
+Example:
+
+	memory-controller: memc@0 {
+		compatible = "brcm,brcmstb-memc", "simple-bus";
+		ranges = <0x0 0x0 0xa000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		memc-arb@1000 {
+			...
+		};
+
+		memc-ddr@2000 {
+			...
+		};
+
+		ddr-phy@6000 {
+			...
+		};
+	};
+
+Should contain subnodes for any of the following relevant hardware resources:
+
+== DDR PHY control
+
+Control registers for this memory controller's DDR PHY.
+
+Required properties:
+- compatible     : should contain one of these
+		   "brcm,brcmstb-ddr-phy-v64.5"
+		   "brcm,brcmstb-ddr-phy"
+
+- reg            : the DDR PHY register range and length
+
+Example:
+
+	ddr-phy@6000 {
+		compatible = "brcm,brcmstb-ddr-phy-v64.5";
+		reg = <0x6000 0xc8>;
+	};
+
+== DDR memory controller sequencer
+
+Control registers for this memory controller's DDR memory sequencer
+
+Required properties:
+- compatible     : should contain one of these
+		   "brcm,bcm7425-memc-ddr"
+		   "brcm,bcm7429-memc-ddr"
+		   "brcm,bcm7435-memc-ddr" and
+		   "brcm,brcmstb-memc-ddr"
+
+- reg            : the DDR sequencer register range and length
+
+Example:
+
+	memc-ddr@2000 {
+		compatible = "brcm,bcm7425-memc-ddr", "brcm,brcmstb-memc-ddr";
+		reg = <0x2000 0x300>;
+	};
+
+== MEMC Arbiter
+
+The memory controller arbiter is responsible for memory clients allocation
+(bandwidth, priorities etc.) and needs to have its contents restored during
+deep sleep states (S3).
+
+Required properties:
+
+- compatible	: should contain one of these
+		  "brcm,brcmstb-memc-arb-v10.0.0.0"
+		  "brcm,brcmstb-memc-arb"
+
+- reg		: the DDR Arbiter register range and length
+
+Example:
+
+	memc-arb@1000 {
+		compatible = "brcm,brcmstb-memc-arb-v10.0.0.0";
+		reg = <0x1000 0x248>;
+	};
+
+== Timers
+
+The Broadcom STB chips contain a timer block with several general purpose
+timers that can be used.
+
+Required properties:
+
+- compatible	: should contain one of:
+		  "brcm,bcm7425-timers"
+		  "brcm,bcm7429-timers"
+		  "brcm,bcm7435-timers and
+		  "brcm,brcmstb-timers"
+- reg		: the timers register range
+- interrupts	: the interrupt line for this timer block
+
+Example:
+
+	timers: timers@4067c0 {
+		compatible = "brcm,bcm7425-timers", "brcm,brcmstb-timers";
+		reg = <0x4067c0 0x40>;
+		interrupts = <&periph_intc 19>;
+	};
-- 
2.9.3
