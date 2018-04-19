Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2018 16:41:44 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.13]:38659 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994667AbeDSOjDCYYdB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2018 16:39:03 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Lmcct-1eaf5m3gOZ-00aIJO; Thu, 19 Apr 2018 16:38:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        albert.aribaud@3adev.fr, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, x86@kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-mips@linux-mips.org, jhogan@kernel.org,
        ralf@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v3 17/17] y2038: compat: Move common compat types to asm-generic/compat.h
Date:   Thu, 19 Apr 2018 16:37:37 +0200
Message-Id: <20180419143737.606138-18-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:5UL22NoOYnFQy+3eWCdhbu52Vp4sjh9GtgOFPkTMYPnG+nI9AJ+
 NYsTbLIypNGyma8t4wMwLbT2Zh+4I/AYjW022+JyFMCUbDSjq/YZFXkabq38cB9hTPnoWqo
 cr1qBhKHUfQHRBXHqU5+xLowd9j/+DdaXFF1G3UZvBsaAShuGx0zp+OeH4247P3EUrh/HPq
 LM+L1OROFjD02jkTbk+cA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UBOPPLYyKfk=:Dz0Ql6rTRjW8IToON1HW7Q
 1YCso3T5kfGA+u8M2xasX2QKvLa1Jb2/xA7spFoWcjfE6Z4+pFJIcyHHaJaZFaxkb+pKoV9r+
 HLKyqhOx4kY4UP2eiuaDmSgj4MZ6960H1MprP4wedEiixSHsXLG5BwNmzX88IZry7ElLzKUnQ
 H6OJsSadjEwGCxpDi0cNFE99nj4Dqt2XJdHVsK9ApF3Mbvn1FYicrh4W2cfJzjM3gR/shosLy
 QzssK2HluAUm2LZwA1AW33wlOav/mS7qrsp3Dic0Dd33kO3v44llXV+nIm3CS2Ih4IEfk4mw5
 7HdTsFTc5E4aqCB5Ft9V78CCZEon3wQrtCdc4PEgTr9GiPxxZpz/+R4EW4WgjJGquxwY6gbca
 3Go9VQhx3vezGGltDFrYKPAc6yNZLFx0crsTqF82HJ45rgJUDGuXACu8s48ry85ZtQeKsy1mF
 dY9L7C3e5ddiGtjhs0X8sNEY6IGN7R1F3hWUF3x224JljZxiAr1D7tjuXeTl7wxj1o9pCSZho
 byc3HqxDdz9c3axRna37TOGCBNlZBXXw12/y9FpgS2pyEz8Cb/1H8AlQOztQ/Wyk7fi5ACUtD
 tw2XinCQyxEwOSXkoUdKcl/G35MrbRmAS2aQVKCsanGXzmxhddYaCR3rXeej3/bY7zbvA68XM
 fxMM3KmuGqOAZCXkubLkMRYRLGyynqbeH5umICcgh+v66XmBAKjZzzXs6coVFFpZZQkyEtn2t
 QlGvpK3ckgeJ1ugNVYb0rS50OlF4Gb6mGA477A==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

The architectures that support 32-bit compat mode define a number
of simple types for use in compat handlers. About half of those
are identical between architectures, and some of those are also
required now by handlers shared with CONFIG_COMPAT_32BIT_TIME
functions on 32-bit architectures.

Let's move all the identical ones into asm-generic/compat.h to avoid
having to add even more identical definitions of those types.

For unknown reasons, mips defines __compat_gid32_t, __compat_uid32_t
and compat_caddr_t as signed, while all others have them unsigned.
This seems to be a mistake, but I'm leaving it alone here. The other
types all differ by size or alignment on at least on architecture.

compat_aio_context_t is currently defined in linux/compat.h but
also needed for compat_sys_io_getevents(), so let's move it into
the same place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/compat.h   | 20 ++------------------
 arch/mips/include/asm/compat.h    | 22 ++--------------------
 arch/parisc/include/asm/compat.h  | 18 ++----------------
 arch/powerpc/include/asm/compat.h | 18 ++----------------
 arch/s390/include/asm/compat.h    | 18 ++----------------
 arch/sparc/include/asm/compat.h   | 19 ++-----------------
 arch/x86/include/asm/compat.h     | 19 ++-----------------
 include/asm-generic/compat.h      | 24 +++++++++++++++++++++++-
 include/linux/compat.h            |  2 --
 9 files changed, 37 insertions(+), 123 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 1a037b94eba1..a4c79f9e856d 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -25,6 +25,8 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ		100
 #ifdef __AARCH64EB__
 #define COMPAT_UTS_MACHINE	"armv8b\0\0"
