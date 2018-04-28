Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2018 05:19:38 +0200 (CEST)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:47067
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbeD1DTa4daGZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2018 05:19:30 +0200
Received: by mail-pg0-x241.google.com with SMTP id z4-v6so2814717pgu.13;
        Fri, 27 Apr 2018 20:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gEE87I3CbShUhdSUNqKL0cA1BFuj6wRWuFLfF7u2Qr0=;
        b=Ipb6Prp6iqQmXJPoVJ17RCoM+Zyg/fhRe9pXYBnfLbINbHO/1mCw74TaESXbjotjG4
         OIOF60VWRAFReqo2KI+Pzmn1VIT6OHQki9Tu1VfJoeXHi0BO7VtZK4pg1JrfSiPkopFd
         p+2kZiPbuMEw+pPLrumSHzMw0e38MZL1+KqOSFDV3JpxuYvI+amBxSvUbXL583vv1k20
         /i3FPWI306jp91r+OUhfDQmcXDWhpdmb9FgjTwS1PLrexePpbiDmD1f4dc6/8XshxMaz
         /K1mxYBZeqFrZKKk4NNBi59xdu6DHosEW6qyl+sCJp/08ZN9U9LmYO5HwMAY7KhiaZ/n
         aTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=gEE87I3CbShUhdSUNqKL0cA1BFuj6wRWuFLfF7u2Qr0=;
        b=N168d6fPQNfPm5SRXh7ThDPDNHk/MUpbyvIgDHZ6Dz81hbd63igpRbXdeIEGgQ0uFB
         pYKhIsC+rPdL0w/XCnRaXnk8RC1TTpvB28/sKaI59z/94XCjCagd3KJMho3Tg4ue9h2s
         8EUBWuOavdoen1UAG3FctlM5ujqI4qI5WuNn45QDTGbt9BzILMnQxR5q6AMmAukCb6/Q
         MaYbx/sdpUtPoFZMyQZQ6w9207jkD5HYehQpUiN2Ddulq2eQ5RerQ9713g0D1OGCqgac
         83mE9l6HU+VbDw+bU1YXNm47ZEHdm6mA+ETG0E+Nuj7L+jvrxEIR0AyXMifV1I5OWCiS
         OZsA==
X-Gm-Message-State: ALQs6tAcKqXSTo/Qq+wbTtBVIP61oGqyCPWJzkpBdK12PSbGiYUQktmv
        mcbh42rl297IIuhZ6XqZLnyavw==
X-Google-Smtp-Source: AB8JxZoRRpmTTPr77ZzYYrPy3eDqKcx5Y/xReIiwg1YpKKsRND6jbEs7MK8x6onL/rq9rPR+N/4hig==
X-Received: by 2002:a17:902:7e05:: with SMTP id b5-v6mr4469764plm.230.1524885563789;
        Fri, 27 Apr 2018 20:19:23 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id g72sm7148114pfg.60.2018.04.27.20.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 20:19:22 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V3 01/10] MIPS: Loongson: Add Loongson-3A R3.1 basic support
Date:   Sat, 28 Apr 2018 11:21:25 +0800
Message-Id: <1524885694-18132-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
References: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63819
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
index 6b07b73..cbdf678 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1837,7 +1837,8 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
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
