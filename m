Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:28:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18949 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994820AbdCNKS2gup5U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:18:28 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 175D8BD742748;
        Tue, 14 Mar 2017 10:18:19 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:18:21 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 25/33] KVM: MIPS: Add VZ support to build system
Date:   Tue, 14 Mar 2017 10:15:32 +0000
Message-ID: <2fd6fb9c03bac22f06697e07e794071bf18b7c83.1489485940.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
References: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Add support for the MIPS Virtualization (VZ) ASE to the MIPS KVM build
system. For now KVM can only be configured for T&E or VZ and not both,
but the design of the user facing APIs support the possibility of having
both available, so this could change in future.

Note that support for various optional guest features (some of which
can't be turned off) are implemented in immediately following commits,
so although it should now be possible to build VZ support, it may not
work yet on your hardware.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/Kconfig  | 28 ++++++++++++++++++++++++++--
 arch/mips/kvm/Makefile |  8 +++++++-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index 65067327db12..81bf5bf1d5e1 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -5,6 +5,7 @@ source "virt/kvm/Kconfig"
 
 menuconfig VIRTUALIZATION
 	bool "Virtualization"
+	depends on HAVE_KVM
 	---help---
 	  Say Y here to get to see options for using your Linux host to run
 	  other operating systems inside virtual machines (guests).
@@ -26,11 +27,34 @@ config KVM
 	select SRCU
 	---help---
 	  Support for hosting Guest kernels.
-	  Currently supported on MIPS32 processors.
+
+choice
+	prompt "Virtualization mode"
+	depends on KVM
+	default KVM_MIPS_TE
+
+config KVM_MIPS_TE
+	bool "Trap & Emulate"
+	---help---
+	  Use trap and emulate to virtualize 32-bit guests in user mode. This
+	  does not require any special hardware Virtualization support beyond
+	  standard MIPS32/64 r2 or later, but it does require the guest kernel
+	  to be configured with CONFIG_KVM_GUEST=y so that it resides in the
+	  user address segment.
+
+config KVM_MIPS_VZ
+	bool "MIPS Virtualization (VZ) ASE"
+	---help---
+	  Use the MIPS Virtualization (VZ) ASE to virtualize guests. This
+	  supports running unmodified guest kernels (with CONFIG_KVM_GUEST=n),
+	  but requires hardware support.
+
+endchoice
 
 config KVM_MIPS_DYN_TRANS
 	bool "KVM/MIPS: Dynamic binary translation to reduce traps"
-	depends on KVM
+	depends on KVM_MIPS_TE
+	default y
 	---help---
 	  When running in Trap & Emulate mode patch privileged
 	  instructions to reduce the number of traps.
diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
index e56403c8a3f5..45d90f5d5177 100644
--- a/arch/mips/kvm/Makefile
+++ b/arch/mips/kvm/Makefile
@@ -9,9 +9,15 @@ common-objs-$(CONFIG_CPU_HAS_MSA) += msa.o
 
 kvm-objs := $(common-objs-y) mips.o emulate.o entry.o \
 	    interrupt.o stats.o commpage.o \
-	    dyntrans.o trap_emul.o fpu.o
+	    fpu.o
 kvm-objs += hypcall.o
 kvm-objs += mmu.o
 
+ifdef CONFIG_KVM_MIPS_VZ
+kvm-objs		+= vz.o
+else
+kvm-objs		+= dyntrans.o
+kvm-objs		+= trap_emul.o
+endif
 obj-$(CONFIG_KVM)	+= kvm.o
 obj-y			+= callback.o tlb.o
-- 
git-series 0.8.10
