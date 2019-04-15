Return-Path: <SRS0=MCbt=SR=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C43FC10F12
	for <linux-mips@archiver.kernel.org>; Mon, 15 Apr 2019 14:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFD62075B
	for <linux-mips@archiver.kernel.org>; Mon, 15 Apr 2019 14:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfDOOb2 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:31:28 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:53183 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfDOOb1 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 15 Apr 2019 10:31:27 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MwQw1-1gxXll3SxZ-00sPrc; Mon, 15 Apr 2019 16:30:17 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [PATCH] [v2] arch: add pidfd and io_uring syscalls everywhere
Date:   Mon, 15 Apr 2019 16:22:57 +0200
Message-Id: <20190415143007.2989285-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:k5DDhad6u3M53Omk69z1Fxj87X5euYlbMbfOKnekmJE+r49YC4G
 kEvcv1R1zpSdPyqWUVMuXBZPQtS+MhzzB/u8+8fjaybLqmveznvw4PFyXn55w0fgiyeESuG
 MnIBL9zsYbTfDn87LSX0oSbhrZMWCa5NrQpjGBEetglwUWmaqQZcaOQnmQMdb7HS81JAD7t
 obJYdo14coUtDqDhhOCCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Zw0XpfPbUQ=:IVbW48zMIcaxVXddZgyR3Q
 shTd9ib/Spy5GvPM20A55tDJtNKxo6yP2Ah0B9Hh+Dfy6s8S8W6hTwYOQg1ixu3GefTm6bP1m
 8t6E8UacTP0Mw5QvlEe+9DvKTZ4oh+dJpo4b1mLux/70kn2F9qgBRHZgXAkiKxL/WeuSrqMXy
 tXCFuPa8F2Ko1YjwVZHxb2R+imHIx3vXMhWq/XJRga2bGvgWRabOrl/DH9rqgExLreREqoBZH
 uziBkHLZDfRN69Fz/itX4IylIetVLHc3O/iJTq+tOc0tlw8syi66AZtQaMHx7KzwyNbTwq8MA
 a9zOzy/pjsFJzE8/7G+K0w/2L8V34Kbtvu//LxwZ2WU8JTuEqgp3TrJ/OblbGgPu5xc2BUsgX
 1eSkOIpIvAnK2lNlYr+x86J0LvGV42cDMpjSnOodVLRFKmMpigvKrGIZbsiipdUiXW6ux/ZPA
 Gr8d2Z4bSKcacXZ5g+hOHFKeK36p3TtovyHLG6LDME8sO9KF1HtX/vedSDEl0sy3/Twi6uw8P
 sF49tw4Y/UlOYo2vU12bzfLieQgvjuhBdmPhnZfNi38jXL79ewhnQDbwtFhmX3UWeIRIo6LaW
 LcpGaQXV+xXlTcTdi0dqShlsEt3Fek60n3Z1Mb0GXav76m3poYBrrIOjnxGqCjiikXKF4XUvw
 giZ6P6Y2a+HQdl7DMqdRZCyWOmjakLLsLMIVrICyOQAba1qx7pSwmMhmfNSQolN1gzqiWi6y1
 ft7Nt8bIllfdyaw3GpkseYIX6ifPQPjxIOBnRw==
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add the io_uring and pidfd_send_signal system calls to all architectures.

These system calls are designed to handle both native and compat tasks,
so all entries are the same across architectures, only arm-compat and
the generic tale still use an old format.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> (s390)
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Changes since v1:
- fix s390 table
- use 'n64' tag in mips-n64 instead of common.
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 4 ++++
 arch/arm/tools/syscall.tbl                  | 4 ++++
 arch/arm64/include/asm/unistd.h             | 2 +-
 arch/arm64/include/asm/unistd32.h           | 8 ++++++++
 arch/ia64/kernel/syscalls/syscall.tbl       | 4 ++++
 arch/m68k/kernel/syscalls/syscall.tbl       | 4 ++++
 arch/microblaze/kernel/syscalls/syscall.tbl | 4 ++++
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 4 ++++
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 4 ++++
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 4 ++++
 arch/parisc/kernel/syscalls/syscall.tbl     | 4 ++++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 4 ++++
 arch/s390/kernel/syscalls/syscall.tbl       | 4 ++++
 arch/sh/kernel/syscalls/syscall.tbl         | 4 ++++
 arch/sparc/kernel/syscalls/syscall.tbl      | 4 ++++
 arch/xtensa/kernel/syscalls/syscall.tbl     | 4 ++++
 16 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 63ed39cbd3bd..165f268beafc 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -463,3 +463,7 @@
 532	common	getppid				sys_getppid
 # all other architectures have common numbers for new syscall, alpha
 # is the exception.
