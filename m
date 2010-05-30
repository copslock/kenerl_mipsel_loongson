From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 30 May 2010 16:03:25 +0200
Subject: [PATCH 3/6] mips: introduce support for Platform definitions
Message-ID: <20100530140325.cubGB8XkUXa0ycLXZTKgKuPzWhi2s_MnVPpLKHY7hik@z>

Move platform specific definitions to the platfrom directories.

Each platform shall do the following:
1) include an entry in arch/mips/Kbuild.platforms
2) add relevant definitions to arch/mips/<platform>/Platform

This commits change ar7 to the new scheme as an example.

Introducing a platform speecific Platfrom file has following advantages:
1) decentralization of platfrom definitions
2) simplification af arch/mips/Makefile
3) force all platfrom to build with -Werror (done in arch/mips/Kbuild)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/mips/Kbuild           |    3 +++
 arch/mips/Kbuild.platforms |    6 ++++++
 arch/mips/Makefile         |    8 +-------
 arch/mips/ar7/Platform     |    7 +++++++
 4 files changed, 17 insertions(+), 7 deletions(-)
 create mode 100644 arch/mips/Kbuild.platforms
 create mode 100644 arch/mips/ar7/Platform

diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index 6ce9382..e322d65 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -3,6 +3,9 @@
 # CFLAGS_<file.o> := -Wno-error
 subdir-ccflags-y := -Werror
 
+# platform specific definitions
+include arch/mips/Kbuild.platforms
+obj-y := $(platform-y)
 
 # mips object files
 # The object files are linked as core-y files would be linked
diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
new file mode 100644
index 0000000..932f268
--- /dev/null
+++ b/arch/mips/Kbuild.platforms
@@ -0,0 +1,6 @@
+# All platforms listed in alphabetic order
+
+platforms += ar7
+
+# include the platform specific files
+include $(patsubst %, arch/mips/%/Platform, $(platforms))
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d39be47..92346d0 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -209,13 +209,7 @@ endif
 #
 # Board-dependent options and extra files
 #
-
-#
-# Texas Instruments AR7
-#
-core-$(CONFIG_AR7)		+= arch/mips/ar7/
-cflags-$(CONFIG_AR7)		+= -I$(srctree)/arch/mips/include/asm/mach-ar7
-load-$(CONFIG_AR7)		+= 0xffffffff94100000
+include arch/mips/Kbuild.platforms
 
 #
 # Acer PICA 61, Mips Magnum 4000 and Olivetti M700.
diff --git a/arch/mips/ar7/Platform b/arch/mips/ar7/Platform
new file mode 100644
index 0000000..2978ddb
--- /dev/null
+++ b/arch/mips/ar7/Platform
@@ -0,0 +1,7 @@
+#
+# Texas Instruments AR7
+#
+platform-$(CONFIG_AR7)          += ar7/
+cflags-$(CONFIG_AR7)            += -I$(srctree)/arch/mips/include/asm/mach-ar7
+load-$(CONFIG_AR7)              += 0xffffffff94100000
+
-- 
1.6.0.6
