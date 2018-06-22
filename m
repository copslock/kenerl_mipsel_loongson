Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2018 16:34:10 +0200 (CEST)
Received: from newton.telenet-ops.be ([195.130.132.45]:44882 "EHLO
        newton.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993104AbeFVOeDasv1f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2018 16:34:03 +0200
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by newton.telenet-ops.be (Postfix) with ESMTPS id 41C1KR0VKTzMqtH6
        for <linux-mips@linux-mips.org>; Fri, 22 Jun 2018 16:34:03 +0200 (CEST)
Received: from ayla.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id 1qa21y0083XaVaC06qa2Gs; Fri, 22 Jun 2018 16:34:02 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWN8U-00055H-1q; Fri, 22 Jun 2018 16:34:02 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWN8T-0001xf-W1; Fri, 22 Jun 2018 16:34:02 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        stable@vger.kernel.org
Subject: [PATCH v3] time: Make sure jiffies_to_msecs() preserves non-zero time periods
Date:   Fri, 22 Jun 2018 16:33:57 +0200
Message-Id: <20180622143357.7495-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

For the common cases where 1000 is a multiple of HZ, or HZ is a multiple
of 1000, jiffies_to_msecs() never returns zero when passed a non-zero
time period.

However, if HZ > 1000 and not an integer multiple of 1000 (e.g. 1024 or
1200, as used on alpha and DECstation), jiffies_to_msecs() may return
zero for small non-zero time periods.  This may break code that relies
on receiving back a non-zero value.

jiffies_to_usecs() does not need such a fix: one jiffy can only be
less than one µs if HZ > 1000000, and such large values of HZ are
already rejected at build time, twice:
  - include/linux/jiffies.h does #error if HZ >= 12288,
  - kernel/time/time.c has BUILD_BUG_ON(HZ > USEC_PER_SEC).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org
---
Broken since forever.

v3:
  - Add Reviewed-by,
  - Cc stable,
  - Explain better why jiffies_to_usecs() does not need a fix,

v2:
  - Add examples of affected systems,
  - Use DIV_ROUND_UP().
---
 kernel/time/time.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 6fa99213fc720e4b..2b41e8e2d31db26f 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -28,6 +28,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/kernel.h>
 #include <linux/timex.h>
 #include <linux/capability.h>
 #include <linux/timekeeper_internal.h>
@@ -314,9 +315,10 @@ unsigned int jiffies_to_msecs(const unsigned long j)
 	return (j + (HZ / MSEC_PER_SEC) - 1)/(HZ / MSEC_PER_SEC);
 #else
 # if BITS_PER_LONG == 32
-	return (HZ_TO_MSEC_MUL32 * j) >> HZ_TO_MSEC_SHR32;
+	return (HZ_TO_MSEC_MUL32 * j + (1ULL << HZ_TO_MSEC_SHR32) - 1) >>
+	       HZ_TO_MSEC_SHR32;
 # else
-	return (j * HZ_TO_MSEC_NUM) / HZ_TO_MSEC_DEN;
+	return DIV_ROUND_UP(j * HZ_TO_MSEC_NUM, HZ_TO_MSEC_DEN);
 # endif
 #endif
 }
-- 
2.17.1
