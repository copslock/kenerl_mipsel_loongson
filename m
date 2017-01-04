Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2017 13:46:03 +0100 (CET)
Received: from smtpbg202.qq.com ([184.105.206.29]:49735 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991232AbdADMpzII-0r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Jan 2017 13:45:55 +0100
X-QQ-mid: Xesmtp23t1483533937t86cz36yg
Received: from Red54.com (unknown [183.39.159.125])
        by esmtp4.qq.com (ESMTP) with SMTP id 0
        for <linux-mips@linux-mips.org>; Wed, 04 Jan 2017 20:45:35 +0800 (CST)
X-QQ-SSF: 00000000000000100M104F00000000U
X-QQ-FEAT: QX/rXDl9P1ud9AqMURhkVROzV1csQyFh0973xasaYtINsRuLSaR3EFv6hDdo/
        p1ndRVKlbQTljF/wXg7UpU3tWFP7dGaEBAThrolWuzxR6Fa1Ge/fDdb14p1bFeo8aveSGVs
        n5xxYcuU17S40Y+vLbH5Vi/fKjmoHDIKQH3hoiw1WkD8dvGI81S04h4JD313TYcaNXcrQqw
        iQ/PoXj1+qK6oRWQjvmVVx8gEmcRfzuGBfhg8g10+P6epkUbTF67Akm5RiEv8b33RqeKLsB
        7yzdkzKH4GiP2F
X-QQ-GoodBg: 0
Received: by Red54.com (sSMTP sendmail emulation); Wed, 04 Jan 2017 20:45:35 +0800
Date:   Wed, 4 Jan 2017 20:45:35 +0800
From:   =?utf-8?B?6LCi6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@Red54.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Loongson: Merge PRID_REV_LOONGSON1*
Message-ID: <20170104124535.GA20567@red54.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.7.2 (2016-11-26)
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:Red54.com:bgforeign:bgforeign1
X-QQ-Bgrelay: 1
Return-Path: <Yeking@Red54.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Yeking@Red54.com
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

Loongson 1 is a 32-bit MIPS CPU family with PRID 0x4220.

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 arch/mips/include/asm/cpu.h         | 3 +--
 arch/mips/kernel/cpu-probe.c        | 2 +-
 arch/mips/loongson32/common/setup.c | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 9a837248..74809296 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -239,8 +239,7 @@
 #define PRID_REV_VR4181A	0x0070	/* Same as VR4122 */
 #define PRID_REV_VR4130		0x0080
 #define PRID_REV_34K_V1_0_2	0x0022
-#define PRID_REV_LOONGSON1B	0x0020
-#define PRID_REV_LOONGSON1C	0x0020	/* Same as Loongson-1B */
+#define PRID_REV_LOONGSON1	0x0020
 #define PRID_REV_LOONGSON2E	0x0002
 #define PRID_REV_LOONGSON2F	0x0003
 #define PRID_REV_LOONGSON3A_R1	0x0005
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 07718bb5..06f690eb 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1502,7 +1502,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_LOONGSON1;
 
 		switch (c->processor_id & PRID_REV_MASK) {
-		case PRID_REV_LOONGSON1B:
+		case PRID_REV_LOONGSON1:
 			__cpu_name[cpu] = "Loongson 1B";
 			break;
 		}
diff --git a/arch/mips/loongson32/common/setup.c b/arch/mips/loongson32/common/setup.c
index 16407442..5f7fb52b 100644
--- a/arch/mips/loongson32/common/setup.c
+++ b/arch/mips/loongson32/common/setup.c
@@ -21,7 +21,7 @@ const char *get_system_type(void)
 	unsigned int processor_id = (&current_cpu_data)->processor_id;
 
 	switch (processor_id & PRID_REV_MASK) {
-	case PRID_REV_LOONGSON1B:
+	case PRID_REV_LOONGSON1:
 #if defined(CONFIG_LOONGSON1_LS1B)
 		return "LOONGSON LS1B";
 #elif defined(CONFIG_LOONGSON1_LS1C)
-- 
2.11.0
