Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2018 04:23:04 +0100 (CET)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:38548
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994032AbeA0DWFG6ANB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2018 04:22:05 +0100
Received: by mail-pg0-x242.google.com with SMTP id y27so1374848pgc.5;
        Fri, 26 Jan 2018 19:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hiav3NAXHdKIaZJW4yzSqMGfZp2IH94KX6CNoV6GZcI=;
        b=nsaR1xFxdzBmT8LpuDcpuGN+gEK9acetIblbyuJyx91AEcgiDS2EfAA6GDW7J5jG4k
         JQ9jES/ZJWPQa+qdGTGKD3BtUQFhEeLNAtmvC6kdSKoOlWnOCWbQ8gCJ/fTAAxUXksbZ
         M2S4pYb2FNyR7jgARodHUtJtTrMl+Pyf5CvVIjy95gGxU/Fax1bnwjPOBEP1oS4w42Fr
         iTW2YlAGnKLAcl4PyKCKzH0xsShv210kLxx5Lc/Y7eZ/FmKR74e/5s0pF55mgPWzT+Ix
         873sW7iXMEvovT0aBho9dhPDXzY3JBtTQ0zKPbXHua2KvpLQrRFqUC7MaojIf1lU+Jkx
         wlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Hiav3NAXHdKIaZJW4yzSqMGfZp2IH94KX6CNoV6GZcI=;
        b=QCvusiSBDaihmkKtncScidrEHhkmRNrdzerbvXt7DkgL1GDdBTE7zT1rtAzT5b3MB4
         I9HJaKurIK/3fPKKKdAY0vbwquUT/rehi/fVBZXm2VjU+M4O6x0I9/kZZUnvDisiDf6h
         qCQ5B2jt5h9QxLkWVatMGNfGJVZTtMQUYx+xAOoVZbe7ZKXPRtEz5bc42yA+D1CfD9Yn
         gL9nnTF8wFEF+ONHySLDSDZdMU2975Ml5oeW3YErWFc+o9/Yc/Jjvh2JpUMpBDQlZad/
         jps3M2DaHhw5mObJM6ZjWKVcjj6/KFQlgB8QU4GTDqBToKpdCz5c4QWWonwdu+mL593D
         BVbA==
X-Gm-Message-State: AKwxyteKPA0pkgk9iMJydya2W3jfG2dVJbVMkMuUCFLbnE2aFNd7E+yZ
        hFiQaQXa5nzp+rLj+VBNrTgK4g==
X-Google-Smtp-Source: AH8x225bdEjb6qiS34x8EebXKus5AFHofm23qaf6kQdkm67TfQ19SMb5bw7ez+dFClX7x921jgeTqA==
X-Received: by 10.99.185.78 with SMTP id v14mr10067433pgo.112.1517023317946;
        Fri, 26 Jan 2018 19:21:57 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id 8sm26843303pfh.170.2018.01.26.19.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 19:21:56 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 09/12] MIPS: Loongson: Add kexec/kdump support
Date:   Sat, 27 Jan 2018 11:22:16 +0800
Message-Id: <1517023336-17575-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1517023336-17575-1-git-send-email-chenhc@lemote.com>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <1517023336-17575-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62352
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

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/relocate_kernel.S    |  30 +++++++++
 arch/mips/loongson64/common/env.c     |   8 +++
 arch/mips/loongson64/common/reset.c   | 119 ++++++++++++++++++++++++++++++++++
 arch/mips/loongson64/loongson-3/smp.c |   4 ++
 4 files changed, 161 insertions(+)

diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/relocate_kernel.S
index c6bbf21..e73edc7 100644
--- a/arch/mips/kernel/relocate_kernel.S
+++ b/arch/mips/kernel/relocate_kernel.S
@@ -135,6 +135,36 @@ LEAF(kexec_smp_wait)
 #else
 	sync
 #endif
