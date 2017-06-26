Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 00:35:11 +0200 (CEST)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:32853
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993963AbdFZWeDZvRrt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jun 2017 00:34:03 +0200
Received: by mail-qt0-x244.google.com with SMTP id c20so1886739qte.0;
        Mon, 26 Jun 2017 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PgAVpv7u8U9ZFVNTmYOtT8EeMX8ba593qOqZf3qxjTk=;
        b=N/BNxv96zRTxTMYiYEKEapeyVw7Rz4w5uoaZ/kBNOXeDnX5g+r6WU5uvvXJF8UEY9G
         HWyrtBqSfnk8YGiRjkOmcCRPoMXDpYCWhT/bg/38Ce9JkQnWg55IS7PjCbeFm7JUQcHE
         ii10SnPotIF1Hpf1dA/IsPeEeHNJyvdPAXbz656HFqhSEG+XToIXPO7Fcjotg8W4B/p7
         dTj2EoKiCbLqap2OOxx4tNXgCqMXAi/JbP1hP2HRMiR8jza5Nw45aPT1byhxzDZuwTcY
         qzkgxlhTnN+f82IGpAPBuMRFWtOG4UII4MF3jvKVPwVUG/IyFHVfGUvBInSi2nsqR4NE
         UwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PgAVpv7u8U9ZFVNTmYOtT8EeMX8ba593qOqZf3qxjTk=;
        b=gkF4IwtgGMV6rLOL6YhbHKj1HhOo+Wjm36G4tcxCTrnRQoiTjJxM9Ml/oH1zJTLl+F
         iE3+HaeioN1pAJMimLj56zYnQzBLiEFbCC47neG4WeSciByjZ1LOrjcEyY26sLc1W/iz
         ysW4v4wWO1ZVZHHENf9SdTQ9uswXmMpMxo1CDxOG9JbKO46WfCGgPq18u81/fZYkGP8J
         gvo9gegKGQpkiuRCEzYIJoVmJ9/8a1YqiveokQkW5F/dDOQKoQOGV/Q306wVPIG1O6qe
         eEdF4f974xZ7aWk/gtBDSRAItNkUOgw0oKelL6qOcQDfzZbycGTbnbZBx4pZvztUTxwE
         6W1w==
X-Gm-Message-State: AKS2vOwkTf6LDCd3MFPBKps6eWzcUgIz6U7dHX7Ofu3YoYSRl6MRyr5x
        ltYVvFZpczi0Dw==
X-Received: by 10.200.3.46 with SMTP id q46mr700081qtg.3.1498516432990;
        Mon, 26 Jun 2017 15:33:52 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id j65sm965542qkf.38.2017.06.26.15.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 15:33:52 -0700 (PDT)
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
Subject: [PATCH 1/4] misc: sram: Allow ARM64 to select SRAM_EXEC
Date:   Mon, 26 Jun 2017 15:32:42 -0700
Message-Id: <20170626223248.14199-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170626223248.14199-1-f.fainelli@gmail.com>
References: <20170626223248.14199-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58815
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

Now that ARM64 also has a fncpy() implementation, allow selection
SRAM_EXEC for ARM64 as well.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 07bbd4cc1852..ac8779278c0c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -464,7 +464,7 @@ config SRAM
 	bool "Generic on-chip SRAM driver"
 	depends on HAS_IOMEM
 	select GENERIC_ALLOCATOR
-	select SRAM_EXEC if ARM
+	select SRAM_EXEC if ARM || ARM64
 	help
 	  This driver allows you to declare a memory region to be managed by
 	  the genalloc API. It is supposed to be used for small on-chip SRAM
-- 
2.9.3
