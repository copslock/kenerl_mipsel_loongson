Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2015 03:10:24 +0100 (CET)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:45968 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013096AbbBQCJiHFjRo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Feb 2015 03:09:38 +0100
Received: by pdjz10 with SMTP id z10so40182834pdj.12
        for <linux-mips@linux-mips.org>; Mon, 16 Feb 2015 18:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RFHRo+pfGN7Iq+nTed0Z1brwZcN7wNzIw5NvQ3nS8RA=;
        b=RzsJfoKIR6+8FPSoXBlXmxcr9vpnq7cqA4VIgDYRpLOVveK0uKRVlQob91yMDRYSw6
         V4BEsKB0kktd9JmHudk3RJMnuGrxWlAIl3UroCosE/P5pvrw2uBDytqBbqkHKOm9Vl8H
         1tEX5tl7YwPg1uxN4E3Pyu5c2E9TJy4w6wvbD9j2p1JvlRX4OZ1zVlTl4tBgKm3soU4V
         np5aekc7oHAERuCtl7NEJluTd/iiTZs2K35ZM3i+I7VfEhvYP6cmD8qzDSDuOLf5K1sP
         ODicFqy67uKF1Qsk/0PmMDD574YOfw/XvRZw5n7VC7K25LFvHctyE3McsfporBpHZ5dh
         pykw==
X-Received: by 10.66.118.238 with SMTP id kp14mr44383772pab.111.1424138972560;
        Mon, 16 Feb 2015 18:09:32 -0800 (PST)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id cq5sm13624562pbc.79.2015.02.16.18.09.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Feb 2015 18:09:31 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mpm@selenic.com, herbert@gondor.apana.org.au, wsa@the-dreams.de,
        cernekee@gmail.com, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 3/4] MIPS: BCM63xx: remove RSET_RNG register definitions
Date:   Mon, 16 Feb 2015 18:09:15 -0800
Message-Id: <1424138956-11563-4-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1424138956-11563-1-git-send-email-f.fainelli@gmail.com>
References: <1424138956-11563-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45837
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

Now that these definitions have been moved to
drivers/char/hw_random/bcm63xx-rng.c where they belong to make the
driver standalone, we can safely remove these definitions from
bcm63xx_regs.h.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 4794067cb5a7..5035f09c5427 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -1259,20 +1259,6 @@
 #define M2M_DSTID_REG(x)		((x) * 0x40 + 0x18)
 
 /*************************************************************************
- * _REG relative to RSET_RNG
- *************************************************************************/
-
-#define RNG_CTRL			0x00
-#define RNG_EN				(1 << 0)
-
-#define RNG_STAT			0x04
-#define RNG_AVAIL_MASK			(0xff000000)
-
-#define RNG_DATA			0x08
-#define RNG_THRES			0x0c
-#define RNG_MASK			0x10
-
-/*************************************************************************
  * _REG relative to RSET_SPI
  *************************************************************************/
 
-- 
2.1.0
