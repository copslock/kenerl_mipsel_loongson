Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2017 23:37:29 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:35559
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993891AbdBSWhXL60hX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Feb 2017 23:37:23 +0100
Received: by mail-wm0-x243.google.com with SMTP id u63so11446370wmu.2;
        Sun, 19 Feb 2017 14:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=32EQQ3eSEnuVeOtd/pZ8GiHQ375HccTRNTGA7ouAYbE=;
        b=V2dZKmFWwkPH3FEP+jmKKxV0Gn91A5JY49EBEhjFb0tmY+N/CyIrfMdn45h/bE6V4m
         ORQIzwa/+DYflej7pc5dqNDYY6iHaBkx0c8WB2vzYcSE7uFh8Dlxg3+6vTtHB79tFUNc
         lZl13fk9YSQ0VpE3bDQvi75lpAXfvckwi+oekTfo0KM1joWBYp5p/ZNtWgZ1/W4eG+lK
         U/NsdXx7ryZDp7/dyLoEm7BfNJ+IVC4kOitC0i7gYMPBoiNb6ZbSti3v5wxCtY6WqOwA
         RQxsoKO7S912hlU85t+48QXiWkf6oEYhRmLQSthJltU72KNnh/04RV4bW/9jjqREzUup
         fpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=32EQQ3eSEnuVeOtd/pZ8GiHQ375HccTRNTGA7ouAYbE=;
        b=g2Xd1jtSo4S6p0bshRSGjGHS49PEs1yR90VZv0c61mvPudx9cKzmF94Z8Vi3waRxOh
         GPPR6NoIQqNKeOkSigyfEXNgVyp5kAReVMG0NFNznnP5J5lRCOriu2r47dTQUtiX0uzI
         mzVcMF2vBwxqbr5JugfrBeEsvQCgCXJwsQrjAS72HgUw4jL5JKYaAnwmDjQAyGs6qqkv
         A1KELYMg/QZX/4rRmR4B3yElaSvnKQQlXXe/Gf6cfyn6VjkAGcRlIgBKUKvrjhdKSjqB
         KWivh7YFOg9isGPH2fkRPQSaocbmA2paUfeIgw+UMHpf6jOH+P2JOtKac0GruTzrL4+k
         Qz3w==
X-Gm-Message-State: AMke39nUoKvIDf8s7CNunuTG4jJri0tMWff1Muwr62YTFSIgCcb4ll3xutGaX/94IrvyBA==
X-Received: by 10.28.109.218 with SMTP id b87mr8518275wmi.52.1487543836685;
        Sun, 19 Feb 2017 14:37:16 -0800 (PST)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id 65sm22302808wri.53.2017.02.19.14.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Feb 2017 14:37:16 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH] MIPS: BCM63XX: fix ENETDMA_6345_MAXBURST_REG offset
Date:   Sun, 19 Feb 2017 23:37:07 +0100
Message-Id: <20170219223707.3999-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.11.0
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

The channels are only 0x40 bytes large, so 0x40 would be the next one's
CHANCFG_REG. Also the position makes it clear that this was intended to
be 0x04. So clearly a typo.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 5035f09c5427..24080af570f9 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -710,7 +710,7 @@
 /* Broadcom 6345 ENET DMA definitions */
 #define ENETDMA_6345_CHANCFG_REG	(0x00)
 
-#define ENETDMA_6345_MAXBURST_REG	(0x40)
+#define ENETDMA_6345_MAXBURST_REG	(0x04)
 
 #define ENETDMA_6345_RSTART_REG		(0x08)
 
-- 
2.11.0
