From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 23 Dec 2015 21:04:31 -0800
Subject: [PATCH] MIPS: VDSO: Fix build error with binutils 2.24 and earlier
Message-ID: <20151224050431.D2zfB9Lmbiea9Awn6NI7v_5OXMFXOd5PNoHpFThULvs@z>

Commit 2a037f310bab ("MIPS: VDSO: Fix build error") tries to fix a build
error seen with binutils 2.24 and earlier. However, the fix does not work,
and again results in the already known build errors if the kernel is built
with an earlier version of binutils.

CC      arch/mips/vdso/gettimeofday.o
/tmp/ccnOVbHT.s: Assembler messages:
/tmp/ccnOVbHT.s:50: Error: can't resolve `_start' {*UND* section} - `L0 {.text section}
/tmp/ccnOVbHT.s:374: Error: can't resolve `_start' {*UND* section} - `L0 {.text section}
scripts/Makefile.build:258: recipe for target 'arch/mips/vdso/gettimeofday.o' failed
make[2]: *** [arch/mips/vdso/gettimeofday.o] Error 1

Fixes: 2a037f310bab ("MIPS: VDSO: Fix build error")
Cc: Qais Yousef <qais.yousef@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/11926/
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 018f8c7b94f2..14568900fc1d 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -26,7 +26,7 @@ aflags-vdso := $(ccflags-vdso) \
 # the comments on that file.
 #
 ifndef CONFIG_CPU_MIPSR6
-  ifeq ($(call ld-ifversion, -lt, 22500000, y),)
+  ifeq ($(call ld-ifversion, -lt, 22500000, y),y)
     $(warning MIPS VDSO requires binutils >= 2.25)
     obj-vdso-y := $(filter-out gettimeofday.o, $(obj-vdso-y))
     ccflags-vdso += -DDISABLE_MIPS_VDSO
-- 
2.6.2
