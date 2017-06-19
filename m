Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:55:50 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58861 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993886AbdFSPuJTsjnH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 17:50:09 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id DC23B1A4879;
        Mon, 19 Jun 2017 17:50:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.ba.imgtec.org (unknown [82.117.201.26])
        by mail.rt-rk.com (Postfix) with ESMTPSA id BC8DD1A490A;
        Mon, 19 Jun 2017 17:50:03 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com
Cc:     Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        Miodrag.Dinic@imgtec.com, Goran.Ferenc@imgtec.com
Subject: [PATCH 3/4] MIPS: VDSO: Add implementation of gettimeofday() fallback
Date:   Mon, 19 Jun 2017 17:49:57 +0200
Message-Id: <1497887398-13772-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1497887398-13772-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1497887398-13772-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58624
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

This patch adds gettimeofday_fallback() function that wraps assembly
invocation of gettimeofday() syscall using __NR_gettimeofday.

This function is used if pure VDSO implementation gettimeofday()
does not succeed for any reason. Its imeplementation is enclosed in
"#ifdef CONFIG_MIPS_CLOCK_VSYSCALL" to be in sync with the similar
arrangement for __vdso_gettimeofday().

If syscall invocation via __NR_gettimeofday fails, register a3 will
be set. So, after the syscall, register a3 is tested and the return
valuem is negated if it's set.

Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/vdso/gettimeofday.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofday.c
index 5f63375..23305bf 100644
--- a/arch/mips/vdso/gettimeofday.c
+++ b/arch/mips/vdso/gettimeofday.c
@@ -20,6 +20,28 @@
 #include <asm/unistd.h>
 #include <asm/vdso.h>
 
+#ifdef CONFIG_MIPS_CLOCK_VSYSCALL
+
+static __always_inline long gettimeofday_fallback(struct timeval *_tv,
+					  struct timezone *_tz)
+{
+	register struct timezone *tz asm("a1") = _tz;
+	register struct timeval *tv asm("a0") = _tv;
+	register long ret asm("v0");
+	register long nr asm("v0") = __NR_gettimeofday;
+	register long error asm("a3");
+
+	asm volatile(
+	"       syscall\n"
+	: "=r" (ret), "=r" (error)
+	: "r" (tv), "r" (tz), "r" (nr)
+	: "memory");
+
+	return error ? -ret : ret;
+}
+
+#endif
+
 static __always_inline long clock_gettime_fallback(clockid_t _clkid,
 					   struct timespec *_ts)
 {
@@ -205,7 +227,7 @@ int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 
 	ret = do_realtime(&ts, data);
 	if (ret)
-		return ret;
+		return gettimeofday_fallback(tv, tz);
 
 	if (tv) {
 		tv->tv_sec = ts.tv_sec;
-- 
2.7.4
