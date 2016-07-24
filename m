Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jul 2016 02:00:33 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:33961 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990778AbcGXAA0eqUkg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Jul 2016 02:00:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From;
        bh=+lJosto0MtExF5iGcc/3Txt+Das6TiWT/B5R3Zt0toM=; b=G4RTBVdkQPgaiLJe9StlrD78oC
        5xC4Z/kAiIuQuDyrYKO5Zu9kWzNDCpdVjCnaEPa7lvubBeFl7xn1DcK0gE28QLzo1pl5eD4ZerUJJ
        1jHHO4z0P3bl5hyBVxii2RkLyZtf9AmTm9CfSBujVgwzxREymWFYI6dimPh03+Ug2t2yhHOsiHeYS
        pUflsSYI0MBSSHKztOm7VjT/LF+FflucF9umYehvz2qAyvY1IhReUxWgSvDtZ8vc/MpOu3kayEEpB
        1A/e8PydyU2AM2ZlHBPiYG2j3XUMAFaU4poLg1g5lFJ3uvvoJuzJE/VOP2EaEDEVBFYZkwaHM0lB+
        9dFXZ7cw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:35334 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1bR6q9-002pZi-Jj; Sun, 24 Jul 2016 00:00:18 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next] MIPS: ath79: Add missing include file
Date:   Sat, 23 Jul 2016 17:00:15 -0700
Message-Id: <1469318415-1834-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.5.0
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Commit ddd0ce87bfde ("mips: Remove unnecessary of_platform_populate with
default match table") dropped the include of linux/clk-provider.h from
arch/mips/ath79/setup.c. This results in the following build error.

arch/mips/ath79/setup.c: In function 'ath79_of_plat_time_init':
arch/mips/ath79/setup.c:232:2: error:
	implicit declaration of function 'of_clk_init'

Fixes: ddd0ce87bfde ("mips: Remove unnecessary of_platform_populate with default match table")
Cc: Rob Herring <robh@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/mips/ath79/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 8887eb1ffc73..3a0019deb7f7 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -17,6 +17,7 @@
 #include <linux/bootmem.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/of_fdt.h>
 
 #include <asm/bootinfo.h>
-- 
2.5.0