@@ -32,10 +34,6 @@
 #define COMPAT_UTS_MACHINE	"armv8l\0\0"
 #endif
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
 typedef u16		__compat_gid_t;
 typedef u16		__compat_uid16_t;
@@ -43,27 +41,13 @@ typedef u16		__compat_gid16_t;
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u32		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef s32		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s32		compat_key_t;
-typedef s32		compat_timer_t;
-
-typedef s16		compat_short_t;
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64		compat_s64;
-typedef u16		compat_ushort_t;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
-typedef u32		compat_uptr_t;
 
 struct compat_stat {
 #ifdef __AARCH64EB__
diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 78675f19440f..7033a7c93b48 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -9,43 +9,25 @@
 #include <asm/page.h>
 #include <asm/ptrace.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ		100
 #define COMPAT_UTS_MACHINE	"mips\0\0\0"
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_suseconds_t;
-
-typedef s32		compat_pid_t;
 typedef s32		__compat_uid_t;
 typedef s32		__compat_gid_t;
 typedef __compat_uid_t	__compat_uid32_t;
 typedef __compat_gid_t	__compat_gid32_t;
 typedef u32		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u32		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef u32		compat_nlink_t;
 typedef s32		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef s32		compat_caddr_t;
 typedef struct {
 	s32	val[2];
 } compat_fsid_t;
-typedef s32		compat_timer_t;
-typedef s32		compat_key_t;
-
-typedef s16		compat_short_t;
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64		compat_s64;
-typedef u16		compat_ushort_t;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
-typedef u32		compat_uptr_t;
 
 struct compat_stat {
 	compat_dev_t	st_dev;
diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index ab8a54771507..f707e025f89b 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -8,36 +8,22 @@
 #include <linux/sched.h>
 #include <linux/thread_info.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ 		100
 #define COMPAT_UTS_MACHINE	"parisc\0\0"
 
-typedef u32	compat_size_t;
-typedef s32	compat_ssize_t;
-typedef s32	compat_clock_t;
-typedef s32	compat_pid_t;
 typedef u32	__compat_uid_t;
 typedef u32	__compat_gid_t;
 typedef u32	__compat_uid32_t;
 typedef u32	__compat_gid32_t;
 typedef u16	compat_mode_t;
-typedef u32	compat_ino_t;
 typedef u32	compat_dev_t;
-typedef s32	compat_off_t;
-typedef s64	compat_loff_t;
 typedef u16	compat_nlink_t;
 typedef u16	compat_ipc_pid_t;
-typedef s32	compat_daddr_t;
 typedef u32	compat_caddr_t;
-typedef s32	compat_key_t;
-typedef s32	compat_timer_t;
-
-typedef s32	compat_int_t;
-typedef s32	compat_long_t;
 typedef s64	compat_s64;
-typedef u32	compat_uint_t;
-typedef u32	compat_ulong_t;
 typedef u64	compat_u64;
-typedef u32	compat_uptr_t;
 
 struct compat_stat {
 	compat_dev_t		st_dev;	/* dev_t is 32 bits on parisc */
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 85c8af2bb272..036b210b1582 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -8,6 +8,8 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ		100
 #ifdef __BIG_ENDIAN__
 #define COMPAT_UTS_MACHINE	"ppc\0\0"
@@ -15,34 +17,18 @@
 #define COMPAT_UTS_MACHINE	"ppcle\0\0"
 #endif
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_pid_t;
 typedef u32		__compat_uid_t;
 typedef u32		__compat_gid_t;
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u32		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u32		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef s16		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s32		compat_key_t;
-typedef s32		compat_timer_t;
-
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64		compat_s64;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
-typedef u32		compat_uptr_t;
 
 struct compat_stat {
 	compat_dev_t	st_dev;
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 97db2fba546a..63b46e30b2c3 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -9,6 +9,8 @@
 #include <linux/sched/task_stack.h>
 #include <linux/thread_info.h>
 
+#include <asm-generic/compat.h>
+
 #define __TYPE_IS_PTR(t) (!__builtin_types_compatible_p( \
 				typeof(0?(__force t)0:0ULL), u64))
 
@@ -51,34 +53,18 @@
 #define COMPAT_USER_HZ		100
 #define COMPAT_UTS_MACHINE	"s390\0\0\0\0"
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
 typedef u16		__compat_gid_t;
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u16		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef u16		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s32		compat_key_t;
-typedef s32		compat_timer_t;
-
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64		compat_s64;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
-typedef u32		compat_uptr_t;
 
 typedef struct {
 	u32 mask;
diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 4eb51d2dae98..985286b79891 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -6,38 +6,23 @@
  */
 #include <linux/types.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ		100
 #define COMPAT_UTS_MACHINE	"sparc\0\0"
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
 typedef u16		__compat_gid_t;
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u16		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef s16		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s32		compat_key_t;
-typedef s32		compat_timer_t;
-
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64		compat_s64;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
-typedef u32		compat_uptr_t;
-
 struct compat_stat {
 	compat_dev_t	st_dev;
 	compat_ino_t	st_ino;
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index fb97cf7c4137..0ce6f452d334 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -12,38 +12,23 @@
 #include <asm/user32.h>
 #include <asm/unistd.h>
 
+#include <asm-generic/compat.h>
+
 #define COMPAT_USER_HZ		100
 #define COMPAT_UTS_MACHINE	"i686\0\0"
 
-typedef u32		compat_size_t;
-typedef s32		compat_ssize_t;
-typedef s32		compat_clock_t;
-typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
 typedef u16		__compat_gid_t;
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
-typedef u32		compat_ino_t;
 typedef u16		compat_dev_t;
-typedef s32		compat_off_t;
-typedef s64		compat_loff_t;
 typedef u16		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
-typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s32		compat_timer_t;
-typedef s32		compat_key_t;
-
-typedef s32		compat_int_t;
-typedef s32		compat_long_t;
 typedef s64 __attribute__((aligned(4))) compat_s64;
-typedef u32		compat_uint_t;
-typedef u32		compat_ulong_t;
-typedef u32		compat_u32;
 typedef u64 __attribute__((aligned(4))) compat_u64;
-typedef u32		compat_uptr_t;
 
 struct compat_stat {
 	compat_dev_t	st_dev;
diff --git a/include/asm-generic/compat.h b/include/asm-generic/compat.h
index 28819451b6d1..a86f65bffab8 100644
--- a/include/asm-generic/compat.h
+++ b/include/asm-generic/compat.h
@@ -1,3 +1,25 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_COMPAT_H
+#define __ASM_GENERIC_COMPAT_H
 
-/* This is an empty stub for 32-bit-only architectures */
+/* These types are common across all compat ABIs */
+typedef u32 compat_size_t;
+typedef s32 compat_ssize_t;
+typedef s32 compat_clock_t;
+typedef s32 compat_pid_t;
+typedef u32 compat_ino_t;
+typedef s32 compat_off_t;
+typedef s64 compat_loff_t;
+typedef s32 compat_daddr_t;
+typedef s32 compat_timer_t;
+typedef s32 compat_key_t;
+typedef s16 compat_short_t;
+typedef s32 compat_int_t;
+typedef s32 compat_long_t;
+typedef u16 compat_ushort_t;
+typedef u32 compat_uint_t;
+typedef u32 compat_ulong_t;
+typedef u32 compat_uptr_t;
+typedef u32 compat_aio_context_t;
+
+#endif
diff --git a/include/linux/compat.h b/include/linux/compat.h
index cfc1b6383ae0..af5ac9de4bdf 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -104,8 +104,6 @@ typedef struct compat_sigaltstack {
 typedef __compat_uid32_t	compat_uid_t;
 typedef __compat_gid32_t	compat_gid_t;
 
-typedef	compat_ulong_t		compat_aio_context_t;
-
 struct compat_sel_arg_struct;
 struct rusage;
 
-- 
2.9.0
