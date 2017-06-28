Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 17:56:49 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:56223 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993988AbdF1P4KrOQ38 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jun 2017 17:56:10 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 5FB441A47F5;
        Wed, 28 Jun 2017 17:56:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 4427C1A47F1;
        Wed, 28 Jun 2017 17:56:05 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Goran Ferenc <goran.ferenc@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 2/4] MIPS: VDSO: Add implementation of clock_gettime() fallback
Date:   Wed, 28 Jun 2017 17:55:29 +0200
Message-Id: <1498665337-28845-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1498665337-28845-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1498665337-28845-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Goran Ferenc <goran.ferenc@imgtec.com>

This patch adds clock_gettime_fallback() function that wraps assembly
invocation of clock_gettime() syscall using __NR_clock_gettime.

This function is used if pure VDSO implementation of clock_gettime()
does not succeed for any reason. For example, it is called if the
clkid parameter of clock_gettime() is not one of the clkids listed
in the switch-case block of the function __vdso_clock_gettime()
(one such case for clkid is CLOCK_BOOTIME).

If syscall invocation via __NR_clock_gettime fails, register a3 will
be set. So, after the syscall, register a3 is tested and the return
value is negated if it's set.

Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/vdso/gettimeofday.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofday.c
index fd7d433..5f63375 100644
--- a/arch/mips/vdso/gettimeofday.c
+++ b/arch/mips/vdso/gettimeofday.c
@@ -20,6 +20,24 @@
 #include <asm/unistd.h>
 #include <asm/vdso.h>
 
+static __always_inline long clock_gettime_fallback(clockid_t _clkid,
+					   struct timespec *_ts)
+{
+	register struct timespec *ts asm("a1") = _ts;
+	register clockid_t clkid asm("a0") = _clkid;
+	register long ret asm("v0");
+	register long nr asm("v0") = __NR_clock_gettime;
+	register long error asm("a3");
+
+	asm volatile(
+	"       syscall\n"
+	: "=r" (ret), "=r" (error)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return error ? -ret : ret;
+}
+
 static __always_inline int do_realtime_coarse(struct timespec *ts,
 					      const union mips_vdso_data *data)
 {
@@ -207,7 +225,7 @@ int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 int __vdso_clock_gettime(clockid_t clkid, struct timespec *ts)
 {
 	const union mips_vdso_data *data = get_vdso_data();
-	int ret;
+	int ret = -1;
 
 	switch (clkid) {
 	case CLOCK_REALTIME_COARSE:
@@ -223,10 +241,11 @@ int __vdso_clock_gettime(clockid_t clkid, struct timespec *ts)
 		ret = do_monotonic(ts, data);
 		break;
 	default:
-		ret = -ENOSYS;
 		break;
 	}
 
-	/* If we return -ENOSYS libc should fall back to a syscall. */
+	if (ret)
+		ret = clock_gettime_fallback(clkid, ts);
+
 	return ret;
 }
-- 
2.7.4
