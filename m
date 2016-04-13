Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2016 20:20:04 +0200 (CEST)
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33669 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026500AbcDMSUC3lcD5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Apr 2016 20:20:02 +0200
Received: by mail-pf0-f174.google.com with SMTP id 184so37555060pff.0
        for <linux-mips@linux-mips.org>; Wed, 13 Apr 2016 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3WhdQkNyDr0f94mo6TSlaNQD3amlDeddyHWapxshXIc=;
        b=AwuXYzn0GfEJOFNY0X0O7ghHG4umYkCdvxfMU3ek4dc/jOb800o/AmOjySuGjla/6V
         y2tSvPRL8qyu1JtB6fsGftU/JRFvTBGohHumSEzgUHu3+fjc9/95djq2v7vqQQKN/gKy
         SGPFsz+CV5SSx19qoYbJbbLjmC9p1hKTfWRFPJ7QvR2/CZiLfAW8S+WKiX6MLgS2mgCH
         tgpsdHZNxVTd6Ykzb64plm7/HsuHv2rOIahmhwnarS4dtzSzUYHEUDF24z7ZV9K5FM8R
         qoom4aH+JLV9aNrA0GskaJrrXQNV/Zot+fKVXl57DFpWe4zAuHaAcTVJ6GvxUt82Aezu
         b44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3WhdQkNyDr0f94mo6TSlaNQD3amlDeddyHWapxshXIc=;
        b=JIdNG1edOUG8q+6Ior0IqxfxaZR5VWn1cdsEeYb7mIBqxNRgyVbeUikfmC7YFPJrI3
         W3cKZ3sqtZoAm5I3kwmjQYfBacueAx2QrXsSS22B7snz98J3LdS8dn+qedFNibpJwQ/9
         AYsm18IK2Bl01WiN5ISI0YuH1DLHHkM7IdL1oF5v/BigrEnsdz/kl1aAaDAVUIlq4VTy
         8+r18R2pqHv7c2hr6P1Ge8HkwX4QcVZ1f4EliBNJpJpDyAaRHPWr1mkj/4pb0G//uPpa
         bXiuqSpQBDAfpuEoXjanRrlO5Y03adizPXwUu2HbZcG2qpQcka51lpfE523FMX8cUoq9
         xq8Q==
X-Gm-Message-State: AOPr4FVdzX43Tq+9jIqeV+mfORo1Q0D8M+UGs8wjLkVknLpe8aKxjLyQ6T8u7CtySyV/dA==
X-Received: by 10.98.70.67 with SMTP id t64mr14915648pfa.110.1460571596398;
        Wed, 13 Apr 2016 11:19:56 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id 17sm52598818pfp.96.2016.04.13.11.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Apr 2016 11:19:55 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Russell King <linux@arm.linux.org.uk>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Chen-Yu Tsai <wens@csie.org>,
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] bus: brcmstb_gisb: Rework dependencies
Date:   Wed, 13 Apr 2016 11:17:48 -0700
Message-Id: <1460571469-20201-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52973
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
 arch/arm/mach-bcm/Kconfig | 1 -
 drivers/bus/Kconfig       | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 7ef121472cdd..af10ff27a2ed 100644
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
index d4a3a3133da5..85c66e5028c1 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -58,6 +58,8 @@ config ARM_CCN
 config BRCMSTB_GISB_ARB
 	bool "Broadcom STB GISB bus arbiter"
 	depends on ARM || MIPS
+	default ARCH_BRCMSTB
+	default BMIPS_GENERIC
 	help
 	  Driver for the Broadcom Set Top Box System-on-a-chip internal bus
 	  arbiter. This driver provides timeout and target abort error handling
-- 
2.1.0
