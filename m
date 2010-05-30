From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 30 May 2010 13:30:43 +0200
Subject: [PATCH 2/6] mips: add -Werror to arch/mips/Kbuild
Message-ID: <20100530113043.7HRflzAuWioetYouNXjXFMhftm3xxYV_4Gew0ougox8@z>

Adding subdirs-ccflags-y := -Werror to arch/mips/Kbuild
let us in one go cover all files with -Werror.

In addition this allows us to remove the
individual -Werror definition in various Makefile.

Adding the definition to Kbuild as a recursive
option help us not to forget to do so.

With this change we now compile arch/mips/kernel/cpufreq with -Werror

One drawback:
When specifying a subdirectory covered by the Kbuild file like this:

    make arch/mips/kernel/

then kbuild fails to pick up the -Werror definition.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/mips/Kbuild            |    6 ++++++
 arch/mips/kernel/Makefile   |    2 --
 arch/mips/math-emu/Makefile |    1 -
 arch/mips/mm/Makefile       |    2 --
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index a18eb5d..6ce9382 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -1,3 +1,9 @@
+# Fail on warnings - also for files referenced in subdirs
+# -Werror can be disabled for specific files using:
+# CFLAGS_<file.o> := -Wno-error
+subdir-ccflags-y := -Werror
+
+
 # mips object files
 # The object files are linked as core-y files would be linked
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 7a6ac50..ff5ec2e 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -101,6 +101,4 @@ obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o
 
 obj-$(CONFIG_MIPS_CPUFREQ)	+= cpufreq/
 
-EXTRA_CFLAGS += -Werror
-
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/mips/math-emu/Makefile b/arch/mips/math-emu/Makefile
index d547efd..9660723 100644
--- a/arch/mips/math-emu/Makefile
+++ b/arch/mips/math-emu/Makefile
@@ -10,4 +10,3 @@ obj-y	:= cp1emu.o ieee754m.o ieee754d.o ieee754dp.o ieee754sp.o ieee754.o \
 	   sp_scalb.o sp_simple.o sp_tint.o sp_fint.o sp_tlong.o sp_flong.o \
 	   dp_sqrt.o sp_sqrt.o kernel_linkage.o dsemul.o
 
-EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index f0e4355..d679c77 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -34,5 +34,3 @@ obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22.o
 obj-$(CONFIG_R5000_CPU_SCACHE)  += sc-r5k.o
 obj-$(CONFIG_RM7000_CPU_SCACHE)	+= sc-rm7k.o
 obj-$(CONFIG_MIPS_CPU_SCACHE)	+= sc-mips.o
-
-EXTRA_CFLAGS += -Werror
-- 
1.6.0.6
