Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 05:24:31 +0200 (CEST)
Received: from smtpbgau2.qq.com ([54.206.34.216]:54659 "EHLO smtpbgau2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991087AbdFFDYXNhvf6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Jun 2017 05:24:23 +0200
X-QQ-mid: bizesmtp16t1496719411toxx9u6a
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 06 Jun 2017 11:21:48 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK92000A0000000
X-QQ-FEAT: r8geFCKg7nbKzQp03+z0Aic7LfWYNMkFHio3bR9HKw3LdYZF4HMpubyvdmSt3
        AerHxfFnoKvIWMtgJBfFTUVlSu7bOnSD/9TKoZrIlGta+L078AtsJbx8kT6+nbne2FCd22h
        c8ZK6K3lKBmWA5SHHsSc3Y/9B0rSC2CnjYCTt5krG+DudfSMnIvFF4ekI4yL6OTa4E9QJBz
        ZPPZfi6QZN0boj12PMNueLrATdBME5hoR7DzACvLcBa88OysgVJqfN0TndLUvFPfpyWLxmc
        4pH9dpPRrdfQKaBbu+4gckGogkWiqQTn6kRy1UgEEx2JhP
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V4 7/9] MIPS: Loogson: Make enum loongson_cpu_type more clear
Date:   Tue,  6 Jun 2017 11:14:46 +0800
Message-Id: <1496718888-18324-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1496718888-18324-1-git-send-email-chenhc@lemote.com>
References: <1496718888-18324-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58249
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
index 4707abf..1e8a955 100644
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
