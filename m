Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 16:23:55 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:49668 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6825756Ab2JaPUDI2upt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2012 16:20:03 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 31 Oct 2012 08:19:56 -0700
From:   Sanjay Lal <sanjayl@kymasys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 09/20] KVM/MIPS32: Release notes and KVM module Makefile
Date:   Wed, 31 Oct 2012 11:19:52 -0400
Message-Id: <54AC28F9-B4F6-4DB1-A410-4D21C60206BF@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Mime-Version: 1.0 (Apple Message framework v1283)
X-Mailer: Apple Mail (2.1283)
X-archive-position: 34822
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/00README.txt | 31 +++++++++++++++++++++++++++++++
 arch/mips/kvm/Makefile     | 13 +++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 arch/mips/kvm/00README.txt
 create mode 100644 arch/mips/kvm/Makefile

diff --git a/arch/mips/kvm/00README.txt b/arch/mips/kvm/00README.txt
new file mode 100644
index 0000000..daaf280
--- /dev/null
+++ b/arch/mips/kvm/00README.txt
@@ -0,0 +1,31 @@
+KVM/MIPS Trap & Emulate Release Notes
+=====================================
+
+(1) KVM/MIPS should support MIPS32R2 and beyond. It has been tested on the following platforms:
+    Malta Board with FPGA based 34K
+    Sigma Designs TangoX board with a 24K based 8654 SoC.
+    Malta Board with 74K @ 1GHz
+
+(2) Both Guest kernel and Guest Userspace execute in UM.  
+    Guest User address space:   0x00000000 -> 0x40000000
+    Guest Kernel Unmapped:      0x40000000 -> 0x60000000
+    Guest Kernel Mapped:        0x60000000 -> 0x80000000
+
+    Guest Usermode virtual memory is limited to 1GB.
+
+(2) 16K Page Sizes: Both Host Kernel and Guest Kernel should have the same page size, currently at least 16K.
+    Note that due to cache aliasing issues, 4K page sizes are NOT supported.
+
+(3) No HugeTLB Support
+    Both the host kernel and Guest kernel should have the page size set to 16K.
+    This will be implemented in a future release.
+
+(4) KVM/MIPS does not have support for SMP Guests
+    Linux-3.7-rc2 based SMP guest hangs due to the following code sequence in the generated TLB handlers:
+	LL/TLBP/SC.  Since the TLBP instruction causes a trap the reservation gets cleared
+	when we ERET back to the guest. This causes the guest to hang in an infinite loop.
+	This will be fixed in a future release.
+
+(5) Use Host FPU
+    Currently KVM/MIPS emulates a 24K CPU without a FPU.
+    This will be fixed in a future release
diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
new file mode 100644
index 0000000..5b609bf
--- /dev/null
+++ b/arch/mips/kvm/Makefile
@@ -0,0 +1,13 @@
+# Makefile for KVM support for MIPS
+#
+
+common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
+
+EXTRA_CFLAGS += -Ivirt/kvm -Iarch/mips/kvm
+
+kvm-objs := $(common-objs) kvm_mips.o kvm_mips_emul.o kvm_locore.o kvm_mips_int.o \
+            kvm_mips_stats.o kvm_mips_commpage.o kvm_mips_dyntrans.o
+
+kvm-objs                  += kvm_trap_emul.o
+obj-$(CONFIG_KVM)         += kvm.o
+obj-y                     += kvm_tlb.o kvm_cb.o 
-- 
1.7.11.3
