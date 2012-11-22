Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2012 03:37:02 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:35882 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6825657Ab2KVCeuP06GM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Nov 2012 03:34:50 +0100
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 21 Nov 2012 18:34:43 -0800
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 9B7AF63027D; Wed, 21 Nov 2012 18:34:18 -0800 (PST)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 08/18] KVM/MIPS32: Release notes and KVM module Makefile
Date:   Wed, 21 Nov 2012 18:34:06 -0800
Message-Id: <1353551656-23579-9-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
X-archive-position: 35082
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
 arch/mips/kvm/Makefile     | 17 +++++++++++++++++
 2 files changed, 48 insertions(+)
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
index 0000000..f3ed378
--- /dev/null
+++ b/arch/mips/kvm/Makefile
@@ -0,0 +1,17 @@
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
+ifdef CONFIG_KVM_MIPS_VZ
+kvm-objs                  += kvm_vz.o
+else
+kvm-objs                  += kvm_trap_emul.o
+endif
+obj-$(CONFIG_KVM)         += kvm.o
+obj-y                     += kvm_tlb.o kvm_cb.o
-- 
1.7.11.3
