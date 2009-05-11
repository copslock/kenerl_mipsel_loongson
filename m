From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 11 May 2009 16:57:59 -0400
Subject: [PATCH] boot: allow user specified kernel command line length
Message-ID: <20090511205759.l5Mb1kFDq715EOYdmBI4Km1qXs_rjQpI3Qzo5aVcjf4@z>

Some boards (esp. custom hardware) may require a lengthy command
line in order to convey all the needed settings from the bootloader
to the kernel.  Even though the length of the command line is
specified on a per arch basis, the ability to tune this value need
not be arch specific.

This creates a CONFIG_COMMAND_LINE_SIZE option, that allows the
arch specific value to be overridden, or if it is left at the
default of zero, then that means that the original arch specific
value specified in arch/*/include/asm/setup.h will be used.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/alpha/include/asm/setup.h      |    4 ++++
 arch/arm/include/asm/setup.h        |    4 ++++
 arch/avr32/include/asm/setup.h      |    4 ++++
 arch/blackfin/include/asm/setup.h   |    4 ++++
 arch/cris/include/asm/setup.h       |    4 ++++
 arch/frv/include/asm/setup.h        |    4 ++++
 arch/h8300/include/asm/setup.h      |    4 ++++
 arch/ia64/include/asm/setup.h       |    4 ++++
 arch/m32r/include/asm/setup.h       |    4 ++++
 arch/m68k/include/asm/setup.h       |    4 ++++
 arch/microblaze/include/asm/setup.h |    4 ++++
 arch/mips/include/asm/setup.h       |    4 ++++
 arch/parisc/include/asm/setup.h     |    4 ++++
 arch/powerpc/include/asm/setup.h    |    4 ++++
 arch/s390/include/asm/setup.h       |    4 ++++
 arch/sh/include/asm/setup.h         |    4 ++++
 arch/sparc/include/asm/setup.h      |    4 ++++
 arch/um/include/asm/setup.h         |    4 ++++
 arch/x86/include/asm/setup.h        |    4 ++++
 arch/xtensa/include/asm/setup.h     |    4 ++++
 init/Kconfig                        |   13 +++++++++++++
 21 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/arch/alpha/include/asm/setup.h b/arch/alpha/include/asm/setup.h
index 2e023a4..fd80253 100644
--- a/arch/alpha/include/asm/setup.h
+++ b/arch/alpha/include/asm/setup.h
@@ -1,6 +1,10 @@
 #ifndef __ALPHA_SETUP_H
 #define __ALPHA_SETUP_H
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	256
+#endif
 
 #endif
diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index ee1304f..25c423e 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -16,7 +16,11 @@
 
 #include <linux/types.h>
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE 1024
+#endif
 
 /* The list ends with an ATAG_NONE node. */
 #define ATAG_NONE	0x00000000
diff --git a/arch/avr32/include/asm/setup.h b/arch/avr32/include/asm/setup.h
index ff5b7cf..20add83 100644
--- a/arch/avr32/include/asm/setup.h
+++ b/arch/avr32/include/asm/setup.h
@@ -11,7 +11,11 @@
 #ifndef __ASM_AVR32_SETUP_H__
 #define __ASM_AVR32_SETUP_H__
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE 256
+#endif
 
 #ifdef __KERNEL__
 
diff --git a/arch/blackfin/include/asm/setup.h b/arch/blackfin/include/asm/setup.h
index 01c8c6c..6fb8784 100644
--- a/arch/blackfin/include/asm/setup.h
+++ b/arch/blackfin/include/asm/setup.h
@@ -12,6 +12,10 @@
 #ifndef _BFIN_SETUP_H
 #define _BFIN_SETUP_H
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	512
+#endif
 
 #endif				/* _BFIN_SETUP_H */
diff --git a/arch/cris/include/asm/setup.h b/arch/cris/include/asm/setup.h
index b907286..52d7e65 100644
--- a/arch/cris/include/asm/setup.h
+++ b/arch/cris/include/asm/setup.h
@@ -1,6 +1,10 @@
 #ifndef _CRIS_SETUP_H
 #define _CRIS_SETUP_H
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	256
+#endif
 
 #endif
diff --git a/arch/frv/include/asm/setup.h b/arch/frv/include/asm/setup.h
index afd787c..9564fc0 100644
--- a/arch/frv/include/asm/setup.h
+++ b/arch/frv/include/asm/setup.h
@@ -12,7 +12,11 @@
 #ifndef _ASM_SETUP_H
 #define _ASM_SETUP_H
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE       512
+#endif
 
 #ifdef __KERNEL__
 
diff --git a/arch/h8300/include/asm/setup.h b/arch/h8300/include/asm/setup.h
index e2c600e..45304d0 100644
--- a/arch/h8300/include/asm/setup.h
+++ b/arch/h8300/include/asm/setup.h
@@ -1,6 +1,10 @@
 #ifndef __H8300_SETUP_H
 #define __H8300_SETUP_H
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	512
+#endif
 
 #endif
diff --git a/arch/ia64/include/asm/setup.h b/arch/ia64/include/asm/setup.h
index 4399a44..1ac9bb7 100644
--- a/arch/ia64/include/asm/setup.h
+++ b/arch/ia64/include/asm/setup.h
@@ -1,6 +1,10 @@
 #ifndef __IA64_SETUP_H
 #define __IA64_SETUP_H
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	2048
+#endif
 
 #endif
