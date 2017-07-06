Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 00:25:30 +0200 (CEST)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:35692
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993941AbdGFWZGRosMb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 00:25:06 +0200
Received: by mail-wr0-x243.google.com with SMTP id z45so3569832wrb.2;
        Thu, 06 Jul 2017 15:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JWOmW3Bbc4DFW1MygRydNjkMRU9pK2725ssg/Kw/aNc=;
        b=SmeFXBarb+DRWyOqYjqhqhNZbE0wdHNQERoReZxaDAbBj3wRhS4f9juFI1KSlWDNmN
         pkgzQUI7DL9JcoTiSrrNrM40VHYKTzP5QwdKFp931r6142LTsN3K0JCXrXIqR7zCsveR
         iTAS/vas9f8qfeyCcj8KyPq4R2Fh23ddW3g3teqk5Zpmqe5N6Mho5QST8kt+HnhEUhgk
         QKh96kl6wFBauczRSZq1he2x2kUiTDHBuTL9j/T4k+DGEwmGRy14ukZYmxNWZCUtlRpM
         Q6qdZPv8ynP2IlogypqDAZb+XW1lWbzkt6VD8Mfaj+ZirdvlgUBbxInxlegtVgd/Bhkk
         uk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JWOmW3Bbc4DFW1MygRydNjkMRU9pK2725ssg/Kw/aNc=;
        b=q/zGNiyXnHMvqyLw6M4DmD2Yc3Am4F9v9/bsUN3LAPaBKMAVvejboEPHL73m52BvQs
         2ELFDuf/7G5shPzC200PZnS0zD2slOgoffcQrSY6rdkDapUceBXo/fRnxmH6/oul6J0L
         xX0sjEF5bREoL3jwpypOMst0Lt5AfmzdNyV52U9NdZGxiNx7yvhXSdyBrleR+mfk7l0V
         g5iDRzjiFx4K+iyf0Tci2ufAHrnva3O1aQlZVtDtYmRCgwCQmxXXA75hS8pUUPANW1d8
         1ybY+CqPpbFM6c7D+MhVcBnYzIyrSomxTiJcO+4PdlnfnDpor1DtpYpRcFkGO6n8jppF
         YVzg==
X-Gm-Message-State: AIVw112NJAe2DIW24+rCwR17VSs+UWltFI2iOcljlFftQo98FkfERTYx
        4TfKz8eWgpDYcA==
X-Received: by 10.28.133.3 with SMTP id h3mr77001wmd.77.1499379901074;
        Thu, 06 Jul 2017 15:25:01 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id o131sm1781301wmd.26.2017.07.06.15.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jul 2017 15:25:00 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
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
        ARM ARCHITECTURE),
        linux-mips@linux-mips.org (open list:BROADCOM BCM47XX MIPS ARCHITECTURE),
        linux-pm@vger.kernerl.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3 1/4] dt-bindings: ARM: brcmstb: Update Broadcom STB Power Management binding
Date:   Thu,  6 Jul 2017 15:22:22 -0700
Message-Id: <20170706222225.9758-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170706222225.9758-1-f.fainelli@gmail.com>
References: <20170706222225.9758-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59040
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

Acked-by: Rob Herring <robh@kernel.org>
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
