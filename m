Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2018 04:12:49 +0100 (CET)
Received: from mail-pl0-x243.google.com ([IPv6:2607:f8b0:400e:c01::243]:37860
        "EHLO mail-pl0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990401AbeA0DMmHvOUB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2018 04:12:42 +0100
Received: by mail-pl0-x243.google.com with SMTP id ay8so156696plb.4;
        Fri, 26 Jan 2018 19:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ePqY9quNIZ0Ox5Ljy0S0rb/uNdfGzfQ2jKKFk4O0ZPk=;
        b=up4t8+RbHZxI+sXLYTHj2LWb947ncedSeIsE/LDkg+DnXqLRqjgRIUijKF2DhaTMQX
         CgBlk/JPCJN4Dgj+bh8ZdNjNdgCRmfys68FTGaXLuHXYpl4iHLhip8z2na+e8EV7iUBf
         MBjxE1SNYK2A0XMaBU8SugdKBAxzx1uXcobD2s2SVieeFsEBU/2mvhc7kwRQYw265hkM
         zhwYnaNHYOmGBpHwXcOPRa9nvwjfRQ8kBxXNIUyGkRAQ4UT8zNwZlMv2IC8qFf6JX+eX
         wYmjT/jTlU+0AHpnUjKVVy0FM12r/qRfyhrCqgRzAmGa82gPfpARObXjam4OuUX4oVk4
         9n/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ePqY9quNIZ0Ox5Ljy0S0rb/uNdfGzfQ2jKKFk4O0ZPk=;
        b=Z/tP9GSJOC8/LtVEW1SFoecnqxhNuRGhGRfd8/tpDjMxXnhFnbN03u0gbmYGD08G3g
         tvX5FcjlX39iEq4vtUMRhSZ2nWJPWXMX8GUzRaI2lVdgKmmOSmRNlxiEW36ckrFexWhY
         FNJM2UHx7j9qhXzOuv21aILIGWyRZ8+PKjPWSOcR4z951JSgWrlRwjamF//qm4DkDdKm
         mqhFdCOGCGZXq9yRA8noLO6j7R4sw0gi21ysdTRjXa/voD4KTj4Rr3RWbHvdi3ZFHiO6
         ohR+QEVXVhaMMJE75WqrVDhXdk3fLB2RQv5yNtxrW2lyU2weLh8mDboD+3W03UAa0+uy
         kd6g==
X-Gm-Message-State: AKwxytdHMfPE3JULDfw8c/r5DiHIPaJNaVp+CCdVPYJURu+3e66IDo0Q
        6ZLaViTGa3awLYrLv+pvoSUNjg==
X-Google-Smtp-Source: AH8x227DV0mR0JKxaHLXrKX3gYZadaKn6yibguXDtSPsoKtlpvgNFNbchsPQzW3tL42uKPug+0cI8A==
X-Received: by 2002:a17:902:203:: with SMTP id 3-v6mr16521366plc.413.1517022755828;
        Fri, 26 Jan 2018 19:12:35 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id w16sm4775884pfk.18.2018.01.26.19.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 19:12:35 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 01/12] MIPS: Loongson: Add Loongson-3A R3.1 basic support
Date:   Sat, 27 Jan 2018 11:12:21 +0800
Message-Id: <1517022752-3053-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62344
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

Loongson-3A R3.1 is the bugfix revision of Loongson-3A R3.

All Loongson-3 CPU family:

Code-name         Brand-name       PRId
Loongson-3A R1    Loongson-3A1000  0x6305
Loongson-3A R2    Loongson-3A2000  0x6308
Loongson-3A R3    Loongson-3A3000  0x6309
Loongson-3A R3.1  Loongson-3A3000  0x630d
Loongson-3B R1    Loongson-3B1000  0x6306
Loongson-3B R2    Loongson-3B1500  0x6307

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cpu.h           | 51 ++++++++++++++++++-----------------
 arch/mips/kernel/cpu-probe.c          |  3 ++-
 arch/mips/loongson64/common/env.c     |  3 ++-
 arch/mips/loongson64/loongson-3/smp.c |  3 ++-
 drivers/platform/mips/cpu_hwmon.c     |  3 ++-
 5 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index d39324c..4fbb069 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -225,31 +225,32 @@
  * Definitions for 7:0 on legacy processors
  */
 
