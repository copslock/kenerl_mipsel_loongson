From: Petr Mladek <pmladek@suse.com>
Date: Fri, 18 Dec 2015 16:04:35 +0100
Subject: [PATCH] printk/nmi: Remove the questionable CONFIG_NEED_PRINTK_NMI
Message-ID: <20151218150435.YXlAxk1zRAL00FFtdqNn2b1i1ffWrZsjfzlFu1LZxho@z>

The flag NEED_PRINTK_NMI was added because of Arm. It used the NMI safe
backtrace implementation on all Arm systems. But it did not have a real
NMI handling on CPU_V7M.

It seems that it causes more confusion than good. Let's use HAVE_NMI
on all arm systems and get rid of the problematic flag.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 arch/Kconfig     | 3 ---
 arch/arm/Kconfig | 3 +--
 init/Kconfig     | 2 +-
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 7ce5101c2472..d1a18b313624 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -190,9 +190,6 @@ config HAVE_KPROBES_ON_FTRACE
 config HAVE_NMI
 	bool
 
-config NEED_PRINTK_NMI
-	bool
-
 config HAVE_NMI_WATCHDOG
 	depends on HAVE_NMI
 	bool
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 96d2c275f0f7..01dc56d8f31b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -63,8 +63,7 @@ config ARM
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_MEMBLOCK
 	select HAVE_MOD_ARCH_SPECIFIC
-	select HAVE_NMI if (!CPU_V7M)
-	select NEED_PRINTK_NMI if (CPU_V7M)
+	select HAVE_NMI
 	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
 	select HAVE_OPTPROBES if !THUMB2_KERNEL
 	select HAVE_PERF_EVENTS
diff --git a/init/Kconfig b/init/Kconfig
index 61cfd96a3c96..abf79f3b1a55 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1481,7 +1481,7 @@ config PRINTK
 config PRINTK_NMI
 	def_bool y
 	depends on PRINTK
-	depends on HAVE_NMI || NEED_PRINTK_NMI
+	depends on HAVE_NMI
 
 config BUG
 	bool "BUG() support" if EXPERT
-- 
1.8.5.6
