Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 07:57:31 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:37102 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010604AbbHGF5aJbKGG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2015 07:57:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Message-Id:Date:Subject:Cc:To:From; bh=55LPD0fQvK8pc+JiEqsMP/Iy/XeK23sNoq3fpMv/JiI=;
        b=vsKU/52rVbd9gqbQ8EgIFl7/iwlRqAPL/MZ5RNPIGsUGUjKpTRd8vCpAQBqesdSYe9dKSsbiWI6BSAuauuQOkFi5qiwYrTbC8tvZVz/pJZ9hKA/vWVtbr+jH34gX/QHQxLgZARpNCHNrEggjDQ13QRBV6dVEmnEz7Rh68rfhN3o=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:38774 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1ZNaef-002Qhg-PO; Fri, 07 Aug 2015 05:57:22 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] mips: Fix console output for Fulong2e system
Date:   Thu,  6 Aug 2015 22:57:16 -0700
Message-Id: <1438927036-1435-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.1.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48702
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

Commit 3adeb2566b9b ("MIPS: Loongson: Improve LEFI firmware interface")
made the number of UARTs dynamic if LEFI_FIRMWARE_INTERFACE is configured.
Unfortunately, it did not initialize the number of UARTs if
LEFI_FIRMWARE_INTERFACE is not configured. As a result, the Fulong2e
system has no console.

Fixes: 3adeb2566b9b ("MIPS: Loongson: Improve LEFI firmware interface")
Cc: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Never mind my earlier e-mail, I figured it out.
Should be a candidate for stable (v3.19+, ie v4.1 in practice).

 arch/mips/loongson64/common/env.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/common/env.c
index f6c44dd332e2..d6d07ad56180 100644
--- a/arch/mips/loongson64/common/env.c
+++ b/arch/mips/loongson64/common/env.c
@@ -64,6 +64,9 @@ void __init prom_init_env(void)
 	}
 	if (memsize == 0)
 		memsize = 256;
+
+	loongson_sysconf.nr_uarts = 1;
+
 	pr_info("memsize=%u, highmemsize=%u\n", memsize, highmemsize);
 #else
 	struct boot_params *boot_p;
-- 
2.1.4
