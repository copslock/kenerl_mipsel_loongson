Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 03:22:52 +0100 (CET)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:62317 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012256AbaJ3CT6LYDXv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 03:19:58 +0100
Received: by mail-pa0-f51.google.com with SMTP id kq14so4456339pab.10
        for <multiple recipients>; Wed, 29 Oct 2014 19:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tjPEmFBZBdGRQMyHVqR7Wa//Jjkmh7h5mvBYaufuTYI=;
        b=ppnilY15Ws3d9DMQfZ3hNc/cclA6OGPJpF2owB97HhdHY3O8YySE5c02KYEV0uW2Kl
         vpeL/CvXpgSBX84Gp26+IZzRVPp8P6UPuAsLEV3DcBiZZkVe0qGtyVlG51vPriNBGAsK
         shL6uM+a7pLwoBAi8ASMUW6H3aDDpwb/YvyoOKgK3X/2BZVodnViMYDT0Wbj21XwA0aj
         AOFK5E2HAsoUBLCcnVoMZuVencm2I9oFl3Bdgkda0SKrYVOxYrGKBX2FqxKDNbUdlCCM
         Xru3UMWXhlB+xbHlbkEtSw4+xhkwi17ssTdNocSaaHFnU/QCBxGKPry+mS+dB4PS7oA/
         EiyQ==
X-Received: by 10.66.155.2 with SMTP id vs2mr6037151pab.135.1414635592104;
        Wed, 29 Oct 2014 19:19:52 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id d17sm5524269pdj.32.2014.10.29.19.19.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Oct 2014 19:19:51 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V2 09/15] irqchip: Remove ARM dependency for bcm7120-l2 and brcmstb-l2
Date:   Wed, 29 Oct 2014 19:18:02 -0700
Message-Id: <1414635488-14137-10-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43748
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

This can compile for MIPS (or anything else) now.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b21f12f..09c79d1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -50,7 +50,6 @@ config ATMEL_AIC5_IRQ
 
 config BRCMSTB_L2_IRQ
 	bool
-	depends on ARM
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
-- 
2.1.1
