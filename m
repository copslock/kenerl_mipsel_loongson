Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Mar 2017 19:26:26 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:38618 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990600AbdCES0T6Zmnp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Mar 2017 19:26:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KjrWd1gII6//eDFCjC7x5s4oIC4WfJ27UOOyDlSw4s8=; b=s6NtDgcyMHYxoxhEPgX/QA1A/2
        ueyTD/gRbQ++Cb8/dusbXFYtBgQWYocLO8rDBMFGROMfxcoeNZCuVWO/xacqGqb06bq9dLSxHy+c5
        RRk6+GXW7Zud9DsIGif4VDachldRRb5DQseOoz8oQ5G2MJEevnmStWJ2PY2UtAo56boSa5U8igk5k
        s7TygDP6PWtwDjPZsiuNEd4PTYM9KzTGYTmCBO05wY147loeRcr84zLHDulc3vyjlGodF1lLx128m
        Vd2p/MEO2NpIpUzYAvlwWqFVkxXMeryqYuRYcMh0WgM57Apt8IdAMdVzRLHILFwcziR2cZtkkpE9b
        6sxebU0g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41994 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.87)
        (envelope-from <linux@roeck-us.net>)
        id 1ckarF-000cx9-JZ; Sun, 05 Mar 2017 18:26:14 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] MIPS: Fix build breakage caused by header file change
Date:   Sun,  5 Mar 2017 10:26:09 -0800
Message-Id: <1488738369-24186-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-archive-position: 57043
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

Since commit f3ac60671954 ("sched/headers: Move task-stack related APIs
from <linux/sched.h> to <linux/sched/task_stack.h>"), various mips builds
fail as follows.

arch/mips/kernel/smp-mt.c: In function ‘vsmp_boot_secondary’:
arch/mips/include/asm/processor.h:384:41: error:
	implicit declaration of function ‘task_stack_page’

Fixes: f3ac60671954 ("sched/headers: Move task-stack related APIs ...")
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/mips/kernel/smp-mt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index e077ea3e11fb..effc1ed18954 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -18,7 +18,7 @@
  * Copyright (C) 2006 Ralf Baechle (ralf@linux-mips.org)
  */
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
 #include <linux/cpumask.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip/mips-gic.h>
-- 
2.7.4
