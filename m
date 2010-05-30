From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 30 May 2010 13:27:22 +0200
Subject: [PATCH 1/6] mips: introduce arch/mips/Kbuild
Message-ID: <20100530112722.r8uE4jhOGIphltFy9ujJi42Mbwn6la8sNlJY36SLxAI@z>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/mips/Kbuild   |    6 ++++++
 arch/mips/Makefile |    3 ++-
 2 files changed, 8 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/Kbuild

diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
new file mode 100644
index 0000000..a18eb5d
--- /dev/null
+++ b/arch/mips/Kbuild
@@ -0,0 +1,6 @@
+# mips object files
+# The object files are linked as core-y files would be linked
+
+obj-y += kernel/
+obj-y += mm/
+obj-y += math-emu/
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 0b9c01a..d39be47 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -706,7 +706,8 @@ head-y := arch/mips/kernel/head.o arch/mips/kernel/init_task.o
 
 libs-y			+= arch/mips/lib/
 
-core-y			+= arch/mips/kernel/ arch/mips/mm/ arch/mips/math-emu/
+# See arch/mips/Kbuild for content of core part of the kernel
+core-y += arch/mips/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/mips/oprofile/
 
-- 
1.6.0.6
