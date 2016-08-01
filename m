Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2016 05:36:12 +0200 (CEST)
Received: from mail5.windriver.com ([192.103.53.11]:57028 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992870AbcHADgFovmEJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Aug 2016 05:36:05 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u713ZuQv023132
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
        Sun, 31 Jul 2016 20:35:56 -0700
Received: from yow-lpgnfs-02.corp.ad.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Sun, 31 Jul 2016 20:35:55 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH] clocksource: mips-gic-timer: make gic_clocksource_of_init return int
Date:   Sun, 31 Jul 2016 23:35:46 -0400
Message-ID: <20160801033546.26472-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.8.4
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

In commit d8152bf85d2c057fc39c3e20a4d623f524d9f09c:
  ("clocksource/drivers/mips-gic-timer: Convert init function to return error")

several return values were added to a void function resulting in:

 clocksource/mips-gic-timer.c: In function 'gic_clocksource_of_init':
 clocksource/mips-gic-timer.c:175:3: warning: 'return' with a value, in function returning void [enabled by default]
 clocksource/mips-gic-timer.c:183:4: warning: 'return' with a value, in function returning void [enabled by default]
 clocksource/mips-gic-timer.c:190:3: warning: 'return' with a value, in function returning void [enabled by default]
 clocksource/mips-gic-timer.c:195:3: warning: 'return' with a value, in function returning void [enabled by default]
 clocksource/mips-gic-timer.c:200:3: warning: 'return' with a value, in function returning void [enabled by default]
 clocksource/mips-gic-timer.c:211:2: warning: 'return' with a value, in function returning void [enabled by default]
 clocksource/mips-gic-timer.c: At top level:
 clocksource/mips-gic-timer.c:213:1: warning: comparison of distinct pointer types lacks a cast [enabled by default]
 clocksource/mips-gic-timer.c: In function 'gic_clocksource_of_init':
 clocksource/mips-gic-timer.c:183:18: warning: ignoring return value of 'PTR_ERR', declared with attribute warn_unused_result [-Wunused-result]

Given that the addition of the return values was intentional, it seems
that the conversion of the containing function from void to int was
simply overlooked.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/clocksource/mips-gic-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index d91e8725917c..b4b3ab5a11ad 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -164,7 +164,7 @@ void __init gic_clocksource_init(unsigned int frequency)
 	gic_start_count();
 }
 
-static void __init gic_clocksource_of_init(struct device_node *node)
+static int __init gic_clocksource_of_init(struct device_node *node)
 {
 	struct clk *clk;
 	int ret;
-- 
2.8.4
