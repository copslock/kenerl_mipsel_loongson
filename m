Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2007 15:34:12 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:20199 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022020AbXDDObQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Apr 2007 15:31:16 +0100
Received: (qmail 16905 invoked by uid 511); 4 Apr 2007 14:30:20 -0000
Received: from unknown (HELO heart.lemote.com) (192.168.2.206)
  by lemote.com with SMTP; 4 Apr 2007 14:30:20 -0000
Message-ID: <255864.73368773-sendEmail@heart>
From:	"zhangfx@lemote.com" <zhangfx@lemote.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject:  [PATCH 2/16] arch related Makefile update for lemote fulong mini-PC
Date:	Wed, 4 Apr 2007 14:38:18 +0000
X-Mailer: sendEmail-1.55
MIME-Version: 1.0
Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-857471.174168499"
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-857471.174168499
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 arch/mips/Makefile        |    8 ++++++++
 arch/mips/kernel/Makefile |    1 +
 arch/mips/lib-32/Makefile |    1 +
 arch/mips/lib-64/Makefile |    1 +
 arch/mips/mm/Makefile     |    1 +
 arch/mips/pci/Makefile    |    1 +
 6 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 92bca6a..2a6742d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -118,6 +118,7 @@ cflags-$(CONFIG_CPU_R4300)	+= -march=r4300 -Wa,--trap
 cflags-$(CONFIG_CPU_VR41XX)	+= -march=r4100 -Wa,--trap
 cflags-$(CONFIG_CPU_R4X00)	+= -march=r4600 -Wa,--trap
 cflags-$(CONFIG_CPU_TX49XX)	+= -march=r4600 -Wa,--trap
+cflags-$(CONFIG_CPU_LOONGSON2)	+= -march=r4600 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS32_R1)	+= $(call cc-option,-march=mips32,-mips32 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
 			-Wa,-mips32 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS32_R2)	+= $(call cc-option,-march=mips32r2,-mips32r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
@@ -298,6 +299,13 @@ cflags-$(CONFIG_WR_PPMC)		+= -Iinclude/asm-mips/mach-wrppmc
 load-$(CONFIG_WR_PPMC)		+= 0xffffffff80100000
 
 #
+# lemote fulong mini-PC board
+#
+core-$(CONFIG_LEMOTE_FULONG) +=arch/mips/lemote/lm2e/
+load-$(CONFIG_LEMOTE_FULONG) +=0xffffffff80100000
+cflags-$(CONFIG_LEMOTE_FULONG) += -Iinclude/asm-mips/mach-lemote
+
+#
 # For all MIPS, Inc. eval boards
 #
 core-$(CONFIG_MIPS_BOARDS_GEN)	+= arch/mips/mips-boards/generic/
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 4924626..40fdf79 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_CPU_R10000)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_SB1)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_MIPS32)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_MIPS64)	+= r4k_fpu.o r4k_switch.o
+obj-$(CONFIG_CPU_LOONGSON2)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R6000)		+= r6000_fpu.o r4k_switch.o
 
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/mips/lib-32/Makefile b/arch/mips/lib-32/Makefile
index 8b94d4c..b4be604 100644
--- a/arch/mips/lib-32/Makefile
+++ b/arch/mips/lib-32/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_CPU_SB1)		+= dump_tlb.o
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 obj-$(CONFIG_CPU_TX49XX)	+= dump_tlb.o
 obj-$(CONFIG_CPU_VR41XX)	+= dump_tlb.o
+obj-$(CONFIG_CPU_LOONGSON2)	+= dump_tlb.o
diff --git a/arch/mips/lib-64/Makefile b/arch/mips/lib-64/Makefile
index 8b94d4c..b4be604 100644
--- a/arch/mips/lib-64/Makefile
+++ b/arch/mips/lib-64/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_CPU_SB1)		+= dump_tlb.o
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 obj-$(CONFIG_CPU_TX49XX)	+= dump_tlb.o
 obj-$(CONFIG_CPU_VR41XX)	+= dump_tlb.o
+obj-$(CONFIG_CPU_LOONGSON2)	+= dump_tlb.o
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 293697b..b2dd42e 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_CPU_R5432)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
 obj-$(CONFIG_CPU_R8000)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r8k.o
 obj-$(CONFIG_CPU_RM7000)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
 obj-$(CONFIG_CPU_RM9000)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
+obj-$(CONFIG_CPU_LOONGSON2)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o 
 obj-$(CONFIG_CPU_SB1)		+= c-sb1.o cerr-sb1.o cex-sb1.o pg-sb1.o \
 				   tlb-r4k.o
 obj-$(CONFIG_CPU_TX39XX)	+= c-tx39.o pg-r4k.o tlb-r3k.o
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index bf85995..3a77235 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -53,3 +53,4 @@ obj-$(CONFIG_TOSHIBA_RBTX4938)	+= fixup-tx4938.o ops-tx4938.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
 obj-$(CONFIG_WR_PPMC)		+= fixup-wrppmc.o
+obj-$(CONFIG_LEMOTE_FULONG)	+= fixup-lm2e.o ops-lm2e.o
-- 
1.4.4.4



------MIME delimiter for sendEmail-857471.174168499--
