Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2016 01:04:28 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33864 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013177AbcCDAE1QGZLK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2016 01:04:27 +0100
Received: by mail-pa0-f49.google.com with SMTP id fy10so23571571pac.1
        for <linux-mips@linux-mips.org>; Thu, 03 Mar 2016 16:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=JJ23uzs0nZfr5zV1y6SvLuhEKSrxPcIv3AgqKiaVLQA=;
        b=EK6TO1mIToU6YNdDVSjB1PyWa+VXaG6323ROsYjXKgz6O7kkHuFh5haVrfQsJMvgbn
         aNT3qPdR6lZFBYxU17zJc76H1ISobZ7L/qA8wGFhdCqblXxOvbN4Q9sRSZRvJnSPz502
         AdCS01YWafckIjl7cJOZuaEBJ30orEbLhzIOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JJ23uzs0nZfr5zV1y6SvLuhEKSrxPcIv3AgqKiaVLQA=;
        b=S1tR8oPl4uq+XYgpc6KTgxn7LI25xhkICcII5Mwfy0kweUmnBCVJHokcynEcO6ZVQW
         z1FID5hOhsZLoooyncqA86fwP4f9RnzcTRCgiJeg7Auc4BZTo7WzDiG1YA6YSvEob+qE
         0fSQk7gt1n1raqmoEdVyISVXcUHRLirOMi2653ZXz5FtmkiHGNgIiZySp8gmV5nxl4Nf
         8PJHVYeFEE+gAkdFdIFXgiHLlU/6tunJhQ5KlCbSi8JEk4rJNyLE5GzYwuHtItsQH2nn
         ObJV2AF1Dvkyg8whlJ0eSEBUevA3XO7tQrH49wDJS5DVXUTubMwngP2e8GizXVgn99OP
         jhgw==
X-Gm-Message-State: AD7BkJIArYBxziBtiejlM2dH9aNei7T4Qssp5JKQ1bRrS5VrW13I5LF0qMLsbli0shFYAQ==
X-Received: by 10.67.30.163 with SMTP id kf3mr7679871pad.45.1457049861301;
        Thu, 03 Mar 2016 16:04:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 12sm174364pfr.22.2016.03.03.16.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2016 16:04:20 -0800 (PST)
Date:   Thu, 3 Mar 2016 16:04:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Milko Leporis <milko.leporis@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [RFC][PATCH] selftests/seccomp: add MIPS self-test support
Message-ID: <20160304000418.GA13322@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

This adds self-test support on MIPS. (On at least Bionic, the siginfo
headers require pid_t and clock_t to be defined first, so this meant
moving the sys/types.h include to before siginfo.h.)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
I don't have hardware at the moment to test this. Can someone check this?
It's based on my best guess about the syscall ABI (v0 for syscall and
return value, which is regs[2]).
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index b9453b838162..bf59558fd50d 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -5,6 +5,7 @@
  * Test code for seccomp bpf.
  */
 
+#include <sys/types.h>
 #include <asm/siginfo.h>
 #define __have_siginfo_t 1
 #define __have_sigval_t 1
@@ -14,7 +15,6 @@
 #include <linux/filter.h>
 #include <sys/prctl.h>
 #include <sys/ptrace.h>
-#include <sys/types.h>
 #include <sys/user.h>
 #include <linux/prctl.h>
 #include <linux/ptrace.h>
@@ -1242,6 +1242,10 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 # define ARCH_REGS     s390_regs
 # define SYSCALL_NUM   gprs[2]
 # define SYSCALL_RET   gprs[2]
+#elif defined(__mips__)
+# define ARCH_REGS	struct pt_regs
+# define SYSCALL_NUM	regs[2]
+# define SYSCALL_RET	regs[2]
 #else
 # error "Do not know how to find your architecture's registers and syscalls"
 #endif
@@ -1293,7 +1297,7 @@ void change_syscall(struct __test_metadata *_metadata,
 	EXPECT_EQ(0, ret);
 
 #if defined(__x86_64__) || defined(__i386__) || defined(__powerpc__) || \
-    defined(__s390__)
+    defined(__s390__) || defined(__mips__)
 	{
 		regs.SYSCALL_NUM = syscall;
 	}
-- 
2.6.3


-- 
Kees Cook
Chrome OS & Brillo Security
