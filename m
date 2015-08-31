Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Aug 2015 06:20:16 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:52162 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006764AbbHaEUOHoBk2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Aug 2015 06:20:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Message-Id:Date:Subject:Cc:To:From; bh=1XQeb5HPBj2szmvNdSdCUpTJF3tmp7q68sHPPbTYlEE=;
        b=Ejtx7Qkt4MpGQlvSZtx68UTqDm3otLOTM/1GImV2ZjiBZ+8ST8B2OZopozEOnJcEre/LGxMWeS/yo2txzvdRrVv80U5gclA99OXUOuHRwS6khvaw6hJ5n0NjQdsTHUDGoNyPmXDgwS+SU693bZtaMUy0tAxqDQ/+DonssSfkuqk=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41924 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1ZWGZg-0021rn-Ox; Mon, 31 Aug 2015 04:20:05 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] MIPS: Fix console output for Fulong2e system
Date:   Sun, 30 Aug 2015 21:19:58 -0700
Message-Id: <1440994798-14032-1-git-send-email-linux@roeck-us.net>
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
X-archive-position: 49070
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
Acked-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Changed subject to 'MIPS'
    Added Acked-by:
    Rebased to v4.2 and re-tested with qemu

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
