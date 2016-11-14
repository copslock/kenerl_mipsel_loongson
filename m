Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 04:16:26 +0100 (CET)
Received: from smtpproxy19.qq.com ([184.105.206.84]:38194 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990864AbcKNDQUE-Wam (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Nov 2016 04:16:20 +0100
X-QQ-mid: bizesmtp1t1479093346tybjv5aib
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 14 Nov 2016 11:14:15 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ72000A0000000
X-QQ-FEAT: 1FVjgQNnvLQFa7/PsJsXQToKQbWsMKsBZS68oJ97meoN8PNtMlP4frGZgiPBB
        pvi1D3rCRGc3vqJZTa/aNN9h+j3/TyKFsZfVvVfVnFl8qIHjH2HJOznrAHKWYuOKo6RllrX
        pq/HFja3f5iM4ztHocVeXrUvnBlcgXaWcjfvFR1eS07+jkmvZLorR2u+YxwRK+1swo7UBCd
        12E9hxE5oyW7X/+y+utBQCIJrBccrrzGT39w4EUAQ/2uf7D7PyptXM7m6tWjYZsqexCZLxf
        w8nGK5wcqPTuP6
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 5/7] MIPS: Loogson: Make enum loongson_cpu_type more clear
Date:   Mon, 14 Nov 2016 11:12:43 +0800
Message-Id: <1479093165-625-6-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1479093165-625-1-git-send-email-chenhc@lemote.com>
References: <1479093165-625-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55814
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

Sort enum loongson_cpu_type in a more reasonable manner, this makes the
CPU names more clear and extensible. Those already defined enum values
are renamed to Legacy_* for compatibility.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson64/boot_param.h | 22 ++++++++++++++++------
 arch/mips/loongson64/common/env.c                  | 11 ++++++++---
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
index d3f3258..9f9bb9c 100644
--- a/arch/mips/include/asm/mach-loongson64/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
@@ -27,12 +27,22 @@ struct efi_memory_map_loongson {
 } __packed;
 
 enum loongson_cpu_type {
-	Loongson_2E = 0,
-	Loongson_2F = 1,
-	Loongson_3A = 2,
-	Loongson_3B = 3,
-	Loongson_1A = 4,
-	Loongson_1B = 5
+	Legacy_2E = 0x0,
+	Legacy_2F = 0x1,
+	Legacy_3A = 0x2,
+	Legacy_3B = 0x3,
+	Legacy_1A = 0x4,
+	Legacy_1B = 0x5,
+	Legacy_2G = 0x6,
+	Legacy_2H = 0x7,
+	Loongson_1A = 0x100,
+	Loongson_1B = 0x101,
+	Loongson_2E = 0x200,
+	Loongson_2F = 0x201,
+	Loongson_2G = 0x202,
+	Loongson_2H = 0x203,
+	Loongson_3A = 0x300,
+	Loongson_3B = 0x301
 };
 
 /*
diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/common/env.c
index 98307c2..bab5bfc 100644
--- a/arch/mips/loongson64/common/env.c
+++ b/arch/mips/loongson64/common/env.c
@@ -90,7 +90,9 @@ void __init prom_init_env(void)
 
 	cpu_clock_freq = ecpu->cpu_clock_freq;
 	loongson_sysconf.cputype = ecpu->cputype;
-	if (ecpu->cputype == Loongson_3A) {
+	switch (ecpu->cputype) {
+	case Legacy_3A:
+	case Loongson_3A:
 		loongson_sysconf.cores_per_node = 4;
 		loongson_sysconf.cores_per_package = 4;
 		smp_group[0] = 0x900000003ff01000;
@@ -111,7 +113,9 @@ void __init prom_init_env(void)
 		loongson_freqctrl[3] = 0x900030001fe001d0;
 		loongson_sysconf.ht_control_base = 0x90000EFDFB000000;
 		loongson_sysconf.workarounds = WORKAROUND_CPUFREQ;
-	} else if (ecpu->cputype == Loongson_3B) {
+		break;
+	case Legacy_3B:
+	case Loongson_3B:
 		loongson_sysconf.cores_per_node = 4; /* One chip has 2 nodes */
 		loongson_sysconf.cores_per_package = 8;
 		smp_group[0] = 0x900000003ff01000;
@@ -132,7 +136,8 @@ void __init prom_init_env(void)
 		loongson_freqctrl[3] = 0x900060001fe001d0;
 		loongson_sysconf.ht_control_base = 0x90001EFDFB000000;
 		loongson_sysconf.workarounds = WORKAROUND_CPUHOTPLUG;
-	} else {
+		break;
+	default:
 		loongson_sysconf.cores_per_node = 1;
 		loongson_sysconf.cores_per_package = 1;
 		loongson_chipcfg[0] = 0x900000001fe00180;
-- 
2.7.0
