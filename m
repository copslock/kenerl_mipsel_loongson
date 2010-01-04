Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2010 10:19:46 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:36824 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493172Ab0ADJRx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2010 10:17:53 +0100
Received: by mail-yx0-f204.google.com with SMTP id 42so15199460yxe.22
        for <multiple recipients>; Mon, 04 Jan 2010 01:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=/GDT4oLVqAd9em5E/uCa+drrQdHKGC1VxyoT6m3Brls=;
        b=X1PCA6uqVJeLcOZozxg0H3DUmuOikCwJFZyXepXpZ/nj5sTdAte873ASa1YmbKZaQN
         OCVSg0+MMsp/EIULdlNOKjM32D0VsgaQTIakd2flipVcFk68RpT4HNCQOq+0OE70Dv1k
         h2XW7yQ4MGGrs5cZ+ZDTP62gky4zXTR3TZSck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XfeweROgfMMWsWRd9o3pGODsMPg++mgqxIAEf7pK2pq0RV6G5unYkwzsDB0QOHoNJs
         pr0bbSORl6/DMsWnacq55QvD3QcLFddA1rqzmK+KLQ6zJut2FWk6lhWl5zqhGk2xWbSo
         ws0UApGlcmyuevssiHa4fHZDrRrf40qXutZko=
Received: by 10.101.10.15 with SMTP id n15mr10667569ani.82.1262596672588;
        Mon, 04 Jan 2010 01:17:52 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm6122077ywh.16.2010.01.04.01.17.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Jan 2010 01:17:51 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, yanh@lemote.com, huhb@lemote.com,
        zhangfx@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 06/10] Loongson: Cleanup of the environment variables
Date:   Mon,  4 Jan 2010 17:16:48 +0800
Message-Id: <b36e03d26901b981248854fcaa645d8c8a0f23a8.1262596493.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.5.6
In-Reply-To: <a5bac10a774e405cffcf79edc430b31d6becb0d0.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262586650.git.wuzhangjin@gmail.com>
 <f4aeb125cb030f10d34966febfe9715874d52ab2.1262596493.git.wuzhangjin@gmail.com>
 <669ff2f39fd2aa3849e472438d3d9d499c8f0e3a.1262596493.git.wuzhangjin@gmail.com>
 <9bcc0f00c46fdf5c832ce3bdd0df8d7f08b7a1be.1262596493.git.wuzhangjin@gmail.com>
 <dc64ae336edaf61405e56534e33fe40c49694378.1262596493.git.wuzhangjin@gmail.com>
 <a5bac10a774e405cffcf79edc430b31d6becb0d0.1262596493.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262596493.git.wuzhangjin@gmail.com>
X-archive-position: 25504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2266

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes:

	o Move bus_clock into prom_init_env()
	o Initialize the cpu_clock_freq to the default values for the
	correspoding processor revisions if no such environment variable
	passed by BIOS/Bootloader.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    2 +-
 arch/mips/loongson/common/env.c                |   25 ++++++++++++++++++++---
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index ee8bc83..a6eac0f 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -23,7 +23,7 @@ extern void mach_prepare_reboot(void);
 extern void mach_prepare_shutdown(void);
 
 /* environment arguments from bootloader */
-extern unsigned long bus_clock, cpu_clock_freq;
+extern unsigned long cpu_clock_freq;
 extern unsigned long memsize, highmemsize;
 
 /* loongson-specific command line, env and memory initialization */
diff --git a/arch/mips/loongson/common/env.c b/arch/mips/loongson/common/env.c
index 196d947..8c01df5 100644
--- a/arch/mips/loongson/common/env.c
+++ b/arch/mips/loongson/common/env.c
@@ -23,13 +23,10 @@
 
 #include <loongson.h>
 
-unsigned long bus_clock, cpu_clock_freq;
+unsigned long cpu_clock_freq;
 EXPORT_SYMBOL(cpu_clock_freq);
 unsigned long memsize, highmemsize;
 
-/* pmon passes arguments in 32bit pointers */
-int *_prom_envp;
-
 #define parse_even_earlier(res, option, p)				\
 do {									\
 	if (strncmp(option, (char *)p, strlen(option)) == 0)		\
@@ -39,6 +36,10 @@ do {									\
 
 void __init prom_init_env(void)
 {
+	/* pmon passes arguments in 32bit pointers */
+	int *_prom_envp;
+	unsigned long bus_clock;
+	unsigned int processor_id;
 	long l;
 
 	/* firmware arguments are initialized in head.S */
@@ -55,6 +56,22 @@ void __init prom_init_env(void)
 	}
 	if (memsize == 0)
 		memsize = 256;
+	if (bus_clock == 0)
+		bus_clock = 66000000;
+	if (cpu_clock_freq == 0) {
+		processor_id = (&current_cpu_data)->processor_id;
+		switch (processor_id & PRID_REV_MASK) {
+		case PRID_REV_LOONGSON2E:
+			cpu_clock_freq = 533080000;
+			break;
+		case PRID_REV_LOONGSON2F:
+			cpu_clock_freq = 797000000;
+			break;
+		default:
+			cpu_clock_freq = 100000000;
+			break;
+		}
+	}
 
 	pr_info("busclock=%ld, cpuclock=%ld, memsize=%ld, highmemsize=%ld\n",
 		bus_clock, cpu_clock_freq, memsize, highmemsize);
-- 
1.6.5.6
