Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2018 05:23:58 +0200 (CEST)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:41851
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbeD1DXv0nUXa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2018 05:23:51 +0200
Received: by mail-pg0-x242.google.com with SMTP id m21-v6so2826992pgv.8;
        Fri, 27 Apr 2018 20:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6fibO+roM9jW2kohcKtEk1Q71XBIV/q3IN4gsGe1dS4=;
        b=Jk+AGoNHSZm+NlGDdzzeBSYNhm8B1IawDzc7TIp7AI5Zo13qUAuiwSZEusUeJy+LaD
         MwAu7SqmIzcxWb3iLg6XoCciKREjH/Vm99u6xszCFxaGrXyzoc2aVOlbH+8d4+oTKKo0
         1EP2rhpzJtcEMlj1KUo2FjN1gm39d7lrS6Q2C5Vo45/0dIHozg0NLSJuSWJ2F8cuwhDE
         DL5MzNOYzb/3W/ACCn1J46pyry/qt9W+FU2loIiM91DXsF5TpcDthf+bAAXJP3e0LeLr
         igpY42L0eKM4w5D91Sj1Xu4jgqDUkfZn6e1nNR0kfEjty2TXn6gH6rA876OoBtMicC4b
         fCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=6fibO+roM9jW2kohcKtEk1Q71XBIV/q3IN4gsGe1dS4=;
        b=ngANs0GcIEFJ9AAAj4gkEPPHs0P2FL3kB2xNEiZYRWykJkDWXf2JkdjjhMMNSUgdKP
         dVHnO4StVYWcY0m6jSF72CGpu0gUTlPz6D43ckOX6r+uZn81erueTA/z653mm5qdra/T
         AfMJPyEAVrjntaxdRL8xJ9DZIBxGjAmrHKfdKPymG+aDpLiA8Gk8/u9fsCajP6AVjIuh
         0PqnDN4nnG+rBD+cmH3TTLKRomlVR0UdU+avRri2O8pw5STWtfxDfpM2JOZWYUh0xlZC
         xz6iZSQvOjXwBVdCbVZZjxKRo6rVXeEXcwFG+BOgYUEv4YHo6Yb2HFrLm41PMVANmaFR
         LrLA==
X-Gm-Message-State: ALQs6tB8VyI98sukVxEkPrRqQXj/Kjx3SgZUxvQdx4F/0R7dzf5hXQ2L
        XR0y24d6ZwxDihxqvXyYEhs3ZA==
X-Google-Smtp-Source: AB8JxZqqdA2l6GU/2f87NLQMW8UfS9HXFnLMqogPWN7YjRSUcZAX6G359ypMf4udEW0RveCZ4h3TJA==
X-Received: by 10.167.133.206 with SMTP id z14mr4407499pfn.2.1524885824234;
        Fri, 27 Apr 2018 20:23:44 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id g72sm7148114pfg.60.2018.04.27.20.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 20:23:43 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH V3 08/10] MIPS: Loongson64: Add kexec/kdump support
Date:   Sat, 28 Apr 2018 11:21:32 +0800
Message-Id: <1524885694-18132-9-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
References: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Add kexec/kdump support for Loongson64 by:
1, Set maximum physical address to 0x20000000000L (2^41, Node-0's
   address space for Loongson64) in CONFIG_64BIT;
2, Provide Loongson-specific kexec functions: loongson_kexec_prepare,
   loongson_kexec_shutdown and loongson_crash_shutdown;
3, Provide Loongson-specific code in kexec_smp_wait;
4, Clear mailbox in loongson3_smp_setup() since KEXEC bypass BIOS;
5, KEXEC always run at boot-cpu, but KDUMP may triggered at non-boot-
   cpu. Loongson64 assume boot-cpu is the first possible cpu, so fix
   boot_cpu_id in prom_init_env();

Cc: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/kexec.h         |  15 +++++
 arch/mips/kernel/relocate_kernel.S    |  26 ++++++++
 arch/mips/loongson64/common/env.c     |   7 ++
 arch/mips/loongson64/common/reset.c   | 120 ++++++++++++++++++++++++++++++++++
 arch/mips/loongson64/loongson-3/smp.c |   5 ++
 5 files changed, 173 insertions(+)

diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index 493a3cc..ffd4cee 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -11,12 +11,26 @@
 
 #include <asm/stacktrace.h>
 
+#ifdef CONFIG_32BIT
+
 /* Maximum physical address we can use pages from */
 #define KEXEC_SOURCE_MEMORY_LIMIT (0x20000000)
 /* Maximum address we can reach in physical address mode */
 #define KEXEC_DESTINATION_MEMORY_LIMIT (0x20000000)
  /* Maximum address we can use for the control code buffer */
 #define KEXEC_CONTROL_MEMORY_LIMIT (0x20000000)
