Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 23:37:56 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:33943
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994881AbdFPVh17VF2C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 23:37:27 +0200
Received: by mail-wm0-x242.google.com with SMTP id 70so7084585wme.1;
        Fri, 16 Jun 2017 14:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BFdAXoJX/J5KNmEN6MJ94K2xn0JHsEbixzX7FgRTEZU=;
        b=X3unWfkY4sdcnzZF7oacHhyjmHH+NmKGGYNlar73mOFV67I3mROLbSl/TELOXhsJ8Q
         sqNRrOb5bwna41O1Xyd2DDIxiC2yOpRYd673i4sGLmZwcJcVuEktfwY6OQcASD/WG7b/
         GpNF6c5HpgYqDC/Zd2GfKfL2DrQH+Oe+BApPSljvlX9TgkX+xiDQtRnGAJdaCjErBhC0
         rhO0wuxZmqXeFef8yb4OXDBthXEyk1Hu/58yB6AsfS58Tz2REQpJjbz1E7/l+gsMrIvl
         MQug3r2kFHnZoUuyl54E4QKTVpdWmhaab0WWGUE0TyCQGuBw8N9g5TkWRQpIma7zPOzJ
         nhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BFdAXoJX/J5KNmEN6MJ94K2xn0JHsEbixzX7FgRTEZU=;
        b=kz1IHxMyJ/RsvqLk1SDL6j2Eg3wQFBaUXXsn+/0fyjWfk+q96++vyTdUh+gAKDAVvE
         Qw84nxBwLQ1wpWFjSZBNzSynQqbK2cg/NPH4zfy/x3KuQY9OToKt3qi3LuIfg99Rh1Im
         YLis7cxIrsx+0KR/NNyZBNVYWNj3/Yly12CLkQexOr1ZNYe/MFtDWkfGokm7+u9YC28l
         j0PvKwpNxx4m/16zsnfMm9BJpm8ZG887gzom3AiebTEwwXEy8suPBx4FRnsXmJbyP8Co
         88t+8nJTMD5RuPiPZa4AaFqqu4ZfSK4bWWYScQNTIPUQBLUvIbZbee7zUa7oCi78smZo
         MhUw==
X-Gm-Message-State: AKS2vOwM0lxzpcqginz5avoLhgfFAR94qPKjLoj2kfTMNcTwlH+mI+AP
        Nxiui1HKiDIfwA==
X-Received: by 10.28.111.5 with SMTP id k5mr8456920wmc.19.1497649042599;
        Fri, 16 Jun 2017 14:37:22 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id w17sm2576546wra.34.2017.06.16.14.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2017 14:37:21 -0700 (PDT)
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
Subject: [PATCH 1/5] dt-bindings: Update Broadcom STB binding
Date:   Fri, 16 Jun 2017 14:36:59 -0700
Message-Id: <20170616213703.21487-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170616213703.21487-1-f.fainelli@gmail.com>
References: <20170616213703.21487-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58581
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

Update the Broadcom STB binding document with new compatible strings for
the DDR PHY and memory controller found on newer chips.

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
