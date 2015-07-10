Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 16:09:44 +0200 (CEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:50267 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009607AbbGJOJmfADU1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 16:09:42 +0200
Received: from localhost.localdomain (a88-112-126-99.elisa-laajakaista.fi [88.112.126.99])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 0747C4043;
        Fri, 10 Jul 2015 17:09:41 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: Loongson 2F: fix broken build due incorrect includes
Date:   Fri, 10 Jul 2015 17:09:37 +0300
Message-Id: <1436537377-7138-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Commit 30ad29bb4888 ("MIPS: Loongson: Naming style cleanup and rework")
renamed mach-loongson to mach-loongson64. Some files are including
loongson.h using the asm/mach-loongson directory name, so the build
got broken. Fix by removing the directory name; the mach directory
is automatically in the include path.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/loongson64/lemote-2f/clock.c | 2 +-
 drivers/cpufreq/loongson2_cpufreq.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/loongson64/lemote-2f/clock.c b/arch/mips/loongson64/lemote-2f/clock.c
index 462e34d..d241434 100644
--- a/arch/mips/loongson64/lemote-2f/clock.c
+++ b/arch/mips/loongson64/lemote-2f/clock.c
@@ -15,7 +15,7 @@
 #include <linux/spinlock.h>
 
 #include <asm/clock.h>
-#include <asm/mach-loongson/loongson.h>
+#include <loongson.h>
 
 static LIST_HEAD(clock_list);
 static DEFINE_SPINLOCK(clock_lock);
diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index fc897ba..2e2738b 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -20,7 +20,7 @@
 #include <asm/clock.h>
 #include <asm/idle.h>
 
-#include <asm/mach-loongson/loongson.h>
+#include <loongson.h>
 
 static uint nowait;
 
-- 
2.4.0
