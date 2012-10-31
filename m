Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 16:27:18 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:55867 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6822164Ab2JaPReIbokY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2012 16:17:34 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 31 Oct 2012 08:17:25 -0700
From:   Sanjay Lal <sanjayl@kymasys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 01/20] KVM/MIPS32: Infrastructure/build files.
Date:   Wed, 31 Oct 2012 11:17:22 -0400
Message-Id: <6A87701A-F946-489D-AFC3-3BC8B7723CE0@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Mime-Version: 1.0 (Apple Message framework v1283)
X-Mailer: Apple Mail (2.1283)
X-archive-position: 34834
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

- Add the KVM option to MIPS build files.
- Add default config files for KVM host/guest kernels.
- Change the link address for the Malta KVM Guest kernel to UM (0x40100000).
- Add KVM Kconfig file with KVM/MIPS specific options

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/Kbuild             |  4 ++++
 arch/mips/Kconfig            | 20 ++++++++++++++++++
 arch/mips/kvm/Kconfig        | 49 ++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/mti-malta/Platform |  6 +++++-
 4 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/kvm/Kconfig

diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index 7dd65cf..d2cfe45 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -17,3 +17,7 @@ obj- := $(platform-)
 obj-y += kernel/
 obj-y += mm/
 obj-y += math-emu/
+
+ifdef CONFIG_KVM
+obj-y += kvm/
+endif
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index dba9390..8ac1aa1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1284,6 +1284,8 @@ config CPU_MIPS32_R2
 	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
+    select HAVE_KVM
+    
 	help
 	  Choose this option to build a kernel for release 2 or later of the
 	  MIPS32 architecture.  Most modern embedded systems with a 32-bit
@@ -1789,6 +1791,21 @@ config 64BIT
 
 endchoice
 
+config KVM_GUEST
+   bool "KVM Guest Kernel"
+   depends on HAVE_KVM 
+   help
+    Select this option if building a guest kernel for KVM (Trap & Emulate) mode
+
+config KVM_HOST_FREQ
+    int "KVM Host Processor Frequency (MHz)"
+    depends on HAVE_KVM 
+    default 500
+    help
+      Select this option if building a guest kernel for KVM to skip
+      RTC emulation when determining guest CPU Frequency.  Instead, the guest
+      processor frequency is automatically derived from the host frequency.
+
 choice
 	prompt "Kernel page size"
 	default PAGE_SIZE_4KB
@@ -2069,6 +2086,7 @@ config SB1_PASS_2_1_WORKAROUNDS
 	depends on CPU_SB1 && CPU_SB1_PASS_2
 	default y
 
+
 config 64BIT_PHYS_ADDR
 	bool
 
@@ -2579,3 +2597,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "arch/mips/kvm/Kconfig"
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
new file mode 100644
index 0000000..53390a3
--- /dev/null
+++ b/arch/mips/kvm/Kconfig
@@ -0,0 +1,49 @@
+#
+# KVM configuration
+#
+source "virt/kvm/Kconfig"
+
+menuconfig VIRTUALIZATION
+	bool "Virtualization"
+	depends on HAVE_KVM
+	---help---
+	  Say Y here to get to see options for using your Linux host to run
+	  other operating systems inside virtual machines (guests).
+	  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and
+	  disabled.
+
+if VIRTUALIZATION
+
+config KVM
+	tristate "Kernel-based Virtual Machine (KVM) support"
+	depends on HAVE_KVM
+	select PREEMPT_NOTIFIERS
+	select ANON_INODES
+    select KVM_MMIO
+
+config KVM_MIPS_DYN_TRANS
+	bool "KVM/MIPS: Dynamic binary translation to reduce traps"
+    depends on KVM
+	---help---
+      When running in Trap & Emulate mode use dynamic translation for privileged
+      instructions to reduce the number of traps
+
+	  If unsure, say Y.
+
+config KVM_EXIT_STATS
+	bool "Maintain VM Exit Statistics"
+    depends on KVM
+	---help---
+	  If unsure, say N.
+
+config KVM_MIPS_DEBUG_COP0_COUNTERS
+	bool "Maintain counters for COP0 accesses"
+    depends on KVM
+	---help---
+	  If unsure, say N.
+
+source drivers/vhost/Kconfig
+
+endif # VIRTUALIZATION
diff --git a/arch/mips/mti-malta/Platform b/arch/mips/mti-malta/Platform
index 5b548b5..2cc72c9 100644
--- a/arch/mips/mti-malta/Platform
+++ b/arch/mips/mti-malta/Platform
@@ -3,5 +3,9 @@
 #
 platform-$(CONFIG_MIPS_MALTA)	+= mti-malta/
 cflags-$(CONFIG_MIPS_MALTA)	+= -I$(srctree)/arch/mips/include/asm/mach-malta
-load-$(CONFIG_MIPS_MALTA)	+= 0xffffffff80100000
+ifdef CONFIG_KVM_GUEST
+    load-$(CONFIG_MIPS_MALTA)	+= 0x0000000040100000
+else
+    load-$(CONFIG_MIPS_MALTA)	+= 0xffffffff80100000
+endif
 all-$(CONFIG_MIPS_MALTA)	:= $(COMPRESSION_FNAME).bin
-- 
1.7.11.3
