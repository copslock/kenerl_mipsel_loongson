Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 00:34:22 +0200 (CEST)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:32840
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993957AbdFZWdzza-tt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jun 2017 00:33:55 +0200
Received: by mail-qt0-x243.google.com with SMTP id c20so1886305qte.0;
        Mon, 26 Jun 2017 15:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wx/wjX7gmBGjikPjKO5Rr/1reBJQR5+LPE1FmGPSWZk=;
        b=KoCP/sLEaV8z/3k+Sxm2kq7KHmMPKeegr9UiM2OzG2/LiZYVpJvk7goRgSMFEFAQXy
         hJPqos1PfHXMWL3nyorBKWctq8yNTNGrsV75joGWLmS7COu/aH7qoRAtGwg6Qf3LMnEL
         bRdnt2wJWkcLlRteGUENI0sJiFApfJaRqDiYqlBBeQ4q9j7zw17Dl2gPW/lBgFxxJSdq
         Fg3qVHuwCEFjnSM/gpdQR60AXnOW3BInVXaLzGfGOtFDLsukQQ0unaskl8OZ81UOQypZ
         5oYC1/JAwj3iR8cAyk2NZLaBpjZ2UAGYY5fzm9FyWieGPwo6g17eR1K7EQttRIiIFtku
         /AJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wx/wjX7gmBGjikPjKO5Rr/1reBJQR5+LPE1FmGPSWZk=;
        b=rlfH9nSL5mzbGQOdz2VyaYZYZfUpYjLLhJJvBerreynxC2fhw/WEgzKO5hWZXFxvnP
         L0/6b59jRLNdRHuqr60cZH0Afl5Nd3o1a6EoezlE+OCQs0NrDaKU3vspjz68Tr959D0J
         39B2ImImIWxImILRqdhD6/Dsuub95aBZ6M8VYGWU7jfOWOTaGxt6eAzINM1uU8hgIUIZ
         9CvJNoh0us6bkF5l7GvuOSIVKADIGAiURPr/5kUA1DC/NU0qtUcWtZ3mtB4YDSW1QxzA
         tAsOjTzhuzd28GhDMxcdkmpJsTdQoAPd68JRZbNW3txO1rVJanotEIA6fT1aad+XtsOk
         JjGA==
X-Gm-Message-State: AKS2vOxrChHezOmK0M+CeyESh0DfBTTAhXCTzBpT3HJmzcoNx+upYj4g
        QdG6uxwlmAV9Ow==
X-Received: by 10.237.62.201 with SMTP id o9mr3149858qtf.4.1498516430276;
        Mon, 26 Jun 2017 15:33:50 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id j65sm965542qkf.38.2017.06.26.15.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 15:33:49 -0700 (PDT)
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
Subject: [PATCH v2 1/4] dt-bindings: ARM: brcmstb: Update Broadcom STB Power Management binding
Date:   Mon, 26 Jun 2017 15:32:41 -0700
Message-Id: <20170626223248.14199-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170626223248.14199-1-f.fainelli@gmail.com>
References: <20170626223248.14199-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58813
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

Update the Broadcom STB Power Management binding document with new
compatible strings for the DDR PHY and memory controller found on newer
chips.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
index 0d0c1ae81bed..790e6b0b8306 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
@@ -164,6 +164,8 @@ Control registers for this memory controller's DDR PHY.
 
 Required properties:
 - compatible     : should contain one of these
+	"brcm,brcmstb-ddr-phy-v71.1"
+	"brcm,brcmstb-ddr-phy-v72.0"
 	"brcm,brcmstb-ddr-phy-v225.1"
 	"brcm,brcmstb-ddr-phy-v240.1"
 	"brcm,brcmstb-ddr-phy-v240.2"
@@ -184,7 +186,9 @@ Sequencer DRAM parameters and control registers. Used for Self-Refresh
 Power-Down (SRPD), among other things.
 
 Required properties:
-- compatible     : should contain "brcm,brcmstb-memc-ddr"
+- compatible     : should contain one of these
+	"brcm,brcmstb-memc-ddr-rev-b.2.2"
+	"brcm,brcmstb-memc-ddr"
 - reg            : the MEMC DDR register range
 
 Example:
-- 
2.9.3
