Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 00:36:26 +0200 (CEST)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:35047
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993967AbdFZWeIevS0t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jun 2017 00:34:08 +0200
Received: by mail-qt0-x243.google.com with SMTP id w12so1879532qta.2;
        Mon, 26 Jun 2017 15:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aJhhyQVBvUoipPvqx9d7uQDaxqSaCEb7sFQxjFzQfQo=;
        b=Bpc2x06/mSmqhr8eTArItl641NrnnstyRcD3INIS2jLgx0F/qZgrulZgYRklqjTody
         bfEgfM66QcpewT2u6U/mZmGHGEucAtaAWzFygxyp4gBIoqmlT9gzPvc5ZcR2zcKIpez/
         HzjQdjd5LDT90KdiqMU4qpqtQH+c1JGVacclIWk3ngknEoAg4/T8RxIVPF0ZyI66ic+2
         N0bsq9yv18vLGWWhxaAm1RW4QVH3ntlg1ps0UGWET32cI6Phg9yaXlHE1hWC/qCd2pyD
         RbuyjXf7zSNEryQXYpE6UkU3ZFtV+ZlAVGrUyg0efjO2qgyXsUZoKoy4PO4/N7+pHtG+
         nM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aJhhyQVBvUoipPvqx9d7uQDaxqSaCEb7sFQxjFzQfQo=;
        b=RIEszM12vjtfPwxw5StAnqe3pNur8WB8gRaeBoWTJzORU1g27zSBnhRUNlgvmu6uVo
         l5bRRw2gXgaWcBGnF5GVA7dp/k0WwV0BHmbSlSCc6CGRD0ZhCy0UEHmfN0tV0jfKNZvG
         Qu3ejVtLR656jKCbOJbgMn1ln/61fO/cIoCh588UtHowv0YJWGBALEWExl4gwFiUcB47
         eQ6Gp/NDg1HhmPWB8hTfIvLQQc4w8aRrOLeit7bXVFff9neyGP2fWNRvOSrXPj88uM//
         p/4cIlesRXgwJ/UoN148oOu4eOSdcioAigSymfsEF33t+mu3ON8iXm3KCkZMOxbpnio0
         Rbag==
X-Gm-Message-State: AKS2vOwqQCkcoyuo4+AuO8AhrlyKD+IGGX94TDSo490TDLYaDVjdcqXP
        oWAMAv2zs1yGGg==
X-Received: by 10.200.37.139 with SMTP id e11mr3310467qte.112.1498516442990;
        Mon, 26 Jun 2017 15:34:02 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id j65sm965542qkf.38.2017.06.26.15.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 15:34:02 -0700 (PDT)
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
Subject: [PATCH 3/4] dt-bindings: Document the Broadcom STB wake-up timer node
Date:   Mon, 26 Jun 2017 15:32:46 -0700
Message-Id: <20170626223248.14199-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170626223248.14199-1-f.fainelli@gmail.com>
References: <20170626223248.14199-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58818
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

Document the binding for the Broadcom STB SoCs wake-up timer node
allowing the system to generate alarms and exit low power states.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/rtc/brcm,brcmstb-waketimer.txt        | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt

diff --git a/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt b/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt
new file mode 100644
index 000000000000..1d990bcc0baf
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt
@@ -0,0 +1,22 @@
+Broadcom STB wake-up Timer
+
+The Broadcom STB wake-up timer provides a 27Mhz resolution timer, with the
+ability to wake up the system from low-power suspend/standby modes.
+
+Required properties:
+- compatible     : should contain "brcm,brcmstb-waketimer"
+- reg            : the register start and length for the WKTMR block
+- interrupts     : The TIMER interrupt
+- interrupt-parent: The phandle to the Always-On (AON) Power Management (PM) L2
+                    interrupt controller node
+- clocks	 : The phandle to the UPG fixed clock (27Mhz domain)
+
+Example:
+
+waketimer@f0411580 {
+	compatible = "brcm,brcmstb-waketimer";
+	reg = <0xf0411580 0x14>;
+	interrupts = <0x3>;
+	interrupt-parent = <&aon_pm_l2_intc>;
+	clocks = <&upg_fixed>;
+};
-- 
2.9.3
