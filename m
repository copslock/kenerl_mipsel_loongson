From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Mon, 18 Feb 2008 11:12:20 +0100
Subject: [PATCH] Alchemy: compile fix
Message-ID: <20080218101220.7_-wYfWS1u38o08oKtG_lYsJlDBTGxthkJM3V1EGNpk@z>

Commit 8b798c4d16b762d15f4055597ff8d87f73b35552 broke
alchemy build, fix it.  Pointed out by Adrian Bunk.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 include/asm-mips/mach-db1x00/db1200.h |    1 +
 include/asm-mips/mach-db1x00/db1x00.h |    1 +
 include/asm-mips/mach-pb1x00/pb1200.h |    1 +
 include/asm-mips/mach-pb1x00/pb1550.h |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/asm-mips/mach-db1x00/db1200.h b/include/asm-mips/mach-db1x00/db1200.h
index 050eae8..a6bdac6 100644
--- a/include/asm-mips/mach-db1x00/db1200.h
+++ b/include/asm-mips/mach-db1x00/db1200.h
@@ -25,6 +25,7 @@
 #define __ASM_DB1200_H
 
 #include <linux/types.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
 
 // This is defined in au1000.h with bogus value
 #undef AU1X00_EXTERNAL_INT
diff --git a/include/asm-mips/mach-db1x00/db1x00.h b/include/asm-mips/mach-db1x00/db1x00.h
index 0f5f4c2..e7a88ba 100644
--- a/include/asm-mips/mach-db1x00/db1x00.h
+++ b/include/asm-mips/mach-db1x00/db1x00.h
@@ -28,6 +28,7 @@
 #ifndef __ASM_DB1X00_H
 #define __ASM_DB1X00_H
 
+#include <asm/mach-au1x00/au1xxx_psc.h>
 
 #ifdef CONFIG_MIPS_DB1550
 
diff --git a/include/asm-mips/mach-pb1x00/pb1200.h b/include/asm-mips/mach-pb1x00/pb1200.h
index d9f384a..ed5fd73 100644
--- a/include/asm-mips/mach-pb1x00/pb1200.h
+++ b/include/asm-mips/mach-pb1x00/pb1200.h
@@ -25,6 +25,7 @@
 #define __ASM_PB1200_H
 
 #include <linux/types.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
 
 // This is defined in au1000.h with bogus value
 #undef AU1X00_EXTERNAL_INT
diff --git a/include/asm-mips/mach-pb1x00/pb1550.h b/include/asm-mips/mach-pb1x00/pb1550.h
index 9a4955c..c2ab0e2 100644
--- a/include/asm-mips/mach-pb1x00/pb1550.h
+++ b/include/asm-mips/mach-pb1x00/pb1550.h
@@ -28,6 +28,7 @@
 #define __ASM_PB1550_H
 
 #include <linux/types.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
 
 #define DBDMA_AC97_TX_CHAN DSCR_CMD0_PSC1_TX
 #define DBDMA_AC97_RX_CHAN DSCR_CMD0_PSC1_RX
-- 
1.5.4