+
+#else
+
+/* Maximum physical address we can use pages from */
+#define KEXEC_SOURCE_MEMORY_LIMIT (0x20000000000L)
+/* Maximum address we can reach in physical address mode */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (0x20000000000L)
+ /* Maximum address we can use for the control code buffer */
+#define KEXEC_CONTROL_MEMORY_LIMIT (0x20000000000L)
+
+#endif
+
 /* Reserve 3*4096 bytes for board-specific info */
 #define KEXEC_CONTROL_PAGE_SIZE (4096 + 3*4096)
 
@@ -36,6 +50,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 #ifdef CONFIG_KEXEC
 struct kimage;
 extern unsigned long kexec_args[4];
+extern const size_t relocate_new_kernel_size;
 extern int (*_machine_kexec_prepare)(struct kimage *);
 extern void (*_machine_kexec_shutdown)(void);
 extern void (*_machine_crash_shutdown)(struct pt_regs *regs);
diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/relocate_kernel.S
index c6bbf21..c769945 100644
--- a/arch/mips/kernel/relocate_kernel.S
+++ b/arch/mips/kernel/relocate_kernel.S
@@ -135,6 +135,32 @@ LEAF(kexec_smp_wait)
 #else
 	sync
 #endif
+
+#ifdef CONFIG_CPU_LOONGSON3
+	/* s0:prid s1:initfn */
+	/* t0:base t1:cpuid t2:node t9:count */
+	mfc0  t1, CP0_EBASE
+	andi  t1, MIPS_EBASE_CPUNUM
+	dli   t0, 0x900000003ff01000 /* mailbox base */
+	dins  t0, t1, 8, 2        /* insert core id*/
+	dext  t2, t1, 2, 2
+	dins  t0, t2, 44, 2       /* insert node id */
+	mfc0  s0, CP0_PRID
+	andi  s0, s0, 0xf
+	blt   s0, 0x6, 1f         /* Loongson-3A1000 */
+	bgt   s0, 0x7, 1f         /* Loongson-3A2000/3A3000 */
+	dins  t0, t2, 14, 2       /* Loongson-3B1000/3B1500 need bit 15~14 */
+1:	li    t9, 0x100           /* wait for init loop */
+2:	addiu t9, -1              /* limit mailbox access */
+	bnez  t9, 2b
+	ld    s1, 0x20(t0)        /* get PC via mailbox */
+	beqz  s1, 1b
+	ld    sp, 0x28(t0)        /* get SP via mailbox */
+	ld    gp, 0x30(t0)        /* get GP via mailbox */
+	ld    a1, 0x38(t0)
+	jr    s1                  /* jump to initial PC */
+#endif
+
 	j		s1
 	END(kexec_smp_wait)
 #endif
diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/common/env.c
index 2928ac5..4382e70 100644
--- a/arch/mips/loongson64/common/env.c
+++ b/arch/mips/loongson64/common/env.c
@@ -149,6 +149,13 @@ void __init prom_init_env(void)
 	loongson_sysconf.nr_cpus = ecpu->nr_cpus;
 	loongson_sysconf.boot_cpu_id = ecpu->cpu_startup_core_id;
 	loongson_sysconf.reserved_cpus_mask = ecpu->reserved_cores_mask;
+#ifdef CONFIG_KEXEC
+	loongson_sysconf.boot_cpu_id = get_ebase_cpunum();
+	loongson_sysconf.reserved_cpus_mask |=
+		(1 << loongson_sysconf.boot_cpu_id) - 1;
+	pr_info("Boot CPU ID is being fixed from %d to %d\n",
+		ecpu->cpu_startup_core_id, loongson_sysconf.boot_cpu_id);
+#endif
 	if (ecpu->nr_cpus > NR_CPUS || ecpu->nr_cpus == 0)
 		loongson_sysconf.nr_cpus = NR_CPUS;
 	loongson_sysconf.nr_nodes = (loongson_sysconf.nr_cpus +
diff --git a/arch/mips/loongson64/common/reset.c b/arch/mips/loongson64/common/reset.c
index a60715e..3d4a190 100644
--- a/arch/mips/loongson64/common/reset.c
+++ b/arch/mips/loongson64/common/reset.c
@@ -9,9 +9,14 @@
  * Copyright (C) 2009 Lemote, Inc.
  * Author: Zhangjin Wu, wuzhangjin@gmail.com
  */
+#include <linux/cpu.h>
+#include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/kexec.h>
 #include <linux/pm.h>
+#include <linux/slab.h>
 
+#include <asm/bootinfo.h>
 #include <asm/idle.h>
 #include <asm/reboot.h>
 
@@ -80,12 +85,127 @@ static void loongson_halt(void)
 	}
 }
 
