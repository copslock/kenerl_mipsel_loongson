Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:13:41 +0200 (CEST)
Received: from mail-ie0-f178.google.com ([209.85.223.178]:40447 "EHLO
        mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835216Ab3FGXEAh8K0m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:04:00 +0200
Received: by mail-ie0-f178.google.com with SMTP id at1so8352509iec.9
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tpxM7tmCd2UAaH8wQa1+C9wCPgSsLX4NPwZvWbfRRJw=;
        b=lKB0lAP4hiwmgPsNXdlSpHiQxWXfqy3064kodLrT0PDaG0VPJZqn1OWLskWz0U/S3O
         RZXVMwB7VJWC36yr1V+60pDRy5qpJ20vOSyixha3ThnDis+3T6RcRmnsg0sMIjho/IWZ
         DmMQmbG1bNioIJOOuHvsQfe9OG5ddafWBdwwBSDvP24Tv8IFsaPKjGaKxmm9OvwVJuNC
         SLbAIZo9LwJEaa/G1avofETBLo736nCwymVnpfRa1YY0ilj1rLMKwKfrIT8zNuYMPN5I
         p//Y2tXvQDaC6pCsoh3SlxQ5lKhrE4KaYrpLTdlpUcMHJ2OGaAfoEDAuAUTYkzxYik5D
         3Rsw==
X-Received: by 10.50.21.42 with SMTP id s10mr2285758ige.84.1370646234527;
        Fri, 07 Jun 2013 16:03:54 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id l14sm1146508igf.9.2013.06.07.16.03.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:53 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3pab006715;
        Fri, 7 Jun 2013 16:03:51 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3pcR006714;
        Fri, 7 Jun 2013 16:03:51 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 26/31] mips/kvm: Split up Kconfig and Makefile definitions in preperation for MIPSVZ.
Date:   Fri,  7 Jun 2013 16:03:30 -0700
Message-Id: <1370646215-6543-27-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Create the symbol KVM_MIPSTE, and use it to select the trap and
emulate specific things.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kvm/Kconfig  | 14 +++++++++-----
 arch/mips/kvm/Makefile | 14 ++++++++------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index 2c15590..95c0d22 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -16,18 +16,22 @@ menuconfig VIRTUALIZATION
 if VIRTUALIZATION
 
 config KVM
-	tristate "Kernel-based Virtual Machine (KVM) support"
-	depends on HAVE_KVM
+	tristate
 	select PREEMPT_NOTIFIERS
+
+config KVM_MIPSTE
+	tristate "Kernel-based Virtual Machine (KVM) 32-bit trap-and-emulate"
+	depends on HAVE_KVM
+	select KVM
 	select ANON_INODES
 	select KVM_MMIO
 	---help---
-	  Support for hosting Guest kernels.
+	  Support for hosting Guest kernels with modified address space layout.
 	  Currently supported on MIPS32 processors.
 
 config KVM_MIPS_DYN_TRANS
 	bool "KVM/MIPS: Dynamic binary translation to reduce traps"
-	depends on KVM
+	depends on KVM_MIPSTE
 	---help---
 	  When running in Trap & Emulate mode patch privileged
 	  instructions to reduce the number of traps.
@@ -36,7 +40,7 @@ config KVM_MIPS_DYN_TRANS
 
 config KVM_MIPS_DEBUG_COP0_COUNTERS
 	bool "Maintain counters for COP0 accesses"
-	depends on KVM
+	depends on KVM_MIPSTE
 	---help---
 	  Maintain statistics for Guest COP0 accesses.
 	  A histogram of COP0 accesses is printed when the VM is
diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
index 78d87bb..3377197 100644
--- a/arch/mips/kvm/Makefile
+++ b/arch/mips/kvm/Makefile
@@ -1,13 +1,15 @@
 # Makefile for KVM support for MIPS
 #
 
-common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
+common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o)
 
 EXTRA_CFLAGS += -Ivirt/kvm -Iarch/mips/kvm
 
-kvm-objs := $(common-objs) kvm_mips.o kvm_mips_emul.o kvm_locore.o \
-	    kvm_mips_int.o kvm_mips_stats.o kvm_mips_commpage.o \
-	    kvm_mips_dyntrans.o kvm_trap_emul.o
+kvm_mipste-objs		:= kvm_mips_emul.o kvm_locore.o kvm_mips_int.o \
+			   kvm_mips_stats.o kvm_mips_commpage.o \
+			   kvm_mips_dyntrans.o kvm_trap_emul.o kvm_cb.o \
+			   kvm_tlb.o \
+			   $(addprefix ../../../virt/kvm/, coalesced_mmio.o)
 
-obj-$(CONFIG_KVM)	+= kvm.o
-obj-y			+= kvm_cb.o kvm_tlb.o
+obj-$(CONFIG_KVM)		+= $(common-objs) kvm_mips.o
+obj-$(CONFIG_KVM_MIPSTE)	+= kvm_mipste.o
-- 
1.7.11.7
