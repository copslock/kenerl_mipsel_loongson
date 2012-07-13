Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 10:48:19 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:63991 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903481Ab2GMIrb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jul 2012 10:47:31 +0200
Received: by bkcji2 with SMTP id ji2so2825838bkc.36
        for <multiple recipients>; Fri, 13 Jul 2012 01:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XRP8s9bp9IpjPfAmln11Q2TXKl+uJAi2FqSiCyCltPE=;
        b=hQhyHuUfORxg/CGSH2Bxl1FMffaF9blZjldTGbcxPtV8IGaTmgU8ydTOPeqq7ccl2T
         t+MzAZbRqwIioA20Lxb7X1mB1aHDoBpbvCUBJg4DcujRVQRB9thUUN0FRGSOfacf8PmY
         FromeYhcqpEuZ5L3ASlW+5cqtyGbBU0cI5s1z2O3P9oqWh7d+Z7VGltnGU7lDyZ8Redt
         rQ2K3r69DK/3rKpg3XUSk2VixvPiCh42wluzj/Ypd+I0JLPdBMvaDIXz9FhZuujFge4M
         BNSEc0wHa/lpsXSMBzVzn3Zt2tQRtJdQ2vx4i2B9frxLbKuR+ukAZNe0vR5vTvureDcc
         tjQg==
Received: by 10.204.154.74 with SMTP id n10mr181638bkw.60.1342169246362;
        Fri, 13 Jul 2012 01:47:26 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-145-009.pools.arcor-ip.net. [88.73.145.9])
        by mx.google.com with ESMTPS id hg13sm4243506bkc.7.2012.07.13.01.47.24
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Jul 2012 01:47:25 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 2/3] MIPS: BCM63XX: don't write to the chipid register on reboot
Date:   Fri, 13 Jul 2012 10:46:04 +0200
Message-Id: <1342169165-18382-3-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1342169165-18382-1-git-send-email-jonas.gorski@gmail.com>
References: <1342169165-18382-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 33905
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Maxime Bizon <mbizon@freebox.fr>

While harmless, it is bad style to do so.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/setup.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index bd83836..314231b 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -86,6 +86,9 @@ void bcm63xx_machine_reboot(void)
 	}
 
 	for (i = 0; i < 2; i++) {
+		if (!perf_regs[i])
+			break;
+
 		reg = bcm_perf_readl(perf_regs[i]);
 		if (BCMCPU_IS_6348()) {
 			reg &= ~EXTIRQ_CFG_MASK_ALL_6348;
-- 
1.7.2.5