+#ifdef CONFIG_KEXEC
+
+/* 0X80000000~0X80200000 is safe */
+#define MAX_ARGS	64
+#define KEXEC_CTRL_CODE	0xFFFFFFFF80100000UL
+#define KEXEC_ARGV_ADDR	0xFFFFFFFF80108000UL
+#define KEXEC_ARGV_SIZE	3060
+#define KEXEC_ENVP_SIZE	4500
+
+void *kexec_argv;
+void *kexec_envp;
+
+static int loongson_kexec_prepare(struct kimage *image)
+{
+	int i, argc = 0;
+	unsigned int *argv;
+	char *str, *ptr, *bootloader = "kexec";
+
+	/* argv at offset 0, argv[] at offset KEXEC_ARGV_SIZE/2 */
+	argv = (unsigned int *)kexec_argv;
+	argv[argc++] = (unsigned int)(KEXEC_ARGV_ADDR + KEXEC_ARGV_SIZE/2);
+
+	for (i = 0; i < image->nr_segments; i++) {
+		if (!strncmp(bootloader, (char *)image->segment[i].buf,
+				strlen(bootloader))) {
+			/*
+			 * convert command line string to array
+			 * of parameters (as bootloader does).
+			 */
+			int offt;
+			memcpy(kexec_argv + KEXEC_ARGV_SIZE/2,
+				image->segment[i].buf, KEXEC_ARGV_SIZE/2);
+			str = (char *)kexec_argv + KEXEC_ARGV_SIZE/2;
+			ptr = strchr(str, ' ');
+
+			while (ptr && (argc < MAX_ARGS)) {
+				*ptr = '\0';
+				if (ptr[1] != ' ') {
+					offt = (int)(ptr - str + 1);
+					argv[argc] = KEXEC_ARGV_ADDR +
+						KEXEC_ARGV_SIZE/2 + offt;
+					argc++;
+				}
+				ptr = strchr(ptr + 1, ' ');
+			}
+			break;
+		}
+	}
+
+	kexec_args[0] = argc;
+	kexec_args[1] = fw_arg1;
+	kexec_args[2] = fw_arg2;
+	image->control_code_page = virt_to_page((void *)KEXEC_CTRL_CODE);
+
+	return 0;
+}
+
+#ifdef CONFIG_SMP
+static void kexec_smp_down(void *ignored)
+{
+	int cpu = smp_processor_id();
+
+	local_irq_disable();
+	set_cpu_online(cpu, false);
+	while (!atomic_read(&kexec_ready_to_reboot))
+		cpu_relax();
+
+	asm volatile (
+	"	sync					\n"
+	"	synci	($0)				\n");
+
+	relocated_kexec_smp_wait(NULL);
+}
+#endif
+
+static void loongson_kexec_shutdown(void)
+{
+#ifdef CONFIG_SMP
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		if (!cpu_online(cpu))
+			cpu_up(cpu); /* All cpus go to reboot_code_buffer */
+
+	smp_call_function(kexec_smp_down, NULL, 0);
+	smp_wmb();
+	while (num_online_cpus() > 1) {
+		mdelay(1);
+		cpu_relax();
+	}
+#endif
+	memcpy((void *)fw_arg1, kexec_argv, KEXEC_ARGV_SIZE);
+	memcpy((void *)fw_arg2, kexec_envp, KEXEC_ENVP_SIZE);
+}
+
+static void loongson_crash_shutdown(struct pt_regs *regs)
+{
+	default_machine_crash_shutdown(regs);
+	memcpy((void *)fw_arg1, kexec_argv, KEXEC_ARGV_SIZE);
+	memcpy((void *)fw_arg2, kexec_envp, KEXEC_ENVP_SIZE);
+}
+
+#endif
+
 static int __init mips_reboot_setup(void)
 {
 	_machine_restart = loongson_restart;
 	_machine_halt = loongson_halt;
 	pm_power_off = loongson_poweroff;
 
+#ifdef CONFIG_KEXEC
+	kexec_argv = kmalloc(KEXEC_ARGV_SIZE, GFP_KERNEL);
+	kexec_envp = kmalloc(KEXEC_ENVP_SIZE, GFP_KERNEL);
+	fw_arg1 = KEXEC_ARGV_ADDR;
+	memcpy(kexec_envp, (void *)fw_arg2, KEXEC_ENVP_SIZE);
+
+	_machine_kexec_prepare = loongson_kexec_prepare;
+	_machine_kexec_shutdown = loongson_kexec_shutdown;
+	_machine_crash_shutdown = loongson_crash_shutdown;
+#endif
+
 	return 0;
 }
 
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index 470e9c1..594fa17 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -387,6 +387,11 @@ static void __init loongson3_smp_setup(void)
 	ipi_status0_regs_init();
 	ipi_en0_regs_init();
 	ipi_mailbox_buf_init();
+
+	/* BIOS clear the mailbox, but KEXEC bypass BIOS so clear here */
+	for (i = 0; i < loongson_sysconf.nr_cpus; i++)
+		loongson3_ipi_write64(0, (void *)(ipi_mailbox_buf[i]+0x0));
+
 	cpu_set_core(&cpu_data[0],
 		     cpu_logical_map(0) % loongson_sysconf.cores_per_package);
 	cpu_data[0].package = cpu_logical_map(0) / loongson_sysconf.cores_per_package;
-- 
2.7.0
