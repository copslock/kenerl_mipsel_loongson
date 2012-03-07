Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2012 09:20:11 +0100 (CET)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:34148 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901171Ab2CGITz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Mar 2012 09:19:55 +0100
Received: by lagy4 with SMTP id y4so9289587lag.36
        for <multiple recipients>; Wed, 07 Mar 2012 00:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=zRsfJqxctb4U+s/tBt+a0lrEHa893vFHoH5xG+pZyBQ=;
        b=MpbIMrFWClwoCn2iz5ySRDwOrGQHoNCvlUy5PHMiq0zl5QIj8MCXDVS4keV5S6pSk9
         87/5Anl6BWCRIz+3JZgmfeR8C7pmvS6S4AHQWzGos8tpFglce+amqVW6fo/fCKXbltcL
         VOYbEETGcQLdCsN5qCxCctwGwMwmN8Y6aD/CcgFf93jTokcIq5SnyF/siU8l0R9um4Sv
         XEWAwAyQNWGZ1vtH0O+qz8Qxz6VX0P7FDgiPrZaBLOGbIn3zVLLOKxgcYSwmFix5ZJ8f
         MxT0QCAnTl2accITCfywayIcbkPWzjihvI2EyOpmGC4FiwTpUovWPqwP+aM43fQS9zlE
         QR1A==
Received: by 10.112.85.136 with SMTP id h8mr375245lbz.72.1331108389317;
        Wed, 07 Mar 2012 00:19:49 -0800 (PST)
Received: from quince.NIISI (t35.niisi.ras.ru. [193.232.173.35])
        by mx.google.com with ESMTPS id k10sm32361667lbu.1.2012.03.07.00.19.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 00:19:48 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-mips@linux-mips.org,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [PATCH] MIPS: JZ4740: fix the JZ4740_IRQ_DMA macro
Date:   Wed,  7 Mar 2012 12:19:43 +0400
Message-Id: <1331108383-11308-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.8.3
X-archive-position: 32612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/include/asm/mach-jz4740/irq.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/irq.h b/arch/mips/include/asm/mach-jz4740/irq.h
index a865c98..5ad1a9c 100644
--- a/arch/mips/include/asm/mach-jz4740/irq.h
+++ b/arch/mips/include/asm/mach-jz4740/irq.h
@@ -45,7 +45,7 @@
 #define JZ4740_IRQ_LCD		JZ4740_IRQ(30)
 
 /* 2nd-level interrupts */
-#define JZ4740_IRQ_DMA(x)	(JZ4740_IRQ(32) + (X))
+#define JZ4740_IRQ_DMA(x)	(JZ4740_IRQ(32) + (x))
 
 #define JZ4740_IRQ_INTC_GPIO(x) (JZ4740_IRQ_GPIO0 - (x))
 #define JZ4740_IRQ_GPIO(x)	(JZ4740_IRQ(48) + (x))
-- 
1.7.8.3
