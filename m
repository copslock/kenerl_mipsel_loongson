Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Apr 2016 22:46:30 +0200 (CEST)
Received: from mail-ob0-f179.google.com ([209.85.214.179]:35430 "EHLO
        mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026769AbcDPUq3P2AVH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Apr 2016 22:46:29 +0200
Received: by mail-ob0-f179.google.com with SMTP id n10so19601564obb.2
        for <linux-mips@linux-mips.org>; Sat, 16 Apr 2016 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wmJstHIczQ72X61LUWvNefY/GdO3raS/ErYUXp7eets=;
        b=tJwXTmPPZuXtJqpL1jO1XzEBK4eVxusogY+qP6h4TCNg49XVr81kXW9HTaTyBHrDYB
         BMxlZaaLNVimAKDlRPftXjvfh5Xq6HTATKRee0SFuQFJ27jHOVNNqQvQmvQVayFrauWS
         gE5a6CAR+To7FYd0VL/23M9KBsTnzkttXvY4iQlzLglFkIiuBBvu53GjsfPnDERWLLBq
         T1RgGCFNAxM263suAK25/HBzzAnjm09G0b7M7TCfySh8WA66U1eLCvS3A3juvUiRDKpI
         2aHspL2S5DXIrXtPNsxiaLHD/mOCig7G8NbGg5AL3UO7E/LpwV4xM5YZdOaFE9fNVFLk
         t+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wmJstHIczQ72X61LUWvNefY/GdO3raS/ErYUXp7eets=;
        b=G25kGY5QrY/eqnvLlcKl7JyzA8tolVxrOjrR/PrxJ6USlaIiJMiedJbE93hSc9+9uC
         /DkpdMpqoKQvs+l5boa57wfUATrP5YNeRzB4GmKyNjljUgHlfB73Ry5+E0DFyNQ02Hf/
         769oPOqneU/ENfI+FMzBHHvM/++Fc20n9O3FMvMSXf18MgeqKRztteP4qyE29/zSXTMU
         ETzyL/5Frh0A1zhuZGZ6nEx/GWy+3gZhJw55JL5OKEEnMcvjfNBVhWYD82raVz2gAC6c
         XqH9a0lllZhzYjf6dKU+HaHgaSBFiGK3X/PGbaXCQYe/hJ8r1E+x8T6M4O7mHO06XATG
         lZEQ==
X-Gm-Message-State: AOPr4FX9Yc+x5SwKCosdeVso80RSXPK5xCsZjOekkVi3NlnVC4bXIiLoXVw8UaqG0MYmWA==
X-Received: by 10.60.52.35 with SMTP id q3mr14047301oeo.42.1460839583254;
        Sat, 16 Apr 2016 13:46:23 -0700 (PDT)
Received: from bender.lan (ip68-5-39-32.oc.oc.cox.net. [68.5.39.32])
        by smtp.gmail.com with ESMTPSA id vi2sm16725895obb.8.2016.04.16.13.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Apr 2016 13:46:22 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Russell King <linux@arm.linux.org.uk>,
        Olof Johansson <olof@lixom.net>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Chen-Yu Tsai <wens@csie.org>,
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] bus: brcmstb_gisb: Rework dependencies
Date:   Sat, 16 Apr 2016 13:46:14 -0700
Message-Id: <1460839575-16869-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.5.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53026
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

Do not have the machine Kconfig entry point need to select
BRCMSTB_GISB_ARB, instead, just let it be default ARCH_BRCMSTB which is
a better way to deal with this. While at it, also make it default
BMIPS_GENERIC so the legacy MIPS-based STB platforms can benefit from
the same thing.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- put conditional on the same line, do not use two default lines

 arch/arm/mach-bcm/Kconfig | 1 -
 drivers/bus/Kconfig       | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index b95ea1135ef9..68ab6412392a 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -173,7 +173,6 @@ config ARCH_BRCMSTB
 	select ARM_GIC
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
-	select BRCMSTB_GISB_ARB
 	select BRCMSTB_L2_IRQ
 	select BCM7120_L2_IRQ
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index d4a3a3133da5..8807495e0efd 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -58,6 +58,7 @@ config ARM_CCN
 config BRCMSTB_GISB_ARB
 	bool "Broadcom STB GISB bus arbiter"
 	depends on ARM || MIPS
+	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
 	  Driver for the Broadcom Set Top Box System-on-a-chip internal bus
 	  arbiter. This driver provides timeout and target abort error handling
-- 
2.5.0
