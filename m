Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 01:04:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36376 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994854AbdHGXDOZLzpI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 01:03:14 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0E93EADFEE639;
        Tue,  8 Aug 2017 00:03:03 +0100 (IST)
Received: from localhost (10.20.1.88) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 8 Aug 2017 00:03:07
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 5/7] MIPS: Make CONFIG_MIPS_MT_SMP default y
Date:   Mon, 7 Aug 2017 16:01:16 -0700
Message-ID: <20170807230119.10629-6-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170807230119.10629-1-paul.burton@imgtec.com>
References: <20170807230119.10629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On systems that support MT ASE multithreading (ie. VPEs) we are very
likely to want to include that support as default. Rather than setting
it in various defconfigs, simply make CONFIG_MIPS_MT_SMP default y such
that systems which select CONFIG_SYS_SUPPORTS_MULTITHREADING get it by
default.

As well as allowing us to remove the selection of CONFIG_MIPS_MT_SMP
from various defconfigs, this also allows the generated generic
defconfigs which derive from generic_defconfig to automatically gain
support for MT ASE SMP when building for a suitable (pre-MIPSr6) ISA.

For malta_kvm_guest_defconfig CONFIG_MIPS_MT_SMP is explicitly disabled
since enabling SMP implicitly disables CONFIG_KVM_GUEST, which depends
on CONFIG_BROKEN_ON_SMP.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/Kconfig                           | 1 +
 arch/mips/configs/malta_defconfig           | 1 -
 arch/mips/configs/malta_kvm_defconfig       | 1 -
 arch/mips/configs/malta_kvm_guest_defconfig | 1 +
 arch/mips/configs/maltasmvp_defconfig       | 1 -
 arch/mips/configs/maltasmvp_eva_defconfig   | 1 -
 6 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 12abdf4d3850..508e4f549b2b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2249,6 +2249,7 @@ config CPU_R4K_CACHE_TLB
 
 config MIPS_MT_SMP
 	bool "MIPS MT SMP support (1 TC on each available VPE)"
+	default y
 	depends on SYS_SUPPORTS_MULTITHREADING && !CPU_MIPSR6
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 078ecac071ab..396408404487 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -2,7 +2,6 @@ CONFIG_MIPS_MALTA=y
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_CPU_MIPS32_R2=y
 CONFIG_PAGE_SIZE_16KB=y
-CONFIG_MIPS_MT_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_HZ_100=y
 CONFIG_SYSVIPC=y
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index 80ecd94ed126..5691673a3327 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -2,7 +2,6 @@ CONFIG_MIPS_MALTA=y
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_CPU_MIPS32_R2=y
 CONFIG_PAGE_SIZE_16KB=y
-CONFIG_MIPS_MT_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_HZ_100=y
 CONFIG_SYSVIPC=y
diff --git a/arch/mips/configs/malta_kvm_guest_defconfig b/arch/mips/configs/malta_kvm_guest_defconfig
index 35ad1f8d1a79..e9cadb37d684 100644
--- a/arch/mips/configs/malta_kvm_guest_defconfig
+++ b/arch/mips/configs/malta_kvm_guest_defconfig
@@ -3,6 +3,7 @@ CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_CPU_MIPS32_R2=y
 CONFIG_KVM_GUEST=y
 CONFIG_PAGE_SIZE_16KB=y
+# CONFIG_MIPS_MT_SMP is not set
 CONFIG_HZ_100=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
index 55b68b981b05..d8c8f5fb8918 100644
--- a/arch/mips/configs/maltasmvp_defconfig
+++ b/arch/mips/configs/maltasmvp_defconfig
@@ -2,7 +2,6 @@ CONFIG_MIPS_MALTA=y
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_CPU_MIPS32_R2=y
 CONFIG_PAGE_SIZE_16KB=y
-CONFIG_MIPS_MT_SMP=y
 CONFIG_SCHED_SMT=y
 CONFIG_MIPS_CPS=y
 CONFIG_NR_CPUS=8
diff --git a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
index 5ca590cf1635..04827bc9f87f 100644
--- a/arch/mips/configs/maltasmvp_eva_defconfig
+++ b/arch/mips/configs/maltasmvp_eva_defconfig
@@ -3,7 +3,6 @@ CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_CPU_MIPS32_R2=y
 CONFIG_CPU_MIPS32_3_5_FEATURES=y
 CONFIG_PAGE_SIZE_16KB=y
-CONFIG_MIPS_MT_SMP=y
 CONFIG_SCHED_SMT=y
 CONFIG_MIPS_CPS=y
 CONFIG_NR_CPUS=8
-- 
2.14.0
