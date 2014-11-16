Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:25:22 +0100 (CET)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:63762 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013779AbaKPAT6QhFM4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:58 +0100
Received: by mail-pd0-f181.google.com with SMTP id z10so1621933pdj.40
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1lm+xpzfGem2J3pknXK2UOatthZ9YRvEXJB3PBAIrqI=;
        b=OWtUdG3OdlI8EMdlAlTasULANWU8uUp0u1swOgs6SqPWKafggE6xQAsM7Y5FoiQE2G
         fs+PXAfkCFZT2ED6jCfEJ+s+CxSfFrTU5brA0ikGM0b33qznJdH4swrC/j4Jdv3I32j8
         Dl8m0i6WVyZnStJyoDAc4b1YPUKxaI5Aa4gaml//Lj0m0W3mGj58huuYeUQNP1+powrJ
         BfoiXX0Ph7uuyMB4WYNvSDBMh2GG1uQzxOf8N/BIDH4LWB3bkds/dgu48HBdtKGKBywY
         rqQuLzZjrJBYha0+8VmHv40IbRsWPsLLWHp/OKeiHXxXZbwhpqHQEVdtBrvybrRAULl1
         apxA==
X-Received: by 10.70.136.66 with SMTP id py2mr20118395pdb.48.1416097192490;
        Sat, 15 Nov 2014 16:19:52 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:51 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 21/22] MAINTAINERS: Add entry for BMIPS multiplatform kernel
Date:   Sat, 15 Nov 2014 16:17:45 -0800
Message-Id: <1416097066-20452-22-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Add myself as a maintainer for the new BMIPS target.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ab20b4..e96b4ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2108,6 +2108,18 @@ S:	Maintained
 F:	arch/arm/mach-bcm/*brcmstb*
 F:	arch/arm/boot/dts/bcm7*.dts*
 
+BROADCOM BMIPS MIPS ARCHITECTURE
+M:	Kevin Cernekee <cernekee@gmail.com>
+M:	Florian Fainelli <f.fainelli@gmail.com>
+L:	linux-mips@linux-mips.org
+S:	Maintained
+F:	arch/mips/bmips/*
+F:	arch/mips/include/asm/mach-bmips/*
+F:	arch/mips/kernel/*bmips*
+F:	arch/mips/boot/dts/bcm*.dts*
+F:	drivers/irqchip/irq-bcm7*
+F:	drivers/irqchip/irq-brcmstb*
+
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Prashant Sreedharan <prashant@broadcom.com>
 M:	Michael Chan <mchan@broadcom.com>
-- 
2.1.1