+
+#ifdef CONFIG_CPU_LOONGSON3
+	/* s0:prid s1:initfn */
+	/* t0:base t1:cpuid t2:node t3:core t9:count */
+	mfc0  t1, $15, 1
+	andi  t1, 0x3ff
+	dli   t0, 0x900000003ff01000
+	andi  t3, t1, 0x3
+	sll   t3, 8               /* get core id */
+	or    t0, t0, t3
+	andi  t2, t1, 0xc
+	dsll  t2, 42              /* get node id */
+	or    t0, t0, t2
+	mfc0  s0, $15, 0
+	andi  s0, s0, 0xf
+	blt   s0, 0x6, 1f         /* Loongson-3A1000 */
+	bgt   s0, 0x7, 1f         /* Loongson-3A2000/3A3000 */
+	dsrl  t2, 30              /* Loongson-3B1000/3B1500 need bit15:14 */
+	or    t0, t0, t2
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
index 2928ac5..990a2d69 100644
--- a/arch/mips/loongson64/common/env.c
+++ b/arch/mips/loongson64/common/env.c
@@ -72,6 +72,7 @@ void __init prom_init_env(void)
 
 	pr_info("memsize=%u, highmemsize=%u\n", memsize, highmemsize);
 #else
+	int i;
 	struct boot_params *boot_p;
 	struct loongson_params *loongson_p;
 	struct system_loongson *esys;
@@ -149,6 +150,13 @@ void __init prom_init_env(void)
 	loongson_sysconf.nr_cpus = ecpu->nr_cpus;
 	loongson_sysconf.boot_cpu_id = ecpu->cpu_startup_core_id;
 	loongson_sysconf.reserved_cpus_mask = ecpu->reserved_cores_mask;
+#ifdef CONFIG_KEXEC
+	loongson_sysconf.boot_cpu_id = get_ebase_cpunum();
+	for (i = 0; i < loongson_sysconf.boot_cpu_id; i++)
+		loongson_sysconf.reserved_cpus_mask |= (1<<i);
+	pr_info("Boot CPU ID is being fixed from %d to %d\n",
+		ecpu->cpu_startup_core_id, loongson_sysconf.boot_cpu_id);
+#endif
 	if (ecpu->nr_cpus > NR_CPUS || ecpu->nr_cpus == 0)
 		loongson_sysconf.nr_cpus = NR_CPUS;
 	loongson_sysconf.nr_nodes = (loongson_sysconf.nr_cpus +
diff --git a/arch/mips/loongson64/common/reset.c b/arch/mips/loongson64/common/reset.c
index a60715e..5f65a4e 100644
--- a/arch/mips/loongson64/common/reset.c
+++ b/arch/mips/loongson64/common/reset.c
@@ -11,9 +11,14 @@
  */
 #include <linux/init.h>
 #include <linux/pm.h>
+#include <linux/cpu.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/kexec.h>
 
 #include <asm/idle.h>
 #include <asm/reboot.h>
+#include <asm/bootinfo.h>
 
 #include <loongson.h>
 #include <boot_param.h>
@@ -80,12 +85,126 @@ static void loongson_halt(void)
 	}
 }
 
+#ifdef CONFIG_KEXEC
+
+/* 0X80000000~0X80200000 is safe */
+#define MAX_ARGS	64
+#define KEXEC_CTRL_CODE	0XFFFFFFFF80100000UL
+#define KEXEC_ARGV_ADDR	0XFFFFFFFF80108000UL
+#define KEXEC_ARGV_SIZE	3060
+#define KEXEC_ENVP_SIZE	4500
+
+void *kexec_argv;
+void *kexec_envp;
+extern const size_t relocate_new_kernel_size;
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
+			memcpy(kexec_argv + KEXEC_ARGV_SIZE/2, image->segment[i].buf, KEXEC_ARGV_SIZE/2);
+			str = (char *)kexec_argv + KEXEC_ARGV_SIZE/2;
+			ptr = strchr(str, ' ');
+
+			while (ptr && (argc < MAX_ARGS)) {
+				*ptr = '\0';
+				if (ptr[1] != ' ') {
+					offt = (int)(ptr - str + 1);
+					argv[argc] = KEXEC_ARGV_ADDR + KEXEC_ARGV_SIZE/2 + offt;
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
+			cpu_up(cpu); /* Everyone should go to reboot_code_buffer */
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
index 470e9c1..1e21ac4 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -387,6 +387,10 @@ static void __init loongson3_smp_setup(void)
 	ipi_status0_regs_init();
 	ipi_en0_regs_init();
 	ipi_mailbox_buf_init();
+
+	for (i = 0; i < loongson_sysconf.nr_cpus; i++)
+		loongson3_ipi_write64(0, (void *)(ipi_mailbox_buf[i]+0x0));
+
 	cpu_set_core(&cpu_data[0],
 		     cpu_logical_map(0) % loongson_sysconf.cores_per_package);
 	cpu_data[0].package = cpu_logical_map(0) / loongson_sysconf.cores_per_package;
-- 
2.7.0
