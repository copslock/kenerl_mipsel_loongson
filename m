Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2011 12:03:46 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:53725 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491050Ab1FHKDk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jun 2011 12:03:40 +0200
Received: by fxm14 with SMTP id 14so267017fxm.36
        for <multiple recipients>; Wed, 08 Jun 2011 03:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Q+VN8wYqVzre7ftpcexUhGJRjHuq+XEgsVwK6dw/uqA=;
        b=JVKMnY9Oj9ApcQhEQG9uNlUpPIcHq8l1uNIxLf3TCA8F42feALaRNPUb9JvZdqW9Th
         kTXwLF36X9ZvKuYPaVALSjdH+9BIJFTS9hhaIjZhU+40AEiID1GRD7jao5oxgaigsK+Z
         DGeyZjLIIUw5p+Tjj7kwDYcx3ISNes1EV7MjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JatPD8WZ838YK84V6Af8lyEDX4Jnj4yOnXOTrEY6TgAiA6UyOq25ZMwYH6WuNuabad
         Br9xXDhLEklM+KSF59IKvax3eY8EfdLFG1TDsPa8/vSB9DfDn7rtMy1ZJE8oeEq0uQcg
         nkvDGvDFmOHrFDui/DNW1haddvbU1ZmgSYlu0=
Received: by 10.223.6.201 with SMTP id a9mr1992435faa.110.1307527414990;
        Wed, 08 Jun 2011 03:03:34 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-061-184.pools.arcor-ip.net [88.73.61.184])
        by mx.google.com with ESMTPS id e15sm153481faa.47.2011.06.08.03.03.33
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 03:03:34 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: bcm63xx: remove duplicate PERF_IRQSTAT_REG definition
Date:   Wed,  8 Jun 2011 12:03:02 +0200
Message-Id: <1307527382-23623-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 30293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6664


Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 85fd275..0ed5230 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -89,7 +89,6 @@
 
 /* Interrupt Mask register */
 #define PERF_IRQMASK_REG		0xc
-#define PERF_IRQSTAT_REG		0x10
 
 /* Interrupt Status register */
 #define PERF_IRQSTAT_REG		0x10
-- 
1.7.2.5
