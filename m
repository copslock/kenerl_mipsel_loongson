Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 01:33:15 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2320 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904286Ab1KJAdI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2011 01:33:08 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ebb1c150001>; Wed, 09 Nov 2011 16:34:29 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 9 Nov 2011 16:33:06 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 9 Nov 2011 16:33:05 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAA0X5cB024236;
        Wed, 9 Nov 2011 16:33:05 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAA0X2mr024235;
        Wed, 9 Nov 2011 16:33:02 -0800
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fs: binfmt_elf: Create Kconfig variable for PIE randomization.
Date:   Wed,  9 Nov 2011 16:32:57 -0800
Message-Id: <1320885178-24201-1-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 10 Nov 2011 00:33:05.0981 (UTC) FILETIME=[503D26D0:01CC9F40]
X-archive-position: 31488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8369

Randomization of PIE load address is hard coded in binfmt_elf.c for
X86 and ARM.  Create a new Kconfig variable
(CONFIG_ARCH_BINFMT_ELF_RANDOMIZE_PIE) for this and use it instead.
Thus architecture specific policy is pushed out of the generic
binfmt_elf.c and into the architecture Kconfig files.

X86 and ARM Kconfigs are modified to select the new variable so there
is no change in behavior.  A follow on patch will select it for MIPS
too.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/arm/Kconfig  |    1 +
 arch/x86/Kconfig  |    1 +
 fs/Kconfig.binfmt |    3 +++
 fs/binfmt_elf.c   |    2 +-
 4 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 44789ef..3830439 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -30,6 +30,7 @@ config ARM
 	select HAVE_SPARSE_IRQ
 	select GENERIC_IRQ_SHOW
 	select CPU_PM if (SUSPEND || CPU_IDLE)
+	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cb9a104..9c3e447 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -75,6 +75,7 @@ config X86
 	select HAVE_BPF_JIT if (X86_64 && NET)
 	select CLKEVT_I8253
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 
 config INSTRUCTION_DECODER
 	def_bool (KPROBES || PERF_EVENTS)
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 79e2ca7..e95d1b6 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -27,6 +27,9 @@ config COMPAT_BINFMT_ELF
 	bool
 	depends on COMPAT && BINFMT_ELF
 
+config ARCH_BINFMT_ELF_RANDOMIZE_PIE
+	bool
+
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 21ac5ee..bcb884e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -794,7 +794,7 @@ static int load_elf_binary(struct linux_binprm *bprm, struct pt_regs *regs)
 			 * default mmap base, as well as whatever program they
 			 * might try to exec.  This is because the brk will
 			 * follow the loader, and is not movable.  */
-#if defined(CONFIG_X86) || defined(CONFIG_ARM)
+#ifdef CONFIG_ARCH_BINFMT_ELF_RANDOMIZE_PIE
 			/* Memory randomization might have been switched off
 			 * in runtime via sysctl.
 			 * If that is the case, retain the original non-zero
-- 
1.7.2.3
