Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 23:39:17 +0200 (CEST)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:36650
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994893AbdFPVhmxMK9C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 23:37:42 +0200
Received: by mail-wm0-x243.google.com with SMTP id d17so7095978wme.3;
        Fri, 16 Jun 2017 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rCA0U5TYnUuBHNM/IOqNI9BMLVjCZbgDVi3XZfPMLrk=;
        b=oCgQ/e8qav3RmizHS9F9Me25/xTvtp73bMzB5XuPC/GQodNeh4rPYuQCMKaABdVvRe
         bhptPDSjESLiU1kCYRhaNw+HM/pbWPfNj3n0oBvCJOWbhbz33eVeowE3LIfGch+YyjqJ
         eNFULZ802bpm1KAl3tf/wCfa3tW0V3xUQuhjZCAa9jCeu09LL+SyqS7PsnIL/1M/Ny4z
         pU4N0EJRitmNZoPMox6vHvV+nLkHbqz1nR7hVtTNDdBTmWlXAYeITlpm/oVPIwkTH9x6
         siNNMzhMn2bZpvecKU3jEpoApeFivIjMSAWCgFuAGXJE1pNsbLw4qweU09Oj4GdUbslb
         fcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rCA0U5TYnUuBHNM/IOqNI9BMLVjCZbgDVi3XZfPMLrk=;
        b=mDpm3lTBMCquBT9NwJq19iEbBOIiDwooDhl72bn+c625M52JlYiW6aAgX563z1xuFS
         /BSCZI+PILfD73kIHHRitNUSY2pw2jrnHUJOVN8L1fEV6cxQ4Jqxdz5dRT6wDn7myRA4
         SNb6dr69FVwmCfXSCwg8tKjFFAgNMQ5fqHBAl21OhsZPj5a6HvVRjnthuKsdMU4xhsBt
         LFwvL+S5X9MaV4bOq9I2un+HaMAJNoYeaXmA4cO4EBJjenPOkNDbn3W2VPA+Fl6fK5j0
         +bZ5EaIyn1VoPY/vNl3HRdHXm1GZ1zSamINgvePHKXySMyL6qbyQKhmDvXyiDO76JuMe
         UV4Q==
X-Gm-Message-State: AKS2vOyavAAPKmKjz34SQxh6wdQ2ky+BDR/k+xZVRRoDfVfQa4DEuCkN
        w/jbfzTy99iRvQ==
X-Received: by 10.28.132.210 with SMTP id g201mr8629800wmd.26.1497649057057;
        Fri, 16 Jun 2017 14:37:37 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id w17sm2576546wra.34.2017.06.16.14.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2017 14:37:36 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@vger.kernel.org
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
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list),
        linux-mips@linux-mips.org (open list:BROADCOM BCM47XX MIPS ARCHITECTURE),
        linux-pm@vger.kernerl.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/5] dt-bindings: Document MIPS Broadcom STB power management nodes
Date:   Fri, 16 Jun 2017 14:37:02 -0700
Message-Id: <20170616213703.21487-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170616213703.21487-1-f.fainelli@gmail.com>
References: <20170616213703.21487-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58584
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
 .../devicetree/bindings/mips/brcm/soc.txt          | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
index e4e1cd91fb1f..f7413168d938 100644
--- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
+++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
@@ -11,3 +11,80 @@ Required properties:
 
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
+- compatible     : should contain "brcm,brcmstb-aon-ctrl"
+- reg            : the register start and length for the AON CTRL block
+
+Example:
+
+aon-ctrl@410000 {
+	compatible = "brcm,brcmstb-aon-ctrl";
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
+associated with a number of hardware register resources (e.g., its PHY). See
+the example device tree snippet below.
+
+== MEMC (MEMory Controller)
+
+Represents a single memory controller instance.
+
+Required properties:
+- compatible     : should contain "brcm,brcmstb-memc" and "simple-bus"
+
+Should contain subnodes for any of the following relevant hardware resources:
+
+== DDR PHY control
+
+Control registers for this memory controller's DDR PHY.
+
+Required properties:
+- compatible     : should contain one of these
+	"brcm,brcmstb-ddr-phy-v64.5"
+	"brcm,brcmstb-ddr-phy"
+
+- reg            : the DDR PHY register range
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
+	"brcm,brcmstb-memc-arb-v10.0.0.0"
+	"brcm,brcmstb-memc-arb"
+
+- reg		: the DDR Arbiter register range
+
+== Timers
+
+The Broadcom STB chips contain a timer block with several general purpose
+timers that can be used.
+
+Required properties:
+
+- compatible	: should contain "brcm,brcmstb-timers"
+- reg		: the timers register range
+
-- 
2.9.3
