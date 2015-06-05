Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2015 16:29:57 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:33599 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007480AbbFEO34A1LyG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jun 2015 16:29:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Message-Id:Date:Subject:Cc:To:From; bh=5gNIixhTNjrxz7+gtB9h2WmJoZOvR57mIhPGtJ5pKy0=;
        b=lN9EStYo9xo/gCAXdJYLuXlZVPrih4ipoLziZP2C+i2rcHnJbY8H1wIfk+OYDK2ZH/HcpWpg+TV3VZsYeivwEm2GflULyU6/htmahCkh52IFRxeNkVaG5zwZ3IhftA089HrkSblXDdpH4RJe53YALlGpBpsZ85C4sQOLakoueqU=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:50580 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1Z0sd2-003e4C-4Z; Fri, 05 Jun 2015 14:29:48 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH -next] MIPS: traps: Add missing include file
Date:   Fri,  5 Jun 2015 07:29:45 -0700
Message-Id: <1433514585-26380-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.1.0
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
X-archive-position: 47887
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

Commit 05155ddc2617 ("MIPS: get rid of 'kgdb_early_setup' cruft")
removed the include of linux/kgdb.h from arch/mips/kernel/traps.c.
This results in

arch/mips/kernel/traps.c: In function 'show_stack':
arch/mips/kernel/traps.c:204:14: error: 'kgdb_active' undeclared
arch/mips/kernel/traps.c: In function 'do_trap_or_bp':
arch/mips/kernel/traps.c:877:2: error:
		implicit declaration of function 'kgdb_ll_trap'

when building mips:allmodconfig.

Fixes: 05155ddc2617 ("MIPS: get rid of 'kgdb_early_setup' cruft")
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/mips/kernel/traps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index b5337a3447e7..2a7b38ed23f0 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -29,6 +29,7 @@
 #include <linux/bootmem.h>
 #include <linux/interrupt.h>
 #include <linux/ptrace.h>
+#include <linux/kgdb.h>
 #include <linux/kdebug.h>
 #include <linux/kprobes.h>
 #include <linux/notifier.h>
-- 
2.1.0
