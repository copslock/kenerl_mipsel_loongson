Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 07:52:18 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:36460 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6835035Ab3ESFsrFehMS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 May 2013 07:48:47 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Sat, 18 May 2013 22:48:39 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 3B9CA630061; Sat, 18 May 2013 22:47:43 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 09/18] KVM/MIPS32-VZ: Add support for CONFIG_KVM_MIPS_VZ option
Date:   Sat, 18 May 2013 22:47:31 -0700
Message-Id: <1368942460-15577-10-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
References: <n>
 <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36466
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

- Add config option for KVM/MIPS with VZ support.

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/Kconfig  | 14 +++++++++++++-
 arch/mips/kvm/Makefile | 14 +++++++++-----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index 2c15590..963657f 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -25,9 +25,21 @@ config KVM
 	  Support for hosting Guest kernels.
 	  Currently supported on MIPS32 processors.
 
+config KVM_MIPS_VZ
+	bool "KVM support using the MIPS Virtualization ASE"
+	depends on KVM
+	---help---
+	  Support running unmodified guest kernels in virtual machines using
+	  the MIPS virtualization ASE.  If this option is not selected
+	  then KVM will default to using trap and emulate to virtualize
+	  guests, which will not be as optimal as using the VZ ASE.
+
+	  If unsure, say N.
+
 config KVM_MIPS_DYN_TRANS
 	bool "KVM/MIPS: Dynamic binary translation to reduce traps"
-	depends on KVM
+	depends on KVM && !KVM_MIPS_VZ
+	default y
 	---help---
 	  When running in Trap & Emulate mode patch privileged
 	  instructions to reduce the number of traps.
diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
index 78d87bb..cc64bb4 100644
--- a/arch/mips/kvm/Makefile
+++ b/arch/mips/kvm/Makefile
@@ -5,9 +5,13 @@ common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
 
 EXTRA_CFLAGS += -Ivirt/kvm -Iarch/mips/kvm
 
-kvm-objs := $(common-objs) kvm_mips.o kvm_mips_emul.o kvm_locore.o \
-	    kvm_mips_int.o kvm_mips_stats.o kvm_mips_commpage.o \
-	    kvm_mips_dyntrans.o kvm_trap_emul.o
+kvm-objs := $(common-objs) kvm_mips.o kvm_mips_emul.o kvm_locore.o kvm_mips_int.o \
+            kvm_mips_stats.o kvm_mips_commpage.o kvm_mips_dyntrans.o
 
-obj-$(CONFIG_KVM)	+= kvm.o
-obj-y			+= kvm_cb.o kvm_tlb.o
+ifdef CONFIG_KVM_MIPS_VZ
+kvm-objs                  += kvm_vz.o
+else
+kvm-objs                  += kvm_trap_emul.o
+endif
+obj-$(CONFIG_KVM)         += kvm.o
+obj-y                     += kvm_tlb.o kvm_cb.o kvm_vz_locore.o
-- 
1.7.11.3
