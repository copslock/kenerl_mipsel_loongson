Return-Path: <SRS0=AiVX=QN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0812BC169C4
	for <linux-mips@archiver.kernel.org>; Wed,  6 Feb 2019 12:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27E72175B
	for <linux-mips@archiver.kernel.org>; Wed,  6 Feb 2019 12:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVDN4R3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfBFMAR (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:00:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43761 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfBFMAR (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 6 Feb 2019 07:00:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so2782928pgk.10
        for <linux-mips@vger.kernel.org>; Wed, 06 Feb 2019 04:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J4BGE8LdeesEnEC9y8TUnqty/TDI125DXchTfu6FzvI=;
        b=lVDN4R3hKYvLlire9g6yXdCpc2VgD8zIzhAl3tWbx4ghETuztqdTdG3pe5bNhCMvg8
         jSaRXmdlnpGZzwtIkWL9Ejbzzy0gUUmw9ipqcdte/3Co59GxKX4+flU4i9MKs02al88I
         13tIOI2Et6Hvpj+/Lq4ZGxMZBXeOgWdYCOpIlIMdH/9uv5CYx4LfLQmgGTDAWjGSEn9m
         +MQuAnuXvfLXDt8soMzLoLmk+fGb+EaR6uckpTjNleCQcYn7WyqjFUJ2jW0RPeHWrFc2
         wdi5IxPQpyAohrK28AJHbiV5UbMQQFvCel7tn4hSP8CakqwZzOo9JR+RULfsW0e11s4A
         ic3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=J4BGE8LdeesEnEC9y8TUnqty/TDI125DXchTfu6FzvI=;
        b=Zle01tM7exGGKGnEGsyIDpq4YVmsHKoqjeHWAS+Lz4QF/MP1hCNi5zAThIMdkt/blC
         dUrTq/Rtm+T6DXqtos1Gag6fMxrVvOFxjaOjG7QEE7agqrtdrwYXQ1Dt/LXRTxwTowBj
         ogJRfFk7qljsG0Ro8x3sWj3tIUBSs3yUbZOD5g7F4b6LqtTrF2udsGGQfi1pFqtMzED5
         3kXygozYG6tdq6h/eAec+o4WY11h7LrXOWhYID9RhQ0eYnwje4saRBt6tSLsFvSinlvQ
         V5AV2/elzlzvPTCvgZWwyRYUMt3d15vmyV20gjdx49AAKd55mqB4jc6vskPo6cjQpr1g
         K64Q==
X-Gm-Message-State: AHQUAubjCA1PGCgxwH2eWFKAi4yMkaRJaN9zmGXuM5tSoxskK6WfJAkO
        3tB9NVww9t20HPqjj7XTz7T4KCirRkRrSQ==
X-Google-Smtp-Source: AHgI3IZnOsgFej5cft7hgwTNyPGbguConjgOylfw0DAvjHYFjujT3FlM8M0YGmZz+pYsVkA4C3ezUA==
X-Received: by 2002:a62:2781:: with SMTP id n123mr10264135pfn.138.1549454415725;
        Wed, 06 Feb 2019 04:00:15 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id u69sm12471710pfj.116.2019.02.06.04.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Feb 2019 04:00:15 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-mips@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 2/2] MIPS: Loongson64: Add kexec/kdump support
Date:   Wed,  6 Feb 2019 19:59:33 +0800
Message-Id: <1549454373-8910-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1549454373-8910-1-git-send-email-chenhc@lemote.com>
References: <1549454373-8910-1-git-send-email-chenhc@lemote.com>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add kexec/kdump support for Loongson64 by:
1, Provide Loongson-specific kexec functions: loongson_kexec_prepare,
   loongson_kexec_shutdown and loongson_crash_shutdown;
2, Provide Loongson-specific code in kexec_smp_wait;
3, Clear mailbox in loongson3_smp_setup() since KEXEC bypass BIOS;
4, KEXEC always run at boot-cpu, but KDUMP may triggered at non-boot-
   cpu. Loongson64 assume boot-cpu is the first possible cpu, so fix
   boot_cpu_id in prom_init_env();

Cc: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/relocate_kernel.S    | 26 ++++++++++
 arch/mips/loongson64/common/env.c     |  7 +++
 arch/mips/loongson64/common/reset.c   | 95 +++++++++++++++++++++++++++++++++++
 arch/mips/loongson64/loongson-3/smp.c |  5 ++
 4 files changed, 133 insertions(+)

diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/relocate_kernel.S
index 419c921..da281c5 100644
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
index d4f9979..d325ae6 100644
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
index a60715e..58c3926 100644
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
 
@@ -80,12 +85,102 @@ static void loongson_halt(void)
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
+static void loongson_kexec_shutdown(void)
+{
+#ifdef CONFIG_SMP
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		if (!cpu_online(cpu))
+			cpu_up(cpu); /* All cpus go to reboot_code_buffer */
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
index bfaba5b..49ef958 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -388,6 +388,11 @@ static void __init loongson3_smp_setup(void)
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

