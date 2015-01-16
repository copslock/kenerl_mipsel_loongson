Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 11:54:57 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52459 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010539AbbAPKwHx0dmw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:52:07 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DAFD3F568F148
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:51:59 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:52:01 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:52:01 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 13/70] MIPS: Use generic checksum functions for MIPS R6
Date:   Fri, 16 Jan 2015 10:48:52 +0000
Message-ID: <1421405389-15512-14-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The following instructions have been removed from MIPS R6

ulw, ulh, swl, lwr, lwl, swr.

However, all of them are used in the MIPS specific checksum implementation.
As a result of which, we will use the generic checksum on MIPS R6

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/Kconfig                | 5 +++++
 arch/mips/include/asm/Kbuild     | 1 +
 arch/mips/include/asm/checksum.h | 6 ++++++
 arch/mips/kernel/mips_ksyms.c    | 2 ++
 arch/mips/lib/Makefile           | 1 +
 5 files changed, 15 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 72156ea62a69..3feabcb541c6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1033,6 +1033,9 @@ config MIPS_MACHINE
 config NO_IOPORT_MAP
 	def_bool n
 
+config GENERIC_CSUM
+	bool
+
 config GENERIC_ISA_DMA
 	bool
 	select ZONE_DMA if GENERIC_ISA_DMA_SUPPORT_BROKEN=n
@@ -1311,6 +1314,7 @@ config CPU_MIPS32_R6
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_MSA
+	select GENERIC_CSUM
 	select HAVE_KVM
 	help
 	  Choose this option to build a kernel for release 6 or later of the
@@ -1361,6 +1365,7 @@ config CPU_MIPS64_R6
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_MSA
+	select GENERIC_CSUM
 	help
 	  Choose this option to build a kernel for release 6 or later of the
 	  MIPS64 architecture.  New MIPS processors, starting with the Warrior
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 200efeac4181..526539cbc99f 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -1,4 +1,5 @@
 # MIPS headers
+generic-(CONFIG_GENERIC_CSUM) += checksum.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += dma-contiguous.h
diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 3418c51e1151..8464b62443b2 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -12,6 +12,10 @@
 #ifndef _ASM_CHECKSUM_H
 #define _ASM_CHECKSUM_H
 
+#ifdef CONFIG_GENERIC_CSUM
+#include <asm-generic/checksum.h>
+#else
+
 #include <linux/in6.h>
 
 #include <asm/uaccess.h>
@@ -287,4 +291,6 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	return csum_fold(sum);
 }
 
+#endif /* CONFIG_GENERIC_CSUM */
+
 #endif /* _ASM_CHECKSUM_H */
diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 17eaf0cf760c..ac66c30c8cd6 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -67,11 +67,13 @@ EXPORT_SYMBOL(__strnlen_kernel_asm);
 EXPORT_SYMBOL(__strnlen_user_nocheck_asm);
 EXPORT_SYMBOL(__strnlen_user_asm);
 
+#ifndef CONFIG_CPU_MIPSR6
 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
 EXPORT_SYMBOL(__csum_partial_copy_kernel);
 EXPORT_SYMBOL(__csum_partial_copy_to_user);
 EXPORT_SYMBOL(__csum_partial_copy_from_user);
+#endif
 
 EXPORT_SYMBOL(invalid_pte_table);
 #ifdef CONFIG_FUNCTION_TRACER
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index eeddc58802e1..1e9e900cd3c3 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -8,6 +8,7 @@ lib-y	+= bitops.o csum_partial.o delay.o memcpy.o memset.o \
 
 obj-y			+= iomap.o
 obj-$(CONFIG_PCI)	+= iomap-pci.o
+lib-$(CONFIG_GENERIC_CSUM)	:= $(filter-out csum_partial.o, $(lib-y))
 
 obj-$(CONFIG_CPU_GENERIC_DUMP_TLB) += dump_tlb.o
 obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
-- 
2.2.1
