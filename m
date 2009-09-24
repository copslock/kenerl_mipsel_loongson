From: Manuel Lauss <manuel.lauss@gmail.com>
Date: Thu, 24 Sep 2009 21:44:24 +0200
Subject: [PATCH] mips: fix build of vmlinux.lds
Message-ID: <20090924194424.lDUAUi2evlCypWDi9B2gDVJpG_oLZPf36vtayj-ybNg@z>

Commit 51b563fc93c8cb5bff1d67a0a71c374e4a4ea049 ("arm, cris, mips,
sparc, powerpc, um, xtensa: fix build with bash 4.0") removed a few
CPPFLAGS with vital include paths necessary to build vmlinux.lds
on MIPS, and moved the calculation of the 'jiffies' symbol
directly to vmlinux.lds.S but forgot to change make ifdef/... to
cpp macros.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
[sam: moved assignment of CPPFLAGS arch/mips/kernel/Makefile]
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/mips/kernel/Makefile      |    2 ++
 arch/mips/kernel/vmlinux.lds.S |   12 ++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index e961221..eecd2a9 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the Linux/MIPS kernel.
 #
 
+CPPFLAGS_vmlinux.lds := $(KBUILD_CFLAGS)
+
 extra-y		:= head.o init_task.o vmlinux.lds
 
 obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 9bf0e3d..162b299 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -11,15 +11,15 @@ PHDRS {
 	note PT_NOTE FLAGS(4);	/* R__ */
 }
 
-ifdef CONFIG_32BIT
-	ifdef CONFIG_CPU_LITTLE_ENDIAN
+#ifdef CONFIG_32BIT
+	#ifdef CONFIG_CPU_LITTLE_ENDIAN
 		jiffies  = jiffies_64;
-	else
+	#else
 		jiffies  = jiffies_64 + 4;
-	endif
-else
+	#endif
+#else
 	jiffies  = jiffies_64;
-endif
+#endif
 
 SECTIONS
 {
-- 
1.6.2.5