-#define PRID_REV_TX4927		0x0022
-#define PRID_REV_TX4937		0x0030
-#define PRID_REV_R4400		0x0040
-#define PRID_REV_R3000A		0x0030
-#define PRID_REV_R3000		0x0020
-#define PRID_REV_R2000A		0x0010
-#define PRID_REV_TX3912		0x0010
-#define PRID_REV_TX3922		0x0030
-#define PRID_REV_TX3927		0x0040
-#define PRID_REV_VR4111		0x0050
-#define PRID_REV_VR4181		0x0050	/* Same as VR4111 */
-#define PRID_REV_VR4121		0x0060
-#define PRID_REV_VR4122		0x0070
-#define PRID_REV_VR4181A	0x0070	/* Same as VR4122 */
-#define PRID_REV_VR4130		0x0080
-#define PRID_REV_34K_V1_0_2	0x0022
-#define PRID_REV_LOONGSON1B	0x0020
-#define PRID_REV_LOONGSON1C	0x0020	/* Same as Loongson-1B */
-#define PRID_REV_LOONGSON2E	0x0002
-#define PRID_REV_LOONGSON2F	0x0003
-#define PRID_REV_LOONGSON3A_R1	0x0005
-#define PRID_REV_LOONGSON3B_R1	0x0006
-#define PRID_REV_LOONGSON3B_R2	0x0007
-#define PRID_REV_LOONGSON3A_R2	0x0008
-#define PRID_REV_LOONGSON3A_R3	0x0009
+#define PRID_REV_TX4927			0x0022
+#define PRID_REV_TX4937			0x0030
+#define PRID_REV_R4400			0x0040
+#define PRID_REV_R3000A			0x0030
+#define PRID_REV_R3000			0x0020
+#define PRID_REV_R2000A			0x0010
+#define PRID_REV_TX3912			0x0010
+#define PRID_REV_TX3922			0x0030
+#define PRID_REV_TX3927			0x0040
+#define PRID_REV_VR4111			0x0050
+#define PRID_REV_VR4181			0x0050	/* Same as VR4111 */
+#define PRID_REV_VR4121			0x0060
+#define PRID_REV_VR4122			0x0070
+#define PRID_REV_VR4181A		0x0070	/* Same as VR4122 */
+#define PRID_REV_VR4130			0x0080
+#define PRID_REV_34K_V1_0_2		0x0022
+#define PRID_REV_LOONGSON1B		0x0020
+#define PRID_REV_LOONGSON1C		0x0020	/* Same as Loongson-1B */
+#define PRID_REV_LOONGSON2E		0x0002
+#define PRID_REV_LOONGSON2F		0x0003
+#define PRID_REV_LOONGSON3A_R1		0x0005
+#define PRID_REV_LOONGSON3B_R1		0x0006
+#define PRID_REV_LOONGSON3B_R2		0x0007
+#define PRID_REV_LOONGSON3A_R2		0x0008
+#define PRID_REV_LOONGSON3A_R3_0	0x0009
+#define PRID_REV_LOONGSON3A_R3_1	0x000d
 
 /*
  * Older processors used to encode processor version and revision in two
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index cf3fd54..83317d6 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1834,7 +1834,8 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 			set_elf_platform(cpu, "loongson3a");
 			set_isa(c, MIPS_CPU_ISA_M64R2);
 			break;
-		case PRID_REV_LOONGSON3A_R3:
+		case PRID_REV_LOONGSON3A_R3_0:
+		case PRID_REV_LOONGSON3A_R3_1:
 			c->cputype = CPU_LOONGSON3;
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/common/env.c
index 1e8a955..8f68ee0 100644
--- a/arch/mips/loongson64/common/env.c
+++ b/arch/mips/loongson64/common/env.c
@@ -198,7 +198,8 @@ void __init prom_init_env(void)
 			break;
 		case PRID_REV_LOONGSON3A_R1:
 		case PRID_REV_LOONGSON3A_R2:
-		case PRID_REV_LOONGSON3A_R3:
+		case PRID_REV_LOONGSON3A_R3_0:
+		case PRID_REV_LOONGSON3A_R3_1:
 			cpu_clock_freq = 900000000;
 			break;
 		case PRID_REV_LOONGSON3B_R1:
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index 8501109..fea95d0 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -682,7 +682,8 @@ void play_dead(void)
 			(void *)CKSEG1ADDR((unsigned long)loongson3a_r1_play_dead);
 		break;
 	case PRID_REV_LOONGSON3A_R2:
-	case PRID_REV_LOONGSON3A_R3:
+	case PRID_REV_LOONGSON3A_R3_0:
+	case PRID_REV_LOONGSON3A_R3_1:
 		play_dead_at_ckseg1 =
 			(void *)CKSEG1ADDR((unsigned long)loongson3a_r2r3_play_dead);
 		break;
diff --git a/drivers/platform/mips/cpu_hwmon.c b/drivers/platform/mips/cpu_hwmon.c
index 322de58..f66521c 100644
--- a/drivers/platform/mips/cpu_hwmon.c
+++ b/drivers/platform/mips/cpu_hwmon.c
@@ -30,7 +30,8 @@ int loongson3_cpu_temp(int cpu)
 	case PRID_REV_LOONGSON3B_R2:
 		reg = ((reg >> 8) & 0xff) - 100;
 		break;
-	case PRID_REV_LOONGSON3A_R3:
+	case PRID_REV_LOONGSON3A_R3_0:
+	case PRID_REV_LOONGSON3A_R3_1:
 		reg = (reg & 0xffff)*731/0x4000 - 273;
 		break;
 	}
-- 
2.7.0
