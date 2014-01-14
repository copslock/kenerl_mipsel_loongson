Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2014 07:09:40 +0100 (CET)
Received: from mail-ob0-f182.google.com ([209.85.214.182]:64384 "EHLO
        mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826582AbaANGIkMqlD- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jan 2014 07:08:40 +0100
Received: by mail-ob0-f182.google.com with SMTP id wn1so6849664obc.13
        for <multiple recipients>; Mon, 13 Jan 2014 22:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LHvBy3vUqjsBgoE664HtiD3m+spCtLK7gJBZFcyA5Qc=;
        b=GYBkqBwSdMbu6TYK3YoxgEhloI+mFdwP7dRQaBAQlvx3AZqUBdcCA2TsNe3jDoAVp6
         2rn0ObaukFnwjfgUfGcHisByRW0msQJjIitUZvm7sYm+/ioSPQZoC/3u0NHHWRaJbs0T
         /QPf2ZS+LvbKzkzzUblm/gRHNgdiwzhRBJggVq0r9t6Jm1Q4VfeXvyB8JZ1543RtB3NN
         OlmcsAkSv0YGRvwSaElVDihc1KqPzk+kQyXJcAmS9AI3vD5Klgl6qV/cxvi1F/etqBlY
         iocstqxaclS8DwbmJkJSsMSAL3xB9AdYgCFsOMH8XpUsZZvqy5MKB3Hp7bZKJA4mtP14
         40BQ==
X-Received: by 10.182.221.230 with SMTP id qh6mr23561174obc.7.1389679714132;
        Mon, 13 Jan 2014 22:08:34 -0800 (PST)
Received: from localhost.localdomain (ip68-5-18-231.oc.oc.cox.net. [68.5.18.231])
        by mx.google.com with ESMTPSA id nw5sm24074812obc.9.2014.01.13.22.08.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 Jan 2014 22:08:33 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, jogo@openwrt.org,
        mbizon@freebox.fr, cernekee@gmail.com, dgcbueu@gmail.com,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH v3 3/3] MIPS: BCM63XX: select correct MIPS_L1_CACHE_SHIFT value
Date:   Mon, 13 Jan 2014 22:07:32 -0800
Message-Id: <1389679652-14269-4-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1389679652-14269-1-git-send-email-f.fainelli@gmail.com>
References: <1389679652-14269-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38969
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

From: Florian Fainelli <florian@openwrt.org>

Broadcom BCM63xx DSL SoCs have a L1-cache line size of 16 bytes (shift
value of 4) instead of the currently configured 32 bytes L1-cache line
size.

Reported-by: Daniel Gonzalez <dgcbueu@gmail.com>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes in v2:
- rebased on top of john's mips-next-3.14

Changes since v1:
- rebased

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 68969d9..beb3766 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -139,6 +139,7 @@ config BCM63XX
 	select SWAP_IO_SPACE
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
+	select MIPS_L1_CACHE_SHIFT_4
 	help
 	 Support for BCM63XX based boards
 
-- 
1.8.3.2
