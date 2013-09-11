Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Sep 2013 18:10:00 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:60340 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824790Ab3IKQJryHThQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Sep 2013 18:09:47 +0200
Received: by mail-pd0-f180.google.com with SMTP id y10so9335452pdj.39
        for <multiple recipients>; Wed, 11 Sep 2013 09:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hDB2FA95ldzs2K8vcq9VeEdnBQxIqVFZMw4Khkb+DaQ=;
        b=vk//IEB0iXLsmHaJkYyh3V+hjuaoHRdZmA0VhVcSQWUDv7eGbtfxg8Z1PBHN4aiC0h
         fDGXGOMQrvw2NB7fJg0NR2LuyLDGMYYHbxAfh4QHemvd076UKLFXlZ3bcZViYv7IXcD5
         rhQTCL+wxn11UIHIY4rLcyIdMEVMzQWv4HhKKlcnwqNZMydN4MCZsSUEpBAldCssRO9R
         ZCE7KJBT4zvnMsE2B3iAYpKOJitubcAPgjOoTL3kmb+EaW/FUhVYF0HEdv8FwyofyNr+
         gNmKphhOq1gki9iRn8v7ClT0yFy1jD/hqEtg86xYSEtLQSym1Kcuvkc0xTQVBkjBkigR
         FdXA==
X-Received: by 10.68.197.104 with SMTP id it8mr2668128pbc.17.1378915781209;
        Wed, 11 Sep 2013 09:09:41 -0700 (PDT)
Received: from localhost.localdomain ([114.250.76.12])
        by mx.google.com with ESMTPSA id u7sm12734166pbf.12.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Sep 2013 09:09:40 -0700 (PDT)
From:   Jiang Liu <liuj97@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Shaohua Li <shli@kernel.org>
Cc:     liuj97@gmail.com, Jiang Liu <jiang.liu@huawei.com>,
        Ingo Molnar <mingo@elte.hu>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Kosina <trivial@kernel.org>,
        Wang YanQing <udknight@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH v2 11/25] smp, mips: kill redundant call of generic_smp_call_function_single_interrupt()
Date:   Thu, 12 Sep 2013 00:07:15 +0800
Message-Id: <1378915649-16395-12-git-send-email-liuj97@gmail.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1378915649-16395-1-git-send-email-liuj97@gmail.com>
References: <1378915649-16395-1-git-send-email-liuj97@gmail.com>
Return-Path: <liuj97@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liuj97@gmail.com
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

From: Jiang Liu <jiang.liu@huawei.com>

Since commit 9a46ad6d6df3b54 "smp: make smp_call_function_many() use
logic similar to smp_call_function_single()",
generic_smp_call_function_single_interrupt() is an alias of
generic_smp_call_function_interrupt(), so kill the redundant call.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>
---
 arch/mips/kernel/smp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 5c208ed..0a022ee 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -150,7 +150,6 @@ asmlinkage void start_secondary(void)
 void __irq_entry smp_call_function_interrupt(void)
 {
 	irq_enter();
-	generic_smp_call_function_single_interrupt();
 	generic_smp_call_function_interrupt();
 	irq_exit();
 }
-- 
1.8.1.2
