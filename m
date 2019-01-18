Return-Path: <SRS0=gTW6=P2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAFCC43613
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 16:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924C020850
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 16:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfARQWd (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:22:33 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:33993 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbfARQVG (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 18 Jan 2019 11:21:06 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M2fDl-1go5tz06Sl-004FYq; Fri, 18 Jan 2019 17:19:40 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, mattst88@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org,
        davem@davemloft.net, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        jcmvbkbc@gmail.com, akpm@linux-foundation.org,
        deepa.kernel@gmail.com, ebiederm@xmission.com,
        firoz.khan@linaro.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 18/29] time: make adjtime compat handling available for 32 bit
Date:   Fri, 18 Jan 2019 17:18:24 +0100
Message-Id: <20190118161835.2259170-19-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:L9/OQwPQmqIrcoCAFJvf58bdFmxPCQDrpg5hoXttL62fnnkW6Rl
 i5YUAL/e0iSbG5RQj4MCfEWq9ECA0ytb02l0LesW+xkgXyG6UtlNHi8BSK5B79L4nWXxBGk
 E6Tz/7dTzNP/dUQu0VdlwFV7tn2zbDYz3I7ljfFHIJ2gv99DBWEfD5ODIp71gC6N8jAvgWj
 k1ehZE13GZhF/svJm/dNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d/VMRrwHTZA=:V595XJR4efcHtQN0xt0oVZ
 s3P1ZWkjeY3FFYEVxLJeWwTAa4ap8r59QbA+F0nNvQPNyk4EdLwiKX2msvtCxRwshzk0k/P4r
 oulKFF0l5QTvjjQwvOCckwXCEqrPyUkFkvA546ngVQVTKOax0G6hmLna9nc3FZ4A6ZMqiP/cd
 XYtkrd+3bAkG7whOYLHya+qgYU8fbt9X4yvO5ImNtc8lDApVS2AKrZJBOLXbHM4YbpGMT70e+
 dJqI/NJyGLNpvUet7I4PL1dftBgkbZ75NZDcM/sOGiD5VZMo+re7AHdgPyMOiW3/g68ATbn/9
 B+oU+1e35zvFGsT4eVIgWD94FeXuHDjsTFlNRoZojWJYENi5wBdyqBam3853dqKugPe3xjtaL
 FeyvMap1JdkyJFdwiNH6ekqp/sJM/hOs7wXspeYeyJSfv3CGg1oHlWBA+Tjf9U537WdQu28Xd
 Ce/kdTvRea6qX0RhJ4BLk7hZAt7jD60kxhv+bplI4jF++AaNBf3zzKqgB6fcdKgb5jPwhnxFL
 y5FsPbsalvUEfD/Mb5pLMTILJxN3rGDP71h4RQ0/XeU+jC7iMjTTf5ZnR0paAySYkN/T7kMwK
 PU3BETDkPWWH5LzD8DBs0XWWtU2T7G479UoEpUu4aaXQRuLgAlnGSjty4Vc7BqrkIIes5hrKS
 6H9uvc3AduDzfLElIgN5QgueRnnWXMlBVffc6VlSC2ZETfbx9DbFtwjvNfbNc7HwRgZZac9NS
 YkU4yImdc1RHhW6avDkWdGpIUuQ4qBvJo5eDaA==
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

We want to reuse the compat_timex handling on 32-bit architectures the
same way we are using the compat handling for timespec when moving to
64-bit time_t.

Move all definitions related to compat_timex out of the compat code
into the normal timekeeping code, along with a rename to old_timex32,
corresponding to the timespec/timeval structures, and make it controlled
by CONFIG_COMPAT_32BIT_TIME, which 32-bit architectures will then select.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/compat.h     | 35 ++-----------------
 include/linux/time32.h     | 32 ++++++++++++++++-
 kernel/compat.c            | 64 ----------------------------------
 kernel/time/posix-timers.c | 14 ++------
 kernel/time/time.c         | 70 +++++++++++++++++++++++++++++++++++---
 5 files changed, 102 insertions(+), 113 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 056be0d03722..657ca6abd855 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -132,37 +132,6 @@ struct compat_tms {
 	compat_clock_t		tms_cstime;
 };
 
-struct compat_timex {
-	compat_uint_t modes;
-	compat_long_t offset;
-	compat_long_t freq;
-	compat_long_t maxerror;
-	compat_long_t esterror;
-	compat_int_t status;
-	compat_long_t constant;
-	compat_long_t precision;
-	compat_long_t tolerance;
-	struct old_timeval32 time;
-	compat_long_t tick;
-	compat_long_t ppsfreq;
-	compat_long_t jitter;
-	compat_int_t shift;
-	compat_long_t stabil;
-	compat_long_t jitcnt;
-	compat_long_t calcnt;
-	compat_long_t errcnt;
-	compat_long_t stbcnt;
-	compat_int_t tai;
-
-	compat_int_t:32; compat_int_t:32; compat_int_t:32; compat_int_t:32;
-	compat_int_t:32; compat_int_t:32; compat_int_t:32; compat_int_t:32;
-	compat_int_t:32; compat_int_t:32; compat_int_t:32;
-};
-
-struct timex;
-int compat_get_timex(struct timex *, const struct compat_timex __user *);
-int compat_put_timex(struct compat_timex __user *, const struct timex *);
-
 #define _COMPAT_NSIG_WORDS	(_COMPAT_NSIG / _COMPAT_NSIG_BPW)
 
 typedef struct {
@@ -808,7 +777,7 @@ asmlinkage long compat_sys_gettimeofday(struct old_timeval32 __user *tv,
 		struct timezone __user *tz);
 asmlinkage long compat_sys_settimeofday(struct old_timeval32 __user *tv,
 		struct timezone __user *tz);
-asmlinkage long compat_sys_adjtimex(struct compat_timex __user *utp);
+asmlinkage long compat_sys_adjtimex(struct old_timex32 __user *utp);
 
 /* kernel/timer.c */
 asmlinkage long compat_sys_sysinfo(struct compat_sysinfo __user *info);
@@ -911,7 +880,7 @@ asmlinkage long compat_sys_open_by_handle_at(int mountdirfd,
 					     struct file_handle __user *handle,
 					     int flags);
 asmlinkage long compat_sys_clock_adjtime(clockid_t which_clock,
-					 struct compat_timex __user *tp);
+					 struct old_timex32 __user *tp);
 asmlinkage long compat_sys_sendmmsg(int fd, struct compat_mmsghdr __user *mmsg,
 				    unsigned vlen, unsigned int flags);
 asmlinkage ssize_t compat_sys_process_vm_readv(compat_pid_t pid,
diff --git a/include/linux/time32.h b/include/linux/time32.h
index 118b9977080c..820a22e2b98b 100644
--- a/include/linux/time32.h
+++ b/include/linux/time32.h
@@ -10,6 +10,7 @@
  */
 
 #include <linux/time64.h>
+#include <linux/timex.h>
 
 #define TIME_T_MAX	(time_t)((1UL << ((sizeof(time_t) << 3) - 1)) - 1)
 
@@ -35,13 +36,42 @@ struct old_utimbuf32 {
 	old_time32_t	modtime;
 };
 
+struct old_timex32 {
+	u32 modes;
+	s32 offset;
+	s32 freq;
+	s32 maxerror;
+	s32 esterror;
+	s32 status;
+	s32 constant;
+	s32 precision;
+	s32 tolerance;
+	struct old_timeval32 time;
+	s32 tick;
+	s32 ppsfreq;
+	s32 jitter;
+	s32 shift;
+	s32 stabil;
+	s32 jitcnt;
+	s32 calcnt;
+	s32 errcnt;
+	s32 stbcnt;
+	s32 tai;
+
+	s32:32; s32:32; s32:32; s32:32;
+	s32:32; s32:32; s32:32; s32:32;
+	s32:32; s32:32; s32:32;
+};
+
 extern int get_old_timespec32(struct timespec64 *, const void __user *);
 extern int put_old_timespec32(const struct timespec64 *, void __user *);
 extern int get_old_itimerspec32(struct itimerspec64 *its,
 			const struct old_itimerspec32 __user *uits);
 extern int put_old_itimerspec32(const struct itimerspec64 *its,
 			struct old_itimerspec32 __user *uits);
-
+struct timex;
+int get_old_timex32(struct timex *, const struct old_timex32 __user *);
+int put_old_timex32(struct old_timex32 __user *, const struct timex *);
 
 #if __BITS_PER_LONG == 64
 
diff --git a/kernel/compat.c b/kernel/compat.c
index f01affa17e22..d8a36c6ad7c9 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -20,7 +20,6 @@
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
 #include <linux/security.h>
-#include <linux/timex.h>
 #include <linux/export.h>
 #include <linux/migrate.h>
 #include <linux/posix-timers.h>
@@ -30,69 +29,6 @@
 
 #include <linux/uaccess.h>
 
-int compat_get_timex(struct timex *txc, const struct compat_timex __user *utp)
-{
-	struct compat_timex tx32;
-
-	memset(txc, 0, sizeof(struct timex));
-	if (copy_from_user(&tx32, utp, sizeof(struct compat_timex)))
-		return -EFAULT;
-
-	txc->modes = tx32.modes;
-	txc->offset = tx32.offset;
-	txc->freq = tx32.freq;
-	txc->maxerror = tx32.maxerror;
-	txc->esterror = tx32.esterror;
-	txc->status = tx32.status;
-	txc->constant = tx32.constant;
-	txc->precision = tx32.precision;
-	txc->tolerance = tx32.tolerance;
-	txc->time.tv_sec = tx32.time.tv_sec;
-	txc->time.tv_usec = tx32.time.tv_usec;
-	txc->tick = tx32.tick;
-	txc->ppsfreq = tx32.ppsfreq;
-	txc->jitter = tx32.jitter;
-	txc->shift = tx32.shift;
-	txc->stabil = tx32.stabil;
-	txc->jitcnt = tx32.jitcnt;
-	txc->calcnt = tx32.calcnt;
-	txc->errcnt = tx32.errcnt;
-	txc->stbcnt = tx32.stbcnt;
-
-	return 0;
-}
-
-int compat_put_timex(struct compat_timex __user *utp, const struct timex *txc)
-{
-	struct compat_timex tx32;
-
-	memset(&tx32, 0, sizeof(struct compat_timex));
-	tx32.modes = txc->modes;
-	tx32.offset = txc->offset;
-	tx32.freq = txc->freq;
-	tx32.maxerror = txc->maxerror;
-	tx32.esterror = txc->esterror;
-	tx32.status = txc->status;
-	tx32.constant = txc->constant;
-	tx32.precision = txc->precision;
-	tx32.tolerance = txc->tolerance;
-	tx32.time.tv_sec = txc->time.tv_sec;
-	tx32.time.tv_usec = txc->time.tv_usec;
-	tx32.tick = txc->tick;
-	tx32.ppsfreq = txc->ppsfreq;
-	tx32.jitter = txc->jitter;
-	tx32.shift = txc->shift;
-	tx32.stabil = txc->stabil;
-	tx32.jitcnt = txc->jitcnt;
-	tx32.calcnt = txc->calcnt;
-	tx32.errcnt = txc->errcnt;
-	tx32.stbcnt = txc->stbcnt;
-	tx32.tai = txc->tai;
-	if (copy_to_user(utp, &tx32, sizeof(struct compat_timex)))
-		return -EFAULT;
-	return 0;
-}
-
 static int __compat_get_timeval(struct timeval *tv, const struct old_timeval32 __user *ctv)
 {
 	return (!access_ok(ctv, sizeof(*ctv)) ||
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 0e84bb72a3da..8955f32f2a36 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1123,12 +1123,8 @@ COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
 	return err;
 }
 
-#endif
-
-#ifdef CONFIG_COMPAT
-
 COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
-		       struct compat_timex __user *, utp)
+		       struct old_timex32 __user *, utp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timex ktx;
@@ -1139,22 +1135,18 @@ COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
 	if (!kc->clock_adj)
 		return -EOPNOTSUPP;
 
-	err = compat_get_timex(&ktx, utp);
+	err = get_old_timex32(&ktx, utp);
 	if (err)
 		return err;
 
 	err = kc->clock_adj(which_clock, &ktx);
 
 	if (err >= 0)
-		err = compat_put_timex(utp, &ktx);
+		err = put_old_timex32(utp, &ktx);
 
 	return err;
 }
 
-#endif
-
-#ifdef CONFIG_COMPAT_32BIT_TIME
-
 COMPAT_SYSCALL_DEFINE2(clock_getres, clockid_t, which_clock,
 		       struct old_timespec32 __user *, tp)
 {
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 2edb5088a70b..2d013bc2b271 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -278,20 +278,82 @@ SYSCALL_DEFINE1(adjtimex, struct timex __user *, txc_p)
 	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
+int get_old_timex32(struct timex *txc, const struct old_timex32 __user *utp)
+{
+	struct old_timex32 tx32;
+
+	memset(txc, 0, sizeof(struct timex));
+	if (copy_from_user(&tx32, utp, sizeof(struct old_timex32)))
+		return -EFAULT;
+
+	txc->modes = tx32.modes;
+	txc->offset = tx32.offset;
+	txc->freq = tx32.freq;
+	txc->maxerror = tx32.maxerror;
+	txc->esterror = tx32.esterror;
+	txc->status = tx32.status;
+	txc->constant = tx32.constant;
+	txc->precision = tx32.precision;
+	txc->tolerance = tx32.tolerance;
+	txc->time.tv_sec = tx32.time.tv_sec;
+	txc->time.tv_usec = tx32.time.tv_usec;
+	txc->tick = tx32.tick;
+	txc->ppsfreq = tx32.ppsfreq;
+	txc->jitter = tx32.jitter;
+	txc->shift = tx32.shift;
+	txc->stabil = tx32.stabil;
+	txc->jitcnt = tx32.jitcnt;
+	txc->calcnt = tx32.calcnt;
+	txc->errcnt = tx32.errcnt;
+	txc->stbcnt = tx32.stbcnt;
+
+	return 0;
+}
+
+int put_old_timex32(struct old_timex32 __user *utp, const struct timex *txc)
+{
+	struct old_timex32 tx32;
+
+	memset(&tx32, 0, sizeof(struct old_timex32));
+	tx32.modes = txc->modes;
+	tx32.offset = txc->offset;
+	tx32.freq = txc->freq;
+	tx32.maxerror = txc->maxerror;
+	tx32.esterror = txc->esterror;
+	tx32.status = txc->status;
+	tx32.constant = txc->constant;
+	tx32.precision = txc->precision;
+	tx32.tolerance = txc->tolerance;
+	tx32.time.tv_sec = txc->time.tv_sec;
+	tx32.time.tv_usec = txc->time.tv_usec;
+	tx32.tick = txc->tick;
+	tx32.ppsfreq = txc->ppsfreq;
+	tx32.jitter = txc->jitter;
+	tx32.shift = txc->shift;
+	tx32.stabil = txc->stabil;
+	tx32.jitcnt = txc->jitcnt;
+	tx32.calcnt = txc->calcnt;
+	tx32.errcnt = txc->errcnt;
+	tx32.stbcnt = txc->stbcnt;
+	tx32.tai = txc->tai;
+	if (copy_to_user(utp, &tx32, sizeof(struct old_timex32)))
+		return -EFAULT;
+	return 0;
+}
 
-COMPAT_SYSCALL_DEFINE1(adjtimex, struct compat_timex __user *, utp)
+COMPAT_SYSCALL_DEFINE1(adjtimex, struct old_timex32 __user *, utp)
 {
 	struct timex txc;
 	int err, ret;
 
-	err = compat_get_timex(&txc, utp);
+	err = get_old_timex32(&txc, utp);
 	if (err)
 		return err;
 
 	ret = do_adjtimex(&txc);
 
-	err = compat_put_timex(utp, &txc);
+	err = put_old_timex32(utp, &txc);
 	if (err)
 		return err;
 
-- 
2.20.0