+534	common	pidfd_send_signal		sys_pidfd_send_signal
+535	common	io_uring_setup			sys_io_uring_setup
+536	common	io_uring_enter			sys_io_uring_enter
+537	common	io_uring_register		sys_io_uring_register
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 9016f4081bb9..0393917eaa57 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -437,3 +437,7 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 310d8f1cae7a..c6946fe640e6 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -49,7 +49,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		424
+#define __NR_compat_syscalls		428
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 5590f2623690..23f1a44acada 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -866,6 +866,14 @@ __SYSCALL(__NR_rt_sigtimedwait_time64, compat_sys_rt_sigtimedwait_time64)
 __SYSCALL(__NR_futex_time64, sys_futex)
 #define __NR_sched_rr_get_interval_time64 423
 __SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
+#define __NR_pidfd_send_signal 424
+__SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
+#define __NR_io_uring_setup 425
+__SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
+#define __NR_io_uring_enter 426
+__SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
+#define __NR_io_uring_register 427
+__SYSCALL(__NR_io_uring_register, sys_io_uring_register)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index ab9cda5f6136..56e3d0b685e1 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -344,3 +344,7 @@
 332	common	pkey_free			sys_pkey_free
 333	common	rseq				sys_rseq
 # 334 through 423 are reserved to sync up with other architectures
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 125c14178979..df4ec3ec71d1 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -423,3 +423,7 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 8ee3a8c18498..4964947732af 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -429,3 +429,7 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 15f4117900ee..9392dfe33f97 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -362,3 +362,7 @@
 421	n32	rt_sigtimedwait_time64		compat_sys_rt_sigtimedwait_time64
 422	n32	futex_time64			sys_futex
 423	n32	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	n32	pidfd_send_signal		sys_pidfd_send_signal
+425	n32	io_uring_setup			sys_io_uring_setup
+426	n32	io_uring_enter			sys_io_uring_enter
+427	n32	io_uring_register		sys_io_uring_register
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index c85502e67b44..cd0c8aa21fba 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -338,3 +338,7 @@
 327	n64	rseq				sys_rseq
 328	n64	io_pgetevents			sys_io_pgetevents
 # 329 through 423 are reserved to sync up with other architectures
+424	n64	pidfd_send_signal		sys_pidfd_send_signal
+425	n64	io_uring_setup			sys_io_uring_setup
+426	n64	io_uring_enter			sys_io_uring_enter
+427	n64	io_uring_register		sys_io_uring_register
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 2e063d0f837e..e849e8ffe4a2 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -411,3 +411,7 @@
 421	o32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
 422	o32	futex_time64			sys_futex			sys_futex
 423	o32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+424	o32	pidfd_send_signal		sys_pidfd_send_signal
+425	o32	io_uring_setup			sys_io_uring_setup
+426	o32	io_uring_enter			sys_io_uring_enter
+427	o32	io_uring_register		sys_io_uring_register
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index b26766c6647d..fe8ca623add8 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -420,3 +420,7 @@
 421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
 422	32	futex_time64			sys_futex			sys_futex
 423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index b18abb0c3dae..00f5a63c8d9a 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -505,3 +505,7 @@
 421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
 422	32	futex_time64			sys_futex			sys_futex
 423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 02579f95f391..061418f787c3 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -426,3 +426,7 @@
 421	32	rt_sigtimedwait_time64	-				compat_sys_rt_sigtimedwait_time64
 422	32	futex_time64		-				sys_futex
 423	32	sched_rr_get_interval_time64	-			sys_sched_rr_get_interval
+424  common	pidfd_send_signal	sys_pidfd_send_signal		sys_pidfd_send_signal
+425  common	io_uring_setup		sys_io_uring_setup              sys_io_uring_setup
+426  common	io_uring_enter		sys_io_uring_enter              sys_io_uring_enter
+427  common	io_uring_register	sys_io_uring_register           sys_io_uring_register
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index bfda678576e4..480b057556ee 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -426,3 +426,7 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index b9a5a04b2d2c..a1dd24307b00 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -469,3 +469,7 @@
 421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
 422	32	futex_time64			sys_futex			sys_futex
 423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 6af49929de85..30084eaf8422 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -394,3 +394,7 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
-- 
2.20.0

