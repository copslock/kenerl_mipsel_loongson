Return-Path: <SRS0=gTW6=P2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C13C43612
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 16:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D2920850
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 16:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfARQ0B (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:26:01 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:34459 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfARQ0A (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 18 Jan 2019 11:26:00 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MJm8N-1gUmN93A53-00K81C; Fri, 18 Jan 2019 17:19:46 +0100
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
Subject: [PATCH v2 23/29] timex: change syscalls to use struct __kernel_timex
Date:   Fri, 18 Jan 2019 17:18:29 +0100
Message-Id: <20190118161835.2259170-24-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kVG9L0004kjVGZ3jTNXRJe2zDldO8i8hhwk/XZl6p/GXzXXvSu2
 S5s+hnfGO6V8L06OXZk9Nmq1uc5XK0SX/tvCGfMVZwqYFwiNbnQCEsDmqBr0jqt+TgbwpgG
 rE1jCFnNroPTGvKPMDwi6YeE/oC7sqo/dZ97spnSvZMQuFdzPWZsc1U7WyjH13VgDKbUZqy
 Al7mfxahnL861tlGnkoFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GdtX94h4lho=:D72s1WJjk91cfsUv/xJSqk
 yzlJcqUOV0iT14rOcK/hs9wT1klyjDNQTUkHZpOc88O3AF/voluPHRS4rQ+QgeMruMrPrMGyY
 sAOjOsrQ1j+eg1PqxQ8lYmIjGjEHhUjaJQdxrUHr7T9ujCGTiHC68Ee88iNIrqzAv8MoZx+Lo
 /rJ124C6Bz8SG88nu7FouNfocgaJ3Jq9o74/5Tz9mpIVzORSZLNB60Wox966FvxADKx1i5dUF
 2Kgm1xJUJ5p4Zerg0lijTxObrW/DJH/XIvcSeSc+o8P6NQOi/U6VaC5H0VlBukKAn9INqr4th
 dZ77teZe8xj1dM3o4NXA5KGQ7q2PGCEkRUvhIR+XYEWbklVCHlFGL1PN7ghP+g+R2Ep3tc4gM
 JOc2LvGsidceO6hVIM3WurIQXhNj8xYs4AVI/IiN2Y4UhFS1aFIvMQflPtHS2PzcZ7M12YGFX
 BTVZq4feGk7odojU0biV2c3YxZ+gOBpUajQ6PmScmmBAVUqSUyrNAuUbNEehuxSbgeTSX6z1V
 Vsjkii2fGyz4HPp6xswrIWzQdA1esCwzoqCOJZjItDgSa6z7TRtu7mc5R/ngtD1VZwgcRRSHH
 IxW5flI9YidANdrFLlZ+DicbDV17BjJ4uj5++7QKTRjVivKB5bUazZOfdxTDL97j10Q71uiam
 mbyJmAXxxLD46k3jDXn8vRyhstR7k0CTVbIC/1VrCDV2a1UY5t1SCmJVUygvCU/QG0u0GvjK+
 6q6ELhMwdPbWhoh0P8PUJ4cEasNYJS7FO5SRFg==
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Deepa Dinamani <deepa.kernel@gmail.com>

struct timex is not y2038 safe.
Switch all the syscall apis to use y2038 safe __kernel_timex.

Note that sys_adjtimex() does not have a y2038 safe solution.  C libraries
can implement it by calling clock_adjtime(CLOCK_REALTIME, ...).

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h   | 6 +++---
 kernel/time/posix-timers.c | 2 +-
 kernel/time/time.c         | 4 +++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index baa4b70b02d3..09330d5bda0c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -54,7 +54,7 @@ struct __sysctl_args;
 struct sysinfo;
 struct timespec;
 struct timeval;
-struct timex;
+struct __kernel_timex;
 struct timezone;
 struct tms;
 struct utimbuf;
@@ -695,7 +695,7 @@ asmlinkage long sys_gettimeofday(struct timeval __user *tv,
 				struct timezone __user *tz);
 asmlinkage long sys_settimeofday(struct timeval __user *tv,
 				struct timezone __user *tz);
-asmlinkage long sys_adjtimex(struct timex __user *txc_p);
+asmlinkage long sys_adjtimex(struct __kernel_timex __user *txc_p);
 
 /* kernel/timer.c */
 asmlinkage long sys_getpid(void);
@@ -870,7 +870,7 @@ asmlinkage long sys_open_by_handle_at(int mountdirfd,
 				      struct file_handle __user *handle,
 				      int flags);
 asmlinkage long sys_clock_adjtime(clockid_t which_clock,
-				struct timex __user *tx);
+				struct __kernel_timex __user *tx);
 asmlinkage long sys_syncfs(int fd);
 asmlinkage long sys_setns(int fd, int nstype);
 asmlinkage long sys_sendmmsg(int fd, struct mmsghdr __user *msg,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 2d84b3db1ade..de79f85ae14f 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1060,7 +1060,7 @@ int do_clock_adjtime(const clockid_t which_clock, struct __kernel_timex * ktx)
 }
 
 SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_clock,
-		struct timex __user *, utx)
+		struct __kernel_timex __user *, utx)
 {
 	struct __kernel_timex ktx;
 	int err;
diff --git a/kernel/time/time.c b/kernel/time/time.c
index d179d33f639a..78b5c8f1495a 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -263,7 +263,8 @@ COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
 }
 #endif
 
-SYSCALL_DEFINE1(adjtimex, struct timex __user *, txc_p)
+#if !defined(CONFIG_64BIT_TIME) || defined(CONFIG_64BIT)
+SYSCALL_DEFINE1(adjtimex, struct __kernel_timex __user *, txc_p)
 {
 	struct __kernel_timex txc;		/* Local copy of parameter */
 	int ret;
@@ -277,6 +278,7 @@ SYSCALL_DEFINE1(adjtimex, struct timex __user *, txc_p)
 	ret = do_adjtimex(&txc);
 	return copy_to_user(txc_p, &txc, sizeof(struct __kernel_timex)) ? -EFAULT : ret;
 }
+#endif
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
 int get_old_timex32(struct __kernel_timex *txc, const struct old_timex32 __user *utp)
-- 
2.20.0

