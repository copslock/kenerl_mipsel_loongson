Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 05:00:07 +0100 (CET)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:48400 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011833AbaJ2D7QbwBA4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 04:59:16 +0100
Received: by mail-pd0-f175.google.com with SMTP id y13so2124126pdi.20
        for <multiple recipients>; Tue, 28 Oct 2014 20:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eg1PyhKWGwL5tsDRan0uiRJciOJIXeLZxA6+VCNoTaA=;
        b=BKJ6OUkdpJDhUy+H/EPB1pwNIWcBdnCCxFGKGwGM5iRJd0azh6lvlRUQzrHZvHKhOC
         KQoIPCY3hQNHBbmdRuq11PtSq4C3A/t0zoArBMbHfJSgjf0lhOwwH+5DMoH0s3k2AoNo
         ph8mmaq1wi9zteRm9MRr32qskH/Y1Om2oCtV6lpbmLWGZVK1wLj6VxgJ/sKYwvCJYvLT
         wcp03ALCy87YWS+6+AUOLYZLAc0LOUxIZAgKKBM6/lMp5uDWp5QtNCRbUUtsK7e7HTlT
         M97K5M6aefpCieHdV1Ve2u5hvOoj59ZBUqrrVPgaFBJ/7m4P0PZWHagh1t0Va7E4Whuh
         798A==
X-Received: by 10.66.220.3 with SMTP id ps3mr8102464pac.8.1414555150453;
        Tue, 28 Oct 2014 20:59:10 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id kj9sm2946249pbc.37.2014.10.28.20.59.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 28 Oct 2014 20:59:09 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH 04/11] irqchip: Remove ARM dependency for bcm7120-l2 and brcmstb-l2
Date:   Tue, 28 Oct 2014 20:58:51 -0700
Message-Id: <1414555138-6500-4-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43674
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
---
 drivers/irqchip/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 6f0e80b..6a03c65 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -53,7 +53,6 @@ config ATMEL_AIC5_IRQ
 
 config BRCMSTB_L2_IRQ
 	bool
-	depends on ARM
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
-- 
2.1.1
