Return-Path: <SRS0=gTW6=P2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313B0C43387
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 16:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BBD20850
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 16:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfARQYm (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:24:42 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:59237 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbfARQUl (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 18 Jan 2019 11:20:41 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MhDEq-1hOWW63G5q-00eOav; Fri, 18 Jan 2019 17:19:17 +0100
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
Subject: [PATCH v2 01/29] ia64: add __NR_umount2 definition
Date:   Fri, 18 Jan 2019 17:18:07 +0100
Message-Id: <20190118161835.2259170-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GsZHhQhcPdYS4XukUdggM06UYDYQwvsQdNjGwXDfVX+xMhWKJ6A
 b6/sxfBHiaOoQOIfuvjuKAlbNSGl602rDk7co3ulFVrnu6AKrROQ37HYQQgaNO9HW3rfMgT
 FMqKekrLMWzwblX2j4DmUwfbjCWxf1hP2S9PKyEsdmmXxHyyNyE9nP/tEZePtCFi+EiC++u
 TwwGDSPYukstzfC9BHnUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4oZGV99i9Es=:zl3RJLFwRuzHjpYAd7JXSy
 j0Xr6hYoVER8/EkE78L0FBpqWwSLiBt89ov75d/lCcZ8EIPJCLfWWFnH4+7vvf1vB0y6PuK+2
 WaQf+0AtlFjXvLDdEdcMfSVEu/oXlSSWgNamYZLhGZ469/XTMPelaTtuGD0qTnhq9O4+UTQho
 lQ0cYwI5yK+bdi3rW56xu/JrQKZ3Mc1eKAmhyP7Z8XnKBd7J/KOv5SpnB5vmiZ9UgJWN1mQ0J
 uElFIJ0O2dyFc82y6vkLE5T7GEigtI0A+75aroKm5Pr+FsnqXqdeb3TURXICg4MGwRgAzGwPT
 ITyTsJU1n9m3+bWS/Td9uI50Cw4obDtx9WUsztTbvRp2ZuXc65G3AXcxY3vSmW+3skW70wera
 SSLEyT/Gr4KCiupFJyCDi0raovIDwiSf7ZEtj4gemjCUQo9j5MsLTvlQqk/nOKVQb4szjPspx
 pemTbbbXRaAzFnfHeAPXsidNtWDfPBiDc8+gvvlcHF4MOkxlHk/ozkznGMZBNIqSskSzpHqa8
 P+BEBZ6X/A2+EO89EKRYprcX7n5o/MRTz1FepCZZugEIueimrUdkjuA8172O5g5FlhKQlzvri
 FSGR9gNOwxSYqCoQsvsK24vYcAGrNxemQqL4YZe0xmRKtuYFyC76eHvi5sDyS8nEqyaRAY0wL
 pUlB8onvyLyM59By8CcmkN7xWdub+PUluNRNrCK+5RhogR3dXC3L21/ad0rw8vt14eCjSILR0
 mRa28hy080RWtHtwzkFq2kRvrYNuY4DpJgJv7A==
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Other architectures commonly use __NR_umount2 for sys_umount,
only ia64 and alpha use __NR_umount here. In order to synchronize
the generated tables, use umount2 like everyone else, and add back
the old name from asm/unistd.h for compatibility.

The __IGNORE_* lines are now all obsolete and can be removed as
a side-effect.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/include/asm/unistd.h        | 14 --------------
 arch/ia64/include/uapi/asm/unistd.h   |  2 ++
 arch/ia64/kernel/syscalls/syscall.tbl |  2 +-
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
index 0b08ebd2dfde..9ba6110b10b9 100644
--- a/arch/ia64/include/asm/unistd.h
+++ b/arch/ia64/include/asm/unistd.h
@@ -12,20 +12,6 @@
 
 #define NR_syscalls		__NR_syscalls /* length of syscall table */
 
-/*
- * The following defines stop scripts/checksyscalls.sh from complaining about
- * unimplemented system calls.  Glibc provides for each of these by using
- * more modern equivalent system calls.
- */
-#define __IGNORE_fork		/* clone() */
-#define __IGNORE_time		/* gettimeofday() */
-#define __IGNORE_alarm		/* setitimer(ITIMER_REAL, ... */
-#define __IGNORE_pause		/* rt_sigprocmask(), rt_sigsuspend() */
-#define __IGNORE_utime		/* utimes() */
-#define __IGNORE_getpgrp	/* getpgid() */
-#define __IGNORE_vfork		/* clone() */
-#define __IGNORE_umount2	/* umount() */
-
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_UTIME
 
diff --git a/arch/ia64/include/uapi/asm/unistd.h b/arch/ia64/include/uapi/asm/unistd.h
index b2513922dcb5..013e0bcacc39 100644
--- a/arch/ia64/include/uapi/asm/unistd.h
+++ b/arch/ia64/include/uapi/asm/unistd.h
@@ -15,6 +15,8 @@
 
 #define __NR_Linux      1024
 
+#define __NR_umount __NR_umount2
+
 #include <asm/unistd_64.h>
 
 #endif /* _UAPI_ASM_IA64_UNISTD_H */
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index b22203b40bfe..e97caf51be42 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -29,7 +29,7 @@
 17	common	getpid				sys_getpid
 18	common	getppid				sys_getppid
 19	common	mount				sys_mount
-20	common	umount				sys_umount
+20	common	umount2				sys_umount
 21	common	setuid				sys_setuid
 22	common	getuid				sys_getuid
 23	common	geteuid				sys_geteuid
-- 
2.20.0

