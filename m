Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 01:52:31 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9606 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492760Ab0A2Aw1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2010 01:52:27 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b6231510002>; Thu, 28 Jan 2010 16:52:33 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 28 Jan 2010 16:52:19 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 28 Jan 2010 16:52:18 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o0T0qER5026625;
        Thu, 28 Jan 2010 16:52:14 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o0T0qDIQ026623;
        Thu, 28 Jan 2010 16:52:13 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Allow the auxv's elf_platform entry to be set.
Date:   Thu, 28 Jan 2010 16:52:12 -0800
Message-Id: <1264726333-26599-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 29 Jan 2010 00:52:18.0896 (UTC) FILETIME=[4EEC8500:01CAA07D]
X-archive-position: 25729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18539

The userspace runtime linker uses the elf_platform to find the
libraries optimized for the current CPU archecture variant.  First we
need to allow it to be set to something other than NULL.  Follow-on
patches will set some values for specific CPUs.

GLIBC already does the right thing.  The kernel just needs to supply
good data.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/elf.h  |   14 +++++++-------
 arch/mips/kernel/cpu-probe.c |    1 +
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index 9266f02..1c3dbf0 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -334,14 +334,14 @@ extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *);
 
 #define ELF_HWCAP       (0)
 
-/* This yields a string that ld.so will use to load implementation
-   specific libraries for optimization.  This is more specific in
-   intent than poking at uname or /proc/cpuinfo.
-
-   For the moment, we have only optimizations for the Intel generations,
-   but that could change... */
+/*
+ * This yields a string that ld.so will use to load implementation
+ * specific libraries for optimization.  This is more specific in
+ * intent than poking at uname or /proc/cpuinfo.
+ */
 
-#define ELF_PLATFORM  (NULL)
+#define ELF_PLATFORM  __elf_platform
+extern const char *__elf_platform;
 
 /*
  * See comments in asm-alpha/elf.h, this is the same thing
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index aa25fd0..91ba1c8 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -917,6 +917,7 @@ static inline void cpu_probe_cavium(struct cpuinfo_mips *c, unsigned int cpu)
 }
 
 const char *__cpu_name[NR_CPUS];
+const char *__elf_platform;
 
 __cpuinit void cpu_probe(void)
 {
-- 
1.6.0.6
