From: Jason Wessel <jason.wessel@windriver.com>
Date: Mon, 28 Jul 2008 13:48:31 -0500
Subject: [PATCH] kgdb: remove the requirement for CONFIG_FRAME_POINTER
Message-ID: <20080728184831.04V4Efh1chS2RsBKDInDSpBb0jjM0XC9Do5A96JlwRM@z>

There is no technical reason that the kgdb core requires frame
pointers.  It is up to the end user of KGDB to decide if they need
them or not.

[ anemo@mba.ocn.ne.jp: removed frame pointers on mips ]

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 Documentation/DocBook/kgdb.tmpl |    8 ++++++++
 lib/Kconfig.kgdb                |   11 +++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/DocBook/kgdb.tmpl b/Documentation/DocBook/kgdb.tmpl
index e8acd1f..54d3b15 100644
--- a/Documentation/DocBook/kgdb.tmpl
+++ b/Documentation/DocBook/kgdb.tmpl
@@ -98,6 +98,14 @@
     "Kernel debugging" select "KGDB: kernel debugging with remote gdb".
     </para>
     <para>
+    It is advised, but not required that you turn on the
+    CONFIG_FRAME_POINTER kernel option.  This option inserts code to
+    into the compiled executable which saves the frame information in
+    registers or on the stack at different points which will allow a
+    debugger such as gdb to more accurately construct stack back traces
+    while debugging the kernel.
+    </para>
+    <para>
     Next you should choose one of more I/O drivers to interconnect debugging
     host and debugged target.  Early boot debugging requires a KGDB
     I/O driver that supports early debugging and the driver must be
diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index 2cfd272..9b5d1d7 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -4,14 +4,17 @@ config HAVE_ARCH_KGDB
 
 menuconfig KGDB
 	bool "KGDB: kernel debugging with remote gdb"
-	select FRAME_POINTER
 	depends on HAVE_ARCH_KGDB
 	depends on DEBUG_KERNEL && EXPERIMENTAL
 	help
 	  If you say Y here, it will be possible to remotely debug the
-	  kernel using gdb.  Documentation of kernel debugger is available
-	  at http://kgdb.sourceforge.net as well as in DocBook form
-	  in Documentation/DocBook/.  If unsure, say N.
+	  kernel using gdb.  It is recommended but not required, that
+	  you also turn on the kernel config option
+	  CONFIG_FRAME_POINTER to aid in producing more reliable stack
+	  backtraces in the external debugger.  Documentation of
+	  kernel debugger is available at http://kgdb.sourceforge.net
+	  as well as in DocBook form in Documentation/DocBook/.  If
+	  unsure, say N.
 
 if KGDB
 
-- 
1.5.5.1
