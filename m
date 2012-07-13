Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 09:59:28 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:34252 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903439Ab2GMH7W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jul 2012 09:59:22 +0200
Received: by bkcji2 with SMTP id ji2so2802728bkc.36
        for <multiple recipients>; Fri, 13 Jul 2012 00:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=OBy3lEWbECer/IAkfViMyphRAJJDD3ncB3OQGMe3A6g=;
        b=bBZ8rcV2h5dPn+6uxBlHNDXU0p2AhmB5sdI2tbgOXKsb9kfsZoXcEvKcwF99qZU/rC
         SJRRCvkGlTo/VJVIIcn56I8zohbgzStHNKVwAfrIIRDcNuEVLmr+obSOYG1v8WXPfBty
         1IkiXMN55DM/hBMaa1y7SIs0/wIkL5sgJ16xIAmBEezZkq9QGDcfIpOR3CTvS3Y3URQ4
         7mLM92OlaDduWplxQfFD4fPu0WQMppiEo9e0KPi9Xacb2WTJDJVdHEgBg94wi5vIi9LT
         myMsL9CnsyZqE8SRjPJCEXP549tosJdpNno/lM8aVHB+bG8lTPd070GWnLs6OUjMHbfB
         N/0g==
Received: by 10.204.157.156 with SMTP id b28mr111108bkx.27.1342166357150;
        Fri, 13 Jul 2012 00:59:17 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-145-009.pools.arcor-ip.net. [88.73.145.9])
        by mx.google.com with ESMTPS id o4sm4150114bkv.15.2012.07.13.00.59.15
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Jul 2012 00:59:16 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Viresh Kumar <viresh.kumar@st.com>,
        Russell King <linux@arm.linux.org.uk>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH] MIPS: BCM63XX: select HAVE_CLK
Date:   Fri, 13 Jul 2012 09:58:35 +0200
Message-Id: <1342166315-17765-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 33900
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

BCM63XX implements the clk interface, but does not advertise it.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---

This fixes a build failure in linux-next caused by
5afae362dc79cb8b6b3965422d13d118c63d4ee4 ("clk: Add non CONFIG_HAVE_CLK
routines"):

  CC      arch/mips/bcm63xx/clk.o
arch/mips/bcm63xx/clk.c:285:5: error: redefinition of 'clk_enable'
include/linux/clk.h:294:19: note: previous definition of 'clk_enable' was here

and so on (I think you have already seen one of these).

@Andrew: This patch should apply cleanly to any tree, so maybe you
could add it to your patch series in front of the mentioned
patch, to keep bisectability for bcm63xx.

@Ralf: I hope it is okay for you that this goes through a different
tree.

 arch/mips/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 09ab87e..80d9199 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -122,6 +122,7 @@ config BCM63XX
 	select SYS_HAS_EARLY_PRINTK
 	select SWAP_IO_SPACE
 	select ARCH_REQUIRE_GPIOLIB
+	select HAVE_CLK
 	help
 	 Support for BCM63XX based boards
 
-- 
1.7.2.5