diff --git a/arch/m32r/include/asm/setup.h b/arch/m32r/include/asm/setup.h
index c637ab9..969ee60 100644
--- a/arch/m32r/include/asm/setup.h
+++ b/arch/m32r/include/asm/setup.h
@@ -5,7 +5,11 @@
  * This is set up by the setup-routine at boot-time
  */
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE       512
+#endif
 
 #ifdef __KERNEL__
 
diff --git a/arch/m68k/include/asm/setup.h b/arch/m68k/include/asm/setup.h
index 4dfb395..69418a0 100644
--- a/arch/m68k/include/asm/setup.h
+++ b/arch/m68k/include/asm/setup.h
@@ -41,7 +41,11 @@
 #define MACH_Q40     10
 #define MACH_SUN3X   11
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE 256
+#endif
 
 #ifdef __KERNEL__
 
diff --git a/arch/microblaze/include/asm/setup.h b/arch/microblaze/include/asm/setup.h
index 9b98e8e..c6ea21c 100644
--- a/arch/microblaze/include/asm/setup.h
+++ b/arch/microblaze/include/asm/setup.h
@@ -10,7 +10,11 @@
 #ifndef _ASM_MICROBLAZE_SETUP_H
 #define _ASM_MICROBLAZE_SETUP_H
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	256
+#endif
 
 # ifndef __ASSEMBLY__
 
diff --git a/arch/mips/include/asm/setup.h b/arch/mips/include/asm/setup.h
index e600ced..c461df2 100644
--- a/arch/mips/include/asm/setup.h
+++ b/arch/mips/include/asm/setup.h
@@ -1,7 +1,11 @@
 #ifndef _MIPS_SETUP_H
 #define _MIPS_SETUP_H
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	256
+#endif
 
 #ifdef  __KERNEL__
 extern void setup_early_printk(void);
diff --git a/arch/parisc/include/asm/setup.h b/arch/parisc/include/asm/setup.h
index 7da2e5b..44751be 100644
--- a/arch/parisc/include/asm/setup.h
+++ b/arch/parisc/include/asm/setup.h
@@ -1,6 +1,10 @@
 #ifndef _PARISC_SETUP_H
 #define _PARISC_SETUP_H
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	1024
+#endif
 
 #endif /* _PARISC_SETUP_H */
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 817fac0..7db0129 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -1,6 +1,10 @@
 #ifndef _ASM_POWERPC_SETUP_H
 #define _ASM_POWERPC_SETUP_H
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	512
+#endif
 
 #endif	/* _ASM_POWERPC_SETUP_H */
diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index 38b0fc2..4c9a299 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -8,7 +8,11 @@
 #ifndef _ASM_S390_SETUP_H
 #define _ASM_S390_SETUP_H
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	1024
+#endif
 
 #define ARCH_COMMAND_LINE_SIZE	896
 
diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
index d450bcf..d92b898 100644
--- a/arch/sh/include/asm/setup.h
+++ b/arch/sh/include/asm/setup.h
@@ -1,7 +1,11 @@
 #ifndef _SH_SETUP_H
 #define _SH_SETUP_H
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE 256
+#endif
 
 #ifdef __KERNEL__
 /*
diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 2643c62..06cf011 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -5,10 +5,14 @@
 #ifndef _SPARC_SETUP_H
 #define _SPARC_SETUP_H
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_SIZE
+#else
 #if defined(__sparc__) && defined(__arch64__)
 # define COMMAND_LINE_SIZE 2048
 #else
 # define COMMAND_LINE_SIZE 256
 #endif
+#endif /* _COMMAND_LINE_SIZE */
 
 #endif /* _SPARC_SETUP_H */
diff --git a/arch/um/include/asm/setup.h b/arch/um/include/asm/setup.h
index 99f0863..cd031a0 100644
--- a/arch/um/include/asm/setup.h
+++ b/arch/um/include/asm/setup.h
@@ -5,6 +5,10 @@
  * command line, so this choice is ok.
  */
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE 4096
+#endif
 
 #endif		/* SETUP_H_INCLUDED */
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index bdc2ada..49a7c11 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -3,7 +3,11 @@
 
 #ifdef __KERNEL__
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE 2048
+#endif
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/xtensa/include/asm/setup.h b/arch/xtensa/include/asm/setup.h
index e363652..f9113a4 100644
--- a/arch/xtensa/include/asm/setup.h
+++ b/arch/xtensa/include/asm/setup.h
@@ -11,6 +11,10 @@
 #ifndef _XTENSA_SETUP_H
 #define _XTENSA_SETUP_H
 
+#if CONFIG_COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	256
+#endif
 
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index 7be4d38..b642f46 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -415,6 +415,19 @@ config IKCONFIG_PROC
 	  This option enables access to the kernel configuration file
 	  through /proc/config.gz.
 
+config COMMAND_LINE_SIZE
+	int "Kernel command line buffer size (0 = use arch default)"
+	range 0 2048
+	default 0
+	help
+	  Select the size of the buffer used to hold the command line
+	  passed into the kernel from the bootloader.  Typically, the
+	  value specified for your architecture will be large enough,
+	  but some boards may require more size for complex command
+	  lines. Typical values are 256, 512, 1024 and 2048.  Use zero
+	  if you want to just take the default for your particular
+	  architecture. (default is set in arch/*/include/asm/setup.h)
+
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)"
 	range 12 21
-- 
1.6.2.3
